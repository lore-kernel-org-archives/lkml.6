Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17B7C6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3DC20685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3DC20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbeGXWpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 18:45:17 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:50214 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbeGXWpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 18:45:17 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue006 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LaNXn-1gQExR41BX-00mGC6; Tue, 24 Jul 2018 23:36:35 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     dalias@libc.org
Cc:     ysato@users.sourceforge.jp, baolin.wang@linaro.org,
        y2038@lists.linaro.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 4/4] sh: remove board_time_init() callback
Date:   Tue, 24 Jul 2018 23:36:24 +0200
Message-Id: <20180724213624.3899336-4-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724213624.3899336-1-arnd@arndb.de>
References: <20180724213624.3899336-1-arnd@arndb.de>
X-Provags-ID: V03:K1:ZIgKU6i9R1fUvipMJQ5XnC7WK7Kl7pHPhsRQgqorIIQraZm0/xW
 si+aR951mBzu8QwQg0Ljmmav1LriJa9x6ZaoFJTixhiZdRKEUNfviZ1+0TaM+XvOHU3jat/
 ILB1740/tuT8v7ISq5RajA8Z7xD4xG6eLhtt9IMhUa/d0oWJkNvcBCWOB9cuQoEXqJgpQhq
 9OmabJJGWUbSGHmCicXWA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FOwVERHe538=:hha4BmIKFU6ccpw912TdQz
 cbJ+tA4AizkZqJ0ODpqiSR95yOL1QJdsE5uql7nRe4nacR5slhhPFch+W7U2ZEP6kOEwGr3Er
 cW2FnP5woxm3yYnTWAqAmtjLhKuYKtTJlLBKZ1OoDiOhIeO7ULcCLa+JhyGhcLQGBHyX9LPa4
 QF79HOZ0XFPONs/KDcPnXc3J71IvGEJ1O3lq3B5YwETZ87/SiTc6GUfVujd9MsANP+PoiQgng
 nP/yo4LYkytzu2uKxFIvRw9raKLQdShYBlNsBQnnbHpYun5h6p43vGQUXBhkcMDyLLmtFZGYa
 t92cvST3wcO7jGe8nxXUaAsS2JMxIE4adqsNU9WsTryjC3hcWxLq8N6LzKAFwcBX16j1aK71Y
 W2yHT117+hfQkpCw+iH14jRtUlYGEtEazbdmUmpydNc1Ozr1Z2exTuV1G+ywUVXKf/DqM7YYT
 ENhWsXpnkkRe8Z47TNRdwhQhLiwoiRxb4xw8cjFECoi53kdCVI2X4giOoY83D6mqvj0SKfjrg
 V3x7Pz9Q46EDzrBLi6Lk/mZAP8dJP3wMYpfH7466tAJAbvzSRWtKpyF4HgU7YXaME2XuvU2dK
 gUisS1UxFZDLAd7TWg02vUREeqWgHWU/alG6K+ZsFCrxJTz9WYg6bOewaJFWeNMRP06QU4vub
 r/KZbj1nbjz34ny0IKEgbQZ4pmfwOMWmYzqTNMdxmtQ8QK3tJcyfczQu/ZciPM1aqYYc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only remaining user of board_time_init() is the of-generic
machine, and that just calls the global timer_init() function.
Calling that one has no effect on non-DT platforms, so we can
simply call it unconditionally in place of board_time_init().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: fix a typo as pointed out by the kbuild bot
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
index 26789ad28193..04d9a666f924 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -117,18 +117,10 @@ static void __init sh_of_mem_reserve(void)
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
index eb0a91270499..8a1c6c8ab4ec 100644
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
+	timer_probe();
 
 	clk_init();
 
-- 
2.18.0

