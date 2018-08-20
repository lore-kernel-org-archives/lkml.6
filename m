Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FC4C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 02:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2306820C0C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 02:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2306820C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbeHTF3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 01:29:09 -0400
Received: from exmail.andestech.com ([59.124.169.137]:8589 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbeHTF3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 01:29:09 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w7K2DWLj072848;
        Mon, 20 Aug 2018 10:13:32 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Mon, 20 Aug 2018
 10:15:19 +0800
From:   Zong Li <zong@andestech.com>
To:     <green.hu@gmail.com>, <linux-kernel@vger.kernel.org>
CC:     <zongbox@gmail.com>, <greentime@andestech.com>,
        Zong Li <zong@andestech.com>
Subject: [PATCH 2/2] nds32: Add macro definition for offset of lp register on stack
Date:   Mon, 20 Aug 2018 10:15:05 +0800
Message-ID: <12f4abaca33749b0d8aa697866797d33e3ab12ce.1534730156.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1534730156.git.zong@andestech.com>
References: <cover.1534730156.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w7K2DWLj072848
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use macro to replace the magic number.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/nds32/include/asm/nds32.h | 1 +
 arch/nds32/kernel/stacktrace.c | 2 +-
 arch/nds32/kernel/traps.c      | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/nds32/include/asm/nds32.h b/arch/nds32/include/asm/nds32.h
index 19b1939..68c3815 100644
--- a/arch/nds32/include/asm/nds32.h
+++ b/arch/nds32/include/asm/nds32.h
@@ -17,6 +17,7 @@
 #else
 #define FP_OFFSET (-2)
 #endif
+#define LP_OFFSET (-1)
 
 extern void __init early_trap_init(void);
 static inline void GIE_ENABLE(void)
diff --git a/arch/nds32/kernel/stacktrace.c b/arch/nds32/kernel/stacktrace.c
index 36bc870..d974c0c 100644
--- a/arch/nds32/kernel/stacktrace.c
+++ b/arch/nds32/kernel/stacktrace.c
@@ -31,7 +31,7 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 	       && (fpn >= (unsigned long *)TASK_SIZE)) {
 		unsigned long lpp, fpp;
 
-		lpp = fpn[-1];
+		lpp = fpn[LP_OFFSET];
 		fpp = fpn[FP_OFFSET];
 		if (!__kernel_text_address(lpp))
 			break;
diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index f432310..b0b85b7 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -117,7 +117,7 @@ static void __dump(struct task_struct *tsk, unsigned long *base_reg)
 		       !((unsigned long)base_reg & 0x3) &&
 		       ((unsigned long)base_reg >= TASK_SIZE)) {
 			unsigned long next_fp;
-			ret_addr = base_reg[-1];
+			ret_addr = base_reg[LP_OFFSET];
 			next_fp = base_reg[FP_OFFSET];
 			if (__kernel_text_address(ret_addr)) {
 
-- 
2.7.4

