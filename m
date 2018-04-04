Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbeDDMqW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:46:22 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:60917 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbeDDMqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:46:19 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86: olpc: fix inconsistent MFD_CS5535 configuration
Date: Wed,  4 Apr 2018 14:44:54 +0200
Message-Id: <20180404124539.3817101-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:/ZNhyHeyDQY0ULX6e8wEL2IepuLPvaVOxSbBBw+C5mg+zeJ0A6g
 GD9XOhJ1DSLVGqm6NtLOguIqmKN30eZmcsWWGHZ2b81d1YZdGYlcDWINcWx97ZtPu4FRjf5
 FqdewPPO8m8QDsYLTeOakIXozAn4ZkDTfBm8c/p4QQFuRwsBsoYZswIyIC2rBQdqur3rbkH
 cv2oMd+iqQ2xod77o6yAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:u5cOkHKqAcc=:Wb/TQjg3BcCanjBotQiO8c
 oSr3H3WMf7hN6qYg6AgjET2byMgLNlwooad5uOCPcucpeEzBA+OSDtNe5Ga+HsLRdCgvT87n1
 +aRuB/paHuZS24dYCowcJKNy3mCnhl624n6VH8wVbs9yLBsKdLRVqTUmVoWcrXjIDouvxPiln
 UkvvyM4inmZn37GyTVapTod1KK7OPAkxm9D3H0kufT6JM44rNysr9YCWwZ+5g1+eaPrqT+h0T
 wgQOibcndtk5gl3qlzM71tHx3cXGaUgWJYXOBeCrmoIDi6nJpDEANdcLQVT9ZS8LYPqCx3y+u
 bMi6yR+rSJgTXlN5hPKqsBe+dCMD1cyyFTtgNJemKCaZ9jw1yjRWKh0NJj01iEu9DJnOcoKJN
 PJiilavbFZ5TWMzmfu5+pz2I03s3KsUGvJ+0L25zDjwSZetdP/MjKRIlSrY8D9UAMURX8I+RT
 JF/SrA+HXlKh9V/jsrKAhqjRr2Dk525kju+YEbHsFIbRMkW1MUmFz0HirtFOZwa7dZtZ9Vcaf
 faLE4RisoMT0hq2UssqhCDCeJH2McSttZskTg0LgfDwJ3Z84cBOLav7Z3gwqnx7NkQV0mKH/r
 xUTvpyI0rbOrcKtTG/fz4R0jpK2srBFHqGWfptZonpMnNoWTvaasxa92lK+6fvj1dFKbPHsLO
 sj7T5+AUJPjIFcCk9Y43PjTRKYkuntEbyiPr+PIVLBRls/u8tCbks7c1c/5p4F6AtSq705Ez4
 vg1mGAIdHRpZs99QhYJAchC9eN5cVfJH3Bf1/w==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Kconfig warning appeared after a fix to the Kconfig validation.
The GPIO_CS5535 driver depends on the MFD_CS5535 driver, but the former
is selected in places where the latter is not:

WARNING: unmet direct dependencies detected for GPIO_CS5535
  Depends on [m]: GPIOLIB [=y] && (X86 [=y] || MIPS || COMPILE_TEST [=y]) && MFD_CS5535 [=m]
  Selected by [y]:
  - OLPC_XO1_SCI [=y] && X86_32 [=y] && OLPC [=y] && OLPC_XO1_PM [=y] && INPUT [=y]=y

The warning does seem appropriate, since the GPIO_CS5535 driver won't
work unless MFD_CS5535 is also present. However, there is no link time
dependency between the two, so this caused no problems during randconfig
testing before.

This changes the 'select GPIO_CS5535' to 'depends on GPIO_CS5535' to
avoid the issue, at the expense of making it harder to configure the
driver (one now has to select the dependencies first).

The 'select MFD_CORE' part is completely redundant, since we already
depend on MFD_CS5535 here, so I'm removing that as well.

Ideally, the private symbols exported by that cs5535 gpio driver would
just be converted to gpiolib interfaces so we could expletely avoid
this dependency.

Fixes: f622f8279581 ("kconfig: warn unmet direct dependency of tristate symbols selected by y")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bf4ddea48e61..ffb2b858e2b1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2773,11 +2773,9 @@ config OLPC_XO1_RTC
 
 config OLPC_XO1_SCI
 	bool "OLPC XO-1 SCI extras"
-	depends on OLPC && OLPC_XO1_PM
+	depends on OLPC && OLPC_XO1_PM && GPIO_CS5535=y
 	depends on INPUT=y
 	select POWER_SUPPLY
-	select GPIO_CS5535
-	select MFD_CORE
 	---help---
 	  Add support for SCI-based features of the OLPC XO-1 laptop:
 	   - EC-driven system wakeups
-- 
2.9.0
