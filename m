Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeDQCY7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 22:24:59 -0400
Received: from vps.xff.cz ([195.181.215.36]:39316 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752306AbeDQCY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 22:24:57 -0400
Date: Tue, 17 Apr 2018 04:15:00 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <doudahwezomiechahtah@xff.cz>
To: =?utf-8?Q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: linux@armlinux.org.uk, maxime.ripard@bootlin.com, wens@csie.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, robh+dt@kernel.org,
        horms@verge.net.au, geert@linux-m68k.org, magnus.damm@gmail.com,
        devicetree@vger.kernel.org, quentin.schulz@bootlin.com,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        clabbe.montjoie@gmail.com, thomas.petazzoni@bootlin.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 00/11] Sunxi: Add SMP support on A83T
Message-ID: <20180417021500.ufcp3fhlcpcu7vmt@core>
Mail-Followup-To: =?utf-8?Q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>,
        linux@armlinux.org.uk, maxime.ripard@bootlin.com, wens@csie.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, robh+dt@kernel.org,
        horms@verge.net.au, geert@linux-m68k.org, magnus.damm@gmail.com,
        devicetree@vger.kernel.org, quentin.schulz@bootlin.com,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        clabbe.montjoie@gmail.com, thomas.petazzoni@bootlin.com,
        linux-arm-kernel@lists.infradead.org
References: <20180416215032.5023-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180416215032.5023-1-mylene.josserand@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mylène,

Please also add this:

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index ce53ceaf4cc5..d9c8ecf88ec6 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -51,7 +51,7 @@ config MACH_SUN9I
 config ARCH_SUNXI_MC_SMP
        bool
        depends on SMP
-   default MACH_SUN9I
+ default MACH_SUN9I || MACH_SUN8I
        select ARM_CCI400_PORT_CTRL
        select ARM_CPU_SUSPEND

Because otherwise when I'm building kernel just for sun8i and I don't have sun9i
enabled, this new SMP code for A83T (which is sun8i) will not be built.

thank you,
  Ondrej

On Mon, Apr 16, 2018 at 11:50:21PM +0200, Mylène Josserand wrote:
> Hello everyone,
> 
> This is a V6 of my series that adds SMP support for Allwinner sun8i-a83t.
> Based on sunxi's tree, sunxi/for-next branch.
> Depends on a patch from Doug Berger that allows to include the "cpu-type"
> header on assembly files:
> 6c7dd080ba4b ("ARM: Allow this header to be included by assembly files")
> 
> This new series refactors the shmobile code to use the function introduced
> in this series: "secure_cntvoff_init".
> Geert Uytterhoeven and Simon Horman, could you review and test this series
> on Renesas boards? Thank you very much!
> 
> If you have any remarks/questions, let me know.
> Thank you in advance,
> Mylène
> 
> Changes since v5:
>     - Remove my patch 01 and use the patch of Doug Berger to be able to
>     include the cpu-type header on assembly files.
>     - Rename smp_init_cntvoff function into secure_cntvoff_init according
>     to Marc Zyngier's review.
>     - According to Chen-Yu and Maxime's reviews, remove the patch that was
>     moving structures. Instead of using an index to retrieve which
>     architecture we are having, use a global variable.
>     - Merge the 2 patches that move assembly code from C to assembly file.
>     - Use a sun8i field instead of sun9i to know on which architecture we
>     are using because many modifications/additions of the code are for
>     sun8i-a83t.
>     - Rework the patch "add is_sun8i field" to add only this field in this
>     patch. The part of the patch that was starting to handle the differences
>     between sun8i-a83t and sun9i-a80 is merged in the patch that adds the
>     support of sun8i-a83t.
>     - Add a new patch that refactor the shmobile code to use the new function
>     secure_cntvoff_init introduced in this series.
> 
> Changes since v4:
>     - Rebased my series according to new Chen-Yu series:
>        "ARM: sunxi: Clean and improvements for multi-cluster SMP"
>        https://lkml.org/lkml/2018/3/8/886
>     - Updated my series according to Marc Zyngier's reviews to add CNTVOFF
>     initialization's function into ARM's common part. Thanks to that, other
>     platforms such as Renesa can use this function.
>     - For boot CPU, create a new machine to handle the CNTVOFF initialization
>     using "init_early" callback.
> Changes since v3:
>     - Take into account Maxime's reviews:
> 	- split the first patch into 4 new patches: add sun9i device tree
> 	parsing, rename some variables, add a83t support and finally,
> 	add hotplug support.
> 	- Move the code of previous patch 07 (to disable CPU0 disabling)
> 	into hotplug support patch (see patch 04)
> 	- Remove the patch that added PRCM register because it is already
> 	available. Because of that, update the device tree parsing to use
> 	"sun8i-a83t-r-ccu".
> 	- Use a variable to know which SoC we currently have
>     - Take into account Chen-Yu's reviews: create two iounmap functions
>     to release the resources of the device tree parsing.
>     - Take into account Marc's review: Update the code to initialize CNTVOFF
>     register. As there is already assembly code in the driver, I decided
>     to create an assembly file not to mix assembly and C code.
>     For that, I create 3 new patches: move the current assembly code that
>     handles the cluster cache enabling into a file, move the cpu_resume entry
>     in this file and finally, add a new assembly entry to initialize the timer
>     offset for boot CPU and secondary CPUs.
> 
> Changes since v2:
>     - Rebased my modifications according to new Chen Yu's patch series
>     that adds SMP support for sun9i-a80 (without MCPM).
>     - Split the device-tree patches into 3 patches for CPUCFG, R_CPUCFG
>     and PRCM registers for more visibility.
>     - The hotplug of CPU0 is currently not working (even after trying what
>     Allwinner's code is doing) so remove the possibility of disabling
>     this CPU. Created a new patch for it.
> 
> Changes since v1:
>     - Add Chen Yu's patch in my series (see path 01)
>     - Add new compatibles for prcm and cpucfg registers for sun8i-a83t.
>     Create two functions to separate the DT parsing of sun9i-a80 and
>     sun8i-a83t.
>     - Thanks to Maxime's review: order device tree's nodes according
>     to physical addresses, remove unused label and fix registers' sizes.
>     Update the commit log and commit title of my last patch (see
>     patch 05).
> 
> Mylène Josserand (11):
>   ARM: sunxi: smp: Move assembly code into a file
>   ARM: dts: sun8i: Add CPUCFG device node for A83T dtsi
>   ARM: dts: sun8i: Add R_CPUCFG device node for the A83T dtsi
>   ARM: dts: sun8i: a83t: Add CCI-400 node
>   ARM: smp: Add initialization of CNTVOFF
>   ARM: sunxi: Add initialization of CNTVOFF
>   ARM: sun9i: smp: Rename clusters's power-off
>   ARM: sun9i: smp: Add is_sun8i field
>   ARM: sun8i: smp: Add support for A83T
>   ARM: dts: sun8i: Add enable-method for SMP support for the A83T SoC
>   ARM: shmobile: Convert file to use cntvoff
> 
>  arch/arm/boot/dts/sun8i-a83t.dtsi        |  59 ++++++++
>  arch/arm/common/Makefile                 |   1 +
>  arch/arm/common/secure_cntvoff.S         |  31 ++++
>  arch/arm/include/asm/secure_cntvoff.h    |   8 ++
>  arch/arm/mach-shmobile/common.h          |   1 -
>  arch/arm/mach-shmobile/headsmp-apmu.S    |  22 +--
>  arch/arm/mach-shmobile/setup-rcar-gen2.c |   3 +-
>  arch/arm/mach-sunxi/Makefile             |   4 +-
>  arch/arm/mach-sunxi/headsmp.S            |  81 +++++++++++
>  arch/arm/mach-sunxi/mc_smp.c             | 240 +++++++++++++++++++------------
>  arch/arm/mach-sunxi/sunxi.c              |  20 ++-
>  11 files changed, 349 insertions(+), 121 deletions(-)
>  create mode 100644 arch/arm/common/secure_cntvoff.S
>  create mode 100644 arch/arm/include/asm/secure_cntvoff.h
>  create mode 100644 arch/arm/mach-sunxi/headsmp.S
> 
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
