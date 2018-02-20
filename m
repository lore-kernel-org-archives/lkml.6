Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752897AbeBTSH7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 13:07:59 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46034 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751376AbeBTSH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 13:07:58 -0500
Subject: Re: [PATCH v3 6/7] arm: dts: sun8i: a83t: Fix undefined offset with
 virtual timer
To: =?UTF-8?Q?Myl=c3=a8ne_Josserand?= <mylene.josserand@bootlin.com>,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, quentin.schulz@bootlin.com,
        linux-kernel@vger.kernel.org, clabbe.montjoie@gmail.com,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org
References: <20180219081837.15482-1-mylene.josserand@bootlin.com>
 <20180219081837.15482-7-mylene.josserand@bootlin.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <823f256a-3240-7bb4-cc0b-711108f3076c@arm.com>
Date: Tue, 20 Feb 2018 18:07:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180219081837.15482-7-mylene.josserand@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mylène,

On 19/02/18 08:18, Mylène Josserand wrote:
> The ARM architected timers use an offset between their physical and
> virtual counters. That offset should be configured by the bootloader
> in CNTVOFF.
> 
> However, the A83t bootloader fails to do so, and we end up with an
> undefined offset (which in our case is random), meaning that each CPU
> will have a different time, which isn't working very well.
> 
> Fix that by setting the arm,cpu-registers-not-fw-configured that will
> make Linux use the physical timers instead of the virtual ones. One
> possible side effect would be that the virtualization features would
> be disabled. However, due to the way the GIC has been integrated in
> the system, it is already unusable so we're effectively not losing any
> feature.
> 
> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> index e97a6d17b8d0..b9bdb891cf2f 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -123,6 +123,7 @@
>  			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>  			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>  			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> +		arm,cpu-registers-not-fw-configured;
>  	};
>  
>  	clocks {
> 

Is the firmware dropping you in the kernel in secure or non-secure mode?

If the later, what you have is the only solution. If the former, that
I'd suggest you adopt what we already have for the Renesas stuff (see
arch/arm/mach-shmobile/headsmp-apmu.S and commit 3fd45a136ff6).

It would allow you to use the virtual timer as intended.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
