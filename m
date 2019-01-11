Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FABEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3783121848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217196;
	bh=lIe9/b299PT3tw69SDKEVZCKIAjJ9YPoZ0XW8MN0D38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dYLv5Tja9Vkqj0Tl4N8DTSinpQDmCbvdrGA79aclMEdKiDnZXmvxtxS+M5LETAmqN
	 lyzqhgYJsT9UbTlYH1IF0WqsgS5habZGgD4cdT1XvdFVLKQRvXSKofX6bY+DrqdpR0
	 Gw1PScsBaku1Ttnzj+lA3CIdelk3qbHiEGx0/08U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389621AbfAKOdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:33:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:53364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389604AbfAKOdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:33:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0832204EC;
        Fri, 11 Jan 2019 14:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217190;
        bh=lIe9/b299PT3tw69SDKEVZCKIAjJ9YPoZ0XW8MN0D38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WYCUKi2jRxmmuXrnASbtL2nD0AIo0eqG6aQKk3RK1+jiKd/jJ3kUZ9JX11u19IRtR
         SOtyMdztWZAs1njquu3AmBBY4pgGX6VFdamtySWSfSLhhtTvAYGQVGbp63lc6HKo+b
         75alyUQ46PR1V63R1L1fpY2vthvN4F+gFVZH1a8k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH 4.14 076/105] powerpc/boot: Set target when cross-compiling for clang
Date:   Fri, 11 Jan 2019 15:14:47 +0100
Message-Id: <20190111131109.347500358@linuxfoundation.org>
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

commit 813af51f5d30a2da6a2523c08465f9726e51772e upstream.

Clang needs to be told which target it is building for when cross
compiling.

Link: https://github.com/ClangBuiltLinux/linux/issues/259
Signed-off-by: Joel Stanley <joel@jms.id.au>
Tested-by: Daniel Axtens <dja@axtens.net> # powerpc 64-bit BE
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
[nc: Use 'ifeq ($(cc-name),clang)' instead of 'ifdef CONFIG_CC_IS_CLANG'
     because that config does not exist in 4.14; the Kconfig rewrite
     that added that config happened in 4.18]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/boot/Makefile |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -49,6 +49,11 @@ endif
 
 BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
 
+ifeq ($(cc-name),clang)
+BOOTCFLAGS += $(CLANG_FLAGS)
+BOOTAFLAGS += $(CLANG_FLAGS)
+endif
+
 ifdef CONFIG_DEBUG_INFO
 BOOTCFLAGS	+= -g
 endif


