Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752675AbeCUSHR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 14:07:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:25924 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752454AbeCUSHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 14:07:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,340,1517904000";
   d="scan'208";a="26403894"
Message-ID: <1521655629.23017.84.camel@linux.intel.com>
Subject: Re: [PATCH v3 3/3] pinctrl: qcom: Don't allow protected pins to be
 requested
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Stephen Boyd <swboyd@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Grant Likely <grant.likely@secretlab.ca>, linux-gpio@vger.kernel.org
Date: Wed, 21 Mar 2018 20:07:09 +0200
In-Reply-To: <20180321165848.89751-4-swboyd@chromium.org>
References: <20180321165848.89751-1-swboyd@chromium.org>
         <20180321165848.89751-4-swboyd@chromium.org>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-21 at 09:58 -0700, Stephen Boyd wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> Some qcom platforms make some GPIOs or pins unavailable for use
> by non-secure operating systems, and thus reading or writing the
> registers for those pins will cause access control issues and
> reset the device. With a DT/ACPI property to describe the set of
> pins that are available for use, parse the available pins and set
> the irq valid bits for gpiolib to know what to consider 'valid'.
> This should avoid any issues with gpiolib. Furthermore, implement
> the pinmux_ops::request function so that pinmux can also make
> sure to not use pins that are unavailable.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Hmm...

> +static int msm_pinmux_request(struct pinctrl_dev *pctldev, unsigned
> offset)
> +{
> +	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
> +	struct gpio_chip *chip = &pctrl->chip;
> +
> +	if (gpiochip_line_is_valid(chip, offset))
> +		return 0;
> +
> +	return -EINVAL;

Perhaps traditional pattern

if (!...)
 return -EINVAL;

return 0;

?

> +}

>  	seq_printf(s, " %dmA", msm_regval_to_drive(drive));
> -	seq_printf(s, " %s", pulls[pull]);
> +	seq_printf(s, " %s\n", pulls[pull]);

I had commented this once, but you ignored by some reason.

I would rather just move 
 seq_puts(s, "\n");
here.

The rationale behind, besides making diff more neat, is to reduce
possible burden in the future if someone would like to squeeze more data
in between.

> +		tmp = kmalloc_array(len, sizeof(tmp[0]), GFP_KERNEL);

sizeof(*tmp) ?

> +		if (!tmp)
> +			return -ENOMEM;

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
