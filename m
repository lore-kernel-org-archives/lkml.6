Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331BFC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17092080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHwSw/Ng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17092080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbeLNIHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:07:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41565 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeLNIHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:07:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so4473946wrs.8;
        Fri, 14 Dec 2018 00:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d7Y+tRnP7xADrzXguTL+CkXWBDU450HhQ+E3NphxUpw=;
        b=dHwSw/NgoBWszRvph0RbbP7p4LUjn+8mL9Lh0bOszo2MLAYpR0Uim4gHmUNPoAzAna
         jkQp+EMScgACo/RGc0PHQTaEEpsZIOCmJu8LpR4bHhgw9ExebYSsE0cCqlHkEi/bfGvC
         BwPYF71zuxcaHDKV2UE1hG1HxPBChwFYRjMxzqweLYOMSOaTuzihaPAS8ILgImeqEZ+t
         XI9z6vGt9XKBuZ1susHM+ZfOFULR8fD47+APFkeV664/XKNRXFRf8FALrgXmv64NPqK1
         Xzq9TVsIJ+BbCunOofciVu7ph3aOZhgAyX4BlxcsaCFzyi1JpRw0vxW9YH8RWhbCKRzC
         kXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d7Y+tRnP7xADrzXguTL+CkXWBDU450HhQ+E3NphxUpw=;
        b=fCFRLWjKHVOYouec5jPraxSkfjiU1rCKbn5pyO+16QXpj8ATZHt0+MP1P6bA6NBb/9
         0ZLs+gm2kR0aoY99CyMs/Wqb62HY0cOXet/VY1fq4FWF4+hkujQHVI2C6f4Bo5gmy5yQ
         uF73LAy4CO4tsv/BzJUssAaImn0lqteMNnOlyPbSLkvL1tq/gGPpNkq7FYe/KYs4eSDh
         xesAPDvniyzk1lwHnctG2pIH8Hp9uwws47O++A4wnPQY3cQYjxQYW2IeSiXhzPBg/JsS
         +EP3ZSvv01qOGsQq5DYl98rdoPLuBvmS9BX89SEeaDsKOGPqu+q9a11duwmhfPrKBY88
         QnIg==
X-Gm-Message-State: AA+aEWbZxAKwRfoow+CXGmd+emiKXNlh/mIL787TmXiKyKNPBCLg6Sr9
        ejYz9pWRmRX7pbLRxO35bLWRldiFxAQ=
X-Google-Smtp-Source: AFSGD/V8j63ZGMQjphTLzeUjceHOS56gIEiEpwPSihJiHBNOlEJUyjLnRGfxtDQ0gtkmOJEVQFbdiA==
X-Received: by 2002:a05:6000:8a:: with SMTP id m10mr1624112wrx.79.1544774826697;
        Fri, 14 Dec 2018 00:07:06 -0800 (PST)
Received: from rocks ([84.88.51.80])
        by smtp.gmail.com with ESMTPSA id k128sm5157820wmd.37.2018.12.14.00.07.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 14 Dec 2018 00:07:06 -0800 (PST)
Date:   Fri, 14 Dec 2018 09:07:00 +0100
From:   Aleix Roca Nonell <kernelrocks@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        mbrugger@suse.com
Subject: Re: [PATCH] HID: asus: Add support for the ASUS T101HA keyboard dock
Message-ID: <20181214080700.GA4189@rocks>
References: <20181201190153.GB4995@arks.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181201190153.GB4995@arks.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kind remminder ping :)

I'm also adding my fellow Matthias in CC

On Sat, Dec 01, 2018 at 08:01:53PM +0100, Aleix Roca Nonell wrote:
> The ASUS T101HA keyboard dock generates HID events using the ASUS vendor
> specific UsagePage 0xff31. In consequence, some multimedia keys such as
> brightness up and down are not working with hid-generic.
> 
> This commit adds the T101HA dock into the supported device list of the
> hid-asus driver. It also prevents the dock's integrated touchpad to be
> bound with hid-asus given that it is already working fine with
> hid-multitouch.
> 
> Signed-off-by: Aleix Roca Nonell <kernelrocks@gmail.com>
> ---
> 
> This is my very first kernel patch done in my free time (be aware of the
> newbie!!) so please, let me know if I can improve anything and I will
> happily do it :)
> 
>  drivers/hid/hid-asus.c | 12 ++++++++++++
>  drivers/hid/hid-ids.h  |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index ab8bd40a77ed..d8b55dca97c6 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -42,6 +42,7 @@ MODULE_AUTHOR("Frederik Wenigwieser <frederik.wenigwieser@gmail.com>");
>  MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
>  
>  #define T100_TPAD_INTF 2
> +#define T101HA_TPAD_INTF 2
>  
>  #define T100CHI_MOUSE_REPORT_ID 0x06
>  #define FEATURE_REPORT_ID 0x0d
> @@ -70,6 +71,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
>  #define QUIRK_T100_KEYBOARD		BIT(6)
>  #define QUIRK_T100CHI			BIT(7)
>  #define QUIRK_G752_KEYBOARD		BIT(8)
> +#define QUIRK_T101HA_DOCK		BIT(9)
>  
>  #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
>  						 QUIRK_NO_INIT_REPORTS | \
> @@ -649,6 +651,14 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	int ret;
>  	struct asus_drvdata *drvdata;
>  
> +	if (id->driver_data & QUIRK_T101HA_DOCK) {
> +		struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
> +
> +		/* use hid-multitouch for T101HA touchpad */
> +		if (intf->altsetting->desc.bInterfaceNumber == T101HA_TPAD_INTF)
> +			return -ENODEV;
> +	}
> +
>  	drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
>  	if (drvdata == NULL) {
>  		hid_err(hdev, "Can't alloc Asus descriptor\n");
> @@ -830,6 +840,8 @@ static const struct hid_device_id asus_devices[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
>  		USB_DEVICE_ID_ASUSTEK_T100TAF_KEYBOARD),
>  	  QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
> +		USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD), QUIRK_T101HA_DOCK },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_ASUS_AK1D) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_ASUS_MD_5110) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_ASUS_MD_5112) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 4206428c0ba2..f1eee2778b70 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -184,6 +184,7 @@
>  #define USB_DEVICE_ID_ASUSTEK_T100TA_KEYBOARD	0x17e0
>  #define USB_DEVICE_ID_ASUSTEK_T100TAF_KEYBOARD	0x1807
>  #define USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD	0x8502
> +#define USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD	0x183d
>  #define USB_DEVICE_ID_ASUSTEK_T304_KEYBOARD	0x184a
>  #define USB_DEVICE_ID_ASUSTEK_I2C_KEYBOARD	0x8585
>  #define USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD	0x0101
> -- 
> 2.19.2
> 
