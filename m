Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41C9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A442720C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfBTMmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:42:10 -0500
Received: from mga07.intel.com ([134.134.136.100]:46491 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfBTMmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:42:10 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 04:42:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,391,1544515200"; 
   d="scan'208";a="145791667"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga004.fm.intel.com with ESMTP; 20 Feb 2019 04:42:07 -0800
Received: from andy by smile with local (Exim 4.92-RC6)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gwRCQ-0003cY-GO; Wed, 20 Feb 2019 14:42:06 +0200
Date:   Wed, 20 Feb 2019 14:42:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 1/2] extcon-intel-cht-wc: Make charger detection
 co-existed with OTG host mode
Message-ID: <20190220124206.GP9224@smile.fi.intel.com>
References: <20190219212441.19391-1-jekhor@gmail.com>
 <20190219212441.19391-2-jekhor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219212441.19391-2-jekhor@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 12:24:40AM +0300, Yauhen Kharuzhy wrote:
> Whiskey Cove Cherry Trail PMIC requires disabling OTG host mode before
> of charger detection procedure. Do this by manipulationg of CHGRCTRL1
> register.
> 
> Source: APCI DSDT code of Lenovo Yoga Book YB1-X91L and open-sourced
> Intel's drivers.

Some minor comments below.

Otherwise,

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> -#define CHT_WC_CHGRCTRL1		0x5e17
> +#define CHT_WC_CHGRCTRL1			0x5e17

Not related change?

> +#define CHT_WC_CHGRCTRL1_DBPEN_MASK		BIT(7)

Drop the _MASK, it's one bit anyway.

> +#define CHT_WC_CHGRCTRL1_OTGMODE		BIT(6)
> +#define CHT_WC_CHGRCTRL1_FTEMP_EVENT		BIT(5)
> +#define CHT_WC_CHGRCTRL1_FUSB_INLMT_1500	BIT(4)
> +#define CHT_WC_CHGRCTRL1_FUSB_INLMT_900		BIT(3)
> +#define CHT_WC_CHGRCTRL1_FUSB_INLMT_500		BIT(2)
> +#define CHT_WC_CHGRCTRL1_FUSB_INLMT_150		BIT(1)
> +#define CHT_WC_CHGRCTRL1_FUSB_INLMT_100		BIT(0)

I think better to keep ascending order.

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

Redundant parens.

> +
> +	ret = regmap_write(ext->regmap, CHT_WC_CHGRCTRL1, chgrctrl1);
> +	if (ret)
> +		dev_err(ext->dev,
> +			"Error writing CHGRCTRL1 OTG mode bit: %d\n", ret);
> +}

-- 
With Best Regards,
Andy Shevchenko


