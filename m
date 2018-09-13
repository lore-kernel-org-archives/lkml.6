Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38631C04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8653204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+SazxOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8653204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeINFMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 01:12:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53940 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeINFMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 01:12:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id b19-v6so171530wme.3;
        Thu, 13 Sep 2018 17:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rtOOC3GLNWGMW84i9cg4IatCMDh5KWmKK57ezAje8XQ=;
        b=A+SazxOIVOng2Qqd9ERzco+Dg3+REfS/RE60E3X3G7QKqhHyhW4Bctoj6r3V3sSWb7
         3glLbnzgm6d+f9IDNotGsedqYq6iGL63xHOXtWpZrRuvpLASra0hy5h4cmNFMcvNWfDR
         qAVWAFj9M8pXAtW85OiluZVxbAD8ZFeOhPv6cPNnJm/NusAeShjgIuzJMHo++JcTgdyj
         w/Jng7jF61j3/bF7bc2kRV3KlOzOCHYpNZkPMeAkPjKds/Sjhs0yQ49pyxdcwDQjdWzi
         L/jzWMXalII5fYifMf06v8JF8i50pU0MU7dFkr3zpjBQyShjt8ZYv5m8+q+hFwc9WSDC
         AjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rtOOC3GLNWGMW84i9cg4IatCMDh5KWmKK57ezAje8XQ=;
        b=l4sSvn3WV9A+isolO6KFr99MnCw3Drut6MHL9eQw2GM1llr27bT1QTWmA/e7kIxsjY
         Td17pS1d8WFKicEYeJgSnYCedeeUk+20EKzP2N5UzlBYYxj+kOz2hrhr/FHMivLAHPJ9
         bKmgy1UqEDgr4qzj7o9JvRWQggoKExxV2GvXLPvJRoEwtrdfmFUXsnT5I43vCxJWQnMf
         uPB13ZJPLiAEwTy6fDsaU8dwKClO8l3Sg1P0dHH3Z6tckR1TsSqD918y3hD/ddZMAjRq
         NoDaaZY6eYsf9RZNBtABwjqv7cIQBDLAHQPSGhrn1DVKpcCMF62CExHo/m1Y0GdBzwzq
         pCDQ==
X-Gm-Message-State: APzg51BFPTYEYE4BNYy2H5lVrVWPN/5J9TS/NgKh18lpPcPsOuJdM/m3
        CcNyASqiqH6BjYmflbi1Qy8=
X-Google-Smtp-Source: ANB0Vda0HzlhPf6xAxFQ1Vug4I/lgs25piWEDe1TkL858TCqU7JMrwnzCAuIgsyq9rbMlUHBnxdQPQ==
X-Received: by 2002:a1c:e70b:: with SMTP id e11-v6mr264388wmh.22.1536883253277;
        Thu, 13 Sep 2018 17:00:53 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id x125-v6sm118129wmg.27.2018.09.13.17.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 17:00:52 -0700 (PDT)
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
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-sparse@vger.kernel.org
Subject: [PATCH 1/2] Compiler Attributes: naked was fixed in gcc 4.6
Date:   Fri, 14 Sep 2018 01:59:40 +0200
Message-Id: <20180913235941.31211-2-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180913235941.31211-1-miguel.ojeda.sandonis@gmail.com>
References: <20180913235941.31211-1-miguel.ojeda.sandonis@gmail.com>
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

Cc: Stefan Agner <stefan@agner.ch>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler-gcc.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 763bbad1e258..25d3dd6b2702 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -84,14 +84,8 @@
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
-#define __naked		__attribute__((naked)) noinline __noclone notrace
+#define __naked		__attribute__((naked)) notrace
 
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
 
-- 
2.17.1

