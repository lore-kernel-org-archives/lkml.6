Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbeBZVeK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:34:10 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38736 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeBZVeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:34:09 -0500
X-Google-Smtp-Source: AH8x224otLkHcyN/iOCKYqlUPN8kScLm6/Qh5a2/33lLzzyIWqVmxhu4wlCsUnD5j8qOy0wWEEeqsw==
Date: Mon, 26 Feb 2018 13:34:06 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] i2c: piix4: Use request_muxed_region
Message-ID: <20180226213406.GB2211@roeck-us.net>
References: <1519678013-32749-1-git-send-email-linux@roeck-us.net>
 <1519678013-32749-2-git-send-email-linux@roeck-us.net>
 <20180226205204.p37lf7dcl5k7az37@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226205204.p37lf7dcl5k7az37@ninjato>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 09:52:04PM +0100, Wolfram Sang wrote:
> On Mon, Feb 26, 2018 at 12:46:53PM -0800, Guenter Roeck wrote:
> > Accesses to SB800_PIIX4_SMB_IDX can occur from multiple drivers.
> > One example for another driver is the sp5100_tco driver.
> > 
> > Use request_muxed_region() to ensure synchronization.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> To understand better: How does this relate to the series Zoltan
> Boszormenyi was proposing (in one sentence)?
> 
It is an alternate and somewhat simpler solution which does not
attempt to change the kernel API. My primary goal was to find
a solution for the immediate problem between the watchdog and
i2c drivers. My solution does not attempt to fix the access problem
for (initialization) functions with no return code. At the same time,
I prefer to use functions which _do_ return an error if that is possible
since it _may_ after all be that there are other users calling
request_region().

Having said that, I'll be just as happy if Zoltan's series is accepted
instead of this patch (except for patch #5; the watchdog driver has
already been converted to use request_muxed_region).

Thanks,
Guenter

> > ---
> > v2: Dropped now unnecessary include of linux/mutex.h
> >     Added error message if request_muxed_region() fails
> >     Spell out affected driver in commit message
> > 
> > Note that I did not try to do a performance analysis.
> > Doing so seemed excessive, even more so in the context of
> > piix4_imc_sleep() already using request_muxed_region(). 
> > 
> >  drivers/i2c/busses/i2c-piix4.c | 55 +++++++++++++++++++-----------------------
> >  1 file changed, 25 insertions(+), 30 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> > index 4c1f6aaec0fc..90946a8b9a75 100644
> > --- a/drivers/i2c/busses/i2c-piix4.c
> > +++ b/drivers/i2c/busses/i2c-piix4.c
> > @@ -40,7 +40,6 @@
> >  #include <linux/dmi.h>
> >  #include <linux/acpi.h>
> >  #include <linux/io.h>
> > -#include <linux/mutex.h>
> >  
> >  
> >  /* PIIX4 SMBus address offsets */
> > @@ -153,10 +152,7 @@ static const struct dmi_system_id piix4_dmi_ibm[] = {
> >  
> >  /*
> >   * SB800 globals
> > - * piix4_mutex_sb800 protects piix4_port_sel_sb800 and the pair
> > - * of I/O ports at SB800_PIIX4_SMB_IDX.
> >   */
> > -static DEFINE_MUTEX(piix4_mutex_sb800);
> >  static u8 piix4_port_sel_sb800;
> >  static u8 piix4_port_mask_sb800;
> >  static u8 piix4_port_shift_sb800;
> > @@ -298,12 +294,19 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
> >  	else
> >  		smb_en = (aux) ? 0x28 : 0x2c;
> >  
> > -	mutex_lock(&piix4_mutex_sb800);
> > +	if (!request_muxed_region(SB800_PIIX4_SMB_IDX, 2, "sb800_piix4_smb")) {
> > +		dev_err(&PIIX4_dev->dev,
> > +			"SMB base address index region 0x%x already in use.\n",
> > +			SB800_PIIX4_SMB_IDX);
> > +		return -EBUSY;
> > +	}
> > +
> >  	outb_p(smb_en, SB800_PIIX4_SMB_IDX);
> >  	smba_en_lo = inb_p(SB800_PIIX4_SMB_IDX + 1);
> >  	outb_p(smb_en + 1, SB800_PIIX4_SMB_IDX);
> >  	smba_en_hi = inb_p(SB800_PIIX4_SMB_IDX + 1);
> > -	mutex_unlock(&piix4_mutex_sb800);
> > +
> > +	release_region(SB800_PIIX4_SMB_IDX, 2);
> >  
> >  	if (!smb_en) {
> >  		smb_en_status = smba_en_lo & 0x10;
> > @@ -373,7 +376,12 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
> >  			break;
> >  		}
> >  	} else {
> > -		mutex_lock(&piix4_mutex_sb800);
> > +		if (!request_muxed_region(SB800_PIIX4_SMB_IDX, 2,
> > +					  "sb800_piix4_smb")) {
> > +			release_region(piix4_smba, SMBIOSIZE);
> > +			return -EBUSY;
> > +		}
> > +
> >  		outb_p(SB800_PIIX4_PORT_IDX_SEL, SB800_PIIX4_SMB_IDX);
> >  		port_sel = inb_p(SB800_PIIX4_SMB_IDX + 1);
> >  		piix4_port_sel_sb800 = (port_sel & 0x01) ?
> > @@ -381,7 +389,7 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
> >  				       SB800_PIIX4_PORT_IDX;
> >  		piix4_port_mask_sb800 = SB800_PIIX4_PORT_IDX_MASK;
> >  		piix4_port_shift_sb800 = SB800_PIIX4_PORT_IDX_SHIFT;
> > -		mutex_unlock(&piix4_mutex_sb800);
> > +		release_region(SB800_PIIX4_SMB_IDX, 2);
> >  	}
> >  
> >  	dev_info(&PIIX4_dev->dev,
> > @@ -679,7 +687,8 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
> >  	u8 port;
> >  	int retval;
> >  
> > -	mutex_lock(&piix4_mutex_sb800);
> > +	if (!request_muxed_region(SB800_PIIX4_SMB_IDX, 2, "sb800_piix4_smb"))
> > +		return -EBUSY;
> >  
> >  	/* Request the SMBUS semaphore, avoid conflicts with the IMC */
> >  	smbslvcnt  = inb_p(SMBSLVCNT);
> > @@ -695,8 +704,8 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
> >  	} while (--retries);
> >  	/* SMBus is still owned by the IMC, we give up */
> >  	if (!retries) {
> > -		mutex_unlock(&piix4_mutex_sb800);
> > -		return -EBUSY;
> > +		retval = -EBUSY;
> > +		goto release;
> >  	}
> >  
> >  	/*
> > @@ -753,8 +762,8 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
> >  	if ((size == I2C_SMBUS_BLOCK_DATA) && adapdata->notify_imc)
> >  		piix4_imc_wakeup();
> >  
> > -	mutex_unlock(&piix4_mutex_sb800);
> > -
> > +release:
> > +	release_region(SB800_PIIX4_SMB_IDX, 2);
> >  	return retval;
> >  }
> >  
> > @@ -899,13 +908,6 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
> >  		bool notify_imc = false;
> >  		is_sb800 = true;
> >  
> > -		if (!request_region(SB800_PIIX4_SMB_IDX, 2, "smba_idx")) {
> > -			dev_err(&dev->dev,
> > -			"SMBus base address index region 0x%x already in use!\n",
> > -			SB800_PIIX4_SMB_IDX);
> > -			return -EBUSY;
> > -		}
> > -
> >  		if (dev->vendor == PCI_VENDOR_ID_AMD &&
> >  		    dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) {
> >  			u8 imc;
> > @@ -922,20 +924,16 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
> >  
> >  		/* base address location etc changed in SB800 */
> >  		retval = piix4_setup_sb800(dev, id, 0);
> > -		if (retval < 0) {
> > -			release_region(SB800_PIIX4_SMB_IDX, 2);
> > +		if (retval < 0)
> >  			return retval;
> > -		}
> >  
> >  		/*
> >  		 * Try to register multiplexed main SMBus adapter,
> >  		 * give up if we can't
> >  		 */
> >  		retval = piix4_add_adapters_sb800(dev, retval, notify_imc);
> > -		if (retval < 0) {
> > -			release_region(SB800_PIIX4_SMB_IDX, 2);
> > +		if (retval < 0)
> >  			return retval;
> > -		}
> >  	} else {
> >  		retval = piix4_setup(dev, id);
> >  		if (retval < 0)
> > @@ -983,11 +981,8 @@ static void piix4_adap_remove(struct i2c_adapter *adap)
> >  
> >  	if (adapdata->smba) {
> >  		i2c_del_adapter(adap);
> > -		if (adapdata->port == (0 << piix4_port_shift_sb800)) {
> > +		if (adapdata->port == (0 << piix4_port_shift_sb800))
> >  			release_region(adapdata->smba, SMBIOSIZE);
> > -			if (adapdata->sb800_main)
> > -				release_region(SB800_PIIX4_SMB_IDX, 2);
> > -		}
> >  		kfree(adapdata);
> >  		kfree(adap);
> >  	}
> > -- 
> > 2.7.4
> > 
