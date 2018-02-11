Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932234AbeBKULY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 15:11:24 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46964 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932140AbeBKULX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 15:11:23 -0500
X-Google-Smtp-Source: AH8x224h4qOwKkFm7QX2T7AoSAb9d88OFtG7Lawhv0ata2Qx5f8aa/G+6Qrttja9WN3yHQBcCsCJJg==
Date: Sun, 11 Feb 2018 12:11:20 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jean Delvare <jdelvare@suse.com>,
        =?iso-8859-1?B?Wm9sdOFuIEL2c3r2cm3pbnlp?= <zboszor@pr.hu>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [1/2] i2c: piix4: Use request_muxed_region
Message-ID: <20180211201120.GA29394@roeck-us.net>
References: <1514652658-6228-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1514652658-6228-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 30, 2017 at 08:50:57AM -0800, Guenter Roeck wrote:
> Accesses to SB800_PIIX4_SMB_IDX can occur from multiple drivers.
> Use request_muxed_region() to ensure synchronization.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Any comments on this patch ?

Thanks,
Guenter

> ---
>  drivers/i2c/busses/i2c-piix4.c | 50 ++++++++++++++++++------------------------
>  1 file changed, 21 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> index 462948e2c535..78dd5951d6e7 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -153,10 +153,7 @@ static const struct dmi_system_id piix4_dmi_ibm[] = {
>  
>  /*
>   * SB800 globals
> - * piix4_mutex_sb800 protects piix4_port_sel_sb800 and the pair
> - * of I/O ports at SB800_PIIX4_SMB_IDX.
>   */
> -static DEFINE_MUTEX(piix4_mutex_sb800);
>  static u8 piix4_port_sel_sb800;
>  static u8 piix4_port_mask_sb800;
>  static u8 piix4_port_shift_sb800;
> @@ -298,12 +295,15 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
>  	else
>  		smb_en = (aux) ? 0x28 : 0x2c;
>  
> -	mutex_lock(&piix4_mutex_sb800);
> +	if (!request_muxed_region(SB800_PIIX4_SMB_IDX, 2, "sb800_piix4_smb"))
> +		return -EBUSY;
> +
>  	outb_p(smb_en, SB800_PIIX4_SMB_IDX);
>  	smba_en_lo = inb_p(SB800_PIIX4_SMB_IDX + 1);
>  	outb_p(smb_en + 1, SB800_PIIX4_SMB_IDX);
>  	smba_en_hi = inb_p(SB800_PIIX4_SMB_IDX + 1);
> -	mutex_unlock(&piix4_mutex_sb800);
> +
> +	release_region(SB800_PIIX4_SMB_IDX, 2);
>  
>  	if (!smb_en) {
>  		smb_en_status = smba_en_lo & 0x10;
> @@ -373,7 +373,12 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
>  			break;
>  		}
>  	} else {
> -		mutex_lock(&piix4_mutex_sb800);
> +		if (!request_muxed_region(SB800_PIIX4_SMB_IDX, 2,
> +					  "sb800_piix4_smb")) {
> +			release_region(piix4_smba, SMBIOSIZE);
> +			return -EBUSY;
> +		}
> +
>  		outb_p(SB800_PIIX4_PORT_IDX_SEL, SB800_PIIX4_SMB_IDX);
>  		port_sel = inb_p(SB800_PIIX4_SMB_IDX + 1);
>  		piix4_port_sel_sb800 = (port_sel & 0x01) ?
> @@ -381,7 +386,7 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
>  				       SB800_PIIX4_PORT_IDX;
>  		piix4_port_mask_sb800 = SB800_PIIX4_PORT_IDX_MASK;
>  		piix4_port_shift_sb800 = SB800_PIIX4_PORT_IDX_SHIFT;
> -		mutex_unlock(&piix4_mutex_sb800);
> +		release_region(SB800_PIIX4_SMB_IDX, 2);
>  	}
>  
>  	dev_info(&PIIX4_dev->dev,
> @@ -679,7 +684,8 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
>  	u8 port;
>  	int retval;
>  
> -	mutex_lock(&piix4_mutex_sb800);
> +	if (!request_muxed_region(SB800_PIIX4_SMB_IDX, 2, "sb800_piix4_smb"))
> +		return -EBUSY;
>  
>  	/* Request the SMBUS semaphore, avoid conflicts with the IMC */
>  	smbslvcnt  = inb_p(SMBSLVCNT);
> @@ -695,8 +701,8 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
>  	} while (--retries);
>  	/* SMBus is still owned by the IMC, we give up */
>  	if (!retries) {
> -		mutex_unlock(&piix4_mutex_sb800);
> -		return -EBUSY;
> +		retval = -EBUSY;
> +		goto release;
>  	}
>  
>  	/*
> @@ -753,8 +759,8 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
>  	if ((size == I2C_SMBUS_BLOCK_DATA) && adapdata->notify_imc)
>  		piix4_imc_wakeup();
>  
> -	mutex_unlock(&piix4_mutex_sb800);
> -
> +release:
> +	release_region(SB800_PIIX4_SMB_IDX, 2);
>  	return retval;
>  }
>  
> @@ -899,13 +905,6 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  		bool notify_imc = false;
>  		is_sb800 = true;
>  
> -		if (!request_region(SB800_PIIX4_SMB_IDX, 2, "smba_idx")) {
> -			dev_err(&dev->dev,
> -			"SMBus base address index region 0x%x already in use!\n",
> -			SB800_PIIX4_SMB_IDX);
> -			return -EBUSY;
> -		}
> -
>  		if (dev->vendor == PCI_VENDOR_ID_AMD &&
>  		    dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) {
>  			u8 imc;
> @@ -922,20 +921,16 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  
>  		/* base address location etc changed in SB800 */
>  		retval = piix4_setup_sb800(dev, id, 0);
> -		if (retval < 0) {
> -			release_region(SB800_PIIX4_SMB_IDX, 2);
> +		if (retval < 0)
>  			return retval;
> -		}
>  
>  		/*
>  		 * Try to register multiplexed main SMBus adapter,
>  		 * give up if we can't
>  		 */
>  		retval = piix4_add_adapters_sb800(dev, retval, notify_imc);
> -		if (retval < 0) {
> -			release_region(SB800_PIIX4_SMB_IDX, 2);
> +		if (retval < 0)
>  			return retval;
> -		}
>  	} else {
>  		retval = piix4_setup(dev, id);
>  		if (retval < 0)
> @@ -983,11 +978,8 @@ static void piix4_adap_remove(struct i2c_adapter *adap)
>  
>  	if (adapdata->smba) {
>  		i2c_del_adapter(adap);
> -		if (adapdata->port == (0 << piix4_port_shift_sb800)) {
> +		if (adapdata->port == (0 << piix4_port_shift_sb800))
>  			release_region(adapdata->smba, SMBIOSIZE);
> -			if (adapdata->sb800_main)
> -				release_region(SB800_PIIX4_SMB_IDX, 2);
> -		}
>  		kfree(adapdata);
>  		kfree(adap);
>  	}
