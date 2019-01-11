Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB23CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD4C21841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217542;
	bh=Mgx1R0P15xDM8hFM22ILjxRR+An+yQ0KvW1dx6qP1nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ryk+7aGFHXdc8dZPp1oltN9nonYLlJczfJfvdJybvG/GzxdQsG9kfo38gvI0qX8O0
	 B7iGPhADlFTrfpA+uIasxKX48RXLAQ3xn8qVviQnzuWh9M1zmJPoF4lK0PkTuEOaeH
	 qn5p4fQ7Mi4G3it9OhrkKaXk4Cbw22WdK9rleZkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403765AbfAKOjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:39:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390949AbfAKOiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:38:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31CC1206B6;
        Fri, 11 Jan 2019 14:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217533;
        bh=Mgx1R0P15xDM8hFM22ILjxRR+An+yQ0KvW1dx6qP1nc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=skx7DHhw544KB4JKwjLwIOOikef/3IF3y4Y4U0qe1+lp2dFMGnIUD230Gd3VPFpKc
         cRP4DiT51lqozyLE8afH4+VyUBy+uZjNQf3gEkGAGHskRYzc21MhTCv6fFxJN8q0wv
         cJhOwT9ZOEX1uiWFir0H8JetrnRuOfmuDAmWtnFs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.19 095/148] powerpc: Disable -Wbuiltin-requires-header when setjmp is used
Date:   Fri, 11 Jan 2019 15:14:33 +0100
Message-Id: <20190111131118.033663291@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joel Stanley <joel@jms.id.au>

commit aea447141c7e7824b81b49acd1bc785506fba46e upstream.

The powerpc kernel uses setjmp which causes a warning when building
with clang:

  In file included from arch/powerpc/xmon/xmon.c:51:
  ./arch/powerpc/include/asm/setjmp.h:15:13: error: declaration of
  built-in function 'setjmp' requires inclusion of the header <setjmp.h>
        [-Werror,-Wbuiltin-requires-header]
  extern long setjmp(long *);
              ^
  ./arch/powerpc/include/asm/setjmp.h:16:13: error: declaration of
  built-in function 'longjmp' requires inclusion of the header <setjmp.h>
        [-Werror,-Wbuiltin-requires-header]
  extern void longjmp(long *, long);
              ^

This *is* the header and we're not using the built-in setjump but
rather the one in arch/powerpc/kernel/misc.S. As the compiler warning
does not make sense, it for the files where setjmp is used.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
[mpe: Move subdir-ccflags in xmon/Makefile to not clobber -Werror]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/Makefile |    3 +++
 arch/powerpc/xmon/Makefile   |    5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -5,6 +5,9 @@
 
 CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
 
+# Disable clang warning for using setjmp without setjmp.h header
+CFLAGS_crash.o		+= $(call cc-disable-warning, builtin-requires-header)
+
 subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
 ifdef CONFIG_PPC64
--- a/arch/powerpc/xmon/Makefile
+++ b/arch/powerpc/xmon/Makefile
@@ -1,7 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for xmon
 
-subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
+# Disable clang warning for using setjmp without setjmp.h header
+subdir-ccflags-y := $(call cc-disable-warning, builtin-requires-header)
+
+subdir-ccflags-$(CONFIG_PPC_WERROR) += -Werror
 
 GCOV_PROFILE := n
 UBSAN_SANITIZE := n


