Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1551C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8C82146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550101054;
	bh=mmw0Cz14/AR/9LF/3AzPMBAHhphh3tGJBq/njSqj7bE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=JoqMHDqV4aRreet3azVwGHfsRYYB083pZrixeB8g8h1hO2vf3tfURQUOkFamgeAPu
	 koh00hAOU6h+EQTNju+T1WUYcki0zz9L0gCZzEl28EZtbRAXtlbSM9M3YW3xagic+V
	 AvL3dDnwfMlriT3p6CC43GdJ0MbSrQ3VHKDty2nE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390638AbfBMXhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 18:37:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:48330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728875AbfBMXhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 18:37:32 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B27912146E;
        Wed, 13 Feb 2019 23:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550101051;
        bh=mmw0Cz14/AR/9LF/3AzPMBAHhphh3tGJBq/njSqj7bE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=cSysp/0Gwp6xQWLvzckob42fhXlEa6YgFSHzyZzYnVeU3oGs7NmS3P1G90Rl4poNk
         U+XNLQqacGfT/iD/OXDBzHGRJw9zvLLRtDHjDaH17Lt8Fy4Kdo0mmIogq37kXTX/LU
         Wz3rRVmUw8SVqEHJBPnVuBHT/AGrV0NB4Yh+tHDY=
Date:   Thu, 14 Feb 2019 00:37:28 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jim Broadus <jbroadus@gmail.com>
cc:     kai.heng.feng@canonical.com, benjamin.tissoires@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix resume for ELAN2097 touchscreen.
In-Reply-To: <20190211070040.4569-1-jbroadus@gmail.com>
Message-ID: <nycvar.YFH.7.76.1902140036400.11598@cbobk.fhfr.pm>
References: <20190211070040.4569-1-jbroadus@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Feb 2019, Jim Broadus wrote:

> Commit 52cf93e63ee6 ("HID: i2c-hid: Don't reset device upon system resume")
> fixes the resume behavior of several devices. However, this breaks the
> resume on the ELAN2097, used on Dell Inspiron laptops, with the same flood
> of messages:
> 
> [27009.817110] i2c_hid i2c-ELAN2097:00: i2c_hid_get_input: incomplete report (67/65535)
> [27009.818867] i2c_hid i2c-ELAN2097:00: i2c_hid_get_input: incomplete report (67/65535)
> [27009.820623] i2c_hid i2c-ELAN2097:00: i2c_hid_get_input: incomplete report (67/65535)
> 
> This change adds a new I2C_HID_QUIRK_RESET_AFTER_RESUME and replaces the
> original reset behavior for this device.
> 
> Signed-off-by: Jim Broadus <jbroadus@gmail.com>

This should be fixed in hid.git#for-5.1/i2c-hid already by commit 
1475af255e18f. Could you please confirm that?

> ---
>  drivers/hid/hid-ids.h              |  1 +
>  drivers/hid/i2c-hid/i2c-hid-core.c | 20 ++++++++++++++------
>  2 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 24f846d67478..38cc7033712a 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -387,6 +387,7 @@
>  #define USB_DEVICE_ID_TOSHIBA_CLICK_L9W	0x0401
>  #define USB_DEVICE_ID_HP_X2		0x074d
>  #define USB_DEVICE_ID_HP_X2_10_COVER	0x0755
> +#define USB_DEVICE_ID_ELAN2097		0x2504
>  
>  #define USB_VENDOR_ID_ELECOM		0x056e
>  #define USB_DEVICE_ID_ELECOM_BM084	0x0061
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index c5edfa966343..fdbad29b4406 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -50,6 +50,7 @@
>  #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET	BIT(1)
>  #define I2C_HID_QUIRK_NO_RUNTIME_PM		BIT(2)
>  #define I2C_HID_QUIRK_DELAY_AFTER_SLEEP		BIT(3)
> +#define I2C_HID_QUIRK_RESET_AFTER_RESUME	BIT(4)
>  
>  /* flags */
>  #define I2C_HID_STARTED		0
> @@ -181,6 +182,8 @@ static const struct i2c_hid_quirks {
>  		I2C_HID_QUIRK_NO_RUNTIME_PM },
>  	{ I2C_VENDOR_ID_GOODIX, I2C_DEVICE_ID_GOODIX_01F0,
>  		I2C_HID_QUIRK_NO_RUNTIME_PM },
> +	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN2097,
> +		 I2C_HID_QUIRK_RESET_AFTER_RESUME },
>  	{ 0, 0 }
>  };
>  
> @@ -1279,12 +1282,17 @@ static int i2c_hid_resume(struct device *dev)
>  
>  	enable_irq(client->irq);
>  
> -	/* Instead of resetting device, simply powers the device on. This
> -	 * solves "incomplete reports" on Raydium devices 2386:3118 and
> -	 * 2386:4B33 and fixes various SIS touchscreens no longer sending
> -	 * data after a suspend/resume.
> -	 */
> -	ret = i2c_hid_set_power(client, I2C_HID_PWR_ON);
> +	if (ihid->quirks & I2C_HID_QUIRK_RESET_AFTER_RESUME) {
> +		ret = i2c_hid_hwreset(client);
> +	} else {
> +		/* Instead of resetting device, simply powers the device on.
> +		 * This solves "incomplete reports" on Raydium devices 2386:3118
> +		 * and 2386:4B33 and fixes various SIS touchscreens no longer
> +		 * sending data after a suspend/resume.
> +		 */
> +		ret = i2c_hid_set_power(client, I2C_HID_PWR_ON);
> +	}
> +
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.20.1
> 

-- 
Jiri Kosina
SUSE Labs

