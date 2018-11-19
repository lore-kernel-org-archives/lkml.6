Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E500FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B5A2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B5A2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbeKTBwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:52:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:45692 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729825AbeKTBwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:52:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1FD34AD91;
        Mon, 19 Nov 2018 15:28:26 +0000 (UTC)
Date:   Mon, 19 Nov 2018 16:28:25 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: i2c-hid: Disable runtime PM for LG touchscreen
In-Reply-To: <20181114072457.19793-1-kai.heng.feng@canonical.com>
Message-ID: <nycvar.YFH.7.76.1811191628190.21108@cbobk.fhfr.pm>
References: <20181114072457.19793-1-kai.heng.feng@canonical.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018, Kai-Heng Feng wrote:

> LG touchscreen (1fd2:8001) stops working after reboot:
> [ 4.859153] i2c_hid i2c-SAPS2101:00: i2c_hid_get_input: incomplete report (64/66)
> [ 4.936070] i2c_hid i2c-SAPS2101:00: i2c_hid_get_input: incomplete report (64/66)
> [ 9.948224] i2c_hid i2c-SAPS2101:00: failed to reset device.
> 
> The device in question stops working after receives SLEEP, ON, SLEEP
> commands in a short period. The scenario is like this:
> - Once the desktop session closes, it also closed the hid device, so the
> device gets runtime suspended and receives a SLEEP command.
> - Before calling shutdown callback, it gets runtime resumed and received
> an ON command.
> - In the shutdown callback, it receives another SLEEP command.
> 
> I failed to find a reliable interval between ON/SLEEP commands that can
> make it work, so let's simply disable runtime PM for the device.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/hid/hid-ids.h              | 1 +
>  drivers/hid/i2c-hid/i2c-hid-core.c | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index c0d668944dbe..bd636f529fad 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -707,6 +707,7 @@
>  #define USB_VENDOR_ID_LG		0x1fd2
>  #define USB_DEVICE_ID_LG_MULTITOUCH	0x0064
>  #define USB_DEVICE_ID_LG_MELFAS_MT	0x6007
> +#define I2C_DEVICE_ID_LG_8001		0x8001
>  
>  #define USB_VENDOR_ID_LOGITECH		0x046d
>  #define USB_DEVICE_ID_LOGITECH_AUDIOHUB 0x0a0e
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index 3cde7c1b9c33..8555ce7e737b 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -177,6 +177,8 @@ static const struct i2c_hid_quirks {
>  		I2C_HID_QUIRK_NO_RUNTIME_PM },
>  	{ I2C_VENDOR_ID_RAYDIUM, I2C_PRODUCT_ID_RAYDIUM_4B33,
>  		I2C_HID_QUIRK_DELAY_AFTER_SLEEP },
> +	{ USB_VENDOR_ID_LG, I2C_DEVICE_ID_LG_8001,
> +		I2C_HID_QUIRK_NO_RUNTIME_PM },
>  	{ 0, 0 }
>  };

Applied.

-- 
Jiri Kosina
SUSE Labs

