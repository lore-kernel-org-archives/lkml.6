Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3337ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AEB21470
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="NjdT4doq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80AEB21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeJRGbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:31:34 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35678 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeJRGbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:31:33 -0400
Received: by mail-ed1-f65.google.com with SMTP id y19-v6so26409453edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=omqU9a54n/sTLmAr8r2fMZvXfZnMhL7iqECIfHXLtPw=;
        b=NjdT4doq+PKHcf7Ur/fRhuE9CqE8KCWbKReFKXjxgMUS0QYh7f84hGmPmsY6UlpemQ
         YuvD2NPHyu4ceMI1Wkz/ztDt/JFF+nAvbJUBEew8AlVY3owar8vRXoC1QyxPkuLl6cuJ
         pKA+DYl4FM6hmbe1p/sMKm7Yyiwonq0YDQvok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=omqU9a54n/sTLmAr8r2fMZvXfZnMhL7iqECIfHXLtPw=;
        b=k5MeZlW35wPU6xBQQvG8GeJULodRgv0QRrBTgDsEIrtO+oAKslMxY1M707sV0IkFpX
         GD+DkdDYVaboNGk1pAu/unAFXxP9oqbOiBpqzknLrVArOd8oglvmaXlNmOkG+1/KxFCz
         +mT61J+a0tn+DCDS1BDwnWd8IaPOBjY3k9feNufv7xqUWcFLoeTqz3j5/taY/oD+rOk9
         dL6/FOE6JfEmFPY0qszmU1vC1WJkdUhwdYF1r5+BwWXd2eKI6z4jMEiqYMa2pXsAWhO4
         sNCVgqG1O2mIh80rfxNZO7D6qfKEr5nqMadlSul+tTL8wIM8CoLYPFFjvwj5CK9GxaI9
         HyAQ==
X-Gm-Message-State: ABuFfohgaa1FNt7XnkSEwiOCsQg9kxz/C6PYAUSWQWg0tDby5/sHPDoS
        Uwuo9yB613FrLevo1pJ231eZ5Od3BIQ=
X-Google-Smtp-Source: ACcGV61DEDS3IFjW0vnK9OptbJldGU8BmwJoXQ36NrAxvKwqlzATkwu19GAgmeBrHocgcJ8kKHRGYA==
X-Received: by 2002:a05:6402:2c9:: with SMTP id b9mr1772339edx.149.1539815623589;
        Wed, 17 Oct 2018 15:33:43 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id e30-v6sm7001555edd.25.2018.10.17.15.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Oct 2018 15:33:43 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [POC 05/12] x86-64: initial ro-after-init patching support
Date:   Thu, 18 Oct 2018 00:33:25 +0200
Message-Id: <20181017223332.11964-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181017223332.11964-1-linux@rasmusvillemoes.dk>
References: <20181017223332.11964-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This just sets things up so that the ARCH_HAS_RAI symbol gets selected,
and prepare the arch-specific headers and support functions.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/x86/Kconfig           |  1 +
 arch/x86/include/asm/rai.S | 18 ++++++++++++++++++
 arch/x86/include/asm/rai.h | 25 ++++++++++++++++++++++++
 arch/x86/kernel/Makefile   |  1 +
 arch/x86/kernel/macros.S   |  1 +
 arch/x86/kernel/rai.c      | 39 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 85 insertions(+)
 create mode 100644 arch/x86/include/asm/rai.S
 create mode 100644 arch/x86/include/asm/rai.h
 create mode 100644 arch/x86/kernel/rai.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5136a1281870..3f1679f258c9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -62,6 +62,7 @@ config X86
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_RAI			if X86_64
 	select ARCH_HAS_REFCOUNT
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
 	select ARCH_HAS_UACCESS_MCSAFE		if X86_64 && X86_MCE
diff --git a/arch/x86/include/asm/rai.S b/arch/x86/include/asm/rai.S
new file mode 100644
index 000000000000..253d27453416
--- /dev/null
+++ b/arch/x86/include/asm/rai.S
@@ -0,0 +1,18 @@
+#ifdef __ASSEMBLY__
+
+.macro rai_entry type instr instr_end templ templ_end thunk
+	.long \type
+	.long \instr - .
+	.long \instr_end - \instr
+	.long \templ - .
+	.long \templ_end - \templ
+	.long \thunk - .
+.endm
+	
+.macro rai_entry_pad start end
+	.ifgt STRUCT_RAI_ENTRY_SIZE-(\end-\start)
+	.skip STRUCT_RAI_ENTRY_SIZE-(\end-\start), 0x00
+	.endif
+.endm
+
+#endif
diff --git a/arch/x86/include/asm/rai.h b/arch/x86/include/asm/rai.h
new file mode 100644
index 000000000000..269d696255b0
--- /dev/null
+++ b/arch/x86/include/asm/rai.h
@@ -0,0 +1,25 @@
+#ifndef _ASM_X86_RAI_H
+#define _ASM_X86_RAI_H
+
+#define STRUCT_RAI_ENTRY_SIZE 24
+
+/* Put the asm macros in a separate file for easier editing. */
+#include <asm/rai.S>
+
+#ifndef __ASSEMBLY__
+
+struct rai_entry {
+	int type;         /* RAI_xxx constant */
+	s32 instr_offset; /* member-relative offset to instructions-to-be-patched */
+	s32 instr_len;    /* size of area, >= templ_len */
+	s32 templ_offset; /* member-relative offset to template */
+	s32 templ_len;    /* length of template */
+	s32 thunk_offset; /* member-relative offset to ool thunk */
+	/* type-specific data follows */
+};
+_Static_assert(sizeof(struct rai_entry) == STRUCT_RAI_ENTRY_SIZE,
+	       "please update STRUCT_RAI_ENTRY_SIZE");
+
+#endif /* !__ASSEMBLY */
+
+#endif /* _ASM_X86_RAI_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 8824d01c0c35..b4dea4e72081 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_SYSFS)	+= ksysfs.o
 obj-y			+= bootflag.o e820.o
 obj-y			+= pci-dma.o quirks.o topology.o kdebugfs.o
 obj-y			+= alternative.o i8253.o hw_breakpoint.o
+obj-$(CONFIG_ARCH_HAS_RAI)	+= rai.o
 obj-y			+= tsc.o tsc_msr.o io_delay.o rtc.o
 obj-y			+= pci-iommu_table.o
 obj-y			+= resource.o
diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
index 161c95059044..af5672a302d4 100644
--- a/arch/x86/kernel/macros.S
+++ b/arch/x86/kernel/macros.S
@@ -14,3 +14,4 @@
 #include <asm/asm.h>
 #include <asm/cpufeature.h>
 #include <asm/jump_label.h>
+#include <asm/rai.h>
diff --git a/arch/x86/kernel/rai.c b/arch/x86/kernel/rai.c
new file mode 100644
index 000000000000..2c6ff06f7a34
--- /dev/null
+++ b/arch/x86/kernel/rai.c
@@ -0,0 +1,39 @@
+#include <linux/memory.h>
+#include <linux/mutex.h>
+#include <linux/rai.h>
+#include <asm/text-patching.h>
+
+extern struct rai_entry __start_rai_data[];
+extern struct rai_entry __stop_rai_data[];
+
+static void
+rai_patch_one(const struct rai_entry *r)
+{
+	u8 *instr = (u8*)&r->instr_offset + r->instr_offset;
+	u8 *templ = (u8*)&r->templ_offset + r->templ_offset;
+	u8 *thunk = (u8*)&r->thunk_offset + r->thunk_offset;
+
+	switch (r->type) {
+	default:
+		WARN_ONCE(1, "unhandled RAI type %d\n", r->type);
+		return;
+	}
+	text_poke_bp(instr, templ, r->templ_len, thunk);
+}
+
+static void
+rai_patch(const struct rai_entry *start, const struct rai_entry *stop)
+{
+	const struct rai_entry *r;
+
+	for (r = start; r < stop; ++r)
+		rai_patch_one(r);
+}
+
+void
+update_rai_access(void)
+{
+	mutex_lock(&text_mutex);
+	rai_patch(__start_rai_data, __stop_rai_data);
+	mutex_unlock(&text_mutex);
+}
-- 
2.19.1.6.gbde171bbf5

