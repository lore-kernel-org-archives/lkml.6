Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4+ntoo8Bsn7+B7ep+th8M7CX0CB7DejnOn6Pcv8RMUIKciq5FMu+NsOXApkpT/carGADyig
ARC-Seal: i=1; a=rsa-sha256; t=1522234750; cv=none;
        d=google.com; s=arc-20160816;
        b=pIHEzH3dUrIKjQJl+wnuusztiaU7q/RcpBLlNdfcj4XjvR4wzzOU3j/xveLpFlAgjS
         110DiHbxeJNIUR5l6TxXATFG8xvCUQoulor0dCjLgToMaAqxU9rWjwwLFaEcm6FfC16c
         98I0T8Yytua5wyhfTn69/7lIzEVgiYDQKZMbTPAyvv5pJGbMJNWf0Z+i14juVmYYZJu0
         rbiPb8WdeHvsuI6upWmqYAD9e9W7ifEkxJeV6SVHYpsc8XwuQyxhmuDzKsm9LoNfytGT
         TF/YtDL7al+fx3M/pPO+kGDNK0HecZm42WhrQhqskGnMq2VR1Aq7mNHBkvNLC0DZDm7b
         tATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dmarc-filter:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=k2TjdzelsM7uOCHk6/2juJ+G4jRSKoebzxd20Mv8wEE=;
        b=LTSnRD9eUg4rK5CgsyJBCrfSmVbFh1lUAKbT7Qy5h5j50RRm5PABaEkjW7Ld6dDy3H
         WX2pZpYolCPVJ51zqS3oHqIgCULAPmjljTQNqFSmbQjjrFQHatftXZ32qhOKVHqcXNtA
         4L4yYWZWihkN3OscJb8MGstgFc1J3jKE601TXYqIsMjOY+piiJbHtrLgFIsuiDqNP1Fp
         P6x95ta1lfXdEsvP6X5lDNqUu6KV7cM1hPEoTSuli3cJISCE51/2hKJ8q3Wt3bD6l7pI
         DItzoK+Pok3uzwR0WwX6p8otO4sLRSEsFEtVF8vWJYLzv7fsmL0dmQk+pkmV+sq2Wfcy
         66VA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=B3dmTPfZ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=fYMowMqQ;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=B3dmTPfZ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=fYMowMqQ;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7157360C66
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
Subject: [PATCH v6 0/4] Fix issues with huge mapping in ioremap for ARM64
Date: Wed, 28 Mar 2018 16:28:47 +0530
Message-Id: <1522234731-27397-1-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596178825691273824?=
X-GMAIL-MSGID: =?utf-8?q?1596178825691273824?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This series of patches are follow up work (and depends on)
Toshi Kani <toshi.kani@hpe.com>'s patches "fix memory leak/
panic in ioremap huge pages".

This series of patches are tested on 4.9 kernel with Cortex-A75
based SoC.

These patches can also go into '-stable' branch (if accepted)
for 4.6 onwards.

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
 arch/x86/mm/pgtable.c             |  6 ++++--
 include/asm-generic/pgtable.h     |  8 ++++----
 lib/ioremap.c                     |  4 ++--
 5 files changed, 41 insertions(+), 20 deletions(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
