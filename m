Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC43C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6BE2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545224944;
	bh=KX/w/H3tuIGgBUD+G1nBd0h+uJmdjfCB/Tn5bItRuUc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=IUk8+3PapScFrpGezhLjHWja4aZvMUrHKeJgFDK2lfW6HTpUDOAsCHGCHi+W9P598
	 qdR7KkRJPaNsaERoqPzb2ftyziubCuVRZ5/mbQyQiDK715Pa9JfzURNqkSNkV/nbAR
	 lV3sqpSwo4scOTx7tV5eb+c2nGd9VYnVR7tXFu+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbeLSNJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:09:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:51750 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727786AbeLSNJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:09:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 203AEADF2;
        Wed, 19 Dec 2018 13:09:01 +0000 (UTC)
Date:   Wed, 19 Dec 2018 14:09:00 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: i2c-hid: Ignore input report if there's no data
 present on Elan touchpanels
In-Reply-To: <20181214090930.13386-1-kai.heng.feng@canonical.com>
Message-ID: <nycvar.YFH.7.76.1812191406240.17216@cbobk.fhfr.pm>
References: <20181214090930.13386-1-kai.heng.feng@canonical.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2018, Kai-Heng Feng wrote:

> While using Elan touchpads, the message floods:
> [  136.138487] i2c_hid i2c-DELL08D6:00: i2c_hid_get_input: incomplete report (14/65535)
> 
> Though the message flood is annoying, the device it self works without
> any issue. I suspect that the device in question takes too much time to
> pull the IRQ back to high after I2C host has done reading its data.
> 
> Since the host receives all useful data, let's ignore the input report
> when there's no data.

Interesting, never seen such a bug before.

> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid-core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index 8555ce7e737b..1776afa6d69c 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -50,6 +50,7 @@
>  #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET	BIT(1)
>  #define I2C_HID_QUIRK_NO_RUNTIME_PM		BIT(2)
>  #define I2C_HID_QUIRK_DELAY_AFTER_SLEEP		BIT(3)
> +#define I2C_HID_QUIRK_BOGUS_IRQ			BIT(4)
>  
>  /* flags */
>  #define I2C_HID_STARTED		0
> @@ -179,6 +180,8 @@ static const struct i2c_hid_quirks {
>  		I2C_HID_QUIRK_DELAY_AFTER_SLEEP },
>  	{ USB_VENDOR_ID_LG, I2C_DEVICE_ID_LG_8001,
>  		I2C_HID_QUIRK_NO_RUNTIME_PM },
> +	{ USB_VENDOR_ID_ELAN, HID_ANY_ID,
> +		 I2C_HID_QUIRK_BOGUS_IRQ },
>  	{ 0, 0 }
>  };
>  
> @@ -503,6 +506,12 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
>  		return;
>  	}
>  
> +	if (ihid->quirks & I2C_HID_QUIRK_BOGUS_IRQ && ret_size == 0xffff) {
> +		dev_dbg(&ihid->client->dev,
> +			"%s: IRQ triggered but there's no data\n", __func__);
> +		return;
> +	}

Would it perhaps make sense to make this some sort of printk_once(), so 
that it's immediately apparent from dmesg that the system/device is 
suffering from this particular problem? Might potentially be helpful piece 
of information.

Thanks,

-- 
Jiri Kosina
SUSE Labs

