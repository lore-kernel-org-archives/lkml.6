Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE2DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310B8208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310B8208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbeHXT1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:27:51 -0400
Received: from foss.arm.com ([217.140.101.70]:32816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbeHXT1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:27:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F09FC1650;
        Fri, 24 Aug 2018 08:52:37 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C25043F7BE;
        Fri, 24 Aug 2018 08:52:37 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id B7AB01AE3265; Fri, 24 Aug 2018 16:52:47 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, benh@au1.ibm.com,
        torvalds@linux-foundation.org, npiggin@gmail.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 02/11] arm64: tlb: Add DSB ISHST prior to TLBI in __flush_tlb_[kernel_]pgtable()
Date:   Fri, 24 Aug 2018 16:52:37 +0100
Message-Id: <1535125966-7666-3-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__flush_tlb_[kernel_]pgtable() rely on set_pXd() having a DSB after
writing the new table entry and therefore avoid the barrier prior to the
TLBI instruction.

In preparation for delaying our walk-cache invalidation on the unmap()
path, move the DSB into the TLB invalidation routines.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/tlbflush.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 7e2a35424ca4..e257f8655b84 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -213,6 +213,7 @@ static inline void __flush_tlb_pgtable(struct mm_struct *mm,
 {
 	unsigned long addr = __TLBI_VADDR(uaddr, ASID(mm));
 
+	dsb(ishst);
 	__tlbi(vae1is, addr);
 	__tlbi_user(vae1is, addr);
 	dsb(ish);
@@ -222,6 +223,7 @@ static inline void __flush_tlb_kernel_pgtable(unsigned long kaddr)
 {
 	unsigned long addr = __TLBI_VADDR(kaddr, 0);
 
+	dsb(ishst);
 	__tlbi(vaae1is, addr);
 	dsb(ish);
 }
-- 
2.1.4

