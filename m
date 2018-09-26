Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA876C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6B0214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XlZ1QiUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6B0214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbeIZSHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:07:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55580 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbeIZSHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4vXKM651yL9SYzrpJ9StXrE0xaFJG55+LSyER0yWd2I=; b=XlZ1QiUamzDpKJA8W8dxiyvoV
        iHHjbJ+LIOK5LCASMP6k6AqSkebc7wWRZ8k1B+2eK2E5g84PDSjbJ2GtkIzMl8P9CgaWoxYktyZr3
        g0SORSFsi8tKHahbDZRheB58Pgzo5dfK5SayYQFc0m+/JoCid0+4PrDe6YyrfKQnTdb4heMbhWFV1
        ejAb5egfeov2daaale4qeZv/hOoW5HzZycXtD58nt49T74yGL2U/kN3tKYsXokK7gkDVeqD/iGEL6
        A+PxsyShXPhjm5YbgVacJryiji/EX1z7NfQPg+sTLNd0KmFlERvPaMy6rvOp/045IrPg3fP0dh9e8
        FcQjyCXlg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g58OM-0005vb-7W; Wed, 26 Sep 2018 11:54:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 717D4206F1802; Wed, 26 Sep 2018 13:54:04 +0200 (CEST)
Message-ID: <20180926113623.863696043@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 26 Sep 2018 13:36:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com,
        fengguang.wu@intel.com
Subject: [PATCH 00/18] my generic mmu_gather patches
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is my current stash of generic mmu_gather patches that goes on top of Will's
tlb patches:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tlb/asm-generic

And they include the s390 patches done by Heiko. At the end of this, there is
not a single arch left with a custom mmu_gather.

I've been slow posting these, because the 0-day bot seems to be having trouble
and I've not been getting the regular cross-build green light emails that I
otherwise rely upon.

I hope to have addressed all the feedback from the last time, and I've added a
bunch of missing Cc's from last time.

Please review with care.

---
 arch/Kconfig                      |   8 +-
 arch/alpha/include/asm/tlb.h      |   2 -
 arch/arc/include/asm/tlb.h        |  32 -----
 arch/arm/include/asm/tlb.h        | 256 +++----------------------------------
 arch/arm64/Kconfig                |   1 -
 arch/arm64/include/asm/tlb.h      |   1 +
 arch/c6x/include/asm/tlb.h        |   1 +
 arch/h8300/include/asm/tlb.h      |   2 -
 arch/hexagon/include/asm/tlb.h    |  12 --
 arch/ia64/include/asm/tlb.h       | 257 +-------------------------------------
 arch/ia64/include/asm/tlbflush.h  |  25 ++++
 arch/ia64/mm/tlb.c                |  23 +++-
 arch/m68k/include/asm/tlb.h       |   1 -
 arch/microblaze/include/asm/tlb.h |   4 +-
 arch/mips/include/asm/tlb.h       |  17 ---
 arch/nds32/include/asm/tlb.h      |  16 ---
 arch/nios2/include/asm/tlb.h      |  14 +--
 arch/openrisc/include/asm/tlb.h   |   6 +-
 arch/parisc/include/asm/tlb.h     |  18 ---
 arch/powerpc/Kconfig              |   2 +
 arch/powerpc/include/asm/tlb.h    |  18 +--
 arch/riscv/include/asm/tlb.h      |   1 +
 arch/s390/Kconfig                 |   2 +
 arch/s390/include/asm/tlb.h       | 130 ++++++-------------
 arch/s390/mm/pgalloc.c            |  63 +---------
 arch/sh/include/asm/pgalloc.h     |   9 ++
 arch/sh/include/asm/tlb.h         | 132 +-------------------
 arch/sparc/Kconfig                |   1 +
 arch/sparc/include/asm/tlb_32.h   |  18 ---
 arch/um/include/asm/tlb.h         | 158 +----------------------
 arch/unicore32/include/asm/tlb.h  |  10 +-
 arch/x86/Kconfig                  |   1 -
 arch/x86/include/asm/tlb.h        |  22 ++--
 arch/x86/include/asm/tlbflush.h   |  12 +-
 arch/x86/mm/tlb.c                 |  17 ++-
 arch/xtensa/include/asm/tlb.h     |  26 ----
 include/asm-generic/tlb.h         | 238 +++++++++++++++++++++++++++++++----
 mm/huge_memory.c                  |   4 +-
 mm/hugetlb.c                      |   2 +-
 mm/madvise.c                      |   2 +-
 mm/memory.c                       |   6 +-
 mm/mmu_gather.c                   | 129 ++++++++++---------
 mm/pgtable-generic.c              |   1 +
 43 files changed, 460 insertions(+), 1240 deletions(-)


