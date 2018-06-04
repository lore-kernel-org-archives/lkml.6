Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753645AbeFDPBP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:01:15 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37416 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbeFDPBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:01:13 -0400
X-Google-Smtp-Source: ADUXVKIRr/Ur9WvA6i27xDBcc2acaLUvzfjf47ThiOuZZyl1Xsg/AbgKyLU0+woiR8e5hWD9RaDQiQ==
Date: Mon, 4 Jun 2018 08:03:19 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        edubezval@gmail.com, Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] thermal: tsens: Add support for SDM845 platform
Message-ID: <20180604150319.GC510@tuxbook-pro>
References: <cover.1527937396.git.amit.kucheria@linaro.org>
 <7a0f33cff94f41110bdbff14d28d36074fae2a7d.1527937396.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a0f33cff94f41110bdbff14d28d36074fae2a7d.1527937396.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 02 Jun 04:11 PDT 2018, Amit Kucheria wrote:
> diff --git a/drivers/thermal/qcom/tsens-sdm845.c b/drivers/thermal/qcom/tsens-sdm845.c
[..]
> +#define TRDY_OFFSET     0xe4
> +#define TRDY_READY_BIT  BIT(1)

This is bit 0.

> +
> +#define STATUS_OFFSET	0xa0
> +#define LAST_TEMP_MASK	0xfff
> +#define STATUS_VALID_BIT	BIT(21)
> +#define CODE_SIGN_BIT		BIT(11)
> +
> +static int get_temp_sdm845(struct tsens_device *tmdev, int id, int *temp)
> +{
> +	struct tsens_sensor *s = &tmdev->sensor[id];
> +	u32 code;
> +	unsigned int sensor_addr;
> +	int last_temp = 0, last_temp2 = 0, last_temp3 = 0, ret;
> +
> +	ret = regmap_read(tmdev->map, TRDY_OFFSET, &code);
> +	if (ret)
> +		return ret;
> +	if (code & TRDY_READY_BIT)
> +		return -ENODATA;

This section is the only difference from 8996, but this register is
identical to 8996 and 8998. So I think you should add this to
tsens-8996.c and we can use that for 8996, 8998 and sdm845.

Perhaps we should name it tsens-v2, as that seems to be the common
denominator for these, according to the documentation.

Regards,
Bjorn
