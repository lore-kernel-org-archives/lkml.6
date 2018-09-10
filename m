Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88C2C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6782087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6782087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbeIJRHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:07:13 -0400
Received: from shell.v3.sk ([90.176.6.54]:36188 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbeIJRHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:07:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B24E6B825D;
        Mon, 10 Sep 2018 14:13:24 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ComQPkIQCz5Z; Mon, 10 Sep 2018 14:13:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 1D2E2B825E;
        Mon, 10 Sep 2018 14:13:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id B7EJQhzJgM4o; Mon, 10 Sep 2018 14:13:21 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id A61F5B825D;
        Mon, 10 Sep 2018 14:13:21 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] ARM: mmp/mmp2: use cpu_is_pj4() instead of cpu_is_mmp2()
Date:   Mon, 10 Sep 2018 14:13:14 +0200
Message-Id: <20180910121314.168636-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MMP2 platform uses the PJ4 CPU. The cpu_is_mmp2() macro is thus
actually not useful at all and moreover gives the wrong result on
MACH_MMP2_DT.

The actual problem I aim to fix is that on a device-tree enabled system,
the timer ends up being initialized incorrectly. In fact, it ticks like
at rate that's 1/100 slower or so.

Perhaps the other cpu_is_mmp2() uses are more benign, but still useless.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/mach-mmp/cputype.h | 9 ---------
 arch/arm/mach-mmp/mmp2.c    | 2 +-
 arch/arm/mach-mmp/pm-mmp2.c | 2 +-
 arch/arm/mach-mmp/time.c    | 2 +-
 4 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-mmp/cputype.h b/arch/arm/mach-mmp/cputype.h
index 446edaeb78a7..405dbbbbbcdd 100644
--- a/arch/arm/mach-mmp/cputype.h
+++ b/arch/arm/mach-mmp/cputype.h
@@ -44,13 +44,4 @@ static inline int cpu_is_pxa910(void)
 #define cpu_is_pxa910()	(0)
 #endif
 
-#ifdef CONFIG_CPU_MMP2
-static inline int cpu_is_mmp2(void)
-{
-	return (((read_cpuid_id() >> 8) & 0xff) == 0x58);
-}
-#else
-#define cpu_is_mmp2()	(0)
-#endif
-
 #endif /* __ASM_MACH_CPUTYPE_H */
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index afba5460cdaf..b670fafedeac 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -104,7 +104,7 @@ void __init mmp2_init_irq(void)
 
 static int __init mmp2_init(void)
 {
-	if (cpu_is_mmp2()) {
+	if (cpu_is_pj4()) {
 #ifdef CONFIG_CACHE_TAUROS2
 		tauros2_init(0);
 #endif
diff --git a/arch/arm/mach-mmp/pm-mmp2.c b/arch/arm/mach-mmp/pm-mmp2.c
index 17699be3bc3d..bcd5111ffb37 100644
--- a/arch/arm/mach-mmp/pm-mmp2.c
+++ b/arch/arm/mach-mmp/pm-mmp2.c
@@ -220,7 +220,7 @@ static int __init mmp2_pm_init(void)
 {
 	uint32_t apcr;
 
-	if (!cpu_is_mmp2())
+	if (!cpu_is_pj4())
 		return -EIO;
 
 	suspend_set_ops(&mmp2_pm_ops);
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 96ad1db0b04b..0f49ac579a17 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -163,7 +163,7 @@ static void __init timer_config(void)
 
 	__raw_writel(0x0, mmp_timer_base + TMR_CER); /* disable */
 
-	ccr &= (cpu_is_mmp2()) ? (TMR_CCR_CS_0(0) | TMR_CCR_CS_1(0)) :
+	ccr &= (cpu_is_pj4()) ? (TMR_CCR_CS_0(0) | TMR_CCR_CS_1(0)) :
 		(TMR_CCR_CS_0(3) | TMR_CCR_CS_1(3));
 	__raw_writel(ccr, mmp_timer_base + TMR_CCR);
 
-- 
2.17.1

