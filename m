Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F814C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C7B20868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uen7wqXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C7B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbeIICM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 22:12:28 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54193 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbeIICM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 22:12:27 -0400
Received: by mail-wm0-f65.google.com with SMTP id b19-v6so17838872wme.3;
        Sat, 08 Sep 2018 14:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KSmd8Leci7Jq2YnVlQ1QxGK80ki+uToFeuQJJ1eS4UY=;
        b=Uen7wqXT0mq9RVEAdjuqREsxTm7Jx/iFihAQFMJNSr0hRPAx38opm1T0w3nS/7/HbI
         Ebh7AIVW1lndVKYV68rIxR7YgjTnlcb++TVT8AXYM7TbjgPAnhPvMo9IpB4dST44wm2J
         BAt0JTiFvo01vEbzPVW4D6K8/pe6Ey+qVYpBSiLGMNxtZm+FrOCvI2aViBZT8WkmTeyO
         xB1PlTq131NRnJuDUTBzy+4WKh89Xq8wxXozS+2udpzD21ORlPZsK40Tq893tvIOrtxI
         SSAQh1N9VjwVOisEEBBFxH0WtBD1XtYimf42YRtuBNeRzGRxhe7hpEUfgeqyOJDM5xg7
         SDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KSmd8Leci7Jq2YnVlQ1QxGK80ki+uToFeuQJJ1eS4UY=;
        b=Mwk+YEtkusz03Xn3L1Asa4tbx757/5OfDkAdaOSNNSuxr33+tI//N/u/ZxyWb+osvk
         DBfe7dD3L9OYsxtwm08lPEH4HZ5qEYtpw7YGUqt7tUBjzsHA9ch+dp0PcnXrXMFESHdr
         lJ9Uu/mcyeruP9/BfnilB7FAoWmDcNLmigWJH+Ps6ow/g2dtOFnNtulEHpX2L007IDSb
         wq9aGAL4RaeIlWP1eZz/1JwVdm3e20J7ZikaxwEpUAHpQ7qr6QoPLqyP5ljBQEOC7D5b
         sw1oiTZSDY1VzBR66w1z5oMNqUVAcHaWKAtypXz1E2ACnf+k07ENsiXxGPO/C63zYwxJ
         o9fQ==
X-Gm-Message-State: APzg51B4bmeWThF0hfq9AOYfjVNfgecWnhSTXzcYxtz8OeyqPhdBnayE
        v1HiQcwsbIa6+a2IsR9qwHU=
X-Google-Smtp-Source: ANB0VdbHuUJHMw0TTomA/pmYGntt/+sLJUUXtgiINqMfe2ovNHBwfb76Q5ChCVCv3hvxzP3npXtyrw==
X-Received: by 2002:a1c:a94d:: with SMTP id s74-v6mr9266511wme.39.1536441918160;
        Sat, 08 Sep 2018 14:25:18 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id u40-v6sm17340786wrc.43.2018.09.08.14.25.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 14:25:17 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-sparse@vger.kernel.org
Subject: [PATCH v4 05/13] Compiler Attributes: naked was fixed in gcc 4.6
Date:   Sat,  8 Sep 2018 23:24:51 +0200
Message-Id: <20180908212459.19736-6-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
References: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9c695203a7dd ("compiler-gcc.h: gcc-4.5 needs noclone
and noinline on __naked functions") added noinline and noclone
as a workaround for a gcc 4.5 bug, which was resolved in 4.6.0.

Since now the minimum gcc supported version is 4.6,
we can clean it up.

See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=44290
and https://godbolt.org/z/h6NMIL

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Eli Friedman <efriedma@codeaurora.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler-gcc.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 76f4907ef707..4cd5e9264bce 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -77,14 +77,8 @@
  * to trace naked functions because then mcount is called without
  * stack and frame pointer being set up and there is no chance to
  * restore the lr register to the value before mcount was called.
- *
- * The asm() bodies of naked functions often depend on standard calling
- * conventions, therefore they must be noinline and noclone.
- *
- * GCC 4.[56] currently fail to enforce this, so we must do so ourselves.
- * See GCC PR44290.
  */
-#define __naked		__attribute__((__naked__)) noinline __noclone notrace
+#define __naked		__attribute__((__naked__)) notrace
 
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
 
-- 
2.17.1

