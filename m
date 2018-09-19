Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E71EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E8F21522
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="hPE6Tgu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E8F21522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387605AbeITDph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:45:37 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46263 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387576AbeITDpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:45:36 -0400
Received: by mail-ed1-f68.google.com with SMTP id k14-v6so6141086edr.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tW+NKKwRXh6spthOntM5Z8zSgYo9P9HRVzqbGFVnaH0=;
        b=hPE6Tgu5VCpJiU2M/oDG9guUoSWI3D3tErDvOFxIGdF0IhLgyWYmuNZ90W5BTlTm6n
         7Af6kz9/IyiQ6hkc6spNeDrCUurnMs2wCUtlhBacqGwV04jzftGsjUR/acKUw3V8+zyb
         RaoXTkuWam0VqyGLBbz1R3o9yPOZ2E41Db7Io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tW+NKKwRXh6spthOntM5Z8zSgYo9P9HRVzqbGFVnaH0=;
        b=IXym2yMAg1lHg7twrVEnw9XLOWoKjZKId/LdQE6BcyC2kaihHFTFBG1tFX3icMr+Gp
         fba36sd63hSOZEHKA4oZNOVSn96ObudqPMy15zVQPfzO5VqHJP80iuX5syrgaEr/r+ew
         nrfPTdsOnMYhYc+sa/JyGytr6VdtohB3KGQ3vyxsb8TiOc6oaC4X4o8nCAr7tYzZcsM+
         mijYjdlwuG05wJcbs/J7IjuPXMGzUbN3eaauSWzs9nVdj40MmrHJE66CUu3uUOCTqwvZ
         6vbjrioD8o5jHW4SigJpYvAlBmBet5weSGlnA7tk/kBSaiEszUKwr1pjn9nABiFu7xc8
         dhCQ==
X-Gm-Message-State: APzg51A+TsMQOUXnBGP5fdCS/EvoEQn2CPLnyuTP/TPeX/nYHfyDb2HV
        WvRpSurgBkYYJGwJJfADKDI0Rg==
X-Google-Smtp-Source: ANB0VdbAf3qQ1kNStSS7+Fh6zrtwXWuPsanXyGdVcpXOjlEQGwenqkTR/RnDd1a0hQPKxJKsQKXyCA==
X-Received: by 2002:a50:d90e:: with SMTP id t14-v6mr60595832edj.241.1537394738271;
        Wed, 19 Sep 2018 15:05:38 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-115-161.cgn.ip.fibianet.dk. [5.186.115.161])
        by smtp.gmail.com with ESMTPSA id a9-v6sm2798edi.26.2018.09.19.15.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 15:05:37 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, x86@kernel.org
Subject: [PATCH 22/22] x86_64: use relative pointers with dynamic debug
Date:   Thu, 20 Sep 2018 00:04:44 +0200
Message-Id: <20180919220444.23190-23-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
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

Cc: x86@kernel.org
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/x86/Kconfig                     |  1 +
 arch/x86/include/asm/dynamic_debug.h | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 arch/x86/include/asm/dynamic_debug.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1a0be022f91d..a44168930e52 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -90,6 +90,7 @@ config X86
 	select CLOCKSOURCE_WATCHDOG
 	select DCACHE_WORD_ACCESS
 	select DMA_DIRECT_OPS
+	select DYNAMIC_DEBUG_RELATIVE_POINTERS	if X86_64
 	select EDAC_ATOMIC_SCRUB
 	select EDAC_SUPPORT
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/x86/include/asm/dynamic_debug.h b/arch/x86/include/asm/dynamic_debug.h
new file mode 100644
index 000000000000..350ef6e2feff
--- /dev/null
+++ b/arch/x86/include/asm/dynamic_debug.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_DYNAMIC_DEBUG_H
+#define _ASM_X86_DYNAMIC_DEBUG_H
+
+#ifdef HAVE_JUMP_LABEL
+# ifdef DEBUG
+#  define _DPRINTK_ASM_KEY_INIT ASM_STATIC_KEY_INIT_TRUE
+# else
+#  define _DPRINTK_ASM_KEY_INIT ASM_STATIC_KEY_INIT_FALSE
+# endif
+#else
+# define _DPRINTK_ASM_KEY_INIT ""
+#endif
+
+#define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)			\
+	extern struct _ddebug name;					\
+	asm volatile(".ifndef " __stringify(name) "\n"			\
+		     ".pushsection __verbose,\"aw\"\n"			\
+		     "1:\n"						\
+		     __stringify(name) ":\n"				\
+		     "\t.long %c0 - 1b \t# _ddebug::modname_disp\n"	\
+		     "\t.long %c1 - 1b \t# _ddebug::function_disp\n"	\
+		     "\t.long %c2 - 1b \t# _ddebug::filename_disp\n"	\
+		     "\t.long %c3 - 1b \t# _ddebug::format_disp\n"	\
+		     "\t.long %c4      \t# _ddebug::flags_lineno\n"	\
+		     "\t.long 0        \t# <padding>\n"			\
+		     _DPRINTK_ASM_KEY_INIT				\
+		     ".popsection\n"					\
+		     ".endif\n"						\
+		     : : "i" (KBUILD_MODNAME), "i" (__func__),		\
+		       "i" (__FILE__), "i" (fmt),			\
+		       "i" (_DPRINTK_FLAGS_LINENO_INIT))
+
+#endif /* _ASM_X86_DYNAMIC_DEBUG_H */
+
-- 
2.16.4

