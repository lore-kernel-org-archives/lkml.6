Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbeBWNie (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:38:34 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:48873 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751351AbeBWNic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:38:32 -0500
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: maxime.ripard@bootlin.com, linux@armlinux.org.uk, wens@csie.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clabbe.montjoie@gmail.com,
        thomas.petazzoni@bootlin.com, mylene.josserand@bootlin.com,
        quentin.schulz@bootlin.com
Subject: [PATCH v4 00/10] Sunxi: Add SMP support on A83T
Date: Fri, 23 Feb 2018 14:37:32 +0100
Message-Id: <20180223133742.26044-1-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

This is a V4 of my series that adds SMP support for Allwinner sun8i-a83t.
Based on sunxi's tree, sunxi/for-next branch.

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

Patch 01: Create a function that handles all the current code doing a
device tree parsing.
Patch 02: Rename a register to prepare the a83t support with different
registers.
Patch 03: Convert the sunxi SMP driver to add support for A83T.
This SoC has a bit flip that needs to be handled.
Patch 04: Add hotplug support for a83t. Remove the possibilite to
disable the CPU0 because CPU0 hotplug is currently not working for
this SoC.
Patch 05-06: Add registers nodes (cpucfg and r_cpucfg) needed
for SMP bringup.
Patch 07: Add CCI-400 node for a83t.
Patch 08: Move the current assembly code into an assembly file
Patch 09: Move another assemble code (for resuming) into this file
Patch 10: Add a new entry to initialize the timer offset for all CPUs.

If you have any remarks/questions, let me know.
Thank you in advance,
Mylène

Mylène Josserand (10):
  ARM: sun9i: smp: Add sun9i dt parsing function
  ARM: sun9i: smp: Rename clusters's power-off register
  ARM: sun8i: smp: Add support for A83T
  ARM: sun8i: smp: Add hotplug support for sun8i-a83t
  ARM: dts: sun8i: Add CPUCFG device node for A83T dtsi
  ARM: dts: sun8i: Add R_CPUCFG device node for the A83T dtsi
  ARM: dts: sun8i: a83t: Add CCI-400 node
  ARM: sunxi: smp: Move assembly code into a file
  ARM: sunxi: smp: Move cpu_resume assembly entry into file
  ARM: sunxi: smp: Add initialization of CNTVOFF

 arch/arm/boot/dts/sun8i-a83t.dtsi |  51 ++++++
 arch/arm/mach-sunxi/Kconfig       |   2 +-
 arch/arm/mach-sunxi/Makefile      |   1 +
 arch/arm/mach-sunxi/headsmp.S     |  99 +++++++++++
 arch/arm/mach-sunxi/mc_smp.c      | 350 ++++++++++++++++++++++++--------------
 arch/arm/mach-sunxi/sunxi.c       |   4 +
 6 files changed, 383 insertions(+), 124 deletions(-)
 create mode 100644 arch/arm/mach-sunxi/headsmp.S

-- 
2.11.0
