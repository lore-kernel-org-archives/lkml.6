Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7194C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 13:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891712147A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 13:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p70glEk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891712147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeJ1VzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 17:55:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33333 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeJ1VzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 17:55:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id z2-v6so2609763pgp.0;
        Sun, 28 Oct 2018 06:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z1p1Mx8pgPnws2nPs4SRISeGm4KePLjEigb8toAYrzc=;
        b=p70glEk2yIucDRr40/8Hr1khRVVKJNRIDH5GYhj9Q0/g7Z+dOkKBVaZDZ98t6IJVCJ
         PbD7er//t9LHVRYB+C+YEoVZxlBecTg0kl1EW6Twv3wswZJpD8oSpcg+jPxjUdhyJpYh
         8NkSxTYPKy8bEh2LBgb6Vcc6HIwzHsPvuBmx6Wwld/2KZ+53cQEzhCRQXA77xVT5pI3P
         QsbNUdTF83/EGw2ZGg8xiNLqirLreNo6qGh9OX/M6aGnbuyXebaamKkU/aovLXC1AhLF
         pHUiSumZHFKjHAwx+8wzEmX8XkqwufG1Mj+Qt5FiDDQPLHZ1aSpF/K13FXu5JIkdMUjb
         mWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z1p1Mx8pgPnws2nPs4SRISeGm4KePLjEigb8toAYrzc=;
        b=Cx5qS+sLKulpYl0EUP/JLTjMw3m89px+tVZ1yj2pTxZxUydJlaTLA/OAue+gRb8+cP
         aN++YJgG/9CWzHmA8FoF1avnTbNOJWNYd9T2kybmOgSpgfs8l4QAWmdeGZlo49amFa7L
         4B+l/AsnqHDdC667p5TQNcqoGJWYY47EqFL3NuPN0DrlY9WAnDO060Vjcbz64nb/srNB
         OzPKtOAMLYSSNFgV58+L7GBNxbhJ+n2pZebM+Wu7CsUo+8vh4SaPVobddQUYOKqhSCpA
         SZKuHTmyic+BfDoBcOKRMA6dxWW4Cvwtf8R0omYvtlujuQnTOmrZNvMTYBJJ+Dp0Jv8D
         9ytw==
X-Gm-Message-State: AGRZ1gKT6a5FGI37zIX350rSV4zTdf/M9E5AF3d0mqQT0iNdYcpavw+j
        uUsVOFo60rCYgtlMDVZgoKw=
X-Google-Smtp-Source: AJdET5cLbwkXzA9J08vC2kuEb0XRP43sQtDazJtqPYG0V2E1TwCUeCXE6abOHRLPKtZT9JI1faLr9g==
X-Received: by 2002:a65:56cc:: with SMTP id w12-v6mr9868447pgs.224.1540732230956;
        Sun, 28 Oct 2018 06:10:30 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id e3-v6sm24520585pgc.71.2018.10.28.06.10.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 06:10:30 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        tglx@linutronix.de, mingo@redhat.com, linux@armlinux.org.uk,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org
Cc:     rostedt@goodmis.org, x86@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, robin.murphy@arm.com,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 2/4] kernel hacking: new config NO_AUTO_INLINE to disable compiler auto-inline optimizations
Date:   Sun, 28 Oct 2018 13:09:43 +0000
Message-Id: <20181028130945.23581-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181028130945.23581-1-changbin.du@gmail.com>
References: <20181028130945.23581-1-changbin.du@gmail.com>
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

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Makefile          |  6 ++++++
 lib/Kconfig.debug | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Makefile b/Makefile
index 7d4ba5196010..04beb822ddfc 100644
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
index 04adfc3b185e..d50711b41dad 100644
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

