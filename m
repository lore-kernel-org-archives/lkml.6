Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC11C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA05C206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfBTNI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:08:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:50328 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbfBTNI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:08:57 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 05:08:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,391,1544515200"; 
   d="scan'208";a="135749175"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga002.jf.intel.com with ESMTP; 20 Feb 2019 05:08:54 -0800
Received: from andy by smile with local (Exim 4.92-RC6)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gwRcL-0003t2-TX; Wed, 20 Feb 2019 15:08:53 +0200
Date:   Wed, 20 Feb 2019 15:08:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 2/2] extcon intel-cht-wc: Enable external charger
Message-ID: <20190220130853.GQ9224@smile.fi.intel.com>
References: <20190219212441.19391-1-jekhor@gmail.com>
 <20190219212441.19391-3-jekhor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219212441.19391-3-jekhor@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 12:24:41AM +0300, Yauhen Kharuzhy wrote:
> In some configuration external charger "#charge enable" signal is
> connected to PMIC. Enable it at device probing to allow charging.
> 
> Save CHGRCTRL0 and CHGDISCTR registers at driver probing and restore
> them at driver unbind to re-enable hardware charging control if it was
> enabled before.
> 
> Tested at Lenovo Yoga Book (YB1-X91L).

My comments below.
After addressing them,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> +#define CHT_WC_CHGDISCTRL_OUTPUT	BIT(0)

Simple _OUT as per documentation.

> +/* 0 - open drain, 1 - regular output */

Regular means push-pull.

> +#define CHT_WC_CHGDISCTRL_DRV_OD_DIS	BIT(4)

_DRV as per documentation.

> +#define CHT_WC_CHGDISCTRL_MODE_HW	BIT(6)

_FN as per documentation.

> +static void cht_wc_extcon_enable_charging(struct cht_wc_extcon_data *ext,
> +					  bool enable)
> +{
> +	unsigned int val;
> +	int ret;
> +

> +	val = enable ? 0 : CHT_WC_CHGDISCTRL_OUTPUT;

Can be assigned in definition block.

> +	ret = regmap_update_bits(ext->regmap, CHT_WC_CHGDISCTRL,
> +				 CHT_WC_CHGDISCTRL_OUTPUT, val);
> +	if (ret)
> +		dev_err(ext->dev, "Error updating CHGDISCTRL reg: %d\n", ret);
> +}

> +	val = enable ? 0 : CHT_WC_CHGDISCTRL_MODE_HW;

> +	ret = regmap_update_bits(ext->regmap, CHT_WC_CHGDISCTRL,
> +			CHT_WC_CHGDISCTRL_MODE_HW, val);

Indentation.

> +	if (ret)
> +		dev_err(ext->dev,
> +			"Error setting sw control for charger enable: %d\n",
> +			ret);

> +static int cht_wc_save_initial_state(struct cht_wc_extcon_data *ext)
> +{
> +	int ret;
> +
> +	/*
> +	 * Save the external charger control output state for restoring it at
> +	 * driver unbinding

You may move "at" to the next line and add a period at the end.

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

-- 
With Best Regards,
Andy Shevchenko


