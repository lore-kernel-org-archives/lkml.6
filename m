Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753565AbeDIRLk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 13:11:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50789 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbeDIRL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 13:11:27 -0400
Date: Mon, 9 Apr 2018 10:10:57 -0700
From: tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-92e830f25fc0be447486a4658887ded68ef824f5@git.kernel.org>
Cc: hpa@zytor.com, peterz@infradead.org, yamada.masahiro@socionext.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
        mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, arnd@arndb.de, mingo@kernel.org,
        hpa@zytor.com, peterz@infradead.org, yamada.masahiro@socionext.com,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        tglx@linutronix.de
In-Reply-To: <20180404124539.3817101-1-arnd@arndb.de>
References: <20180404124539.3817101-1-arnd@arndb.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/olpc: Fix inconsistent MFD_CS5535
 configuration
Git-Commit-ID: 92e830f25fc0be447486a4658887ded68ef824f5
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  92e830f25fc0be447486a4658887ded68ef824f5
Gitweb:     https://git.kernel.org/tip/92e830f25fc0be447486a4658887ded68ef824f5
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Wed, 4 Apr 2018 14:44:54 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 9 Apr 2018 18:22:34 +0200

x86/olpc: Fix inconsistent MFD_CS5535 configuration

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

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kbuild@vger.kernel.org
Fixes: f622f8279581 ("kconfig: warn unmet direct dependency of tristate symbols selected by y")
Link: http://lkml.kernel.org/r/20180404124539.3817101-1-arnd@arndb.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index eb7f43f23521..a9f0048b880a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2770,11 +2770,9 @@ config OLPC_XO1_RTC
 
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
