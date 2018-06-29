Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60B7C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50DA27FD8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50DA27FD8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935212AbeF2OoQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:44:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57141 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753194AbeF2OoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:44:14 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DA2D820DD1; Fri, 29 Jun 2018 16:44:11 +0200 (CEST)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id A3703206ED;
        Fri, 29 Jun 2018 16:44:01 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Jason Cooper <jason@lakedaemon.net>,
        Hua Jing <jinghua@marvell.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        stable@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>, Ken Ma <make@marvell.com>,
        Victor Gu <xigu@marvell.com>,
        Neta Zur Hershkovits <neta@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Wilson Ding <dingwei@marvell.com>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 1/2] clk: mvebu: armada-37xx-periph: Fix switching CPU rate from 300Mhz to 1.2GHz
References: <20180619123446.694-1-gregory.clement@bootlin.com>
        <20180619123446.694-2-gregory.clement@bootlin.com>
Date:   Fri, 29 Jun 2018 16:44:02 +0200
In-Reply-To: <20180619123446.694-2-gregory.clement@bootlin.com> (Gregory
        CLEMENT's message of "Tue, 19 Jun 2018 14:34:45 +0200")
Message-ID: <87tvpl4pql.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
 On mar., juin 19 2018, Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> Switching the CPU from the L2 or L3 frequencies (300 and 200 Mhz
> respectively) to L0 frequency (1.2 Ghz) requires a significant amount
> of time to let VDD stabilize to the appropriate voltage. This amount of
> time is large enough that it cannot be covered by the hardware
> countdown register. Due to this, the CPU might start operating at L0
> before the voltage is stabilized, leading to CPU stalls.
>
> To work around this problem, we prevent switching directly from the
> L2/L3 frequencies to the L0 frequency, and instead switch to the L1
> frequency in-between. The sequence therefore becomes:
>
> 1. First switch from L2/L3(200/300MHz) to L1(600MHZ)
> 2. Sleep 20ms for stabling VDD voltage
> 3. Then switch from L1(600MHZ) to L0(1200Mhz).

Do you have any comment on this fix?

Gregory

>
> It is based on the work done by Ken Ma <make@marvell.com>
>
> Cc: stable@vger.kernel.org
> Fixes: 2089dc33ea0e ("clk: mvebu: armada-37xx-periph: add DVFS support for cpu clocks")
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  drivers/clk/mvebu/armada-37xx-periph.c | 38 ++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
> index 6860bd5a37c5..44e4e27eddad 100644
> --- a/drivers/clk/mvebu/armada-37xx-periph.c
> +++ b/drivers/clk/mvebu/armada-37xx-periph.c
> @@ -35,6 +35,7 @@
>  #define CLK_SEL		0x10
>  #define CLK_DIS		0x14
>  
> +#define  ARMADA_37XX_DVFS_LOAD_1 1
>  #define LOAD_LEVEL_NR	4
>  
>  #define ARMADA_37XX_NB_L0L1	0x18
> @@ -507,6 +508,40 @@ static long clk_pm_cpu_round_rate(struct clk_hw *hw, unsigned long rate,
>  	return -EINVAL;
>  }
>  
> +/*
> + * Switching the CPU from the L2 or L3 frequencies (300 and 200 Mhz
> + * respectively) to L0 frequency (1.2 Ghz) requires a significant
> + * amount of time to let VDD stabilize to the appropriate
> + * voltage. This amount of time is large enough that it cannot be
> + * covered by the hardware countdown register. Due to this, the CPU
> + * might start operating at L0 before the voltage is stabilized,
> + * leading to CPU stalls.
> + *
> + * To work around this problem, we prevent switching directly from the
> + * L2/L3 frequencies to the L0 frequency, and instead switch to the L1
> + * frequency in-between. The sequence therefore becomes:
> + * 1. First switch from L2/L3(200/300MHz) to L1(600MHZ)
> + * 2. Sleep 20ms for stabling VDD voltage
> + * 3. Then switch from L1(600MHZ) to L0(1200Mhz).
> + */
> +static void clk_pm_cpu_set_rate_wa(unsigned long rate, struct regmap *base)
> +{
> +	unsigned int cur_level;
> +
> +	if (rate != 1200 * 1000 * 1000)
> +		return;
> +
> +	regmap_read(base, ARMADA_37XX_NB_CPU_LOAD, &cur_level);
> +	cur_level &= ARMADA_37XX_NB_CPU_LOAD_MASK;
> +	if (cur_level <= ARMADA_37XX_DVFS_LOAD_1)
> +		return;
> +
> +	regmap_update_bits(base, ARMADA_37XX_NB_CPU_LOAD,
> +			   ARMADA_37XX_NB_CPU_LOAD_MASK,
> +			   ARMADA_37XX_DVFS_LOAD_1);
> +	msleep(20);
> +}
> +
>  static int clk_pm_cpu_set_rate(struct clk_hw *hw, unsigned long rate,
>  			       unsigned long parent_rate)
>  {
> @@ -537,6 +572,9 @@ static int clk_pm_cpu_set_rate(struct clk_hw *hw, unsigned long rate,
>  			 */
>  			reg = ARMADA_37XX_NB_CPU_LOAD;
>  			mask = ARMADA_37XX_NB_CPU_LOAD_MASK;
> +
> +			clk_pm_cpu_set_rate_wa(rate, base);
> +
>  			regmap_update_bits(base, reg, mask, load_level);
>  
>  			return rate;
> -- 
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
