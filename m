Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E1EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E692147D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="USsVu3AP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E692147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbeKZVs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:48:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:56946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbeKZVs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:48:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D47EC2146F;
        Mon, 26 Nov 2018 10:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229681;
        bh=QCEqhBY+Ne66DET4jGKPDEeL7sb9GOlkcItyso8j6z0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=USsVu3APE6H4Lx/PZdLPwPfCVGRZnpjUbJixDg4wJPD8Kt1wo6gpDT67pu8IAih1N
         SiOcU1UXZqZT3Ig12EkZcFhXxUHqZqq8yWsV90TFg8xB7lmXjtj5L93wfD6LBHxdl8
         5mkhk0pdf5xouiOyiFLRAVSnm8fbn7R46hIpjm6E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Grant Grundler <grundler@chromium.org>,
        Greg Hackmann <ghackmann@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Davidson <md@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 31/70] x86/mm/kaslr: Use the _ASM_MUL macro for multiplication to work around Clang incompatibility
Date:   Mon, 26 Nov 2018 11:50:46 +0100
Message-Id: <20181126105049.785151902@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105046.722096341@linuxfoundation.org>
References: <20181126105046.722096341@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit 121843eb02a6e2fa30aefab64bfe183c97230c75 upstream.

The constraint "rm" allows the compiler to put mix_const into memory.
When the input operand is a memory location then MUL needs an operand
size suffix, since Clang can't infer the multiplication width from the
operand.

Add and use the _ASM_MUL macro which determines the operand size and
resolves to the NUL instruction with the corresponding suffix.

This fixes the following error when building with clang:

  CC      arch/x86/lib/kaslr.o
  /tmp/kaslr-dfe1ad.s: Assembler messages:
  /tmp/kaslr-dfe1ad.s:182: Error: no instruction mnemonic suffix given and no register operands; can't size instruction

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Cc: Grant Grundler <grundler@chromium.org>
Cc: Greg Hackmann <ghackmann@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Davidson <md@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20170501224741.133938-1-mka@chromium.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[nc: Apply to aslr.c in get_random_long as the kaslr shift didn't happen
     until 4.8 in commit d899a7d146a2]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/boot/compressed/aslr.c |    3 ++-
 arch/x86/include/asm/asm.h      |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/boot/compressed/aslr.c
+++ b/arch/x86/boot/compressed/aslr.c
@@ -1,5 +1,6 @@
 #include "misc.h"
 
+#include <asm/asm.h>
 #include <asm/msr.h>
 #include <asm/archrandom.h>
 #include <asm/e820.h>
@@ -94,7 +95,7 @@ static unsigned long get_random_long(voi
 	}
 
 	/* Circular multiply for better bit diffusion */
-	asm("mul %3"
+	asm(_ASM_MUL "%3"
 	    : "=a" (random), "=d" (raw)
 	    : "a" (random), "rm" (mix_const));
 	random += raw;
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -34,6 +34,7 @@
 #define _ASM_ADD	__ASM_SIZE(add)
 #define _ASM_SUB	__ASM_SIZE(sub)
 #define _ASM_XADD	__ASM_SIZE(xadd)
+#define _ASM_MUL	__ASM_SIZE(mul)
 
 #define _ASM_AX		__ASM_REG(ax)
 #define _ASM_BX		__ASM_REG(bx)


