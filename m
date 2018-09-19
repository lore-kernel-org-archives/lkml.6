Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C90EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C1E20880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Focb2vMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C1E20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731139AbeISM3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:29:13 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51186 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731086AbeISM3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:29:13 -0400
Received: by mail-it0-f65.google.com with SMTP id j81-v6so6864335ite.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 23:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6WcczBvykg2Z58bAiHqwLTs7BS22B+N9kwtSqthViSE=;
        b=Focb2vMv0Nwcyy8JpgHJ+eawzudhCpL77NjYEXyCv5owfpRIMB9U+XM+EUUsK4ZAgM
         FzzcDvaN97C+D4oF8Abvfa1yIacasMqfez3ah7v1BBLBqkVVyQMiR4oCyqB/pi8iYLns
         qqs7M3GyoO3OUXvzfKgFJjlZ98/QYCN5z09n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6WcczBvykg2Z58bAiHqwLTs7BS22B+N9kwtSqthViSE=;
        b=Sv+8DEOUIv8GoGfRZuu0qWT0wzNTZJGNRX9kVsRaANo8zJHNmTetKpE64Lv86N/Mk/
         AMMz3RH2IA2x6gv4VYzAkYpATSDtL9GOq0l455vaNGDPyDt7LRFnifdnEvRTdoXTrT/q
         SbV6HxWuIT3HH9kcBfZER28ER60vLVVUv/i7VvJ+KHJligVxEThnMNWteNKUgfaPG4Vq
         gkF4FqAnLkuiJy+sORYqrmsmEO6XMyYOkShbQHkfr/vYbrsn3hFEWgP7DdNQgRZxgi4W
         wpLiHCGRFgrv23ez14aUqrBD943U7n54uFjJndwafjlpIM0dhIqE7CeEUsXM5sGtSfBw
         FJlw==
X-Gm-Message-State: APzg51Cd1t2ixLfd8vsKkCDKjFuRHRfgAdDmKtpXmBcPrd9hmkHjMOLY
        YFI2HkyLiNt+j6SC6qCCbEweEyYiIq8KBw==
X-Google-Smtp-Source: ANB0Vdav2eJIjyrERUEmiGtnItipG3yg96dIXIH+VceUJ53gJklJE8jmvQvZXExnKIj05TmFCizbcQ==
X-Received: by 2002:a24:1355:: with SMTP id 82-v6mr20940938itz.74.1537339963109;
        Tue, 18 Sep 2018 23:52:43 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id x68-v6sm7939477ita.2.2018.09.18.23.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 23:52:42 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
Subject: [PATCH v3 8/9] jump_table: move entries into ro_after_init region
Date:   Tue, 18 Sep 2018 23:51:43 -0700
Message-Id: <20180919065144.25010-9-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
References: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
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

Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
 
-- 
2.17.1

