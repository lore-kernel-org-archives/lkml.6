Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELuoKzUkKImsZfjMkqr8g+mK+yIaagfbqZHJFWYgVzY6nSKu40/vHiuZN1u2ABDHE7IgtdJN
ARC-Seal: i=1; a=rsa-sha256; t=1521546341; cv=none;
        d=google.com; s=arc-20160816;
        b=u7WkgNzKNCwkLhsBYGQgv3YaUCucBdoypHic7LAbZSriD9cjdCK3RaIAVGKzn1O+16
         XzfibuT/SzU72wK8QO/uaIvNcDJH2h7rk4Y18SVc7FV5URDa7EWO4uRruJU9Y1/1utG3
         gki6cJcPN3a1X6krGaauBa17me2J8nNMD3okZm5nQn5FNP7sn4g52qR7ZbngCE/yQHgc
         UXCNRsb5wit2QCF88qNz2meQkHDXDNUfDfDDHdH8MIEJoGtwZd4AdKR/4md5n+sE+i7X
         siEp3zmDhcqobb+1vgePucaxrMNDOMAbu2ShNCH+RIGBNDXnQTN306tx/Hs09YbkjQS0
         3UuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dmarc-filter:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=k8hM8jjY+OdYsqj1dt4mdC6syGT1i23ZJQkv9QApQn8=;
        b=belDIMAkcmHnOmC0CPUbdnt7f0ZcavwZtmylIfuV4uNYRezDkQgCwQk6wfYhsjYczD
         pE/eHN5LQLv3zoYa6RvdjJTC61hVawF88vLXwnBYWQZKqnSjPu9QtqqljZJWQEEV5sOU
         dxcnsNJlRVUdpJLTDI+SNsD3vWyKjhQla8ddJ8tCEFMrFoMWJ4IkrWhDHCG56NMUYTIg
         wrMrFaCcXvF+p3ZY789f4vpABMupttQcnYlHuv1wtdo+9iHDlw+nR5z7bM7+Tl94W9VS
         qkEQ9acC9SsyHDuC33SJXA5FWsYG1oJ1t8t6kFeA9z0zFueR+Hn7cw3PnJBX5JH2Iicq
         /CWA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=QPePq62u;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=HieibKSc;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=QPePq62u;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=HieibKSc;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1BF2560591
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
From: Chintan Pandya <cpandya@codeaurora.org>
To: catalin.marinas@arm.com,
	will.deacon@arm.com,
	mark.rutland@arm.com
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
	toshi.kani@hpe.com,
	Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v4 0/3] Fix issues with huge mapping in ioremap for ARM64
Date: Tue, 20 Mar 2018 17:15:11 +0530
Message-Id: <1521546314-31753-1-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595456976806796505?=
X-GMAIL-MSGID: =?utf-8?q?1595456976806796505?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This series of patches are follow up work (and depends on)
Toshi Kani <toshi.kani@hpe.com>'s patches "fix memory leak/
panic in ioremap huge pages".

This series of patches are tested on 4.9 kernel with Cortex-A75
based SoC.

Chintan Pandya (3):
  ioremap: Update pgtable free interfaces with addr
  arm64: Implement page table free interfaces
  Revert "arm64: Enforce BBM for huge IO/VMAP mappings"

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

 arch/arm64/mm/mmu.c           | 51 +++++++++++++++++++++++++++++++++----------
 arch/x86/mm/pgtable.c         |  6 +++--
 include/asm-generic/pgtable.h |  8 +++----
 lib/ioremap.c                 |  4 ++--
 4 files changed, 49 insertions(+), 20 deletions(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
