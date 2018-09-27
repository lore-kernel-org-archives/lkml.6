Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCE7C004D5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CAD8216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CAD8216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbeI0WZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:25:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55069 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeI0WZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:25:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RG4nfV085173
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 09:04:49 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RG4mXI085169;
        Thu, 27 Sep 2018 09:04:48 -0700
Date:   Thu, 27 Sep 2018 09:04:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-e872267b8bcbb179e21ccc7118f258873d6e7a59@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, keescook@chromium.org,
        ard.biesheuvel@linaro.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
        arnd@arndb.de, rostedt@goodmis.org, tglx@linutronix.de,
        heiko.carstens@de.ibm.com, jeyu@kernel.org, will.deacon@arm.com,
        catalin.marinas@arm.com
Reply-To: heiko.carstens@de.ibm.com, jeyu@kernel.org,
          catalin.marinas@arm.com, will.deacon@arm.com, mingo@kernel.org,
          peterz@infradead.org, tglx@linutronix.de, arnd@arndb.de,
          rostedt@goodmis.org, schwidefsky@de.ibm.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          ard.biesheuvel@linaro.org, keescook@chromium.org
In-Reply-To: <20180919065144.25010-9-ard.biesheuvel@linaro.org>
References: <20180919065144.25010-9-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/core] jump_table: Move entries into ro_after_init region
Git-Commit-ID: e872267b8bcbb179e21ccc7118f258873d6e7a59
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e872267b8bcbb179e21ccc7118f258873d6e7a59
Gitweb:     https://git.kernel.org/tip/e872267b8bcbb179e21ccc7118f258873d6e7a59
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Tue, 18 Sep 2018 23:51:43 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Sep 2018 17:56:49 +0200

jump_table: Move entries into ro_after_init region

The __jump_table sections emitted into the core kernel and into
each module consist of statically initialized references into
other parts of the code, and with the exception of entries that
point into init code, which are defused at post-init time, these
data structures are never modified.

So let's move them into the ro_after_init section, to prevent them
from being corrupted inadvertently by buggy code, or deliberately
by an attacker.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Jessica Yu <jeyu@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: https://lkml.kernel.org/r/20180919065144.25010-9-ard.biesheuvel@linaro.org

---
 arch/s390/kernel/vmlinux.lds.S    |  1 +
 include/asm-generic/vmlinux.lds.h | 11 +++++++----
 kernel/module.c                   |  9 +++++++++
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index b43f8d33a369..4042bbf3f9ad 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -66,6 +66,7 @@ SECTIONS
 		 *(.data..ro_after_init)
 	}
 	EXCEPTION_TABLE(16)
+	JUMP_TABLE_DATA
 	. = ALIGN(PAGE_SIZE);
 	__end_ro_after_init = .;
 
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 7b75ff6e2fce..f09ee3c544bc 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -253,10 +253,6 @@
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
@@ -300,6 +296,12 @@
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
@@ -308,6 +310,7 @@
 #define RO_AFTER_INIT_DATA						\
 	__start_ro_after_init = .;					\
 	*(.data..ro_after_init)						\
+	JUMP_TABLE_DATA							\
 	__end_ro_after_init = .;
 #endif
 
diff --git a/kernel/module.c b/kernel/module.c
index 6746c85511fe..49a405891587 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3315,6 +3315,15 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
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
 
