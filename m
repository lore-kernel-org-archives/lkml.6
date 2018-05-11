Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeEKJZX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 05:25:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38586 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752272AbeEKJZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 05:25:22 -0400
Subject: Re: [PATCH 0/2] Allwinner A64 timer workaround
To: Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180511022751.9096-1-samuel@sholland.org>
From: Andre Przywara <andre.przywara@arm.com>
Message-ID: <9d12075e-745d-b7d7-9847-f1493fc8647e@arm.com>
Date: Fri, 11 May 2018 10:24:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180511022751.9096-1-samuel@sholland.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/05/18 03:27, Samuel Holland wrote:
> Hello,
> 
> Several people (including me) have experienced extremely large system
> clock jumps on their A64-based devices, apparently due to the
> architectural timer going backward, which is interpreted by Linux as
> the timer wrapping around after 2^56 cycles.

So I experienced this before, though I didn't see actual clock jumps,
only that subsequent reads of CNTVCT_EL0, both directly via mrs and
indirectly via CLOCK_MONOTONIC, from userland (triggered by a directed
test) *sometimes* went backwards, with a number of '1's in the lower bits.
But that didn't happen on every boot, and I was suspecting that some
timer setup was missing on the hardware/firmware side. And later on I
failed to reproduce it anymore.
So do you see it on every boot, with recent U-Boot/ATF?

Cheers,
Andre.

> Investigation led to discovery of some obvious problems with this SoC's
> architectural timer, and this patch series introduces what I believe is
> the simplest workaround. More details are in the commit message for
> patch 1. Patch 2 simply enables the workaround in the device tree.
> 
> Thanks,
> Samuel
> 
> Samuel Holland (2):
>   arm64: arch_timer: Workaround for Allwinner A64 timer instability
>   arm64: dts: allwinner: a64: Enable A64 timer workaround
> 
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  1 +
>  drivers/clocksource/Kconfig                   | 11 ++++++++
>  drivers/clocksource/arm_arch_timer.c          | 39 +++++++++++++++++++++++++++
>  3 files changed, 51 insertions(+)
> 
> --
> 2.16.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
