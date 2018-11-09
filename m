Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDE3C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BA420827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="WF2B5Wfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17BA420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbeKJIyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:54:16 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38175 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbeKJIyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:54:15 -0500
Received: by mail-lf1-f68.google.com with SMTP id p86so2500236lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZxYezAbvcYT+DmndAaVqMLZ3DVn779bkEogocNkcQok=;
        b=WF2B5Wfn359DGYJp03v5+YUJXklZAqDKzF06NeiNj2FYLBa3DvA9fNxBXcKLAikAYN
         aLCG3vj90ikjGACDYAQR6lKKR+3xwHhJ0rzySfTyYQr3blTm7Q3Xs8QPD91Bt/4GY3Mk
         Tlg6uDgJcYJpj2DHNjomIDuCnxWO6Vr76p5j0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZxYezAbvcYT+DmndAaVqMLZ3DVn779bkEogocNkcQok=;
        b=WcBsIxiodlto517aW6CW2tlKMrAPcsD5+XqRooMcuw4R+xy9TQNTdKEaThpSajun1T
         b/6OoyoNpHsuotcAotjAY5koYdsAIW+M5nvHPicghPCN5iQrzEpzBMOXQ4kUkxmryIlz
         pl7t66tf1UKcKEGKrBsAwJgk57xCUeZuLi7McLlvUp3et4IFRlKsTv+ZqMudJfe1duLq
         07R43vQp6jYk1E7/9M1APc2k8y1c2DJimXu3Vdo8rdeANPFXsVwGPzmUS72n1eT4W+Lo
         RbmURXSsufb8kyfqPaVa1gFaXAZ+QjUcHyvfcZoryPAVUOxO8RmqafN4BWCtuhJW1n3c
         /x6w==
X-Gm-Message-State: AGRZ1gJqnsYndRb39UQBEeBjSt5tPtUyHS4qam6XT9G3/MaPNmfV1PCh
        isCuivY11HLiNAFIljMTqYVaGg==
X-Google-Smtp-Source: AJdET5fTxq3ZZxmxHrM8eOdGsEHW6Cq3qaLvvVXfSZ8z6YAjvm8Q3y26EN61ZmbDnlYsnKr8GRgGMA==
X-Received: by 2002:a19:9dd1:: with SMTP id g200mr6210714lfe.127.1541805088505;
        Fri, 09 Nov 2018 15:11:28 -0800 (PST)
Received: from prevas-ravi.prevas.se (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id x16sm1584012lff.26.2018.11.09.15.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 15:11:28 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v3 23/23] x86_64: use relative pointers with dynamic debug
Date:   Sat, 10 Nov 2018 00:10:21 +0100
Message-Id: <20181109231021.11658-24-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181109231021.11658-1-linux@rasmusvillemoes.dk>
References: <20181009112013.14238-1-linux@rasmusvillemoes.dk>
 <20181109231021.11658-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to how x86_64 uses bug_entry-relative pointers to reduce
sizeof(struct bug_entry), the same thing can now be done for struct
_ddebug, saving 16 bytes for each of those (i.e., each pr_debug, dev_dbg
etc. in a CONFIG_DYNAMIC_DEBUG kernel).

Note the use of .ifndef/.endif in asm to avoid

fs/aio.c:1382: Error: symbol `__UNIQUE_ID_ddebug112' is already defined

This is due to uses of pr_debug et al in functions that get inlined. In
such a case, __COUNTER__ is obviously only expanded once, but the asm()
is repeated once for every inlined instance. Letting all instances share
the same descriptor object is the right thing to do; that is also what
happens when it is the compiler that defines a static object inside an
inline(d) function.

That, however, leads to another problem if the same identifier is used
in two different DEFINE_DYNAMIC_DEBUG_METADATA() in the same translation
unit: They would both end up referring to the same (first occuring)
instance. So the second one would end up using the wrong file, line,
function etc. information. All current in-tree macro users of
DEFINE_DYNAMIC_DEBUG_METADATA() have been updated to ensure they use
UNIQUE_ID to generate the identifier.

To prevent such a problem from going unnoticed, we use a guard symbol in
assembly whose value is unique per DEFINE_DYNAMIC_DEBUG_METADATA
invocation.

Cc: x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/x86/Kconfig                     |  1 +
 arch/x86/include/asm/dynamic_debug.h | 58 ++++++++++++++++++++++++++++
 arch/x86/kernel/macros.S             |  1 +
 3 files changed, 60 insertions(+)
 create mode 100644 arch/x86/include/asm/dynamic_debug.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ba7e3464ee92..c7cb31f39e5a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -91,6 +91,7 @@ config X86
 	select CLOCKSOURCE_WATCHDOG
 	select DCACHE_WORD_ACCESS
 	select DMA_DIRECT_OPS
+	select DYNAMIC_DEBUG_RELATIVE_POINTERS	if X86_64
 	select EDAC_ATOMIC_SCRUB
 	select EDAC_SUPPORT
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/x86/include/asm/dynamic_debug.h b/arch/x86/include/asm/dynamic_debug.h
new file mode 100644
index 000000000000..80730409183f
--- /dev/null
+++ b/arch/x86/include/asm/dynamic_debug.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_DYNAMIC_DEBUG_H
+#define _ASM_X86_DYNAMIC_DEBUG_H
+
+#ifndef __ASSEMBLY__
+
+#ifdef DEBUG
+#define _DPRINTK_INIT_TRUE 1
+#else
+#define _DPRINTK_INIT_TRUE 0
+#endif
+
+#define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)			\
+	extern struct _ddebug name;					\
+	asm volatile("DYNAMIC_DEBUG_METADATA"				\
+		     " ident="__stringify(name)				\
+		     " modname=%c0"					\
+		     " func=%c1"					\
+		     " file=%c2"					\
+		     " fmt=%c3"						\
+		     " flag_line=%c4"					\
+		     " init_true=%c5"					\
+		     " cnt=%c6"						\
+		     : : "i" (KBUILD_MODNAME), "i" (__func__),		\
+		       "i" (__FILE__), "i" (fmt),			\
+		       "i" (_DPRINTK_FLAGS_LINENO_INIT),		\
+		       "i" (_DPRINTK_INIT_TRUE),			\
+		       "i" (__COUNTER__)				\
+		)
+
+#else	/* __ASSEMBLY__ */
+
+.macro DYNAMIC_DEBUG_METADATA ident modname func file fmt flag_line init_true cnt
+.ifndef \ident
+	.pushsection __verbose,"aw"
+\ident :
+	.long \modname - \ident
+	.long \func    - \ident
+	.long \file    - \ident
+	.long \fmt     - \ident
+	.long \flag_line
+	.long 0
+	.if \init_true
+	STATIC_KEY_INIT_TRUE
+	.else
+	STATIC_KEY_INIT_FALSE
+	.endif
+	.popsection
+	.set \ident\().ddebug.once, \cnt
+.elseif \ident\().ddebug.once - \cnt
+	.error "'\ident' used as _ddebug identifier more than once"
+.endif
+.endm
+
+#endif	/* __ASSEMBLY__ */
+
+#endif /* _ASM_X86_DYNAMIC_DEBUG_H */
+
diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
index 161c95059044..2c2b8e5229a9 100644
--- a/arch/x86/kernel/macros.S
+++ b/arch/x86/kernel/macros.S
@@ -14,3 +14,4 @@
 #include <asm/asm.h>
 #include <asm/cpufeature.h>
 #include <asm/jump_label.h>
+#include <asm/dynamic_debug.h>
-- 
2.19.1.6.gbde171bbf5

