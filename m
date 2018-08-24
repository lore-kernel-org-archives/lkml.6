Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416B2C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0E021557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0E021557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbeHXT2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:28:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32796 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbeHXT1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:27:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1B9E80D;
        Fri, 24 Aug 2018 08:52:37 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A24D73F5BC;
        Fri, 24 Aug 2018 08:52:37 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 9A9651AE323F; Fri, 24 Aug 2018 16:52:47 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, benh@au1.ibm.com,
        torvalds@linux-foundation.org, npiggin@gmail.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 00/11] Avoid synchronous TLB invalidation for intermediate page-table entries on arm64
Date:   Fri, 24 Aug 2018 16:52:35 +0100
Message-Id: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I hacked up this RFC on the back of the recent changes to the mmu_gather
stuff in mainline. It's had a bit of testing and it looks pretty good so
far.

The main changes in the series are:

  - Avoid emitting a DSB barrier after clearing each page-table entry.
    Instead, we can have a single DSB prior to the actual TLB invalidation.

  - Batch last-level TLB invalidation until the end of the VMA, and use
    last-level-only invalidation instructions

  - Batch intermediate TLB invalidation until the end of the gather, and
    use all-level invalidation instructions

  - Adjust the stride of TLB invalidation based upon the smallest unflushed
    granule in the gather

As a really stupid benchmark, unmapping a populated mapping of
0x4_3333_3000 bytes using munmap() takes around 20% of the time it took
before.

The core changes now track the levels of page-table that have been visited
by the mmu_gather since the last flush. It may be possible to use the
page_size field instead if we decide to resurrect that from its current
"debug" status, but I think I'd prefer to track the levels explicitly.

Anyway, I wanted to post this before disappearing for the long weekend
(Monday is a holiday in the UK) in the hope that it helps some of the
ongoing discussions.

Cheers,

Will

--->8

Peter Zijlstra (1):
  asm-generic/tlb: Track freeing of page-table directories in struct
    mmu_gather

Will Deacon (10):
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

 arch/arm64/Kconfig                |  1 +
 arch/arm64/include/asm/pgtable.h  | 10 ++++-
 arch/arm64/include/asm/tlb.h      | 34 +++++++----------
 arch/arm64/include/asm/tlbflush.h | 28 +++++++-------
 include/asm-generic/tlb.h         | 79 +++++++++++++++++++++++++++++++++------
 mm/memory.c                       |  4 +-
 6 files changed, 105 insertions(+), 51 deletions(-)

-- 
2.1.4

