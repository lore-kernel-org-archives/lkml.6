Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754823AbeDCGUy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 02:20:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34592 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752460AbeDCGUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 02:20:52 -0400
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: linux@armlinux.org.uk, maxime.ripard@bootlin.com, wens@csie.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, thomas.petazzoni@bootlin.com,
        mylene.josserand@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/13] Sunxi: Add SMP support on A83T
Date: Tue,  3 Apr 2018 08:18:23 +0200
Message-Id: <20180403061836.3926-1-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

This is a V5 of my series that adds SMP support for Allwinner sun8i-a83t.
Based on sunxi's tree, sunxi/for-next branch.

For boot CPU, I tried to add the CNTVOFF initialization in mc_smp.c file
(in sunxi_mc_smp_init function) but it is not working.
Instead of adding it in timer's function of sunxi.c file, I create
a new machine to handle this case. Thanks to that, it is specific to
sun8i-a83t SoC. Let me know what you think.

Changes since v4:
    - Rebased my series according to new Chen-Yu series:
       "ARM: sunxi: Clean and improvements for multi-cluster SMP"
       https://lkml.org/lkml/2018/3/8/886
    - Updated my series according to Marc Zyngier's reviews to add CNTVOFF
    initialization's function into ARM's common part. Thanks to that, other
    platforms such as Renesa can use this function.
    - For boot CPU, create a new machine to handle the CNTVOFF initialization
    using "init_early" callback.
Changes since v3:
    - Take into account Maxime's reviews:
	- split the first patch into 4 new patches: add sun9i device tree
	parsing, rename some variables, add a83t support and finally,
	add hotplug support.
	- Move the code of previous patch 07 (to disable CPU0 disabling)
	into hotplug support patch (see patch 04)
	- Remove the patch that added PRCM register because it is already
	available. Because of that, update the device tree parsing to use
	"sun8i-a83t-r-ccu".
	- Use a variable to know which SoC we currently have
    - Take into account Chen-Yu's reviews: create two iounmap functions
    to release the resources of the device tree parsing.
    - Take into account Marc's review: Update the code to initialize CNTVOFF
    register. As there is already assembly code in the driver, I decided
    to create an assembly file not to mix assembly and C code.
    For that, I create 3 new patches: move the current assembly code that
    handles the cluster cache enabling into a file, move the cpu_resume entry
    in this file and finally, add a new assembly entry to initialize the timer
    offset for boot CPU and secondary CPUs.

Changes since v2:
    - Rebased my modifications according to new Chen Yu's patch series
    that adds SMP support for sun9i-a80 (without MCPM).
    - Split the device-tree patches into 3 patches for CPUCFG, R_CPUCFG
    and PRCM registers for more visibility.
    - The hotplug of CPU0 is currently not working (even after trying what
    Allwinner's code is doing) so remove the possibility of disabling
    this CPU. Created a new patch for it.

Changes since v1:
    - Add Chen Yu's patch in my series (see path 01)
    - Add new compatibles for prcm and cpucfg registers for sun8i-a83t.
    Create two functions to separate the DT parsing of sun9i-a80 and
    sun8i-a83t.
    - Thanks to Maxime's review: order device tree's nodes according
    to physical addresses, remove unused label and fix registers' sizes.
    Update the commit log and commit title of my last patch (see
    patch 05).

Patch 01: To be able to use macro definition (such as ARM_CPU_PART_MASK)
in an assembly file, we need to separate macro difinitions and C functions
definitions. This is what this patch is doing.
Patch 02: Move assembly code into a new assembly file
Patch 03: Move another assembly code (resuming function) into above file
Patch 04-06: Add registers nodes (cpucfg, r_cpucfg and cci-400) needed
for SMP bringup.
Patch 07: Create a new assembly file to initialize the CNTVOFF register. Can
be used on other platform so add it in "common" ARM folder.
Patch 08: Create a new machine to initialize the timer offset for boot CPU.
Add a new entry to initialize the timer offset for secondary CPUs.
Patch 09: Prepare to handle sun8i-a83t by renaming some sun9i-a80 functions.
Patch 10: Again a preparation to support sun8i-a83t by moving some structures.
Patch 11: Add a new field to know if we are on sun9i-a80 or sun8i-a83t.
Patch 12: Convert the sunxi SMP driver to add support for A83T.
This SoC has a bit flip that needs to be handled.
Patch 13: Enable the smp support on sun8i-a83t by adding enable-method.

If you have any remarks/questions, let me know.
Thank you in advance,
Mylène

Mylène Josserand (13):
  ARM: move cputype definitions into another file
  ARM: sunxi: smp: Move assembly code into a file
  ARM: sunxi: smp: Move cpu_resume assembly entry into file
  ARM: dts: sun8i: Add CPUCFG device node for A83T dtsi
  ARM: dts: sun8i: Add R_CPUCFG device node for the A83T dtsi
  ARM: dts: sun8i: a83t: Add CCI-400 node
  ARM: smp: Add initialization of CNTVOFF
  ARM: sunxi: Add initialization of CNTVOFF
  ARM: sun9i: smp: Rename clusters's power-off
  ARM: sun9i: smp: Move structures
  ARM: sun9i: smp: Add is_sun9i field
  ARM: sun8i: smp: Add support for A83T
  ARM: dts: sun8i: Add enable-method for SMP support for the A83T SoC

 arch/arm/boot/dts/sun8i-a83t.dtsi  |  59 ++++++++
 arch/arm/common/Makefile           |   1 +
 arch/arm/common/smp_cntvoff.S      |  35 +++++
 arch/arm/include/asm/cputype.h     |  94 +-----------
 arch/arm/include/asm/cputype_def.h |  98 +++++++++++++
 arch/arm/include/asm/smp_cntvoff.h |   8 ++
 arch/arm/mach-sunxi/Makefile       |   4 +-
 arch/arm/mach-sunxi/headsmp.S      |  81 +++++++++++
 arch/arm/mach-sunxi/mc_smp.c       | 287 ++++++++++++++++++++++---------------
 arch/arm/mach-sunxi/sunxi.c        |  18 ++-
 10 files changed, 472 insertions(+), 213 deletions(-)
 create mode 100644 arch/arm/common/smp_cntvoff.S
 create mode 100644 arch/arm/include/asm/cputype_def.h
 create mode 100644 arch/arm/include/asm/smp_cntvoff.h
 create mode 100644 arch/arm/mach-sunxi/headsmp.S

-- 
2.11.0
