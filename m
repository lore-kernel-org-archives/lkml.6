Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD92ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA04214C4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJGaYjYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA04214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeJSUzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:55:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35463 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbeJSUzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:55:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id f8-v6so15851265plb.2;
        Fri, 19 Oct 2018 05:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=slUZHPHVWILEQDe/G53asTgV55QCgnXrDwP4FLIrtew=;
        b=UJGaYjYfqXz18nB33Ii+Cxvd7ozcGVB4Iku1dHrakrbdo0Ei615ophZrWC1l7ZaBoD
         VE4ypyFjqFXMWkfVhcD2+Y1bQ7gyVcToweVvoGCwpGPYsWvBiJzFEEwHrN1dyN5OxJBq
         M6Tpr6eT6WdlcaQCi4U1cO/NQ3o0pFKLzN9O9VguxVyJ5vWaNznByYEv0+pstVk+F/4F
         lGtCxt3DMxd3/SJqnxXXojw/I78ZycaZ94zm56qyJnw4ubjzf/GEsjabW0l1t1GPvl2d
         clWy8zT3ifZLvBuCcChUKuoNVlen/Lb1Ln++av4H74uQofbf14tNlTXI5arcYGyY0d0W
         6cUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=slUZHPHVWILEQDe/G53asTgV55QCgnXrDwP4FLIrtew=;
        b=UtihT2emtAWqU8SP1PBJx9rDTYgGGWHyInJ8rvb4ieD3LTPDGCQ+aRaJWvInP7xXoo
         +OmqL9THhhPYNLCL+XuYfKZ04JvME9zz5PFbkJ130LmWuB6XMf8BvsBJY5V7nNb5zlyG
         XnJqS1tjw6OCeCPmiw5ipZCGTXBWc49UPnMSe4FYG3fze9ugzVmNcWbukWpZ3qUKrw48
         ToIO89z/Te4T5JRem8+ln11zkiLcWlsIyC+n2lRHefZbM4QtGqexdPDETOekkWbsshpF
         TvUaMOlEEpEFYP5WvjFi81Rvi5CntljIImIaKoWUxxYMjNSbSO+/Ny+GPDvKG1phPoom
         6MPg==
X-Gm-Message-State: ABuFfoja8LeF0QMk4EjhEtSnJMLoQ1+mukqs4QqU9dVxtKsRW3SCfDp6
        CQ5RENxJ82ZNFX3QJB9pHWc=
X-Google-Smtp-Source: ACcGV60Nk76JtkMCH1g1HWC0/HmuI92qIA6BTyXE6LzTJSoOQI79YcoBgHhfuWqAR8GOzGx4SBWj9w==
X-Received: by 2002:a17:902:9a45:: with SMTP id x5-v6mr33783592plv.213.1539953378492;
        Fri, 19 Oct 2018 05:49:38 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id o131-v6sm33640679pgo.53.2018.10.19.05.49.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 05:49:37 -0700 (PDT)
From:   Du Changbin <changbin.du@gmail.com>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        tglx@linutronix.de, mingo@redhat.com, linux@armlinux.org.uk,
        akpm@linux-foundation.org
Cc:     rostedt@goodmis.org, x86@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, robin.murphy@arm.com,
        Du Changbin <changbin.du@gmail.com>
Subject: [PATCH v2 2/4] kernel hacking: new config NO_AUTO_INLINE to disable compiler auto-inline optimizations
Date:   Fri, 19 Oct 2018 12:49:19 +0000
Message-Id: <20181019124921.13780-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181019124921.13780-1-changbin.du@gmail.com>
References: <20181019124921.13780-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add a new kernel hacking option NO_AUTO_INLINE. Selecting
this option will prevent the compiler from optimizing the kernel by
auto-inlining functions not marked with the inline keyword.

With this option, only functions explicitly marked with "inline" will
be inlined. This will allow the function tracer to trace more functions
because it only traces functions that the compiler has not inlined.

Signed-off-by: Du Changbin <changbin.du@gmail.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Makefile          |  6 ++++++
 lib/Kconfig.debug | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Makefile b/Makefile
index e8b599b4dcde..757d6507cb5c 100644
--- a/Makefile
+++ b/Makefile
@@ -749,6 +749,12 @@ KBUILD_CFLAGS 	+= $(call cc-option, -femit-struct-debug-baseonly) \
 		   $(call cc-option,-fno-var-tracking)
 endif
 
+ifdef CONFIG_NO_AUTO_INLINE
+KBUILD_CFLAGS   += $(call cc-option, -fno-inline-functions) \
+		   $(call cc-option, -fno-inline-small-functions) \
+		   $(call cc-option, -fno-inline-functions-called-once)
+endif
+
 ifdef CONFIG_FUNCTION_TRACER
 ifdef CONFIG_FTRACE_MCOUNT_RECORD
   # gcc 5 supports generating the mcount tables directly
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 4966c4fbe7f7..c7c28ee01dfc 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -211,6 +211,23 @@ config GDB_SCRIPTS
 	  instance. See Documentation/dev-tools/gdb-kernel-debugging.rst
 	  for further details.
 
+config NO_AUTO_INLINE
+	bool "Disable compiler auto-inline optimizations"
+	help
+	  This will prevent the compiler from optimizing the kernel by
+	  auto-inlining functions not marked with the inline keyword.
+	  With this option, only functions explicitly marked with
+	  "inline" will be inlined. This will allow the function tracer
+	  to trace more functions because it only traces functions that
+	  the compiler has not inlined.
+
+	  Enabling this function can help debugging a kernel if using
+	  the function tracer. But it can also change how the kernel
+	  works, because inlining functions may change the timing,
+	  which could make it difficult while debugging race conditions.
+
+	  If unsure, select N.
+
 config ENABLE_MUST_CHECK
 	bool "Enable __must_check logic"
 	default y
-- 
2.17.1

