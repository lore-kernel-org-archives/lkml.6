Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442DCFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3ED52086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMBOoo3E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3ED52086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbeINFMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 01:12:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35398 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbeINFMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 01:12:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id o18-v6so183631wmc.0;
        Thu, 13 Sep 2018 17:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kgNdH1mJaCf3YmynMLZAEJJb4IOLoepeJBnI5H762Gw=;
        b=ZMBOoo3EBAG80KeCqfw76V4Kp8Ks/Kp5O1E7gSgTxi5nXLN3oaE0Cdl7wLgiia+3QF
         mpc+y4gjtGhp5lxz8Nz2wgR4PSvWlPNbjKeVl0LClQll7XE+ruGKJPUu0BCC498Ri3L4
         h8kPtPlYcS55x7U9l9ThFXWt6jdFFuYflLc6Ukv1qLEvvGZTCRg2TVB3OufoZlKe/c9o
         7Fg5ZY9/bG1flipvpmQWQmIj5Cd5T+x0Nx1ecu31wmJtLq1wrku2qT+b0vYi5MvmYroI
         vxn/3+0G6yft10PD2tYx6Tk0wGQ9QunfNqEq9MNEkOodPUxj9bBfc/HxJ3iSd1R3FySz
         /yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kgNdH1mJaCf3YmynMLZAEJJb4IOLoepeJBnI5H762Gw=;
        b=Y4ypCM92M0z1pkCv48/ksAZUUPuONa15YNTZNkFueGxu49eugR4O5cnKwiVwtMvENU
         qCSTf8MnhQW2JFP6oBtXqNTsUlcF3bk4SFzXrLZUiSF242TKbf0wi9yqsfD7EciCgMTS
         CFFHUGmUhJrYfmlAyyNttYmDcj6hmQ0YgKkKS3HvkYJd6yHNRjDIct+hKmcVg81wDB1/
         nIGc//QoebsYCfQjvlcm3ip4OJbz78HHtDWE1JzjMCK/zHkEsUerGoBtV0HctmfFOhb6
         NmMoT37yJGY0a1TBejY+M44aXUNeDup5UbqlVkROCWHIzSAgMZEGtxZ0z62WE/Ou+crj
         JbQg==
X-Gm-Message-State: APzg51BcOqphWyQoamRsZEj3bC2lIi/4H08Be/JQ+xQ0IlZ2FPqJv1NF
        3dNIAopl9X555jg4DMgrsZY=
X-Google-Smtp-Source: ANB0VdZg02j/0SVerxwHXEogWddqdcFfOmXv+4UnYjOWqN15DPKgGgszUlQB01uOuTDNTl4yb/Nz/Q==
X-Received: by 2002:a1c:a1c6:: with SMTP id k189-v6mr251619wme.93.1536883254676;
        Thu, 13 Sep 2018 17:00:54 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id x125-v6sm118129wmg.27.2018.09.13.17.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 17:00:54 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-sparse@vger.kernel.org
Subject: [PATCH 2/2] Compiler Attributes: naked can be shared
Date:   Fri, 14 Sep 2018 01:59:41 +0200
Message-Id: <20180913235941.31211-3-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180913235941.31211-1-miguel.ojeda.sandonis@gmail.com>
References: <20180913235941.31211-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The naked attribute is supported by at least gcc >= 4.6 (for ARM,
which is the only current user), gcc >= 8 (for x86), clang >= 3.1
and icc >= 13. See https://godbolt.org/z/350Dyc

Therefore, move it out of compiler-gcc.h so that the definition
is shared by all compilers.

This also fixes Clang support for ARM32 --- 815f0ddb346c
("include/linux/compiler*.h: make compiler-*.h mutually exclusive").

Cc: Stefan Agner <stefan@agner.ch>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Eli Friedman <efriedma@codeaurora.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler-gcc.h   | 8 --------
 include/linux/compiler_types.h | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 25d3dd6b2702..4d36b27214fd 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -79,14 +79,6 @@
 #define __noretpoline __attribute__((indirect_branch("keep")))
 #endif
 
-/*
- * it doesn't make sense on ARM (currently the only user of __naked)
- * to trace naked functions because then mcount is called without
- * stack and frame pointer being set up and there is no chance to
- * restore the lr register to the value before mcount was called.
- */
-#define __naked		__attribute__((naked)) notrace
-
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
 
 #define __optimize(level)	__attribute__((__optimize__(level)))
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 3525c179698c..db192becfec4 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -226,6 +226,14 @@ struct ftrace_likely_data {
 #define notrace			__attribute__((no_instrument_function))
 #endif
 
+/*
+ * it doesn't make sense on ARM (currently the only user of __naked)
+ * to trace naked functions because then mcount is called without
+ * stack and frame pointer being set up and there is no chance to
+ * restore the lr register to the value before mcount was called.
+ */
+#define __naked			__attribute__((naked)) notrace
+
 #define __compiler_offsetof(a, b)	__builtin_offsetof(a, b)
 
 /*
-- 
2.17.1

