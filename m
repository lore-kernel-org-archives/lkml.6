Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELtIkXnpiqBo2GIDegPJETK0+M2LgPu6HKbKKSogNB1XrQHYM0xSlFhgJl2+QsUMIDztxOrv
ARC-Seal: i=1; a=rsa-sha256; t=1521463273; cv=none;
        d=google.com; s=arc-20160816;
        b=gJV8VB5Da1mtSpq+baOMMLTaYAL1kaOV6uQyvMeQhkk4AdTAH9pw8+6AcY/aaEqu3F
         Y5ItkWQ7wInrEO8E6MnoVysuKsd1u3n3ITPzrFXFfS6r06i5mzVn+uzS06gdIdT/Ip8K
         IBJSqZyvpPApiWpr0+H6tzhKiJBHPtsWAG6G/2xvGxs01c+6R6OZrC9povmLTl2Y/7sS
         NaZYOatRpT9vEXPmeE2EkW16w36j7AvL7K6hRoau5jEFO372cic+S6WFlYvpgOv0ZrLX
         lEuWeSuHKbSlCXspmHOB9XZt6weUimRDxYAxRnPY6UJDva5HhX9TEBjtIXmg7ZFM5mgh
         9ftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dmarc-filter:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=YSlYqRwvJyYOCOpOvY5NiuxLR8QH06R0lvVXZSXAiA8=;
        b=Nb7+ShyYnsw3bYKPE7GtJ/A5piwgU9qrwKmpQYWAlaLPtV9ePeXUPLXR7qCfUGQWmw
         FZfdLBZGdcS5RAl0V+kONJytUm8XDBEjm1Bvcvu+/5tRrCs0U6iJDLzczG/d7qB9VI4C
         zGllb62TfILINhYuJm63r6Fvg9zYTe3pvCI/F1I+migSYYV9um6BCFGQ2Q3HvhPm81IT
         uoJMx9KAkGfZjTzGD2qR7VC8bSSMnB9NXFNRU7jGHb48Io4voNV9m3IqY5J1xQ7DxTIa
         q4Z7HhcNuFBDUvLQTem71aaiNC7rWnyAAXOY5Hz7Ax0ZzIQd5L2780Y8NBdb9vuk0nN7
         KLuA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=kHAaRM0+;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=cSeQGwZW;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=kHAaRM0+;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=cSeQGwZW;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 852C36055B
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
Subject: [PATCH v3 0/3] Fix issues with huge mapping in ioremap for ARM64
Date: Mon, 19 Mar 2018 18:10:53 +0530
Message-Id: <1521463256-19858-1-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595369872957799920?=
X-GMAIL-MSGID: =?utf-8?q?1595369872957799920?=
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

>From V2->V3:
 - Use the exisiting page table free interface to do arm64
   specific things

>From V1->V2:
 - Rebased my patches on top of "[PATCH v2 1/2] mm/vmalloc:
   Add interfaces to free unmapped page table"
 - Honored BBM for ARM64

 arch/arm64/mm/mmu.c           | 40 ++++++++++++++++++++++++++++------------
 arch/x86/mm/pgtable.c         |  4 ++--
 include/asm-generic/pgtable.h |  8 ++++----
 lib/ioremap.c                 |  4 ++--
 4 files changed, 36 insertions(+), 20 deletions(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
