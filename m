Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AIpwx49csB6WQGC22rLaQ/5XApn0zwbHibe8RGr4xmX4xP+hDfPc6+AHbnDXQz+zcbDGbjOyGLTL
ARC-Seal: i=1; a=rsa-sha256; t=1522742462; cv=none;
        d=google.com; s=arc-20160816;
        b=u72EEvCH2a//YmKYyOYxdLtknQs8iRBNVXQdMPzgvU7tIZNwbAFALQ57gbLNIlWcXF
         +jeUyWgClFwV3BcRS/7fFZ+64CNhiS40hdMcasoT5Kg1pKjyS1wrd594x7FQcmtbsgX0
         P3L3GDuZ5Oos4sc+QStEFHxDzJVOSBnCz4no/Jl7zzEoLriqrVBtOTfCdL3QwN3nI2/O
         5iAIDDxyzSH4I61bd57V14XVcmZnRoVfkjPyT5rkJySL1KZ5DuTC0FIf5WjhxyAuq/6d
         vTn+C/plq2qIazFYc7+elmEdL7umUDbBBezG2x+3nKQw7mtUogcWWUsdZi1Doh5FwaEG
         GSIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dmarc-filter:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=izlosYSX2Z2ixUlImOJkArGmhuf2QgixllKKuHJ8PWE=;
        b=XVgkXf7jDjetv1aF4d9OLTpbuZ2NEISuowYBsITpDmtcLLEPKe0hvMipiaaagrEy6X
         vuIxzI9k9RNDe6th8Vdz2TTKtpa8U0L9kft9foPjmKTS4YpkMImdySR9agcH/dt1mQ0P
         cr3jJ/ZrBEPI4Kw6zNme+He0xm6cwoPGOGkLH6ayELfRm7UTze2i+5Wv2PucyIGUIuA1
         9Lh+6qXGJBv0zd0dBFur0dP+yWR3ZZy2wCqSUtZW05+kOhtNIUNXhtifFQ++H3UukLkO
         ZODXbkRSrb9DWnfygaVm6rd50OYnkuPxFwK5eb2bZPG5/1pxc5nXGkZrorz+UUCBX3Oe
         iF/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=NTIz6mIW;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=WoPF3OXs;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=NTIz6mIW;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=WoPF3OXs;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C14A6602B7
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
Subject: [PATCH v8 0/4] Fix issues with huge mapping in ioremap for ARM64
Date: Tue,  3 Apr 2018 13:30:42 +0530
Message-Id: <1522742446-5084-1-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596711199968894044?=
X-GMAIL-MSGID: =?utf-8?q?1596711199968894044?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This series of patches are follow up work (and depends on)
Toshi Kani <toshi.kani@hpe.com>'s patches "fix memory leak/
panic in ioremap huge pages".

This series of patches are tested on 4.9 kernel with Cortex-A75
based SoC.

These patches can also go into '-stable' branch (if accepted)
for 4.6 onwards.

>From V7->V8:
 - Properly fixed compilation issue in x86 file

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
