Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11567C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10ED20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10ED20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeH3USm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:18:42 -0400
Received: from foss.arm.com ([217.140.101.70]:44780 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbeH3USl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:18:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F41E718A;
        Thu, 30 Aug 2018 09:15:48 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C482D3F557;
        Thu, 30 Aug 2018 09:15:48 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 0DC661AE3614; Thu, 30 Aug 2018 17:16:01 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, benh@au1.ibm.com,
        torvalds@linux-foundation.org, npiggin@gmail.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 00/12] Avoid synchronous TLB invalidation for intermediate page-table entries on arm64
Date:   Thu, 30 Aug 2018 17:15:34 +0100
Message-Id: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

This is v1 of the RFC I previously posted here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2018-August/597821.html

The main changes include:

  * Rewrite the comment in tlbflush.h to explain the various functions
    and justify the barrier semantics

  * Fix the "flush entire ASID" heuristic to work with !4K page sizes

  * Fixed the build on sh (well, it fails somewhere else that isn't my fault)

  * Report PxD_SHIFT instead of PxD_SIZE via tlb_get_unmap_shift()

It's also had a lot more testing, but has held up nicely so far on arm64.
I haven't figured out how to merge this yet, but I'll probably end up pulling
the core changes out onto a separate branch.

Cheers,

Will

--->8

Peter Zijlstra (1):
  asm-generic/tlb: Track freeing of page-table directories in struct
    mmu_gather

Will Deacon (11):
  arm64: tlb: Use last-level invalidation in flush_tlb_kernel_range()
  arm64: tlb: Add DSB ISHST prior to TLBI in
    __flush_tlb_[kernel_]pgtable()
  arm64: pgtable: Implement p[mu]d_valid() and check in set_p[mu]d()
  arm64: tlb: Justify non-leaf invalidation in flush_tlb_range()
  arm64: tlbflush: Allow stride to be specified for __flush_tlb_range()
  arm64: tlb: Remove redundant !CONFIG_HAVE_RCU_TABLE_FREE code
  asm-generic/tlb: Guard with #ifdef CONFIG_MMU
  asm-generic/tlb: Track which levels of the page tables have been
    cleared
  arm64: tlb: Adjust stride and type of TLBI according to mmu_gather
  arm64: tlb: Avoid synchronous TLBIs when freeing page tables
  arm64: tlb: Rewrite stale comment in asm/tlbflush.h

 arch/arm64/Kconfig                |   1 +
 arch/arm64/include/asm/pgtable.h  |  10 +++-
 arch/arm64/include/asm/tlb.h      |  34 +++++-------
 arch/arm64/include/asm/tlbflush.h | 112 ++++++++++++++++++++++++--------------
 include/asm-generic/tlb.h         |  85 +++++++++++++++++++++++++----
 mm/memory.c                       |   4 +-
 6 files changed, 168 insertions(+), 78 deletions(-)

-- 
2.1.4

