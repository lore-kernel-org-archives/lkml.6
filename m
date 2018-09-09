Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11C0C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 10:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C0720866
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 10:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C0720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbeIIPjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 11:39:41 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:43378 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeIIPjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 11:39:41 -0400
Received: by mail-ed1-f49.google.com with SMTP id z27-v6so14425391edb.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 03:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rO7F5NSEIOvlfBOCrt4zTu2sYiSMMYELzfpFkRn7frc=;
        b=fZgtmoZoxsGDrRooWxGmZDNvJQSTMh3U5VCeRMFK3hRhY0Y8m2K2oHGT/HvVZ7igYW
         1Uuu1PIKJGpvmAnta764FXkEwE1An+RpXonODzeP3ORbeLkkXZE+SHhpWw2nuNxAKDwi
         0WzE6eiNQFqQzAJcgWiagRpBirni1Sxf2dudY96/fhv8h1wjAitVdv78MIZdDmNUyM6k
         4/hb1m0tKlJL11hwANgtzp+Vq2tyuFuhhvwpkZ2mj/aEXH3662UT6+l+ZeYi3NhbazgF
         AZ1qP602Uv3BZDCRpJquWJ963koPnOIYivDPAkdfxszkVK4hUXTMF5ZaFBQQNEARXWPt
         ZFVQ==
X-Gm-Message-State: APzg51C6rRN4LLUJKkMAXxwEKh9yNDz/Y5fCQcHwacNpZpuGYNBvIv7U
        KoDr2ZENzP9nxZveCFm3F+/m4Q==
X-Google-Smtp-Source: ANB0VdYiy16KTiSP8D6ZJin3ufNzcqo+zHWbOGna9DjyV1iIAQijvW1ETTEdiaWFXlKAdLgALKjuAQ==
X-Received: by 2002:aa7:d884:: with SMTP id u4-v6mr17439207edq.223.1536490223881;
        Sun, 09 Sep 2018 03:50:23 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id m35-v6sm6532470ede.14.2018.09.09.03.50.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 03:50:23 -0700 (PDT)
Subject: Re: [PATCH v2] HID: i2c-hid: Don't reset device upon system resume
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aaron Ma <aaron.ma@canonical.com>,
        AceLan Kao <acelan.kao@canonical.com>
References: <20180906025518.30191-1-kai.heng.feng@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <90dc0599-b902-3c86-6668-04a342b3acac@redhat.com>
Date:   Sun, 9 Sep 2018 12:50:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180906025518.30191-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06-09-18 04:55, Kai-Heng Feng wrote:
> Raydium touchscreen triggers interrupt storm after system-wide suspend:
> [ 179.085033] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete
> report (58/65535)
> 
> According to Raydium, Windows driver does not reset the device after
> system resume.
> 
> The HID over I2C spec does specify a reset should be used at
> intialization, but it doesn't specify if reset is required for system
> suspend.
> 
> Tested this patch on other i2c-hid touchpanels I have and those
> touchpanels do work after S3 without doing reset. If any regression
> happens to other touchpanel vendors, we can use quirk for Raydium
> devices.
> 
> There's still one device uses I2C_HID_QUIRK_RESEND_REPORT_DESCR so keep
> it there.

I added that quirk and I still have the hardware for it. I've tested
things with the quirk remove and the touchscreen works after resume
now without the quirk.

I also have some other devices with a SIS i2c-hid touchscreen which
would no longer work after resume where the quirk did not help.

I had looking into those on my TODO but did not get around to
this yet. I've re-tested those with this patch and I'm happy to report
that this patch also fixes resume on the SIS touchscreens in the
following models:

Asus T100HA
Asus T200TA
Peaq C1010

Regards,

Hans



> 
> Cc: Aaron Ma <aaron.ma@canonical.com>
> Cc: AceLan Kao <acelan.kao@canonical.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>   Remove Raydium devices' ID and quirk.
>   Rewording.
> 
>   drivers/hid/hid-ids.h         |  4 ----
>   drivers/hid/i2c-hid/i2c-hid.c | 13 +++++++------
>   2 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 7da93d789080..e254ae802688 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -530,10 +530,6 @@
>   #define I2C_VENDOR_ID_HANTICK		0x0911
>   #define I2C_PRODUCT_ID_HANTICK_5288	0x5288
>   
> -#define I2C_VENDOR_ID_RAYD		0x2386
> -#define I2C_PRODUCT_ID_RAYD_3118	0x3118
> -#define I2C_PRODUCT_ID_RAYD_4B33	0x4B33
> -
>   #define USB_VENDOR_ID_HANWANG		0x0b57
>   #define USB_DEVICE_ID_HANWANG_TABLET_FIRST	0x5000
>   #define USB_DEVICE_ID_HANWANG_TABLET_LAST	0x8fff
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 57126f6837bb..f3076659361a 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -170,12 +170,8 @@ static const struct i2c_hid_quirks {
>   		I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV },
>   	{ I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288,
>   		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
> -	{ I2C_VENDOR_ID_RAYD, I2C_PRODUCT_ID_RAYD_3118,
> -		I2C_HID_QUIRK_RESEND_REPORT_DESCR },
>   	{ USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS10FB_TOUCH,
>   		I2C_HID_QUIRK_RESEND_REPORT_DESCR },
> -	{ I2C_VENDOR_ID_RAYD, I2C_PRODUCT_ID_RAYD_4B33,
> -		I2C_HID_QUIRK_RESEND_REPORT_DESCR },
>   	{ 0, 0 }
>   };
>   
> @@ -1237,11 +1233,16 @@ static int i2c_hid_resume(struct device *dev)
>   	pm_runtime_enable(dev);
>   
>   	enable_irq(client->irq);
> -	ret = i2c_hid_hwreset(client);
> +
> +	/* Instead of resetting device, simply powers the device on. This
> +	 * solves "incomplete reports" on Raydium devices 2386:3118 and
> +	 * 2386:4B33
> +	 */
> +	ret = i2c_hid_set_power(client, I2C_HID_PWR_ON);
>   	if (ret)
>   		return ret;
>   
> -	/* RAYDIUM device (2386:3118) need to re-send report descr cmd
> +	/* Some devices need to re-send report descr cmd
>   	 * after resume, after this it will be back normal.
>   	 * otherwise it issues too many incomplete reports.
>   	 */
> 
