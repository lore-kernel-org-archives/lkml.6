Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B91C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003F82087B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfBTPxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:53:55 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35749 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfBTPxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:53:55 -0500
Received: by mail-ed1-f68.google.com with SMTP id g19so11294099edp.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 07:53:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LYRmrR4SYmdpmtGw/cCPVdYH6/jklVa1zo3V2K34YYI=;
        b=iNxy6n2sN34yhXrLHJu/f/AuBi2GdGY0VlS0KESTeU3qiEHAa2pnpcxGoWKT/FCgCN
         8kEcB2adxkbRO+mRzu7+E/aE3w4E/Jx0P8dz+pMM3HsS44hZu9IE3MnjsItgR76jt/IK
         9JIE1LHXiJ8QxLtRni+NhUGcayAJq66chh//M3ZM8zSQnJ4l7+pPEioFF98h5v+65jpK
         Zc09BEvJX0ZDvcCrQq1GHNmnvAmsGLxcyr7f11pTD0fEkdZ+6o9JIrxu60hvEChJq3D6
         1xyvpIUmOlxXJHuDlo0KA9YM/BqXqpw/V/S0eV6E55UIJKYuz3MR6NYlsLVBbwsNXdIu
         sE/g==
X-Gm-Message-State: AHQUAuYU2XsUKsiISIzXKzAF9DF76f/Uud0Odrtsz1GiFV4Y/jDv+Jsl
        HbpyBpBxWNFHSpFB2USssi/X5rMl2r0=
X-Google-Smtp-Source: AHgI3IaxTA1f4D9M7Q2aJdcluOwIEYJ031qGpuxZQ/mlo/vEtSPRXeTBs+JFghQ2VmJYk/C/N8FKhA==
X-Received: by 2002:a50:e007:: with SMTP id e7mr28284239edl.10.1550678032806;
        Wed, 20 Feb 2019 07:53:52 -0800 (PST)
Received: from dhcp-44-202.space.revspace.nl ([2a01:4f8:1c0c:6c86:46e0:a7ad:5246:f04d])
        by smtp.gmail.com with ESMTPSA id o6sm2338481ejb.14.2019.02.20.07.53.51
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 07:53:51 -0800 (PST)
Subject: Re: [PATCH v2 2/2] extcon intel-cht-wc: Enable external charger
To:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20190219212441.19391-1-jekhor@gmail.com>
 <20190219212441.19391-3-jekhor@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <19f27109-434d-3e5e-c895-fdec0324572f@redhat.com>
Date:   Wed, 20 Feb 2019 16:53:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190219212441.19391-3-jekhor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/19/19 10:24 PM, Yauhen Kharuzhy wrote:
> In some configuration external charger "#charge enable" signal is
> connected to PMIC. Enable it at device probing to allow charging.
> 
> Save CHGRCTRL0 and CHGDISCTR registers at driver probing and restore
> them at driver unbind to re-enable hardware charging control if it was
> enabled before.
> 
> Tested at Lenovo Yoga Book (YB1-X91L).
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---
>   drivers/extcon/extcon-intel-cht-wc.c | 91 +++++++++++++++++++++++++++-
>   1 file changed, 90 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
> index 4f6ba249bc30..ac009929d244 100644
> --- a/drivers/extcon/extcon-intel-cht-wc.c
> +++ b/drivers/extcon/extcon-intel-cht-wc.c
> @@ -57,6 +57,16 @@
>   #define CHT_WC_USBSRC_TYPE_OTHER	8
>   #define CHT_WC_USBSRC_TYPE_DCP_EXTPHY	9
>   
> +#define CHT_WC_CHGDISCTRL		0x5e2f
> +#define CHT_WC_CHGDISCTRL_OUTPUT	BIT(0)
> +/* 0 - open drain, 1 - regular output */
> +#define CHT_WC_CHGDISCTRL_DRV_OD_DIS	BIT(4)
> +#define CHT_WC_CHGDISCTRL_MODE_HW	BIT(6)
> +
> +#define CHT_WC_CHGDISCTRL_CCSM_DIS	0x11
> +#define CHT_WC_CHGDISCTRL_CCSM_EN	0x00
> +#define CHT_WC_CHGDISCTRL_CCSM_MASK	0x51
> +

You no longer need the last 3 defines and IMHO keeping them
will only confuse the reader of the code, please drop these 3.

>   #define CHT_WC_PWRSRC_IRQ		0x6e03
>   #define CHT_WC_PWRSRC_IRQ_MASK		0x6e0f
>   #define CHT_WC_PWRSRC_STS		0x6e1e
> @@ -103,6 +113,8 @@ struct cht_wc_extcon_data {
>   	struct regmap *regmap;
>   	struct extcon_dev *edev;
>   	unsigned int previous_cable;
> +	unsigned int chgdisctrl_saved;
> +	unsigned int chgrctrl0_saved;
>   	bool usb_host;
>   };
>   
> @@ -230,6 +242,20 @@ static void cht_wc_extcon_set_otgmode(struct cht_wc_extcon_data *ext,
>   			"Error writing CHGRCTRL1 OTG mode bit: %d\n", ret);
>   }
>   
> +static void cht_wc_extcon_enable_charging(struct cht_wc_extcon_data *ext,
> +					  bool enable)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	val = enable ? 0 : CHT_WC_CHGDISCTRL_OUTPUT;
> +
> +	ret = regmap_update_bits(ext->regmap, CHT_WC_CHGDISCTRL,
> +				 CHT_WC_CHGDISCTRL_OUTPUT, val);
> +	if (ret)
> +		dev_err(ext->dev, "Error updating CHGDISCTRL reg: %d\n", ret);
> +}
> +
>   /* Small helper to sync EXTCON_CHG_USB_SDP and EXTCON_USB state */
>   static void cht_wc_extcon_set_state(struct cht_wc_extcon_data *ext,
>   				    unsigned int cable, bool state)
> @@ -254,6 +280,7 @@ static void cht_wc_extcon_pwrsrc_event(struct cht_wc_extcon_data *ext)
>   
>   	id = cht_wc_extcon_get_id(ext, pwrsrc_sts);
>   	if (id == USB_ID_GND) {
> +		cht_wc_extcon_enable_charging(ext, false);
>   		cht_wc_extcon_set_otgmode(ext, true);
>   
>   		/* The 5v boost causes a false VBUS / SDP detect, skip */
> @@ -261,6 +288,7 @@ static void cht_wc_extcon_pwrsrc_event(struct cht_wc_extcon_data *ext)
>   	}
>   
>   	cht_wc_extcon_set_otgmode(ext, false);
> +	cht_wc_extcon_enable_charging(ext, true);
>   
>   	/* Plugged into a host/charger or not connected? */
>   	if (!(pwrsrc_sts & CHT_WC_PWRSRC_VBUS)) {
> @@ -314,6 +342,14 @@ static int cht_wc_extcon_sw_control(struct cht_wc_extcon_data *ext, bool enable)
>   {
>   	int ret, mask, val;
>   
> +	val = enable ? 0 : CHT_WC_CHGDISCTRL_MODE_HW;
> +	ret = regmap_update_bits(ext->regmap, CHT_WC_CHGDISCTRL,
> +			CHT_WC_CHGDISCTRL_MODE_HW, val);
> +	if (ret)
> +		dev_err(ext->dev,
> +			"Error setting sw control for charger enable: %d\n",
> +			ret);
> +
>   	mask = CHT_WC_CHGRCTRL0_SWCONTROL | CHT_WC_CHGRCTRL0_CCSM_OFF;
>   	val = enable ? mask : 0;
>   	ret = regmap_update_bits(ext->regmap, CHT_WC_CHGRCTRL0, mask, val);
> @@ -323,6 +359,52 @@ static int cht_wc_extcon_sw_control(struct cht_wc_extcon_data *ext, bool enable)
>   	return ret;
>   }
>   
> +static int cht_wc_save_initial_state(struct cht_wc_extcon_data *ext)
> +{
> +	int ret;
> +
> +	/*
> +	 * Save the external charger control output state for restoring it at
> +	 * driver unbinding
> +	 */
> +	ret = regmap_read(ext->regmap, CHT_WC_CHGDISCTRL,
> +			  &ext->chgdisctrl_saved);
> +	if (ret) {
> +		dev_err(ext->dev, "Error reading CHGDISCTRL: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_read(ext->regmap, CHT_WC_CHGRCTRL0,
> +			  &ext->chgrctrl0_saved);
> +	if (ret) {
> +		dev_err(ext->dev, "Error reading CHGRCTRL0: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cht_wc_restore_initial_state(struct cht_wc_extcon_data *ext)
> +{
> +	int ret;
> +
> +	ret = regmap_write(ext->regmap, CHT_WC_CHGDISCTRL,
> +			   ext->chgdisctrl_saved);
> +	if (ret)
> +		dev_err(ext->dev, "Error restoring of CHGDISCTRL reg: %d\n",
> +			ret);
> +
> +	ret = regmap_write(ext->regmap, CHT_WC_CHGRCTRL0,
> +			   ext->chgrctrl0_saved);
> +	if (ret)
> +		dev_err(ext->dev, "Error restoring of CHGRCTRL0 reg: %d\n",
> +			ret);
> +
> +	return ret;
> +}
> +
>   static int cht_wc_extcon_probe(struct platform_device *pdev)
>   {
>   	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
> @@ -347,6 +429,8 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
>   	if (IS_ERR(ext->edev))
>   		return PTR_ERR(ext->edev);
>   
> +	cht_wc_save_initial_state(ext);
> +
>   	/*
>   	 * When a host-cable is detected the BIOS enables an external 5v boost
>   	 * converter to power connected devices there are 2 problems with this:
> @@ -365,7 +449,10 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
>   	/* Enable sw control */
>   	ret = cht_wc_extcon_sw_control(ext, true);
>   	if (ret)
> -		return ret;
> +		goto disable_sw_control;
> +
> +	/* Disable charging by external battery charger */
> +	cht_wc_extcon_enable_charging(ext, false);
>   
>   	/* Register extcon device */
>   	ret = devm_extcon_dev_register(ext->dev, ext->edev);
> @@ -400,6 +487,7 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
>   
>   disable_sw_control:
>   	cht_wc_extcon_sw_control(ext, false);
> +	cht_wc_restore_initial_state(ext);

The restore_initial_state will clober al changes made by the
cht_wc_extcon_sw_control call, so we do not need both. Thinking a bit
more about this I think it might be best to drop the state save/restore
code and just enable hw-control on exit unconditionally. We cannot be
sure that te initial state is sane, so just switching to hw-control on
exit seem best and requires less code.  Andy, what is your take on this?

>   	return ret;
>   }
>   
> @@ -408,6 +496,7 @@ static int cht_wc_extcon_remove(struct platform_device *pdev)
>   	struct cht_wc_extcon_data *ext = platform_get_drvdata(pdev);
>   
>   	cht_wc_extcon_sw_control(ext, false);
> +	cht_wc_restore_initial_state(ext);

Idem / same as my prvious comment.

Regards,

Hans
