Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7C8C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A559F2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A559F2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbeLJUoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:44:02 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:45991 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbeLJUoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:44:02 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MdNLi-1h5W6X4C1o-00ZS5E; Mon, 10 Dec 2018 21:43:42 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     arm@kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: mmp: fix timer_init calls
Date:   Mon, 10 Dec 2018 21:43:01 +0100
Message-Id: <20181210204340.2269622-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:p4KIKsdMkroejDb6VC93k97xs9//yUmHuhfFoJCeiMAQlbuCsIy
 S6jtk4rYpwv1xnRbYm+dBLsUsNq35C20kqAJZG4Bt5sWZZkImV6hvOibu1B01Ep83CFsUi7
 /Qo8KJ3R087aa2UswogSGWIJH6IwPExXplLIEhoC0KpQjH6xI5hBgd21EXv/bqE0fcLMThV
 0FI3BHHT8tr94EZ67RsYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bPzUQHTr9Gs=:y6iZ2wrVmt64qDoEn2HE7I
 Km/DQy/dwZnx3yB8MAqd3t2YTmGY1iaQmK/kNtBtIwF37kDnywl6M+oVfNJpuXWkHHjJE1mFZ
 dZQfxhbu1VwPnEN9NULCviJcHEsXc8ikI1SXJnlxIgxkk/7Y85jn1d1jw/VmcGNDyJN5OaTmr
 ODWaVJEic+21u1y64DZ6Ox92gsgRZOa/wOrSyEzbi56RgAxKevLYUqxvzk8Bk9LHd3PTc+cjw
 GQjjLYFdom4kU67IOJimhOUAneFToWhGw/QIyw4kX7NxNvyKDvHg849qxIan1OCVKvONBTt3a
 58XIz4xC90ApFpiJMFI7cMlB5iDFv5f/jWi1jaRjOk15mGKhR7FZIQXrMZDuXDzyb6ANwSL3C
 fRpmUqb//g+GAffwK5Y0SK8kLRo/yaj7zryyaBO7pkg84z9TdpN/4avTeaRt4aBv61tbIFViO
 SBYcgmbVmAYW3ACWws5ZeQU0gQsVRc9xQJKKElQS96JQMnLJzBG185L9Fk6mBiuYEeVXLHqIk
 uel2QmDoEOzevqRzdsmhhoD7OswN0cccJvOB/nly9nye8M56qyIjwr2A7yQFxnu3Bx+UE04Di
 kgrmihLJD/WeIkmWjdZjkpkKL9gHR4w3mq6bW2ArKnmTbX3vNdwQUburh4qq7GAKVYXnvuuql
 yie8edyQHEdxSsL6ZliWx0oumDWbuh6qA29J1dcogxy6Q8cRgpodh6f+sI2t5gB+/oRWpl27C
 CWbDUmhp85H2UTNtdAjO5QesLiiE5vLrmD/z2g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change to passing the timer frequency as a function argument
was a good idea, but caused a build failure for one user that
was missed in the update:

arch/arm/mach-mmp/time.c: In function 'mmp_dt_init_timer':
arch/arm/mach-mmp/time.c:242:2: error: implicit declaration of function 'timer_init'; did you mean 'hrtimer_init'? [-Werror=implicit-function-declaration]

Change that as well to fix the build error, and rename the
function to put it into a proper namespace and make it clearer
what is actually going on.

I saw that the high 6500000 HZ frequency was previously only
set with CONFIG_MMP2, but is now also used with MMP (pxa910),
so I'm changing that back here. Please make sure that the
frequencies are all correct now.

Fixes: f36797ee4380 ("ARM: mmp/mmp2: dt: enable the clock")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-mmp/common.h | 2 +-
 arch/arm/mach-mmp/mmp2.c   | 2 +-
 arch/arm/mach-mmp/pxa168.c | 2 +-
 arch/arm/mach-mmp/pxa910.c | 2 +-
 arch/arm/mach-mmp/time.c   | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mmp/common.h b/arch/arm/mach-mmp/common.h
index 5ac2851ef5d3..483b8b6d3005 100644
--- a/arch/arm/mach-mmp/common.h
+++ b/arch/arm/mach-mmp/common.h
@@ -2,7 +2,7 @@
 #include <linux/reboot.h>
 #define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
 
-extern void timer_init(int irq, unsigned long rate);
+extern void mmp_timer_init(int irq, unsigned long rate);
 
 extern void __init mmp_map_io(void);
 extern void mmp_restart(enum reboot_mode, const char *);
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index fb3e7e32c882..726c1a642dea 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -134,7 +134,7 @@ void __init mmp2_timer_init(void)
 	clk_rst = APBC_APBCLK | APBC_FNCLK | APBC_FNCLKSEL(1);
 	__raw_writel(clk_rst, APBC_TIMERS);
 
-	timer_init(IRQ_MMP2_TIMER1, 6500000);
+	mmp_timer_init(IRQ_MMP2_TIMER1, 6500000);
 }
 
 /* on-chip devices */
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 77a358165a56..cdcf65ace3f9 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -79,7 +79,7 @@ void __init pxa168_timer_init(void)
 	/* 3.25MHz, bus/functional clock enabled, release reset */
 	__raw_writel(TIMER_CLK_RST, APBC_TIMERS);
 
-	timer_init(IRQ_PXA168_TIMER1, 6500000);
+	mmp_timer_init(IRQ_PXA168_TIMER1, 3250000);
 }
 
 void pxa168_clear_keypad_wakeup(void)
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index 1ccbba9ac495..d30a7d12bc98 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -116,7 +116,7 @@ void __init pxa910_timer_init(void)
 	__raw_writel(APBC_APBCLK | APBC_RST, APBC_TIMERS);
 	__raw_writel(TIMER_CLK_RST, APBC_TIMERS);
 
-	timer_init(IRQ_PXA910_AP1_TIMER1);
+	mmp_timer_init(IRQ_PXA910_AP1_TIMER1, 3250000);
 }
 
 /* on-chip devices */
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index eab0fd8a7343..f9c295154b94 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -184,7 +184,7 @@ static struct irqaction timer_irq = {
 	.dev_id		= &ckevt,
 };
 
-void __init timer_init(int irq, unsigned long rate)
+void __init mmp_timer_init(int irq, unsigned long rate)
 {
 	timer_config();
 
@@ -239,7 +239,7 @@ void __init mmp_dt_init_timer(void)
 		ret = -ENOMEM;
 		goto out;
 	}
-	timer_init(irq, rate);
+	mmp_timer_init(irq, rate);
 	return;
 out:
 	pr_err("Failed to get timer from device tree with error:%d\n", ret);
-- 
2.20.0

