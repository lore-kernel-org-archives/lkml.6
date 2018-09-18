Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE68C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89782214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7bkRPwr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89782214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbeIRWaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:30:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50814 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730200AbeIRWaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:30:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id s12-v6so3308377wmc.0;
        Tue, 18 Sep 2018 09:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2DzhRwrr2MWLw9Cg0FhGTgbP6uZUQ8F4dsAU+Q41KI4=;
        b=I7bkRPwrMX0I9BKLmWfW34DbB6GVFNvJAUKiimRdcjDZd1vhYYVngYmbraAccRTAZs
         af1+kNk9AdolBJUKRkOq+JueS8gPjxHGUpg7eilak0Pr1ExEwoptOeKjpqYRNf5vBDzV
         aLq6ojsjUQn2IA71Lug7kqFHPsrdeTEKqWb7TNZRztSNAInqubJ7e5MtA10dRMtX0uPg
         aeKvA9U5TqqOCf9I/TsE+u9Ts5siIu6Lo4V0i+zLi9vMpSDhbhr8pm9rDvP3Dn+fppMh
         7qFRR4zr5WPkmIsFfgI6z14ZJKOPLVpBeu/qRlb64iisYIhd7JyfWAT72Kjh5+S2lpkZ
         u1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2DzhRwrr2MWLw9Cg0FhGTgbP6uZUQ8F4dsAU+Q41KI4=;
        b=McXbtjH6XhVzQV9mcLuG5mI+9ATwk5uPUOuLiomfo7RA1oTEx7JK0Z+MhrhiE63auq
         VyECQHu5O6sn5RhZdZbkDE8eBQ1MLI/coig0dtdD85UMrnheZlPZyfrCdiYalprsmv8R
         zgJEuZLWgrdKiF/sdRL9AjIFJYUEWN6m0lydVSgRsNA0Q3NOmnuIixL4QQi3pGaVe6+P
         2U0QWNMx4LfkOMezLGqtu7ElptU/BqZhOD5BX7lYuwz+UB8lHHiwhKRJL5/oJK1wlsj7
         C2N1Dos/RLcsr8SNUcNZ55+BFsLwyxEfgHR58udXke9pD4gNpXZLdPMBq310x67DNhCF
         CZrQ==
X-Gm-Message-State: APzg51B0Tko0gfGEV7pjzsz1QgOglm3lM0TfYc+ddHXUEN0RY8b9gbr6
        Xl6JePO/cm25XUhbZ1gbU0s=
X-Google-Smtp-Source: ANB0VdbSKHVkg2v6Q+jYyvqtVyI9hWCaPah68zIzHMbPf58TYHDtxmFC3MNuD83hPexqONNqugv8hA==
X-Received: by 2002:a1c:1745:: with SMTP id 66-v6mr16019615wmx.38.1537289812850;
        Tue, 18 Sep 2018 09:56:52 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id g2-v6sm2934768wme.20.2018.09.18.09.56.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 09:56:52 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-sparse@vger.kernel.org
Subject: [PATCH v2 1/2] Compiler Attributes: naked was fixed in gcc 4.6
Date:   Tue, 18 Sep 2018 18:55:41 +0200
Message-Id: <20180918165542.4691-2-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180918165542.4691-1-miguel.ojeda.sandonis@gmail.com>
References: <20180918165542.4691-1-miguel.ojeda.sandonis@gmail.com>
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
Tested-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Stefan Agner <stefan@agner.ch>
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

