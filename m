Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01D9C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A531F20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A531F20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeH3USm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:18:42 -0400
Received: from foss.arm.com ([217.140.101.70]:44834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbeH3USl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:18:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B26B168F;
        Thu, 30 Aug 2018 09:15:49 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0CED33F557;
        Thu, 30 Aug 2018 09:15:49 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 4AF5A1AE36AF; Thu, 30 Aug 2018 17:16:01 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, benh@au1.ibm.com,
        torvalds@linux-foundation.org, npiggin@gmail.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 04/12] arm64: tlb: Justify non-leaf invalidation in flush_tlb_range()
Date:   Thu, 30 Aug 2018 17:15:38 +0100
Message-Id: <1535645747-9823-5-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
References: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a comment to explain why we can't get away with last-level
invalidation in flush_tlb_range()

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/tlbflush.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index e257f8655b84..ddbf1718669d 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -182,6 +182,10 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 static inline void flush_tlb_range(struct vm_area_struct *vma,
 				   unsigned long start, unsigned long end)
 {
+	/*
+	 * We cannot use leaf-only invalidation here, since we may be invalidating
+	 * table entries as part of collapsing hugepages or moving page tables.
+	 */
 	__flush_tlb_range(vma, start, end, false);
 }
 
-- 
2.1.4

