Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79ADC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D657222A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897109;
	bh=RLd6isiJ3v2hghgJ/c3Fwku8OmP+/HR8OlRXfTaukb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jNMTSlk1ilo4jCgNXI80lgd6I1ZCX1Xg7g+JXyzvWEK9NTsC07rvUI29o9fIiPuJt
	 Bxp67HJmRHojmS3uQpZDKe6IbT99pKywldckXcusOwRGFs62VppDOIc0epjgKaHpea
	 1XfR0gJVq/oWZKdEkDiXuAina3e/Z7iAv/pcHjI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389552AbfBKO62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:58:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:46070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389137AbfBKO60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:58:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DEB3222A6;
        Mon, 11 Feb 2019 14:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897105;
        bh=RLd6isiJ3v2hghgJ/c3Fwku8OmP+/HR8OlRXfTaukb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ayouS/wNnSKFgqMb5c2Af4IEWBQBE8r8YnfZoJn/1EtDUTtYL/vuf+vnlq5vy2X1j
         VxHHYWlz4cdmooF1lslkzRej4/jlrt0hsa3QJfmJT8nYJ45zfIV3wA52Yrev6QFYK8
         WKtvBKoc1BGqDW4P9Iu624qrgM59mryhCH8+gILY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 093/205] ARM: mmp: fix timer_init calls
Date:   Mon, 11 Feb 2019 15:18:11 +0100
Message-Id: <20190211141834.719689984@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1



