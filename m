Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELsfckcfKc70fSGSTwZFE2Gze3osDEVseKV+MlK1TfBvpfBIZU9VExbIKbx9tYTF/Df48TQn
ARC-Seal: i=1; a=rsa-sha256; t=1522157117; cv=none;
        d=google.com; s=arc-20160816;
        b=rM1HBXP+xivUJtCopeRetPm/tH094QUHOihoCRgJ+c0NLMj4jLq3zjFxpsG3L+tA53
         GJu8V8f9P2kT/7rXj0JV1XXnO5QbPSeKcnS3Dcfo6mlst8k11sdJiA7Zh22XIRJj0kd+
         aOJ/tABpR4xG6ZBb47Ottdz4zf/4zBxYQKgKB/k01kxPPJ+bdaOL3VT/fohPjKTYOX0i
         CSMn/HLYCYWBIesYGkMBC9T59j3hBWmeAeO4ronW6cR+Q5H++0DBdmB3/OLXpmzX6g7z
         3C+snoaqYxVNOjXh4A6g9jvseODenaprow6xDdAD/sFfSPtr5FHq+M2pF6wnrXzj36ny
         oR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dmarc-filter:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=A7aLEfRYOFoDJiSkGx6hSch9fAlRI3TqYrkTHhL50r0=;
        b=F2SJ4rYpNHMYZ3SwmY4onEiPCDl7VxAtfbuwLqVklGguyMFqHRTYMgEyckUcEhxftB
         TzoSKPhBB0wLdPkzX7HcFjcdhCS+0v+lRDck2sykClVn9tkFC3AEn4yQKFNcqT27KkBS
         QnNqvbZwxXdE/1E1tp1bR2jZIy8Jm3QsGHPdq+/dum6W6VwIlv6HzBXlDbW9jAWrsXPn
         FKq4vVUpcqbKQFNFt5Db/Q8eL5+f71JJ3+9WIiKJMSgTZQkk9/pqgoHgbDieZGrIXScI
         a5AbIchwdYdcAnFBhcfq5VXKq8/LqLS1ePnQEHbncOzwJa7sdniiwsYjLDwyug6uWJ2T
         bsdA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=VmaOBNnO;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=QtOYTcP4;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=VmaOBNnO;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=QtOYTcP4;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B0D7C6070A
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
Subject: [PATCH v5 0/4] Fix issues with huge mapping in ioremap for ARM64
Date: Tue, 27 Mar 2018 18:54:56 +0530
Message-Id: <1522157100-16879-1-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596097422055338244?=
X-GMAIL-MSGID: =?utf-8?q?1596097422055338244?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This series of patches are follow up work (and depends on)
Toshi Kani <toshi.kani@hpe.com>'s patches "fix memory leak/
panic in ioremap huge pages".

This series of patches are tested on 4.9 kernel with Cortex-A75
based SoC.

These patches can also go into '-stable' branch.

Chintan Pandya (4):
  ioremap: Update pgtable free interfaces with addr
  arm64: tlbflush: Introduce __flush_tlb_kernel_pgtable
  arm64: Implement page table free interfaces
  Revert "arm64: Enforce BBM for huge IO/VMAP mappings"

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


 arch/arm64/include/asm/tlbflush.h |  6 ++++++
 arch/arm64/mm/mmu.c               | 45 ++++++++++++++++++++++++++++-----------
 arch/x86/mm/pgtable.c             |  6 ++++--
 include/asm-generic/pgtable.h     |  8 +++----
 lib/ioremap.c                     |  4 ++--
 5 files changed, 49 insertions(+), 20 deletions(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
