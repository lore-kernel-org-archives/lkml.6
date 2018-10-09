Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5565AC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B05720835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="MBvT4fLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B05720835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeJIShq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:37:46 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40990 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbeJIShM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:37:12 -0400
Received: by mail-ed1-f68.google.com with SMTP id x31-v6so1316033edd.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LBUwPwfdLWts77YZu8bq/0EXuP3hIPxvE2iNOPD8lGk=;
        b=MBvT4fLP7b1NBcJpRV8vz23+nVQM3RHeCw/CNMIp+LAFQCnjlLDonxPSWfBWbB78cq
         ORVAeFL64SsQHT5C7Jh/CE5Nlo2n8+o7VKEcFitwkydABqzw/6e/GFN3M17BHtg6R0eh
         D3WtAMyjtBzgpV5KVAzP0bs9V3ddaWxgB47pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LBUwPwfdLWts77YZu8bq/0EXuP3hIPxvE2iNOPD8lGk=;
        b=C9zbEItN0AbZeaiiRe/RImf8tIJ9gefCbMSiUL1NQiITr/bAIqnSXETQ2mNRocveVU
         0HBaO7AY3b5Eeh9fzRB5ggJc3mhaIsjALw9c8eHqKzyvCrJHInn95J/Eandcq6GVYkB9
         BrsLxiH6mMM8gpKCtXqr6fQQD9Gh/7MNDhMT3VYl3mzQbwMXgPLDzp4BptHrglmQ+MSw
         4bLNsNFBHbjOaQJEer2Jv21psGs3kG571gIQRYZyYGclirwAaW4qflVp88HTyh9SGDs+
         jGQdTF9xX02Lrew204My6q1m/IRMTjrKLiTzJu3kOFJPVaNzPokXtznws6ByjE9E7u0b
         bbMw==
X-Gm-Message-State: ABuFfogtrcPZdEJOZtTN8zS9LoeKQqsLm/EoLyOUXyjP2nxvi7mT0KWH
        v7qMIbaCQ+HIYwIDeCMdbjibgQ==
X-Google-Smtp-Source: ACcGV63FB+8bUVKA2JCWO05iOyT/Zd2sNRimvPsm9GqIVwyK7effjZBpavytCnDDfazPCus3qBkMuQ==
X-Received: by 2002:a17:906:830e:: with SMTP id j14-v6mr27367317ejx.6.1539084042802;
        Tue, 09 Oct 2018 04:20:42 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id n23-v6sm3595821eja.41.2018.10.09.04.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 04:20:42 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2 22/23] x86_64: use relative pointers with dynamic debug
Date:   Tue,  9 Oct 2018 13:20:12 +0200
Message-Id: <20181009112013.14238-23-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.4.g721af0fda3
In-Reply-To: <20181009112013.14238-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
 <20181009112013.14238-1-linux@rasmusvillemoes.dk>
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

Cc: x86@kernel.org
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/x86/Kconfig                     |  1 +
 arch/x86/include/asm/dynamic_debug.h | 35 ++++++++++++++++++++++++++++
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
2.19.1.3.g1d92a00e68

