Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E54D5C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 15:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C566208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 15:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C566208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965938AbeFOPuR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 11:50:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51712 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964778AbeFOPuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 11:50:15 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 59EFF20728; Fri, 15 Jun 2018 17:50:14 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-37-30.w90-88.abo.wanadoo.fr [90.88.156.30])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3287C207A5;
        Fri, 15 Jun 2018 17:50:14 +0200 (CEST)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH] arch/sh: fix SH4 flush_dcache_all() for SMP
Date:   Fri, 15 Jun 2018 17:50:10 +0200
Message-Id: <20180615155010.8019-1-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SH4 flush_dcache_all() function uses current_cpu_data, which
internally uses smp_processor_id(). However, it is incorrect to use
smp_processor_id() in a context where migration is enabled, because
the processor on which the code is running can change at any point in
time.

To avoid this, we enclose the code flushing the dcache in a get_cpu()
/ put_cpu() section so that migration is disabled.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
Note: I am not sure at all this is the best fix. Careful review and
suggestions are welcome.

 arch/sh/mm/cache-sh4.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
index eee911422cf9..cde8d7f8acbb 100644
--- a/arch/sh/mm/cache-sh4.c
+++ b/arch/sh/mm/cache-sh4.c
@@ -149,13 +149,17 @@ static void flush_icache_all(void)
 static void flush_dcache_all(void)
 {
 	unsigned long addr, end_addr, entry_offset;
+	struct sh_cpuinfo *cpud;
+	int cpu;
+
+	cpu = get_cpu();
+	cpud = &cpu_data[cpu];
 
 	end_addr = CACHE_OC_ADDRESS_ARRAY +
-		(current_cpu_data.dcache.sets <<
-		 current_cpu_data.dcache.entry_shift) *
-			current_cpu_data.dcache.ways;
+		(cpud->dcache.sets << cpud->dcache.entry_shift) *
+		cpud->dcache.ways;
 
-	entry_offset = 1 << current_cpu_data.dcache.entry_shift;
+	entry_offset = 1 << cpud->dcache.entry_shift;
 
 	for (addr = CACHE_OC_ADDRESS_ARRAY; addr < end_addr; ) {
 		__raw_writel(0, addr); addr += entry_offset;
@@ -167,6 +171,8 @@ static void flush_dcache_all(void)
 		__raw_writel(0, addr); addr += entry_offset;
 		__raw_writel(0, addr); addr += entry_offset;
 	}
+
+	put_cpu();
 }
 
 static void sh4_flush_cache_all(void *unused)
-- 
2.14.4

