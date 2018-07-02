Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91885C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506CB24FB0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YU/k/IND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506CB24FB0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932128AbeGBSNW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:13:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33821 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753411AbeGBSMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:12:12 -0400
Received: by mail-wm0-f66.google.com with SMTP id l15-v6so8434961wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7N9XKGd0sxRVNc0we3lJWgc+AZzZcg0kB6rVsSIgvFo=;
        b=YU/k/INDi7ij+ctOedglsRe1RQX9OZkobjcjBTQZxe0TrWVakVSSHk/gzOjSe48e8y
         VBuXRqlAK8daj7ebbxM1MvemtyICuuPWJNG4ZL6wx6Tc13wGbhRJOAY/cmCBEVVBm7Si
         L4a5xr2wOAY9UkUzCayl09/NATos5WTWpEJ5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7N9XKGd0sxRVNc0we3lJWgc+AZzZcg0kB6rVsSIgvFo=;
        b=JLf0u5xGZf+qEvzM7rpTbyw0WqnkJuWhtmrVnGu+Ly/WSWkUeMx3CnTWoNbTLx2VWb
         iG7a332u7bo9FWfFf9UAL1FVeYbPUKRdyIC5I1jxqh745rgbfiLDw4/PFJoeANaGtltg
         TJQW0uodcylLkhJt40bR7VANJ2HDwuP67600EpabWWbMvtpgpUqLC/oCWgesMk12vyWm
         nw/VlsuPZ4OWC/cEOnkIq5kh28i0GKM4XCY+q9yOdfJMCGiQhOLXooERUXc3qRGs98AE
         PkimaB5YBFJ7dYRHOBbrUr23egrVFGt0R4Y/LDtwxa4blhp8/crC1hHQvAy9tc+W5lZa
         6pZw==
X-Gm-Message-State: APt69E3VDnqupBuTI+fJefWS3Y6c5aYnHl7YmDg1bslnB3zSEOByNd3J
        NTVNgbgErWlCULa2kAYdZt3v2A==
X-Google-Smtp-Source: AAOMgpdmhcIBEG4WwrqsCE7ynxd8/r0InpnAAFIlwmj3ZJ0PjKjxT94JUFdvFrypu/IE6luygYmgRg==
X-Received: by 2002:a1c:b6d6:: with SMTP id g205-v6mr9662447wmf.17.1530555130943;
        Mon, 02 Jul 2018 11:12:10 -0700 (PDT)
Received: from localhost.localdomain (151.21.90.92.rev.sfr.net. [92.90.21.151])
        by smtp.gmail.com with ESMTPSA id 189-v6sm10582822wmd.17.2018.07.02.11.12.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 11:12:10 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Jessica Yu <jeyu@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 8/8] jump_table: move entries into ro_after_init region
Date:   Mon,  2 Jul 2018 20:11:45 +0200
Message-Id: <20180702181145.4799-9-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
References: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __jump_table sections emitted into the core kernel and into
each module consist of statically initialized references into
other parts of the code, and with the exception of entries that
point into init code, which are defused at post-init time, these
data structures are never modified.

So let's move them into the ro_after_init section, to prevent them
from being corrupted inadvertently by buggy code, or deliberately
by an attacker.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kernel/vmlinux-xip.lds.S |  1 +
 arch/s390/kernel/vmlinux.lds.S    |  1 +
 include/asm-generic/vmlinux.lds.h | 11 +++++++----
 kernel/module.c                   |  9 +++++++++
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 3593d5c1acd2..763c41068ecc 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -118,6 +118,7 @@ SECTIONS
 	RW_DATA_SECTION(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
 	.data.ro_after_init : AT(ADDR(.data.ro_after_init) - LOAD_OFFSET) {
 		*(.data..ro_after_init)
+		JUMP_TABLE_DATA
 	}
 	_edata = .;
 
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index f0414f52817b..a7cf61e46f88 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -67,6 +67,7 @@ SECTIONS
 	__start_ro_after_init = .;
 	.data..ro_after_init : {
 		 *(.data..ro_after_init)
+		JUMP_TABLE_DATA
 	}
 	EXCEPTION_TABLE(16)
 	. = ALIGN(PAGE_SIZE);
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e373e2e10f6a..ed6befa4c47b 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -256,10 +256,6 @@
 	STRUCT_ALIGN();							\
 	*(__tracepoints)						\
 	/* implement dynamic printk debug */				\
-	. = ALIGN(8);                                                   \
-	__start___jump_table = .;					\
-	KEEP(*(__jump_table))                                           \
-	__stop___jump_table = .;					\
 	. = ALIGN(8);							\
 	__start___verbose = .;						\
 	KEEP(*(__verbose))                                              \
@@ -303,6 +299,12 @@
 	. = __start_init_task + THREAD_SIZE;				\
 	__end_init_task = .;
 
+#define JUMP_TABLE_DATA							\
+	. = ALIGN(8);							\
+	__start___jump_table = .;					\
+	KEEP(*(__jump_table))						\
+	__stop___jump_table = .;
+
 /*
  * Allow architectures to handle ro_after_init data on their
  * own by defining an empty RO_AFTER_INIT_DATA.
@@ -311,6 +313,7 @@
 #define RO_AFTER_INIT_DATA						\
 	__start_ro_after_init = .;					\
 	*(.data..ro_after_init)						\
+	JUMP_TABLE_DATA							\
 	__end_ro_after_init = .;
 #endif
 
diff --git a/kernel/module.c b/kernel/module.c
index 7cb82e0fcac0..0d4e320e41cd 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3349,6 +3349,15 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
 	 * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
 	 */
 	ndx = find_sec(info, ".data..ro_after_init");
+	if (ndx)
+		info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
+	/*
+	 * Mark the __jump_table section as ro_after_init as well: these data
+	 * structures are never modified, with the exception of entries that
+	 * refer to code in the __init section, which are annotated as such
+	 * at module load time.
+	 */
+	ndx = find_sec(info, "__jump_table");
 	if (ndx)
 		info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
 
-- 
2.17.1

