Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755871AbeDTPw3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 11:52:29 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:45881 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755390AbeDTPw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 11:52:27 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Rich Felker <dalias@libc.org>
Cc: Baolin Wang <baolin.wang@linaro.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org,
        broonie@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] sh: remove board_time_init() callback
Date: Fri, 20 Apr 2018 17:48:56 +0200
Message-Id: <20180420154933.3235131-4-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180420154933.3235131-1-arnd@arndb.de>
References: <20180420154933.3235131-1-arnd@arndb.de>
X-Provags-ID: V03:K1:E6aI9z5mOwSy8SUT+nQPwhJTVsiqKC1upruTVpvUf7i5xfZa28r
 9WFRFG0OqOFj5Q0KqreXb95HyRaThOJ9p5jPI4cy4BBHXOXhNHQIde7QbV/ypboG1BfZz5K
 wtYGpKyLrVnMPYGRTL8Mb2WKQyQK32WXQGdfWoOuOX7th9aT0OsMU0qpP/2NFZ5vhvtwieD
 ehAw3H5vdXGN7Y7ksXr0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ElrQUGIjCBE=:2k0JXKUI3TfS6+wJX04xVE
 xjFFE77GXbNZomgqIjl3a7fmFUEgGo47LC7TUygFJYu2JfMe5VJYAeHAoKG5PtW7Wfmu+x7Ib
 kwkBmqzxZvmIw3poNO6XyiHEBXCehrpYQMW38k/w6BztJAvV3qKWlbyKeYRT6/B6xyL6N8vYh
 QLyUS1OsMnvhrA2atXcBOxDcTiJH6RsagTX0u5xhOWcfQk8T/nKRDP2X6ae44xjvGd7EN4pHJ
 TYEJiX5PUZoMFTAakznzHD1SzCJUm3FfccIIq6PB8CaGtHHFf9eFZUceBFqobylLvaCTYK977
 1MIgZRKBCTZ/dDnRhl4/a1C80+2rzB/+1mq5DyxVk6PD5Srb8CTKYyV1FSKgRokwJeOm3k1vz
 Znpi27AIwu46O6Z6Qna5Ntoh/zvpRUr0cCyWz/MJx4nn26S2wKlKs7NLTMwQh0zbMwdmle+p7
 54gLWC2FQeHFqRcvQX+/XdkfxS9bN0ihupSPKJOoSU2GptL2qxJvsYpwzNPhb/AQTW8TY8Oa6
 GePg4uITNfz5kmBGcl9zWB2Bcekrph4s8jGKi2Ggvxx1YAUeIR7dn8kOnCqIGbHUFsMlsKhZg
 08AIHodjtaupj4AIcAfxWarW7PhjBbUvLFpBtvYprIXwv12o18JGypsToHKjOtbr1B9pE+g0x
 5wRn8wFbphnah56nP7DdPc4bra/7Sg1DBLoP02Rg7re1CwFVOLifE+nuCVF2hKLDKs93R+/dS
 FtM5qe+8x+/O3zSqjMWBRcaD/9yqhdarsf3hAw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only remaining user of board_time_init() is the of-generic
machine, and that just calls the global timer_init() function.
Calling that one has no effect on non-DT platforms, so we can
simply call it unconditionally in place of board_time_init().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/sh/new-machine.txt | 8 --------
 arch/sh/boards/of-generic.c      | 8 --------
 arch/sh/include/asm/rtc.h        | 1 -
 arch/sh/kernel/time.c            | 5 +----
 4 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/Documentation/sh/new-machine.txt b/Documentation/sh/new-machine.txt
index f0354164cb0e..e0961a66130b 100644
--- a/Documentation/sh/new-machine.txt
+++ b/Documentation/sh/new-machine.txt
@@ -116,7 +116,6 @@ might look something like:
  * arch/sh/boards/vapor/setup.c - Setup code for imaginary board
  */
 #include <linux/init.h>
-#include <asm/rtc.h> /* for board_time_init() */
 
 const char *get_system_type(void)
 {
@@ -132,13 +131,6 @@ int __init platform_setup(void)
 	 * this board.
 	 */
 
-  	/* 
-	 * Presume all FooTech boards have the same broken timer,
-	 * and also presume that we've defined foo_timer_init to
-	 * do something useful.
-	 */
-  	board_time_init = foo_timer_init;
-
 	/* Start-up imaginary PCI ... */
 
 	/* And whatever else ... */
diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index 46b2481eec90..ee74ff1e7721 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -116,18 +116,10 @@ static void __init sh_of_mem_reserve(void)
 	early_init_fdt_scan_reserved_mem();
 }
 
-static void __init sh_of_time_init(void)
-{
-	pr_info("SH generic board support: scanning for clocksource devices\n");
-	timer_probe();
-}
-
 static void __init sh_of_setup(char **cmdline_p)
 {
 	struct device_node *root;
 
-	board_time_init = sh_of_time_init;
-
 	sh_mv.mv_name = "Unknown SH model";
 	root = of_find_node_by_path("/");
 	if (root) {
diff --git a/arch/sh/include/asm/rtc.h b/arch/sh/include/asm/rtc.h
index fe55fbb181aa..69dbae2949b0 100644
--- a/arch/sh/include/asm/rtc.h
+++ b/arch/sh/include/asm/rtc.h
@@ -3,7 +3,6 @@
 #define _ASM_RTC_H
 
 void time_init(void);
-extern void (*board_time_init)(void);
 
 #define RTC_CAP_4_DIGIT_YEAR	(1 << 0)
 
diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
index eb0a91270499..a29eb989d81b 100644
--- a/arch/sh/kernel/time.c
+++ b/arch/sh/kernel/time.c
@@ -22,8 +22,6 @@
 #include <asm/clock.h>
 #include <asm/rtc.h>
 
-void (*board_time_init)(void);
-
 static void __init sh_late_time_init(void)
 {
 	/*
@@ -41,8 +39,7 @@ static void __init sh_late_time_init(void)
 
 void __init time_init(void)
 {
-	if (board_time_init)
-		board_time_init();
+	timer_init();
 
 	clk_init();
 
-- 
2.9.0
