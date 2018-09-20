Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC14C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753282152C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="AB3oeSuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753282152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732285AbeITQjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 12:39:54 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33829 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeITQjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 12:39:54 -0400
Received: by mail-lj1-f196.google.com with SMTP id f8-v6so7960433ljk.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 03:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hYMeEJ1mYS5w9VXVieRfI6JukzrJSr09XclRJKwYHzI=;
        b=AB3oeSuDtW5PNFd34tPPMvm/x1z4LHIU1y83yZK3cSf+tz4iVY7DhlRDUxDIqeVna+
         lUSdnlbnVQ3HYEUwvtIzS5ELQjsUVB/w5b08/kafWz01I5aN1gfSnbNSx/KQPGTj4TJO
         0iAgAGThtSWPPbapV0HYs1DMFAbxvyZALtwFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hYMeEJ1mYS5w9VXVieRfI6JukzrJSr09XclRJKwYHzI=;
        b=k5N5ttv60wX4BMavxTVE2iFaM0xiSP6xxUuRJf6OYhh4JWPb83EWlynFVdrDRcV0wB
         wtgnvJ/QLJDnZ/delIZQqEQ+RFZKXMWVVHR9s5DkoLYz9DMyN4R22PLJJPTHKalxIwPU
         MGRG6rbmdO+LtVXa0ldnCoZJAXcHzxB906f+UqSE4t85aRxc3JeZB6svfw72Gl9XYhpH
         wAgKIsiACwtMo4xSD0GN+QzNtS8BBU4zbMA4bWWpa//EVMh+Wj3porlnZy66zQDHUwCG
         PmYaSWE2CF/SyFYK9iiavDZ2o24KZ58J6NwoC2j50bEdlOJ7dVS6T76xTNCZZiO3SIlT
         WpoA==
X-Gm-Message-State: APzg51AwO1JwpjmiLmR0jsl3YLaXS8hFyDvGcP9zQXbS745l/APwkbF5
        E2bOtpo9JDG8rHgn0rsCE/CWPhzBpi3MP3PN
X-Google-Smtp-Source: ANB0VdZP94c6MoqI0v7+xr5xLhuObE3ntYaYUUNRSDBlENUSGTPIVrqAKd1Y0dXKfszvpAqwes5PaQ==
X-Received: by 2002:a2e:1248:: with SMTP id t69-v6mr24183525lje.129.1537441017913;
        Thu, 20 Sep 2018 03:56:57 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o67-v6sm1582025lff.36.2018.09.20.03.56.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 03:56:57 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, x86@kernel.org
Subject: [PATCH 23/22] x86: dynamic_debug: protect against dynamic debug identifier reuse
Date:   Thu, 20 Sep 2018 12:56:53 +0200
Message-Id: <20180920105653.10964-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180919220444.23190-23-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-23-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most invocations of DEFINE_DYNAMIC_DEBUG_METADATA happen through
"public" macros such as pr_debug or netdev_dbg, which have been updated
to ensure they pass a unique identifier to use as the name for the
struct _ddebug instance. But it is still possible that someone invokes
DEFINE_DYNAMIC_DEBUG_METADATA directly, or creates a new wrapper macro
that does not do the extra-level-of-macros-passing-on-a__UNIQUE_ID
dance. On x86-64, all subsequent uses of that same identifier would
silently reuse the first instance, which is bad.

But we can catch such cases by defining a guard symbol that is unique
per expansion of DEFINE_DYNAMIC_DEBUG_METADATA. This still allows gcc to
emit multiple copies of some static inline function that has a pr_debug
call (because all such copies would pass the same value of %5 to the
assembler), but prevents repeated naked
DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, "bla") - even with a helpful
error message saying that '"descriptor" used as _ddebug identifer more
than once'.

Cc: x86@kernel.org
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Just in case it wasn't already ugly enough ;)

 arch/x86/include/asm/dynamic_debug.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/dynamic_debug.h b/arch/x86/include/asm/dynamic_debug.h
index 350ef6e2feff..69167f40482c 100644
--- a/arch/x86/include/asm/dynamic_debug.h
+++ b/arch/x86/include/asm/dynamic_debug.h
@@ -26,10 +26,15 @@
 		     "\t.long 0        \t# <padding>\n"			\
 		     _DPRINTK_ASM_KEY_INIT				\
 		     ".popsection\n"					\
+		     ".set "__stringify(name)".ddebug.once, %c5\n"	\
+		     ".elseif "__stringify(name)".ddebug.once - %c5\n"	\
+		     ".line "__stringify(__LINE__) " - 1\n"		\
+		     ".error \"'"__stringify(name)"' used as _ddebug identifier more than once\"\n" \
 		     ".endif\n"						\
 		     : : "i" (KBUILD_MODNAME), "i" (__func__),		\
 		       "i" (__FILE__), "i" (fmt),			\
-		       "i" (_DPRINTK_FLAGS_LINENO_INIT))
+		       "i" (_DPRINTK_FLAGS_LINENO_INIT),		\
+		       "i" (__COUNTER__))
 
 #endif /* _ASM_X86_DYNAMIC_DEBUG_H */
 
-- 
2.16.4

