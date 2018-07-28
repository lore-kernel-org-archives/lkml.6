Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5089FC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151B720862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151B720862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbeG1XWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 19:22:20 -0400
Received: from shelob.surriel.com ([96.67.55.147]:44102 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731347AbeG1XWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 19:22:20 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fjXA0-0000QZ-PG; Sat, 28 Jul 2018 17:54:00 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, peterz@infradead.org, luto@kernel.org,
        x86@kernel.org, vkuznets@redhat.com, mingo@kernel.org,
        efault@gmx.de, dave.hansen@intel.com, will.daecon@arm.com,
        catalin.marinas@arm.com, benh@kernel.crashing.org,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 06/10] mm,x86: skip cr4 and ldt reload when mm stays the same
Date:   Sat, 28 Jul 2018 17:53:53 -0400
Message-Id: <20180728215357.3249-7-riel@surriel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180728215357.3249-1-riel@surriel.com>
References: <20180728215357.3249-1-riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When switching back from lazy TLB mode to a thread of the same process
that switched into lazy TLB mode, we still have the cr4 (and sometimes
LDT) of that process loaded, and there is no need to reload it.

When there was no TLB flush while the CPU was in lazy TLB mode, the
current code in switch_mm_irqs_off already avoids the reload, by
returning early.

However, when the TLB contents on the CPU are out of date, and we
flush the TLB for the task, we fall through to the regular context
switching code. This patch teaches that code to skip the cr4 and LDT
flushes when switching back to the same mm after a flush.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 arch/x86/mm/tlb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 671cc66df801..149fb64e4bf4 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -367,8 +367,10 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	this_cpu_write(cpu_tlbstate.loaded_mm, next);
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);
 
-	load_mm_cr4(next);
-	switch_ldt(real_prev, next);
+	if (next != real_prev) {
+		load_mm_cr4(next);
+		switch_ldt(real_prev, next);
+	}
 }
 
 /*
-- 
2.14.4

