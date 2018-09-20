Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E84AECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE5F21523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EK7tU2d3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE5F21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387905AbeITXH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:07:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33650 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbeITXH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:07:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id r1-v6so2108473wmh.0;
        Thu, 20 Sep 2018 10:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E8ChE32l4QMnvkDCzYi/BjHhTEniuUicL3Qb16ak874=;
        b=EK7tU2d3EzwtjToDAwleWFyllaQEXVljVpM5iKIuuCtPstD3DxLFeXbfLKQlY3KlKs
         14DZVJjFWzCW+CYaxDelfUSwziAeuq2Ez51hAAEze+NkDA7oazgwkZG72UYsRqlHP4E1
         M4I7Jd4d9IsQydVhFUCNkVqvT8Pvl8gaCZQCXWFmbhAm4gAG4N9kPkuW9oyaeJyVuO7W
         /cZaBVkd/SKf5SNbX/r/AxV+RTuSeGAR+W7/xTWOh2F/GHXMxLwwHe+Pc1XQa+sSull+
         Meb0UGU5QxV9KE2b8XwLj/f5ZkN3OnytmYpT+saoBMhTuEZ7tcBEZCzaOYF2fSj5Fnqm
         kmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E8ChE32l4QMnvkDCzYi/BjHhTEniuUicL3Qb16ak874=;
        b=qq8WcAVYkzDNeEzO3oPa03vsWv7mIQNevdRnHj9g2exvBrFkcCcoYWd96sCrUEq0i7
         1SaQTEo/Rw1iOoIwt10sdJHTv2JYK0MxOcdggb3snPoKF87MXvDG1ZVgJ0YK8K8eyx0H
         QSFQGwD04ZccyALpuapM0jSqjxAaKFm8/wmk45IcdT8nkOvUh2N1/vhoL9Zyx0UFX04k
         nDYkGwmgbRXNQG8jQhQRAFkbJYKJ1Vm4HHKplp3B5ZBk5AKgsmNvDkgRpzWIdtXHPRoD
         +uQ/sgEguOF2eresjm+bl3/WyTMFU9LICHPfyrMkEjyJpxyqmb6sp/iLWBrVoRiSeaLK
         GddQ==
X-Gm-Message-State: APzg51A5BNR9B8BgqhLq8fGWcS20funecOa3fdosZ8KlNu+S4Mi/lbeD
        C/mkgRSB8r7u0oPmix5htrw=
X-Google-Smtp-Source: ACcGV63kmMhl2QFs6k7xK5F0sxevTVPbPDSWQ7GHj80yg/Dz1KY0rRDXHTNAgSmI8IpbxQ4cK/gphQ==
X-Received: by 2002:a1c:60c4:: with SMTP id u187-v6mr3693587wmb.121.1537464206268;
        Thu, 20 Sep 2018 10:23:26 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id q200-v6sm3466562wmd.2.2018.09.20.10.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:23:25 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Theodore Ts'o <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH v5 01/15] Compiler Attributes: remove unused attributes
Date:   Thu, 20 Sep 2018 19:22:47 +0200
Message-Id: <20180920172301.21868-2-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
References: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__optimize and __deprecate_for_modules are unused in
the whole kernel tree. Simply drop them.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler-gcc.h   | 2 --
 include/linux/compiler.h       | 4 ----
 include/linux/compiler_types.h | 1 -
 3 files changed, 7 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 4d36b27214fd..1302b425e625 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -81,8 +81,6 @@
 
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
 
-#define __optimize(level)	__attribute__((__optimize__(level)))
-
 #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
 
 #ifndef __CHECKER__
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 681d866efb1e..7c0157d50964 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -301,10 +301,6 @@ static inline void *offset_to_ptr(const int *off)
 
 #endif /* __ASSEMBLY__ */
 
-#ifndef __optimize
-# define __optimize(level)
-#endif
-
 /* Compile time object size, -1 for unknown */
 #ifndef __compiletime_object_size
 # define __compiletime_object_size(obj) -1
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index db192becfec4..a19562cb047c 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -108,7 +108,6 @@ struct ftrace_likely_data {
 
 /* Don't. Just don't. */
 #define __deprecated
-#define __deprecated_for_modules
 
 #endif /* __KERNEL__ */
 
-- 
2.17.1

