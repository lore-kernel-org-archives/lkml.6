Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934022AbeCGQZM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:25:12 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:51197 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933502AbeCGQZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:25:11 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: npcm: drop extraneous 'select' statements
Date: Wed,  7 Mar 2018 17:24:13 +0100
Message-Id: <20180307162430.2664523-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180307162430.2664523-1-arnd@arndb.de>
References: <20180307162430.2664523-1-arnd@arndb.de>
X-Provags-ID: V03:K0:nU2rZ+Wml/8E+9GxQtEn7StbOIsGHQSOb1gZPPg5n8LkDIxZMUH
 tA0mPmE/YAjJ2v2rsmIE9KeNtSghCfoEw7dmoNhdsHpubT0ZHxisOfpRv7sFCiMoQ6EejU+
 ARNbxhBIOjTUPHqfkf7y+RddFLYW3WVMkSL4boOsu8e+LOqEx625mUPOQ3wJ2j31zVridYk
 seetRZWfncMKJpTL2lU3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RHv5hhLc8kY=:AGgcS3Yu+VsbhdrBi0KxCp
 AkF0wr8Frl9PH5tYW5Vw2R4XEeTtWTkaAlz5DJlrWgtMB+pMYPaNKlmYbnCIM58U//fPsNxcH
 M7DGiP+mAyjuMFK3A4UXf8fqbl1UWK7+ta+XvGBBOFjeCSxd1wy/7s/eqzq/cVPxZHdQQMhcN
 9a1FEATs1qn4jcCzV5y3Jeu3Hs01iYKSMtbNfbscvPk/ltkhlvGSiTIm6o+dxAMB7NlUcp7yT
 KGS9cKSRsbw6F0WHbeESbyn8T551gRhWb8iLRGeLD1J2fBg/Vop0u0UxwZDkcDr109iRCjPNw
 cTBpCCJQZUp4tSIhB+wJMiWUNDpDwhhEpmSbfSt9rd6lJG3jixNpc/adbgTNNRCltzAa4sglF
 IrQer4r5a+ZoKKXauZS2sK7sc8q5G/LjdLTn3ps2eBKaTl5KnX4VnniHJ6+QevVNxMvq3HlJP
 mA7epMJAOBIPlOHRJXDhCKoe+12KoB/bo5BQE0RRF9FFdGaorev6LBuEH9qo3Po2rMQ+zFJ0E
 Idpa1+8jFgw/0TSHNP6p+C8HYHW6ZufgaqULoCmp0RPFzhHMBvPaMw3LCL1ZQr/WPiU0LF3dF
 mCN346Sd1pKpShmciGlweuG3rkgVR8macxYabAc5mVpL4h6CrjGNgqT/viMi3/bnFcyyiQw5X
 6XEwHxijqZM8Dn0uGbLukFE1tza5zC82Tl6ZtdML04Rs8ypUUClb1hwJgX4UFlt0jQBFQZnNQ
 UDXkKkQArBTuhFGbPmAHDLJ6lBiZabnl4KPQow==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While looking at the build regression, I noticed that the
platform selects a lot of other Kconfig symbols that it really
should not:

CPU_V7, ARM_GIC, HAVE_SMP, COMMON_CLK, GENERIC_CLOCKEVENTS,
and CLKDEV_LOOKUP are all implied by ARCH_MULTI_V7, so they
can be dropped.

CACHE_L2X0, SMP and USB are meant to be user-selectable, we
want to be able to turn those off for testing purposes.

CPU_USE_DOMAINS looks completely misplaced here, we should not
select that for an ARMv7 platform.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-npcm/Kconfig | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/arm/mach-npcm/Kconfig b/arch/arm/mach-npcm/Kconfig
index 2bc6697c8d97..c6a16230e8ef 100644
--- a/arch/arm/mach-npcm/Kconfig
+++ b/arch/arm/mach-npcm/Kconfig
@@ -12,12 +12,6 @@ comment "NPCM7XX CPU type"
 config ARCH_NPCM750
 	depends on ARCH_NPCM
 	bool "Support for NPCM750 BMC CPU (Poleg)"
-	select CACHE_L2X0
-	select CPU_V7
-	select ARM_GIC
-	select HAVE_SMP
-	select SMP
-	select SMP_ON_UP
 	select HAVE_ARM_SCU
 	select HAVE_ARM_TWD if SMP
 	select ARM_ERRATA_720789
@@ -26,18 +20,6 @@ config ARCH_NPCM750
 	select ARM_ERRATA_794072
 	select PL310_ERRATA_588369
 	select PL310_ERRATA_727915
-	select USB_EHCI_ROOT_HUB_TT
-	select USB_ARCH_HAS_HCD
-	select USB_ARCH_HAS_EHCI
-	select USB_EHCI_HCD
-	select USB_ARCH_HAS_OHCI
-	select USB_OHCI_HCD
-	select USB
-	select FIQ
-	select CPU_USE_DOMAINS
-	select GENERIC_CLOCKEVENTS
-	select CLKDEV_LOOKUP
-	select COMMON_CLK if OF
 	select NPCM750_TIMER
 	select MFD_SYSCON
 	help
-- 
2.9.0
