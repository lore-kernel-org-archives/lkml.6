Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbeEUKyo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 06:54:44 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:37746 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbeEUKyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 06:54:38 -0400
Date: Mon, 21 May 2018 11:54:28 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Ilia Lin <ilialin@codeaurora.org>
Cc: viresh.kumar@linaro.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] cpufreq: Add Kryo CPU scaling driver
Message-ID: <20180521105428.GM17671@n2100.armlinux.org.uk>
References: <1526555955-29960-11-git-send-email-ilialin@codeaurora.org>
 <1526898690-4018-1-git-send-email-ilialin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526898690-4018-1-git-send-email-ilialin@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 01:31:30PM +0300, Ilia Lin wrote:
> +#define SILVER_LEAD	0
> +#define GOLD_LEAD	2

Okay, two different values here, but "GOLD_LEAD" appears unused.

> +	cpu_dev_silver = get_cpu_device(SILVER_LEAD);
> +	if (NULL == cpu_dev_silver)
> +		return -ENODEV;
> +
> +	cpu_dev_gold = get_cpu_device(SILVER_LEAD);
> +	if (NULL == cpu_dev_gold)
> +		return -ENODEV;

get_cpu_device() takes the logical CPU number.  So the above gets CPU 0
each time, and so cpu_dev_silver == cpu_dev_gold here.  So what's the
point of the second get_cpu_device() ?  If it's supposed to be:

	cpu_dev_gold = get_cpu_device(GOLD_LEAD);

That would get CPU 2, but in terms of these defines, it doesn't make that
much sense.  What exactly does "silver lead" and "gold lead" refer to in
these definitions?

> +	opp_silver = dev_pm_opp_set_supported_hw(cpu_dev_silver,&versions,1);
> +	if (IS_ERR(opp_silver)) {
> +		dev_err(cpu_dev_silver, "Failed to set supported hardware\n");
> +		ret = PTR_ERR(opp_silver);
> +		goto free_np;
> +	}
> +
> +	opp_gold = dev_pm_opp_set_supported_hw(cpu_dev_gold,&versions,1);
> +	if (IS_ERR(opp_gold)) {
> +		dev_err(cpu_dev_gold, "Failed to set supported hardware\n");
> +		ret = PTR_ERR(opp_gold);
> +		goto free_opp_silver;
> +	}

Given that cpu_dev_silver == cpu_dev_gold, doesn't the second call to
dev_pm_opp_set_supported_hw() always fail, as opp_table->supported_hw
will be set by the first call?

To me, this driver looks completely useless as it will always fail to
initialise, and I question whether this code has even been runtime
tested.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
