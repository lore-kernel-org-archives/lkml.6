Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751736AbeEDTGs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 15:06:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42907 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751632AbeEDTGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 15:06:46 -0400
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: linux@armlinux.org.uk, maxime.ripard@bootlin.com, wens@csie.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, robh+dt@kernel.org,
        horms@verge.net.au, geert@linux-m68k.org, magnus.damm@gmail.com
Cc: f.fainelli@gmail.com, opendmb@gmail.com,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mylene.josserand@bootlin.com
Subject: [PATCH v9 00/12] Sunxi: Add SMP support on A83T
Date: Fri,  4 May 2018 21:05:33 +0200
Message-Id: <20180504190545.5114-1-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

This is a V9 of my series that adds SMP support for Allwinner sun8i-a83t.
Based on sunxi's tree, sunxi/for-next branch.
Depends on a patch from Doug Berger that allows to include the "cpu-type"
header on assembly files that I included in my series (patch 01).

The difference with the v8 is just that the machine is renamed in sun8i-a83t
(see patch 07), according to Maxime's review.

Thank you in advance,
Best regards,
Mylène

Changes from v8:
    - Rename machine into "sun8i-a83t"

Changes from v7:
    - Add the patch of Doug Berger in my series.
    - Rename the machine name to start secure_cntvoff into "sun8i-a83t",
    according to Maxime's review.
    - Change the type of is_a83t field from integer into boolean.

Changes from v6:
    - Correct the commit log on patch 07 according to Sergei Shtylyov's
    review.
    - Rename the field "is_sun8i" into "is_a83t".
    - Add all Tested-by and Reviewed-by from previous version.

Changes from v5:
    - Remove my patch 01 and use the patch of Doug Berger to be able to
    include the cpu-type header on assembly files.
    - Rename smp_init_cntvoff function into secure_cntvoff_init according
    to Marc Zyngier's review.
    - According to Chen-Yu and Maxime's reviews, remove the patch that was
    moving structures. Instead of using an index to retrieve which
    architecture we are having, use a global variable.
    - Merge the 2 patches that move assembly code from C to assembly file.
    - Use a sun8i field instead of sun9i to know on which architecture we
    are using because many modifications/additions of the code are for
    sun8i-a83t.
    - Rework the patch "add is_sun8i field" to add only this field in this
    patch. The part of the patch that was starting to handle the differences
    between sun8i-a83t and sun9i-a80 is merged in the patch that adds the
    support of sun8i-a83t.
    - Add a new patch that refactor the shmobile code to use the new function
    secure_cntvoff_init introduced in this series.

Changes from v4:
    - Rebased my series according to new Chen-Yu series:
       "ARM: sunxi: Clean and improvements for multi-cluster SMP"
       https://lkml.org/lkml/2018/3/8/886
    - Updated my series according to Marc Zyngier's reviews to add CNTVOFF
    initialization's function into ARM's common part. Thanks to that, other
    platforms such as Renesa can use this function.
    - For boot CPU, create a new machine to handle the CNTVOFF initialization
    using "init_early" callback.

Changes from v3:
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

Changes from v2:
    - Rebased my modifications according to new Chen Yu's patch series
    that adds SMP support for sun9i-a80 (without MCPM).
    - Split the device-tree patches into 3 patches for CPUCFG, R_CPUCFG
    and PRCM registers for more visibility.
    - The hotplug of CPU0 is currently not working (even after trying what
    Allwinner's code is doing) so remove the possibility of disabling
    this CPU. Created a new patch for it.

Changes from v1:
    - Add Chen Yu's patch in my series (see path 01)
    - Add new compatibles for prcm and cpucfg registers for sun8i-a83t.
    Create two functions to separate the DT parsing of sun9i-a80 and
    sun8i-a83t.
    - Thanks to Maxime's review: order device tree's nodes according
    to physical addresses, remove unused label and fix registers' sizes.
    Update the commit log and commit title of my last patch (see
    patch 05).

Doug Berger (1):
  ARM: Allow this header to be included by assembly files

Mylène Josserand (11):
  ARM: sunxi: smp: Move assembly code into a file
  ARM: dts: sun8i: Add CPUCFG device node for A83T dtsi
  ARM: dts: sun8i: Add R_CPUCFG device node for the A83T dtsi
  ARM: dts: sun8i: a83t: Add CCI-400 node
  ARM: smp: Add initialization of CNTVOFF
  ARM: sunxi: Add initialization of CNTVOFF
  ARM: sun9i: smp: Rename clusters's power-off
  ARM: sun9i: smp: Add is_a83t field
  ARM: sun8i: smp: Add support for A83T
  ARM: dts: sun8i: Add enable-method for SMP support for the A83T SoC
  ARM: shmobile: Convert file to use cntvoff

 arch/arm/boot/dts/sun8i-a83t.dtsi        |  59 ++++++++
 arch/arm/common/Makefile                 |   1 +
 arch/arm/common/secure_cntvoff.S         |  31 ++++
 arch/arm/include/asm/cputype.h           |  10 +-
 arch/arm/include/asm/secure_cntvoff.h    |   8 ++
 arch/arm/mach-shmobile/common.h          |   1 -
 arch/arm/mach-shmobile/headsmp-apmu.S    |  22 +--
 arch/arm/mach-shmobile/setup-rcar-gen2.c |   3 +-
 arch/arm/mach-sunxi/Kconfig              |   2 +-
 arch/arm/mach-sunxi/Makefile             |   2 +-
 arch/arm/mach-sunxi/headsmp.S            |  81 +++++++++++
 arch/arm/mach-sunxi/mc_smp.c             | 239 +++++++++++++++++++------------
 arch/arm/mach-sunxi/sunxi.c              |  20 ++-
 13 files changed, 356 insertions(+), 123 deletions(-)
 create mode 100644 arch/arm/common/secure_cntvoff.S
 create mode 100644 arch/arm/include/asm/secure_cntvoff.h
 create mode 100644 arch/arm/mach-sunxi/headsmp.S

-- 
2.11.0
