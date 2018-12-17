Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B623C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86F7206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Eu9BMTHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388129AbeLQQKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:10:53 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:64868 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387635AbeLQQKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:10:53 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id wBHG3bRn008119;
        Tue, 18 Dec 2018 01:03:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com wBHG3bRn008119
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545062634;
        bh=o/MEbJ3S1hhfmW2hGhchL96p7dT26gkeOJCbbt7ujYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eu9BMTHWNTBFYlbJ5nxhDX/xlXN7gxMGDpvSFqfP9NsumwKw7Yu0/dNS1ahhxe2Up
         WGnthgiNa/dtN5WRTRgudM3l3m5zOok6fPxUX7znA4wSc1Vouu0rolq2Sw+e04JRYF
         Ht0zfpHHbtoij48qC16YZZwhlZAcBkDO83lVya+1eibEUfXgPhwwfEpMRwxuPxPsW/
         nxRKhvZyBl8j54qtpQCYCpVSaODEY8L9nkIU0YF4jz7isFdTAhmlqMKMJEPbjN4fr/
         h0ibKG7JxoxJtxvuWGdoLoE3cmHjTK6q64ds2WB94zH9Ud5XaVVSXKnY2xBxdUOtg4
         c6Z/iCL7IKOXQ==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Richard Biener <rguenther@suse.de>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/12] linux/linkage: add ASM() macro to reduce duplication between C/ASM code
Date:   Tue, 18 Dec 2018 01:03:25 +0900
Message-Id: <1545062607-8599-11-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
References: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We often duplicate similar assembly code to use it from .c and .S files.
The difference is mostly the presence of double quotes.

So, here is a new macro ASM().
(We have similar approach for __ASM_FORM(), etc.)

The usage is like this:

    #define MY_CODE              \
    ASM(    .section ".text"    )\
    ASM(    movl $1, %eax       )

In C context, the preprocessor expands it into:

  ".section \".text\"" "\n\t" "movl $1, %eax" "\n\t"

This is perfect for the use from the inline asm(...) in .c files.

In assembly context, the preprocessor expands it into:

  .section ".text" ; movl $1, %eax ;

This is fine for the use in .S files.

I used double-expansion like __stringify() so that we can use
macros in ASM(...).

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/linux/linkage.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index 7c47b1a..80faeae 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -12,6 +12,14 @@
 #define ASM_NL		 ;
 #endif
 
+#ifdef __ASSEMBLY__
+#define _ASM(x...)	x ASM_NL
+#else
+#define _ASM(x...)	#x __stringify(\n\t)
+#endif
+/* Doing two levels allows macros to be used in ASM(...) */
+#define ASM(x...)	_ASM(x)
+
 #ifdef __cplusplus
 #define CPP_ASMLINKAGE extern "C"
 #else
-- 
2.7.4

