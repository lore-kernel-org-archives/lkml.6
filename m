Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94A8C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFFA2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFFA2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbeHaOLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 10:11:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39584 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbeHaOLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 10:11:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id h4-v6so8633733edi.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 03:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=joNZdlJNzYDd73xgdP1WAaNcOB8lTvuCRzqyoRPfZ9s=;
        b=hGsUmx7mCBbFoCPmvyjJEue75sVfxL3WH9d/jDYDFGM52VGYUSw4SU5cts/d+FWiyt
         ezxxIBkzcOZ4FnZQzSPrj8nuVSVxF0gR7+qtnSJZaimZ46a9HEOCgs3GtJrREiCzq4Tq
         Oi3fMzd66hMhIeWi7W5ZbtyUiQQnn3I0xoidpk44gi0HHRdLTMHLpSc8P+zyoVKfRShH
         dTC61hgA0Om1LhXmoLS2ucew0uS8vHXC0LVKarJ3IsDRJmSA47TGmX3w0V2MtBVQOCtk
         xLdUIYuzSndtvnmYznaVtnp759GqRCJ+nf2gjoR05hTiOTgoAWj/MghIb2nSMmtXQGl1
         v+tg==
X-Gm-Message-State: APzg51CULR29pFcp6ujU3+9rIuQLi7ClXx5cspMvgi9IAR/p/78VQRh/
        0Tx7K87wHJVGhAlti1kIhvjby0379T4=
X-Google-Smtp-Source: ANB0VdZzk/cfwTY/Z4WLTdLFxZIOMwbkp5vxhdoCc7ikB2Eao0hyXZhvAjndqheKungOQKHAfabVjQ==
X-Received: by 2002:a50:f743:: with SMTP id j3-v6mr16982753edn.203.1535709863357;
        Fri, 31 Aug 2018 03:04:23 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id n44-v6sm4194786edd.15.2018.08.31.03.04.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 03:04:22 -0700 (PDT)
Subject: Re: [PATCH] HID: i2c-hid: enforce I2C_HID_QUIRK_RESEND_REPORT_DESCR
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180831095417.8541-1-benjamin.tissoires@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4687e76a-d9a8-4a20-194b-526bb345cf73@redhat.com>
Date:   Fri, 31 Aug 2018 12:04:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180831095417.8541-1-benjamin.tissoires@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31-08-18 11:54, Benjamin Tissoires wrote:
> The spec states that the HID devices should allow
> the host to query the HID descriptor at any time.
> 
> Some devices require the HID descriptor to be set
> on resume, or they will fail.
> 
> Instead of having a growing list of blacklisted devices
> make the call part of the general resume process
> so we can remove this list.
> 
> Tested on a Dell XPS 9360 and a Surface 3.
> 
> link: https://bugzilla.redhat.com/show_bug.cgi?id=1622695
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

I agree we should just do this everywhere:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>   drivers/hid/i2c-hid/i2c-hid.c | 16 ++++------------
>   1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 57126f6837bb..17ec57c62a0b 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -47,7 +47,7 @@
>   /* quirks to control the device */
>   #define I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV	BIT(0)
>   #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET	BIT(1)
> -#define I2C_HID_QUIRK_RESEND_REPORT_DESCR	BIT(2)
> +/* reserved: I2C_HID_QUIRK_RESEND_REPORT_DESCR	BIT(2) */
>   
>   /* flags */
>   #define I2C_HID_STARTED		0
> @@ -170,12 +170,6 @@ static const struct i2c_hid_quirks {
>   		I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV },
>   	{ I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288,
>   		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
> -	{ I2C_VENDOR_ID_RAYD, I2C_PRODUCT_ID_RAYD_3118,
> -		I2C_HID_QUIRK_RESEND_REPORT_DESCR },
> -	{ USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS10FB_TOUCH,
> -		I2C_HID_QUIRK_RESEND_REPORT_DESCR },
> -	{ I2C_VENDOR_ID_RAYD, I2C_PRODUCT_ID_RAYD_4B33,
> -		I2C_HID_QUIRK_RESEND_REPORT_DESCR },
>   	{ 0, 0 }
>   };
>   
> @@ -1245,11 +1239,9 @@ static int i2c_hid_resume(struct device *dev)
>   	 * after resume, after this it will be back normal.
>   	 * otherwise it issues too many incomplete reports.
>   	 */
> -	if (ihid->quirks & I2C_HID_QUIRK_RESEND_REPORT_DESCR) {
> -		ret = i2c_hid_command(client, &hid_report_descr_cmd, NULL, 0);
> -		if (ret)
> -			return ret;
> -	}
> +	ret = i2c_hid_command(client, &hid_report_descr_cmd, NULL, 0);
> +	if (ret)
> +		return ret;
>   
>   	if (hid->driver && hid->driver->reset_resume) {
>   		ret = hid->driver->reset_resume(hid);
> 
