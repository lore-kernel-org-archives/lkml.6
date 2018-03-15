Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELtL93uxKLgiyf31vGRDkwKSEFw61BmpYO7+LODQewt8cviAOd5KOfPlsz/krDDmsOOXMuS7
ARC-Seal: i=1; a=rsa-sha256; t=1521117921; cv=none;
        d=google.com; s=arc-20160816;
        b=r5YieWoGB01/Zqknb8zHIJsBe8fVx/q06GmQFelsZfOncAAPbb8a1QepfjSyHH2UVI
         a5rMXzJVZl6X3tzzmLBqcLELxB41nqLrPqMyl5bMdt+n8avv9xFoGpnhdi/UN/FBC8JT
         F6vLJkvu2+YyFyyCkuJN2s1yfXJ2ySAMqkH1OX3bbqnVy2HOStX3PX88lDupZ/XrU1Cg
         9rH1aOLi+7JiBuDs/20qbHzp4mFxvm34Lq5NrvDqaaaum3zC/hio+0e2lt+4r5qh8xfu
         JjWzZ0O77a7YUJ9vLmm53hakRQ1A2rqzbq/zrBuFPldkPsazEv1ta/FaVvTHWH/HvrsK
         EWBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dmarc-filter:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=lBzfBNWZM8yzleg8AzLbWY9SqTkibmMuna0rZgsJa60=;
        b=HWymilLHZIIV2MygCN0mH2rf0B+/fULF4wN3wyOLt+jmgjL8N8NdlPjzxN7rbOqMGo
         b/0j5Wu8JZHUIMk8eOuJiK1QoVoBxOb8MdyLlijhKCcEQXdQHNevhiDvJuMRZ/i3T2Nv
         Q46HAcccmlYFtkHhriHFFdK7IoYtOxtBiVuiQHt2OALNbr5U4yGgF4iPqV0Dkjp7aAFT
         ZppHB+E1lmWghiCvTxzsYHQKalUno36Xkzjb0FLRDrIYXeTcwjEDTaIM8TyWXLHV/NFA
         XGeU3vmO+N5apADrO5O/+4Ne/zphUpb+IRu3QfrCsROl7/UQKVqmLQ8X5zwWw7FqAHA4
         DPXA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Pr7CFZSi;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=lNxQZ78J;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Pr7CFZSi;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=lNxQZ78J;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03AA260128
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
From: Chintan Pandya <cpandya@codeaurora.org>
To: catalin.marinas@arm.com,
	will.deacon@arm.com,
	arnd@arndb.de
Cc: mark.rutland@arm.com,
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
	toshi.kani@hpe.com,
	Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v2 0/4] Fix issues with huge mapping in ioremap for ARM64
Date: Thu, 15 Mar 2018 18:15:02 +0530
Message-Id: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595007745044345185?=
X-GMAIL-MSGID: =?utf-8?q?1595007745044345185?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These series of patches are follow up work (and depends on)
Toshi Kani <toshi.kani@hpe.com>'s patches "fix memory leak/
panic in ioremap huge pages".

IOREMAP code has been touched up to honor BBM which is
requirement for some arch (like arm64) and works well
with all other.

Chintan Pandya (4):
  asm/tlbflush: Add flush_tlb_pgtable() for ARM64
  ioremap: Implement TLB_INV before huge mapping
  arm64: Implement page table free interfaces
  Revert "arm64: Enforce BBM for huge IO/VMAP mappings"

>From V1->V2:
 - Rebased my patches on top of "[PATCH v2 1/2] mm/vmalloc:
 Add interfaces to free unmapped page table"
 - Honored BBM for ARM64

 arch/arm64/include/asm/tlbflush.h |  5 +++++
 arch/arm64/mm/mmu.c               | 28 ++++++++++++++++++----------
 include/asm-generic/tlb.h         |  6 ++++++
 lib/ioremap.c                     | 25 +++++++++++++++++++------
 4 files changed, 48 insertions(+), 16 deletions(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
