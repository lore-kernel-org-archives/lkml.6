Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6ABC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3602146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbfBMXPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 18:15:04 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37568 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfBMXPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 18:15:04 -0500
Received: by mail-ed1-f66.google.com with SMTP id m12so3464845edv.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 15:15:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ITX70Gx9XdyD69REALtRVDDT679qDYa33evwsYAqmHo=;
        b=aCCErUfJ01lSLM2G3zYDXzD6Us9C4CyWsg+h2w7hIOdP4d1L1ZYhBiEjqo5VocVZE3
         zLK1TzwAD+hiB56bkObsPrxnKgESkS/gtxblB5EOb14OCMemNUSZCI4F5V7/xuKQRGsi
         8Y4yKzKCe0xXsHG6LPykr6lZUFYABWAsur8XNjSZ+14yrvabvsMTnhXEHzqUCmHwDgIl
         NntJI8+IDihB6Kst8rzURUBOhi6668S0tHuZxOm95BaQZBuYRR5sVyA/Ifn8xPbAfLCt
         jkEG+tVxYWsmVqOTcqfdXWLnpIXsP8C4nDVY4dF3Ir/sI31jG/7J2W7mzQ0xvAsIqY8X
         lTTg==
X-Gm-Message-State: AHQUAubbFBvRMwEAD0Tt+T73NHK7+4DqrK1k4rF4hawLqSPE5wHSR3mx
        zgJNGDKFNLdyzv+7vNKOnRZYvw==
X-Google-Smtp-Source: AHgI3IaZxnxdlIkHn/mqBsQAFHPs4Re9siEbZgI6SEybJbVNyPpfSao2DoLkWvthE5Kmt0jz77HK3g==
X-Received: by 2002:a17:906:b31a:: with SMTP id n26mr387873ejz.173.1550099701960;
        Wed, 13 Feb 2019 15:15:01 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id t12sm183337edq.11.2019.02.13.15.15.00
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 15:15:01 -0800 (PST)
Subject: Re: [PATCH 1/2] extcon-intel-cht-wc: Make charger detection
 co-existed with OTG host mode
To:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20190210203649.21691-1-jekhor@gmail.com>
 <20190210203649.21691-2-jekhor@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <767c3d5e-f521-4d59-3922-a322b4124126@redhat.com>
Date:   Thu, 14 Feb 2019 00:15:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190210203649.21691-2-jekhor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10-02-19 21:36, Yauhen Kharuzhy wrote:
> Whiskey Cove Cherry Trail PMIC requires disabling OTG host mode before
> of charger detection procedure. Do this by manipulationg of CHGRCTRL1
> register.
> 
> Source: APCI DSDT code of Lenovo Yoga Book YB1-X91L and open-sourced
> Intel's drivers.

Hmm, of the ACPI code is updating the otg-mode, then there should be
no reason for us to do this, can you provide an acpidump of your
device please?

Regards,

Hans



> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---
>   drivers/extcon/extcon-intel-cht-wc.c | 38 +++++++++++++++++++++++++++-
>   1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
> index 5ef215297101..4f6ba249bc30 100644
> --- a/drivers/extcon/extcon-intel-cht-wc.c
> +++ b/drivers/extcon/extcon-intel-cht-wc.c
> @@ -29,7 +29,16 @@
>   #define CHT_WC_CHGRCTRL0_DBPOFF		BIT(6)
>   #define CHT_WC_CHGRCTRL0_CHR_WDT_NOKICK	BIT(7)
>   
> -#define CHT_WC_CHGRCTRL1		0x5e17
> +#define CHT_WC_CHGRCTRL1			0x5e17
> +#define CHT_WC_CHGRCTRL1_DBPEN_MASK		BIT(7)
> +#define CHT_WC_CHGRCTRL1_OTGMODE		BIT(6)
> +#define CHT_WC_CHGRCTRL1_FTEMP_EVENT		BIT(5)
> +#define CHT_WC_CHGRCTRL1_FUSB_INLMT_1500	BIT(4)
> +#define CHT_WC_CHGRCTRL1_FUSB_INLMT_900		BIT(3)
> +#define CHT_WC_CHGRCTRL1_FUSB_INLMT_500		BIT(2)
> +#define CHT_WC_CHGRCTRL1_FUSB_INLMT_150		BIT(1)
> +#define CHT_WC_CHGRCTRL1_FUSB_INLMT_100		BIT(0)
> +
>   
>   #define CHT_WC_USBSRC			0x5e29
>   #define CHT_WC_USBSRC_STS_MASK		GENMASK(1, 0)
> @@ -198,6 +207,29 @@ static void cht_wc_extcon_set_5v_boost(struct cht_wc_extcon_data *ext,
>   		dev_err(ext->dev, "Error writing Vbus GPIO CTLO: %d\n", ret);
>   }
>   
> +static void cht_wc_extcon_set_otgmode(struct cht_wc_extcon_data *ext,
> +				      bool enable)
> +{
> +	unsigned int chgrctrl1;
> +	int ret;
> +
> +	ret = regmap_read(ext->regmap, CHT_WC_CHGRCTRL1, &chgrctrl1);
> +	if (ret) {
> +		dev_err(ext->dev, "Error reading CHGRCTRL1 reg: %d\n", ret);
> +		return;
> +	}
> +
> +	if (enable)
> +		chgrctrl1 |= CHT_WC_CHGRCTRL1_OTGMODE;
> +	else
> +		chgrctrl1 &= ~(CHT_WC_CHGRCTRL1_OTGMODE);
> +
> +	ret = regmap_write(ext->regmap, CHT_WC_CHGRCTRL1, chgrctrl1);
> +	if (ret)
> +		dev_err(ext->dev,
> +			"Error writing CHGRCTRL1 OTG mode bit: %d\n", ret);
> +}
> +
>   /* Small helper to sync EXTCON_CHG_USB_SDP and EXTCON_USB state */
>   static void cht_wc_extcon_set_state(struct cht_wc_extcon_data *ext,
>   				    unsigned int cable, bool state)
> @@ -222,10 +254,14 @@ static void cht_wc_extcon_pwrsrc_event(struct cht_wc_extcon_data *ext)
>   
>   	id = cht_wc_extcon_get_id(ext, pwrsrc_sts);
>   	if (id == USB_ID_GND) {
> +		cht_wc_extcon_set_otgmode(ext, true);
> +
>   		/* The 5v boost causes a false VBUS / SDP detect, skip */
>   		goto charger_det_done;
>   	}
>   
> +	cht_wc_extcon_set_otgmode(ext, false);
> +
>   	/* Plugged into a host/charger or not connected? */
>   	if (!(pwrsrc_sts & CHT_WC_PWRSRC_VBUS)) {
>   		/* Route D+ and D- to PMIC for future charger detection */
> 
