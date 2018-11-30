Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15261C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD62C2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD62C2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbeLAEoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:44:15 -0500
Received: from foss.arm.com ([217.140.101.70]:33166 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbeLAEoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 23:44:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4C8B1596;
        Fri, 30 Nov 2018 09:34:13 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B50883F73C;
        Fri, 30 Nov 2018 09:34:13 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 846C21AE0808; Fri, 30 Nov 2018 17:34:32 +0000 (GMT)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        catalin.marinas@arm.com, rml@tech9.net, tglx@linutronix.de,
        peterz@infradead.org, schwidefsky@de.ibm.com,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 1/2] preempt: Move PREEMPT_NEED_RESCHED definition into arch code
Date:   Fri, 30 Nov 2018 17:34:30 +0000
Message-Id: <1543599271-14339-2-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1543599271-14339-1-git-send-email-will.deacon@arm.com>
References: <1543599271-14339-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PREEMPT_NEED_RESCHED is never used directly, so move it into the arch
code where it can potentially be implemented using either a different
bit in the preempt count or as an entirely separate entity.

Cc: Robert Love <rml@tech9.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/s390/include/asm/preempt.h | 2 ++
 arch/x86/include/asm/preempt.h  | 3 +++
 include/linux/preempt.h         | 3 ---
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/preempt.h b/arch/s390/include/asm/preempt.h
index 23a14d187fb1..b5ea9e14c017 100644
--- a/arch/s390/include/asm/preempt.h
+++ b/arch/s390/include/asm/preempt.h
@@ -8,6 +8,8 @@
 
 #ifdef CONFIG_HAVE_MARCH_Z196_FEATURES
 
+/* We use the MSB mostly because its available */
+#define PREEMPT_NEED_RESCHED	0x80000000
 #define PREEMPT_ENABLED	(0 + PREEMPT_NEED_RESCHED)
 
 static inline int preempt_count(void)
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 90cb2f36c042..99a7fa9ab0a3 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -8,6 +8,9 @@
 
 DECLARE_PER_CPU(int, __preempt_count);
 
+/* We use the MSB mostly because its available */
+#define PREEMPT_NEED_RESCHED	0x80000000
+
 /*
  * We use the PREEMPT_NEED_RESCHED bit as an inverted NEED_RESCHED such
  * that a decrement hitting 0 means we can and should reschedule.
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index c01813c3fbe9..dd92b1a93919 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -53,9 +53,6 @@
 
 #define SOFTIRQ_DISABLE_OFFSET	(2 * SOFTIRQ_OFFSET)
 
-/* We use the MSB mostly because its available */
-#define PREEMPT_NEED_RESCHED	0x80000000
-
 #define PREEMPT_DISABLED	(PREEMPT_DISABLE_OFFSET + PREEMPT_ENABLED)
 
 /*
-- 
2.1.4

