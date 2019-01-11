Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D3FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60C12133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218810;
	bh=4hvtWoCrIpG920XK+4SZuZ0GhiHGSdbcxmfOanezncw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2AQ301Upezh8TPqbzlgZ3hteKh2CPMT4TyKBNV0XRU7Wxsm260xVTJ7JiIuRODfkH
	 zC9s+aCtzNhyvTHqzsCmF/+QbDg8Pew6RnCDu8tKgas+gronkNSrrjXsgn1KMcr3ea
	 ehjsbU+ozZKx/8EX9QfgCV4B+l4yKRFel0TzXcg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391784AbfAKPAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:00:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:53436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389597AbfAKOdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:33:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 782602133F;
        Fri, 11 Jan 2019 14:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217193;
        bh=4hvtWoCrIpG920XK+4SZuZ0GhiHGSdbcxmfOanezncw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sx7JuQjlcZuWoDLRDoS1y3gwj/TFTHxTd0RVp1wTWP52deyaQl/jA1u9+kDBfUhVJ
         0rGx2pp8+pvgNw1hi2Jc6UfqGpXxOFwij7nH1fnAiuXjmptCOn72GkoFJskd7hRFSq
         OZ4/pGVfm5fAT9gjkkw9ZG9N4tRXDpGHLriup5o8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.14 077/105] raid6/ppc: Fix build for clang
Date:   Fri, 11 Jan 2019 15:14:48 +0100
Message-Id: <20190111131109.430939390@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joel Stanley <joel@jms.id.au>

commit e213574a449f7a57d4202c1869bbc7680b6b5521 upstream.

We cannot build these files with clang as it does not allow altivec
instructions in assembly when -msoft-float is passed.

Jinsong Ji <jji@us.ibm.com> wrote:
> We currently disable Altivec/VSX support when enabling soft-float.  So
> any usage of vector builtins will break.
>
> Enable Altivec/VSX with soft-float may need quite some clean up work, so
> I guess this is currently a limitation.
>
> Removing -msoft-float will make it work (and we are lucky that no
> floating point instructions will be generated as well).

This is a workaround until the issue is resolved in clang.

Link: https://bugs.llvm.org/show_bug.cgi?id=31177
Link: https://github.com/ClangBuiltLinux/linux/issues/239
Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[nc: Use 'ifeq ($(cc-name),clang)' instead of 'ifdef CONFIG_CC_IS_CLANG'
     because that config does not exist in 4.14; the Kconfig rewrite
     that added that config happened in 4.18]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/raid6/Makefile |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/lib/raid6/Makefile
+++ b/lib/raid6/Makefile
@@ -18,6 +18,21 @@ quiet_cmd_unroll = UNROLL  $@
 
 ifeq ($(CONFIG_ALTIVEC),y)
 altivec_flags := -maltivec $(call cc-option,-mabi=altivec)
+
+ifeq ($(cc-name),clang)
+# clang ppc port does not yet support -maltivec when -msoft-float is
+# enabled. A future release of clang will resolve this
+# https://bugs.llvm.org/show_bug.cgi?id=31177
+CFLAGS_REMOVE_altivec1.o  += -msoft-float
+CFLAGS_REMOVE_altivec2.o  += -msoft-float
+CFLAGS_REMOVE_altivec4.o  += -msoft-float
+CFLAGS_REMOVE_altivec8.o  += -msoft-float
+CFLAGS_REMOVE_altivec8.o  += -msoft-float
+CFLAGS_REMOVE_vpermxor1.o += -msoft-float
+CFLAGS_REMOVE_vpermxor2.o += -msoft-float
+CFLAGS_REMOVE_vpermxor4.o += -msoft-float
+CFLAGS_REMOVE_vpermxor8.o += -msoft-float
+endif
 endif
 
 # The GCC option -ffreestanding is required in order to compile code containing


