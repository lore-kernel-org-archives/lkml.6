Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753517AbeEKPIr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 11:08:47 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50823 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753120AbeEKPIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 11:08:45 -0400
X-ME-Sender: <xms:_LH1WqslAvTG36Uo6A8On5sMFLPHI2ucXWVhtDTssBRrptuPMNcbuA>
From: Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 1/2] arm64: arch_timer: Workaround for Allwinner A64 timer
 instability
To: Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Mark Rutland <Mark.Rutland@arm.com>
References: <20180511022751.9096-1-samuel@sholland.org>
 <20180511022751.9096-2-samuel@sholland.org>
 <058bea48-a19b-d2c2-d5c4-8de7a424ef8a@arm.com>
Message-ID: <e9b0d748-1c99-6eb0-2463-a6103b19e4aa@sholland.org>
Date: Fri, 11 May 2018 10:08:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <058bea48-a19b-d2c2-d5c4-8de7a424ef8a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/18 03:48, Marc Zyngier wrote:
> [+Mark, who co-maintains the arch timer code with me]
> 
> Hi Samuel,
> 
> On 11/05/18 03:27, Samuel Holland wrote:
>> The Allwinner A64 SoC is known [1] to have an unstable architectural
>> timer, which manifests itself most obviously in the time jumping forward
>> a multiple of 95 years [2][3]. This coincides with 2^56 cycles at a
>> timer frequency of 24 MHz, implying that the time went slightly backward
>> (and this was interpreted by the kernel as it jumping forward and
>> wrapping around past the epoch).
>>
>> Further investigation revealed instability in the low bits of CNTVCT at
>> the point a high bit rolls over. This leads to power-of-two cycle
>> forward and backward jumps. (Testing shows that forward jumps are about
>> twice as likely as backward jumps.)
>>
>> Without trapping reads to CNTVCT, a userspace program is able to read it
>> in a loop faster than it changes. A test program running on all 4 CPU
>> cores that reported jumps larger than 100 ms was run for 13.6 hours and
>> reported the following:
>>
>>  Count | Event
>> -------+---------------------------
>>   9940 | jumped backward      699ms
>>    268 | jumped backward     1398ms
>>      1 | jumped backward     2097ms
>>  16020 | jumped forward       175ms
>>   6443 | jumped forward       699ms
>>   2976 | jumped forward      1398ms
>>      9 | jumped forward    356516ms
>>      9 | jumped forward    357215ms
>>      4 | jumped forward    714430ms
>>      1 | jumped forward   3578440ms
>>
>> This works out to a jump larger than 100 ms about every 5.5 seconds on
>> each CPU core.
>>
>> The largest jump (almost an hour!) was the following sequence of reads:
>>       0x0000007fffffffff → 0x00000093feffffff → 0x0000008000000000
>>
>> Note that the middle bits don't necessarily all read as all zeroes or
>> all ones during the anomalous behavior; however the low 11 bits checked
>> by the function in this patch have never been observed with any other
>> value.
>>
>> Also note that smaller jumps are much more common, with the smallest
>> backward jumps of 2048 cycles observed over 400 times per second on each
>> core. (Of course, this is partially due to lower bits rolling over more
>> frequently.) Any one of these could have caused the 95 year time skip.
>>
>> Similar anomalies were observed while reading CNTPCT (after patching the
>> kernel to allow reads from userspace). However, the jumps are much less
>> frequent, and only small jumps were observed. The same program as before
>> (except now reading CNTPCT) observed after 72 hours:
>>
>>  Count | Event
>> -------+---------------------------
>>     17 | jumped backward      699ms
>>     52 | jumped forward       175ms
>>   2831 | jumped forward       699ms
>>      5 | jumped forward      1398ms
>>
>> ========================================================================
>>
>> Because the CPU can read the CNTPCT/CNTVCT registers faster than they
>> change, performing two reads of the register and comparing the high bits
>> (like other workarounds) is not a workable solution. And because the
>> timer can jump both forward and backward, no pair of reads can
>> distinguish a good value from a bad one. The only way to guarantee a
>> good value from consecutive reads would be to read _three_ times, and
>> take the middle value iff the three values are 1) individually unique
>> and 2) increasing. This takes at minimum 3 cycles (125 ns), or more if
>> an anomaly is detected.
>>
>> However, since there is a distinct pattern to the bad values, we can
>> optimize the common case (2046/2048 of the time) to a single read by
>> simply ignoring values that match the pattern. This still takes no more
>> than 3 cycles in the worst case, and requires much less code.
> 
> Thanks for the thorough description of the problem. A couple of questions:
> 
> - Have the 000/7ff values of the bottom bits only been experimentally
> found? Or do you have more concrete evidence of this is what happens in
> the HW?

Only experimentally found. Here's a sample of the larger jumps:

CPU 3: 0x000000a5ebffffff → 0x000000a5edffffff (retry = 0x000000a5ec000000)
CPU 1: 0x000000a5ebffffff → 0x000000a5edffffff (retry = 0x000000a5ec000000)
CPU 1: 0x000000a5ecffffff > 0x000000a5ec000000 (retry = 0x000000a5ed000000)
CPU 0: 0x000000a5eeffffff > 0x000000a5ee000000 (retry = 0x000000a5ef000000)
CPU 2: 0x000000a5f0bfffff → 0x000000a5f0ffffff (retry = 0x000000a5f0c00000)
CPU 0: 0x000000a5f0ffffff > 0x000000a5f0000000 (retry = 0x000000a5f1000000)
CPU 2: 0x000000a5f3ffffff > 0x000000a5f2000000 (retry = 0x000000a5f4000000)
CPU 0: 0x000000a5f6ffffff > 0x000000a5f6000000 (retry = 0x000000a5f7000000)
CPU 1: 0x000000a5fbbfffff → 0x000000a5fbffffff (retry = 0x000000a5fbc00000)
CPU 0: 0x000000a5fdffffff → 0x000000a5feffffff (retry = 0x000000a5fe000000)
CPU 2: 0x000000a5ffffffff → 0x000000a7fe000000 (retry = 0x000000a600000000)
CPU 3: 0x000000a5ffffffff → 0x000000a7fe000000 (retry = 0x000000a600000000)
CPU 1: 0x000000a603bfffff → 0x000000a603ffffff (retry = 0x000000a603c00000)
CPU 1: 0x000000a607bfffff → 0x000000a607ffffff (retry = 0x000000a607c00000)
CPU 3: 0x000000a60cbfffff → 0x000000a60cffffff (retry = 0x000000a60cc00000)
CPU 2: 0x000000a60cbfffff → 0x000000a60cffffff (retry = 0x000000a60cc00000)
CPU 2: 0x000000a60dffffff → 0x000000a60effffff (retry = 0x000000a60e000000)
CPU 0: 0x000000a60e3fffff → 0x000000a60e7fffff (retry = 0x000000a60e400000)
CPU 1: 0x000000a60effffff > 0x000000a60e000000 (retry = 0x000000a60f000000)

(Note that for the large jump, 0x000000a5ffffffff → 0x000000a7fe000000, not
all of the low bits are zeroes during the transition.)

And of the tiny jumps backward:

CPU 3: 0x000000d2f010bfff > 0x000000d2f010b800 (retry = 0x000000d2f010b801)
CPU 3: 0x000000d2f0110fff > 0x000000d2f0110800 (retry = 0x000000d2f0110801)
CPU 3: 0x000000d2f0112fff > 0x000000d2f0112800 (retry = 0x000000d2f0112801)
CPU 3: 0x000000d2f0119fff > 0x000000d2f0119800 (retry = 0x000000d2f0119801)
CPU 3: 0x000000d2f011f7ff > 0x000000d2f011f000 (retry = 0x000000d2f011f800)
CPU 3: 0x000000d2f01257ff > 0x000000d2f0125000 (retry = 0x000000d2f0125800)
CPU 3: 0x000000d2f012b7ff > 0x000000d2f012b000 (retry = 0x000000d2f012b800)
CPU 3: 0x000000d2f01317ff > 0x000000d2f0131000 (retry = 0x000000d2f0131800)
CPU 2: 0x000000d2f00c17ff > 0x000000d2f00c1000 (retry = 0x000000d2f00c1800)
CPU 2: 0x000000d2f0136fff > 0x000000d2f0136800 (retry = 0x000000d2f0136801)
CPU 2: 0x000000d2f01377ff > 0x000000d2f0137000 (retry = 0x000000d2f0137800)
CPU 2: 0x000000d2f013afff > 0x000000d2f013a800 (retry = 0x000000d2f013a801)
CPU 2: 0x000000d2f01417ff > 0x000000d2f0141000 (retry = 0x000000d2f0141800)
CPU 2: 0x000000d2f0142fff > 0x000000d2f0142800 (retry = 0x000000d2f0142801)
CPU 2: 0x000000d2f01497ff > 0x000000d2f0149000 (retry = 0x000000d2f0149800)
CPU 2: 0x000000d2f014b7ff > 0x000000d2f014b000 (retry = 0x000000d2f014b800)
CPU 2: 0x000000d2f0150fff > 0x000000d2f0150800 (retry = 0x000000d2f0150801)
CPU 2: 0x000000d2f01577ff > 0x000000d2f0157000 (retry = 0x000000d2f0157800)
CPU 2: 0x000000d2f015d7ff > 0x000000d2f015d000 (retry = 0x000000d2f015d800)
CPU 2: 0x000000d2f015f7ff > 0x000000d2f015f000 (retry = 0x000000d2f015f800)
CPU 2: 0x000000d2f01617ff > 0x000000d2f0161000 (retry = 0x000000d2f0161800)
CPU 2: 0x000000d2f0166fff > 0x000000d2f0166800 (retry = 0x000000d2f0166801)
CPU 2: 0x000000d2f0168fff > 0x000000d2f0168800 (retry = 0x000000d2f0168801)
CPU 2: 0x000000d2f016b7ff > 0x000000d2f016b000 (retry = 0x000000d2f016b800)

I have close to 100 hours of data, and the "bottom 11 bits" value came from
the observations that:
1) Jumps by 2048 cycles were the smallest jumps seen
2) Even when the anomalous values were not all ones/all zeroes, the bottom
   11 bits _were_ all ones/all zeroes

I'd be happy to run more tests if there's something else you think I should
look for.

> - Do you have an official erratum number from the silicon vendor, so
> that Documentation/arm64/silicon-errata.txt can be kept up to date?

No, unfortunately the only information we have from the vendor is in the
form of BSP kernel code drops. There _is_ a workaround present in their
official sources [1], but it looks to be for a different issue (one that I
haven't experienced).

[1]
https://github.com/Allwinner-Homlet/H6-BSP4.9-linux/blob/e634a960316d/drivers/clocksource/arm_arch_timer.c#L272-L327

>>
>> [1]: https://github.com/armbian/build/commit/a08cd6fe7ae9
>> [2]: https://forum.armbian.com/topic/3458-a64-datetime-clock-issue/
>> [3]: https://irclog.whitequark.org/linux-sunxi/2018-01-26
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>  drivers/clocksource/Kconfig          | 11 ++++++++++
>>  drivers/clocksource/arm_arch_timer.c | 39 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 50 insertions(+)
>>
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index 8e8a09755d10..7a5d434dd30b 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -364,6 +364,17 @@ config ARM64_ERRATUM_858921
>>  	  The workaround will be dynamically enabled when an affected
>>  	  core is detected.
>>  
>> +config SUN50I_A64_UNSTABLE_TIMER
>> +	bool "Workaround for Allwinner A64 timer instability"
>> +	default y
>> +	depends on ARM_ARCH_TIMER && ARM64 && ARCH_SUNXI
>> +	select ARM_ARCH_TIMER_OOL_WORKAROUND
>> +	help
>> +	  This option enables a workaround for instability in the timer on
>> +	  the Allwinner A64 SoC. The workaround will only be active if the
>> +	  allwinner,sun50i-a64-unstable-timer property is found in the
>> +	  timer node.
>> +
>>  config ARM_GLOBAL_TIMER
>>  	bool "Support for the ARM global timer" if COMPILE_TEST
>>  	select TIMER_OF if OF
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index 57cb2f00fc07..66ce13578c52 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -319,6 +319,36 @@ static u64 notrace arm64_858921_read_cntvct_el0(void)
>>  }
>>  #endif
>>  
>> +#ifdef CONFIG_SUN50I_A64_UNSTABLE_TIMER
>> +/*
>> + * The low bits of each register can transiently read as all ones or all zeroes
>> + * when bit 11 or greater rolls over. Since the value can jump both backward
>> + * (7ff -> 000 -> 800) and forward (7ff -> fff -> 800), it is simplest to just
>> + * ignore register values with all ones or zeros in the low bits.
>> + */
>> +static u64 notrace sun50i_a64_read_cntpct_el0(void)
>> +{
>> +	u64 val;
>> +
>> +	do {
>> +		val = read_sysreg(cntpct_el0);
>> +	} while (((val + 1) & GENMASK(10, 0)) <= 1);
> 
> Other workarounds of the same kind have a bounded loop. Have you done
> any investigation on how many loops you need at most to sort the timer?
> Depending on how many loops you need, it might be worth sticking a WFE
> here to just wait for something to happen instead of busy looping.

The worst case delay inside the loop is two timer cycles at 24 MHz (83.3 ns).
So the number of iterations depends on the CPU speed. For example:

0x???4ffe -> read once and return
0x???4fff -> read and loop (((val + 1) & GENMASK(10, 0)) == 0)
0x???5000 -> read and loop (((val + 1) & GENMASK(10, 0)) == 1)
0x???5001 -> read once and return

Now of course this function could be preempted, in which case it most likely
does even fewer reads. (The probability of "read 0x???4fff", "preempt", "read
0x???5fff" is pretty low.)

I do not think it is possible to know if an 000/7ff value is valid without
reading three unique values from the timer. So the latency entirely depends
on the timer frequency, not the CPU speed.

>> +
>> +	return val;
>> +}
>> +
>> +static u64 notrace sun50i_a64_read_cntvct_el0(void)
>> +{
>> +	u64 val;
>> +
>> +	do {
>> +		val = read_sysreg(cntvct_el0);
>> +	} while (((val + 1) & GENMASK(10, 0)) <= 1);
>> +
>> +	return val;
>> +}
>> +#endif
>> +
>>  #ifdef CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND
>>  DEFINE_PER_CPU(const struct arch_timer_erratum_workaround *, timer_unstable_counter_workaround);
>>  EXPORT_SYMBOL_GPL(timer_unstable_counter_workaround);
>> @@ -408,6 +438,15 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
>>  		.read_cntvct_el0 = arm64_858921_read_cntvct_el0,
>>  	},
>>  #endif
>> +#ifdef CONFIG_SUN50I_A64_UNSTABLE_TIMER
>> +	{
>> +		.match_type = ate_match_dt,
>> +		.id = "allwinner,sun50i-a64-unstable-timer",
>> +		.desc = "Allwinner A64 timer instability",
>> +		.read_cntpct_el0 = sun50i_a64_read_cntpct_el0,
>> +		.read_cntvct_el0 = sun50i_a64_read_cntvct_el0,
>> +	},
>> +#endif
>>  };
>>  
>>  typedef bool (*ate_match_fn_t)(const struct arch_timer_erratum_workaround *,
>>
> 
> Thanks,
> 
> 	M.
> 
