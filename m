Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeCNKi3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 06:38:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50374 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751502AbeCNKi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 06:38:28 -0400
Date: Wed, 14 Mar 2018 10:38:23 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Shanker Donthineni <shankerd@codeaurora.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Vikram Sethi <vikrams@codeaurora.org>
Subject: Re: [PATCH] irqchip/gic-v3: Ensure GICR_CTLR.EnableLPI=0 is observed
 before enabling
Message-ID: <20180314103823.roo7qt7htcr27dkt@lakrids.cambridge.arm.com>
References: <1520988601-16705-1-git-send-email-shankerd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520988601-16705-1-git-send-email-shankerd@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 07:50:01PM -0500, Shanker Donthineni wrote:
> The definition of the GICR_CTLR.RWP control bit was expanded to indicate
> status of changing GICR_CTLR.EnableLPI from 1 to 0 is being in progress
> or completed. Software must observe GICR_CTLR.RWP==0 after clearing
> GICR_CTLR.EnableLPI from 1 to 0 and before writing GICR_PENDBASER and/or
> GICR_PROPBASER, otherwise behavior is UNPREDICTABLE.

> +	/* Make sure LPIs are disabled before programming PEND/PROP registers */
> +	if (val & GICR_CTLR_ENABLE_LPIS) {
> +		u32 count = 1000000; /* 1s! */

Please use USEC_PER_SEC from <linux/time64.h>.

> +		/* Wait for GICR_CTLR.RWP==0 or timeout */
> +		while (readl_relaxed(rbase + GICR_CTLR) & GICR_CTLR_RWP) {
> +			if (!count) {
> +				pr_err("CPU%d: Failed to disable LPIs\n",
> +				       smp_processor_id());
> +				return;
> +			}
> +			cpu_relax();
> +			udelay(1);
> +			count--;
> +		};

Please use readl_relaxed_poll_timeout() from <linux/iopoll.h>.

	/* Wait for GICR_CTLR.RWP==0 or timeout */
	ret = readl_relaxed_poll_timeout(rbase + GICR_CTLR, reg,
					 !(reg & GICR_CTLR_RWP), 1,
					 USEC_PER_SEC);
	if (ret) {
		pr_err("CPU%d: Failed to disable LPIs\n",
			smp_processor_id());
		return;
	}

Thanks,
Mark.
