Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E54C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1113021479
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1113021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeGLLIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:08:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49546 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbeGLLIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:08:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 429257A9;
        Thu, 12 Jul 2018 03:59:44 -0700 (PDT)
Received: from [10.1.206.75] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65A223F5B1;
        Thu, 12 Jul 2018 03:59:42 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] arm64: arch_timer: Workaround for Allwinner A64
 timer instability
To:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <Mark.Rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20180712022515.7255-1-samuel@sholland.org>
 <20180712022515.7255-2-samuel@sholland.org>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <45ebd533-f41d-0d9f-4979-f565a705a7fa@arm.com>
Date:   Thu, 12 Jul 2018 11:59:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180712022515.7255-2-samuel@sholland.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/18 03:25, Samuel Holland wrote:
> The Allwinner A64 SoC is known [1] to have an unstable architectural
> timer, which manifests itself most obviously in the time jumping forward
> a multiple of 95 years [2][3]. This coincides with 2^56 cycles at a
> timer frequency of 24 MHz, implying that the time went slightly backward
> (and this was interpreted by the kernel as it jumping forward and
> wrapping around past the epoch).
> 
> Further investigation revealed instability in the low bits of CNTVCT at
> the point a high bit rolls over. This leads to power-of-two cycle
> forward and backward jumps. (Testing shows that forward jumps are about
> twice as likely as backward jumps.)
> 
> Without trapping reads to CNTVCT, a userspace program is able to read it
> in a loop faster than it changes. A test program running on all 4 CPU
> cores that reported jumps larger than 100 ms was run for 13.6 hours and
> reported the following:
> 
>  Count | Event
> -------+---------------------------
>   9940 | jumped backward      699ms
>    268 | jumped backward     1398ms
>      1 | jumped backward     2097ms
>  16020 | jumped forward       175ms
>   6443 | jumped forward       699ms
>   2976 | jumped forward      1398ms
>      9 | jumped forward    356516ms
>      9 | jumped forward    357215ms
>      4 | jumped forward    714430ms
>      1 | jumped forward   3578440ms
> 
> This works out to a jump larger than 100 ms about every 5.5 seconds on
> each CPU core.
> 
> The largest jump (almost an hour!) was the following sequence of reads:
>       0x0000007fffffffff → 0x00000093feffffff → 0x0000008000000000
> 
> Note that the middle bits don't necessarily all read as all zeroes or
> all ones during the anomalous behavior; however the low 11 bits checked
> by the function in this patch have never been observed with any other
> value.
> 
> Also note that smaller jumps are much more common, with the smallest
> backward jumps of 2048 (2^11) cycles observed over 400 times per second
> on each core. (Of course, this is partially due to lower bits rolling
> over more frequently.) Any one of these could have caused the 95 year
> time skip.
> 
> Similar anomalies were observed while reading CNTPCT (after patching the
> kernel to allow reads from userspace). However, the CNTPCT jumps are
> much less frequent, and only small jumps were observed. The same program
> as before (except now reading CNTPCT) observed after 72 hours:
> 
>  Count | Event
> -------+---------------------------
>     17 | jumped backward      699ms
>     52 | jumped forward       175ms
>   2831 | jumped forward       699ms
>      5 | jumped forward      1398ms
> 
> ========================================================================
> 
> Because the CPU can read the CNTPCT/CNTVCT registers faster than they
> change, performing two reads of the register and comparing the high bits
> (like other workarounds) is not a workable solution. And because the
> timer can jump both forward and backward, no pair of reads can
> distinguish a good value from a bad one. The only way to guarantee a
> good value from consecutive reads would be to read _three_ times, and
> take the middle value iff the three values are 1) individually unique
> and 2) increasing. This takes at minimum 3 cycles (125 ns), or more if
> an anomaly is detected.
> 
> However, since there is a distinct pattern to the bad values, we can
> optimize the common case (2046/2048 of the time) to a single read by
> simply ignoring values that match the pattern. This still takes no more
> than 3 cycles in the worst case, and requires much less code.
> 
> As an additional safety check, limit the loop iteration based on the
> number of maximum-frequency CPU cycles in three 24 MHz counter periods.
> 
> [1]: https://github.com/armbian/build/commit/a08cd6fe7ae9
> [2]: https://forum.armbian.com/topic/3458-a64-datetime-clock-issue/
> [3]: https://irclog.whitequark.org/linux-sunxi/2018-01-26
> 
> Tested-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  drivers/clocksource/Kconfig          | 11 +++++++++
>  drivers/clocksource/arm_arch_timer.c | 43 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 8e8a09755d10..7a5d434dd30b 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -364,6 +364,17 @@ config ARM64_ERRATUM_858921
>  	  The workaround will be dynamically enabled when an affected
>  	  core is detected.
>  
> +config SUN50I_A64_UNSTABLE_TIMER
> +	bool "Workaround for Allwinner A64 timer instability"
> +	default y
> +	depends on ARM_ARCH_TIMER && ARM64 && ARCH_SUNXI
> +	select ARM_ARCH_TIMER_OOL_WORKAROUND
> +	help
> +	  This option enables a workaround for instability in the timer on
> +	  the Allwinner A64 SoC. The workaround will only be active if the
> +	  allwinner,sun50i-a64-unstable-timer property is found in the
> +	  timer node.
> +

This still missing some documentation in Documentation/arm64/silicon-errata.txt.

Since the silicon vendor has gone AWOL, I suggest the platform maintainers
put together an SoC-specific namespace, and maintain it, so that we track
what is handled where. Something like "AW_SUN50I_UNKOWN_1".

>  config ARM_GLOBAL_TIMER
>  	bool "Support for the ARM global timer" if COMPILE_TEST
>  	select TIMER_OF if OF
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 57cb2f00fc07..4fba50716bda 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -319,6 +319,40 @@ static u64 notrace arm64_858921_read_cntvct_el0(void)
>  }
>  #endif
>  
> +#ifdef CONFIG_SUN50I_A64_UNSTABLE_TIMER
> +/*
> + * The low bits of each register can transiently read as all ones or all zeroes
> + * when bit 11 or greater rolls over. Since the value can jump both backward
> + * (7ff -> 000 -> 800) and forward (7ff -> fff -> 800), it is simplest to just
> + * ignore register values with all ones or zeros in the low bits.
> + *
> + * Bound the loop by the worst-case number of CPU cycles that can occur during
> + * three distinct counter periods.
> + */
> +#define __sun50i_a64_read_reg(reg) ({					\
> +	u64 _val;							\
> +	int _retries = 150;						\
> +									\
> +	do {								\
> +		_val = read_sysreg(reg);				\
> +		_retries--;						\
> +	} while (((_val + 1) & GENMASK(10, 0)) <= 1 && _retries);	\
> +									\
> +	WARN_ON_ONCE(!_retries);					\
> +	_val;								\
> +})
> +
> +static u64 notrace sun50i_a64_read_cntpct_el0(void)
> +{
> +	return __sun50i_a64_read_reg(cntpct_el0);
> +}
> +
> +static u64 notrace sun50i_a64_read_cntvct_el0(void)
> +{
> +	return __sun50i_a64_read_reg(cntvct_el0);
> +}
> +#endif
> +
>  #ifdef CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND
>  DEFINE_PER_CPU(const struct arch_timer_erratum_workaround *, timer_unstable_counter_workaround);
>  EXPORT_SYMBOL_GPL(timer_unstable_counter_workaround);
> @@ -408,6 +442,15 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
>  		.read_cntvct_el0 = arm64_858921_read_cntvct_el0,
>  	},
>  #endif
> +#ifdef CONFIG_SUN50I_A64_UNSTABLE_TIMER
> +	{
> +		.match_type = ate_match_dt,
> +		.id = "allwinner,sun50i-a64-unstable-timer",
> +		.desc = "Allwinner A64 timer instability",
> +		.read_cntpct_el0 = sun50i_a64_read_cntpct_el0,
> +		.read_cntvct_el0 = sun50i_a64_read_cntvct_el0,
> +	},
> +#endif
>  };
>  
>  typedef bool (*ate_match_fn_t)(const struct arch_timer_erratum_workaround *,
> 

As we discussed last week, it is likely that this is not enough to 
address all the problems with this wonderful piece of kit. I strongly
suspect that TVAL read/write is affected as well, due to the implicit
counter read, so it needs to be emulated in SW as well. Something like:

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 4fba50716bda..11d9b53d19da 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -351,6 +351,16 @@ static u64 notrace sun50i_a64_read_cntvct_el0(void)
 {
 	return __sun50i_a64_read_reg(cntvct_el0);
 }
+
+static u32 sun50i_a64_read_cntp_tval_el0(void)
+{
+	return read_sysreg(cntp_cval_el0) - sun50i_a64_read_cntpct_el0();
+}
+
+static u32 sun50i_a64_read_cntv_tval_el0(void)
+{
+	return read_sysreg(cntv_cval_el0) - sun50i_a64_read_cntvct_el0();
+}
 #endif
 
 #ifdef CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND
@@ -447,8 +457,12 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 		.match_type = ate_match_dt,
 		.id = "allwinner,sun50i-a64-unstable-timer",
 		.desc = "Allwinner A64 timer instability",
+		.read_cntp_tval_el0 = sun50i_a64_read_cntp_tval_el0,
+		.read_cntv_tval_el0 = sun50i_a64_read_cntv_tval_el0,
 		.read_cntpct_el0 = sun50i_a64_read_cntpct_el0,
 		.read_cntvct_el0 = sun50i_a64_read_cntvct_el0,
+		.set_next_event_phys = erratum_set_next_event_tval_phys,
+		.set_next_event_virt = erratum_set_next_event_tval_virt,
 	},
 #endif
 };

which is of course completely untested. Let me know if that helps
making the system behave.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
