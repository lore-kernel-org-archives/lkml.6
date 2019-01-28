Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7125AC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB1120844
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693400;
	bh=/7p2qpS/4QgBGl2xToBUbCtvOd5E0fm6zDisu/X6dHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BCRwvHwttKbF7pJwXwTpa1OjqICmux+c0S3h3nlxryOaCNl47ABN+GxyqklryHTQo
	 16SAdHUUeQ8Iiz4nyoAudaXX/N3JmbdMl0PP4Nrc67pXsMCdxi85b6CZit+62CAs2u
	 M1ivXeJ1OjAb/KsroWGKj/eipVTTEYjFQFm/sUT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389904AbfA1QZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:25:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:34090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389853AbfA1QZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:25:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0D1D2084A;
        Mon, 28 Jan 2019 16:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692716;
        bh=/7p2qpS/4QgBGl2xToBUbCtvOd5E0fm6zDisu/X6dHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pjLi2HPEL9Lt2eFWqcTXYxsCwcVbD1x/mY3tClPSY53D1XUJhiSEHfQAGuYTuSWlP
         C6Dr6KUI+mwraozRiigQXf2/ZjDJJHfWY1LQIKx99Fqbi+YWBDQMMdiOOLWeQlmIj/
         f1IQWn0OBQao6fBF/TjfuGat1B6O61FiVlUHHQjE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 43/80] ARM: mmp: fix timer_init calls
Date:   Mon, 28 Jan 2019 11:23:24 -0500
Message-Id: <20190128162401.58841-43-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162401.58841-1-sashal@kernel.org>
References: <20190128162401.58841-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 12d3a30db4a3b3df5fbadf5974b9cf50544a9950 ]

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
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-mmp/common.h | 2 +-
 arch/arm/mach-mmp/mmp2.c   | 2 +-
 arch/arm/mach-mmp/pxa168.c | 2 +-
 arch/arm/mach-mmp/pxa910.c | 2 +-
 arch/arm/mach-mmp/time.c   | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mmp/common.h b/arch/arm/mach-mmp/common.h
index 69c7eec6d1e0..10779ab9d55f 100644
--- a/arch/arm/mach-mmp/common.h
+++ b/arch/arm/mach-mmp/common.h
@@ -1,7 +1,7 @@
 #include <linux/reboot.h>
 #define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
 
-extern void timer_init(int irq, unsigned long rate);
+extern void mmp_timer_init(int irq, unsigned long rate);
 
 extern void __init mmp_map_io(void);
 extern void mmp_restart(enum reboot_mode, const char *);
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index 90a0d8114af2..c02a1f14aa02 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -133,7 +133,7 @@ void __init mmp2_timer_init(void)
 	clk_rst = APBC_APBCLK | APBC_FNCLK | APBC_FNCLKSEL(1);
 	__raw_writel(clk_rst, APBC_TIMERS);
 
-	timer_init(IRQ_MMP2_TIMER1, 6500000);
+	mmp_timer_init(IRQ_MMP2_TIMER1, 6500000);
 }
 
 /* on-chip devices */
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 5a616db7f392..94230041ec8f 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -78,7 +78,7 @@ void __init pxa168_timer_init(void)
 	/* 3.25MHz, bus/functional clock enabled, release reset */
 	__raw_writel(TIMER_CLK_RST, APBC_TIMERS);
 
-	timer_init(IRQ_PXA168_TIMER1, 6500000);
+	mmp_timer_init(IRQ_PXA168_TIMER1, 3250000);
 }
 
 void pxa168_clear_keypad_wakeup(void)
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index eb57ee196842..6b002763721d 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -114,7 +114,7 @@ void __init pxa910_timer_init(void)
 	__raw_writel(APBC_APBCLK | APBC_RST, APBC_TIMERS);
 	__raw_writel(TIMER_CLK_RST, APBC_TIMERS);
 
-	timer_init(IRQ_PXA910_AP1_TIMER1);
+	mmp_timer_init(IRQ_PXA910_AP1_TIMER1, 3250000);
 }
 
 /* on-chip devices */
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 7e7520a9eddb..a9bc5a739e63 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -185,7 +185,7 @@ static struct irqaction timer_irq = {
 	.dev_id		= &ckevt,
 };
 
-void __init timer_init(int irq, unsigned long rate)
+void __init mmp_timer_init(int irq, unsigned long rate)
 {
 	timer_config();
 
@@ -240,7 +240,7 @@ void __init mmp_dt_init_timer(void)
 		ret = -ENOMEM;
 		goto out;
 	}
-	timer_init(irq, rate);
+	mmp_timer_init(irq, rate);
 	return;
 out:
 	pr_err("Failed to get timer from device tree with error:%d\n", ret);
-- 
2.19.1

