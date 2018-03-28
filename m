Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AIpwx48wFfh1kbErrr83VOF5D+jDz4NdF6IUJbcUUU6yRmmMS6AKlMqQUbE7j1pHTMe/qRRBDR1X
ARC-Seal: i=1; a=rsa-sha256; t=1522240298; cv=none;
        d=google.com; s=arc-20160816;
        b=jlCu2v/NBVytFzBT+ly+ozpODx5lwDMxw/Z+Y0RLmNQIHj9q4v8pRZTcF8ITWzCG8G
         g9jO9iRrqSuJOIUQYEbrAzywC+HyZNQKQJfGwv/kczB/oEnLMo6EbiyBREQtXQlaHKhn
         w68UMaSh0Bozolh4MtFaaNCNAQS7dJJgXknilPuVC6p0ailzcVI47bkUS0V/a1RF6Sff
         yeb8caZdf9zDfVWCIJPJjcvZJ4VPV5bX8W0+O3Tzau9Ibba2dBa9smylRWmyvG4EK7jk
         cKMirV8KxYC/C8CddwII5IXCOrCyXcfBldu9RhM0mBJ2DpRfxSfr5PUxGkht4eYFYiwb
         JHhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dmarc-filter:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=9wG+C9Rf1Wr2knDn7Yq9un8hGP7uLUOoN6PkseyifJk=;
        b=X9SsvwnB1g/GedMOOw5e9L51dcExInAkoj24sN+uBqXJZxQhDcDgEG9ESDKOPr1NxJ
         BoCMtdvrv01m4coQV/PMvYM11L8cJQKWFvhbsywDSZoRhVtcw+PAPnnrxl5jMrmXrXsV
         NP6YEBgfpP7ShTOZr11YD3QJC+QqN+U7inc89dL/2aMFBlSqK0WPpt4PS1TgPNO2VoOy
         kbKMGgXclbb0aElCbTqqOOEoWWiOdnB7w2Pnl2wM06aZ71VPQ/9C2JRhJwOXSMgR35ma
         ugtGT+xBOZrKrnal1AXYMwUtgWpI6kvZQrRinDPuVmvQ+JcP6M9SNSgn3eTHAy5s25lf
         uL6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=LwWET+VB;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=HwbnZ8PZ;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=LwWET+VB;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=HwbnZ8PZ;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 14FF960591
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
From: Chintan Pandya <cpandya@codeaurora.org>
To: catalin.marinas@arm.com,
	will.deacon@arm.com,
	mark.rutland@arm.com,
	toshi.kani@hpe.com
Cc: arnd@arndb.de,
	ard.biesheuvel@linaro.org,
	marc.zyngier@arm.com,
	james.morse@arm.com,
	kristina.martsenko@arm.com,
	takahiro.akashi@linaro.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	akpm@linux-foundation.org,
	Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v7 0/4] Fix issues with huge mapping in ioremap for ARM64
Date: Wed, 28 Mar 2018 18:01:18 +0530
Message-Id: <1522240282-12104-1-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596178825691273824?=
X-GMAIL-MSGID: =?utf-8?q?1596184643504363017?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This series of patches are follow up work (and depends on)
Toshi Kani <toshi.kani@hpe.com>'s patches "fix memory leak/
panic in ioremap huge pages".

This series of patches are tested on 4.9 kernel with Cortex-A75
based SoC.

These patches can also go into '-stable' branch (if accepted)
for 4.6 onwards.

>From V6->V7:
 - Fixed compilation issue in x86 case
 - V6 patches were not properly enumarated

>From V5->V6:
 - Use __flush_tlb_kernel_pgtable() for both PUD and PMD. Remove
   "bool tlb_inv" based variance as it is not need now
 - Re-naming for consistency

>From V4->V5:
 - Add new API __flush_tlb_kernel_pgtable(unsigned long addr)
   for kernel addresses

>From V3->V4:
 - Add header for 'addr' in x86 implementation
 - Re-order pmd/pud clear and table free
 - Avoid redundant TLB invalidatation in one perticular case

>From V2->V3:
 - Use the exisiting page table free interface to do arm64
   specific things

>From V1->V2:
 - Rebased my patches on top of "[PATCH v2 1/2] mm/vmalloc:
   Add interfaces to free unmapped page table"
 - Honored BBM for ARM64

Chintan Pandya (4):
  ioremap: Update pgtable free interfaces with addr
  arm64: tlbflush: Introduce __flush_tlb_kernel_pgtable
  arm64: Implement page table free interfaces
  Revert "arm64: Enforce BBM for huge IO/VMAP mappings"

 arch/arm64/include/asm/tlbflush.h |  6 ++++++
 arch/arm64/mm/mmu.c               | 37 +++++++++++++++++++++++++------------
 arch/x86/mm/pgtable.c             |  8 +++++---
 include/asm-generic/pgtable.h     |  8 ++++----
 lib/ioremap.c                     |  4 ++--
 5 files changed, 42 insertions(+), 21 deletions(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
