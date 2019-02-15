Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02BBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 04:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4638421A80
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 04:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="lVnZ3FfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbfBOEEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 23:04:44 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:65215 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbfBOEEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 23:04:44 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x1F44VKQ016178;
        Fri, 15 Feb 2019 13:04:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x1F44VKQ016178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550203472;
        bh=/7el2vCDzAReGIevnNfGHriy40ZvtjfSlPLwN8yRet0=;
        h=From:To:Cc:Subject:Date:From;
        b=lVnZ3FfXy8ia869I2JS6wYWbksGVNdkXeVzXPbvGeMbTXgUpaOYERh+IxaU4yYVag
         zw730nI4CwZJ3wVVH1760TEJ55eTXoaqpfgnItJA7WP5a0h12tiDXfdjs4aFlWe4CX
         1zH65l9h0ULEplynv6Tw5uDfcKJwAnjX8WJIK+XjQZQuH4XO65HQAfoF0WStD/gxjE
         orTkqIUIqPPAp5paIiV7KygmrB6MIRjWRIovGISc8pb2gSBRr/HD3X3mOBfGlZz5SO
         L9KSsLEhzqNCdMtmWpACwjb2qBkAXXDknPxbAMiD7KicdLkkfMICqxX6ps2dDA2ryi
         Po9vTGOHyWPXA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        uclinux-h8-devel@lists.sourceforge.jp
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] h8300: use cc-cross-prefix instead of hardcoding h8300-unknown-linux-
Date:   Fri, 15 Feb 2019 13:04:26 +0900
Message-Id: <1550203466-13984-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It believe it is a bad idea to hardcode a specific compiler prefix
that may or may not be installed on a user's system. It is annoying
when testing features that should not require compilers at all.

For example, mrproper, headers_install, etc. should work without
any compiler.

They look like follows on my machine.

$ make ARCH=h8300 mrproper
./scripts/gcc-version.sh: line 26: h8300-unknown-linux-gcc: command not found
./scripts/gcc-version.sh: line 27: h8300-unknown-linux-gcc: command not found
make: h8300-unknown-linux-gcc: Command not found
make: h8300-unknown-linux-gcc: Command not found
  [ a bunch of the same error messages continue ]

$ make ARCH=h8300 headers_install
./scripts/gcc-version.sh: line 26: h8300-unknown-linux-gcc: command not found
./scripts/gcc-version.sh: line 27: h8300-unknown-linux-gcc: command not found
make: h8300-unknown-linux-gcc: Command not found
  HOSTCC  scripts/basic/fixdep
make: h8300-unknown-linux-gcc: Command not found
  WRAP    arch/h8300/include/generated/uapi/asm/kvm_para.h
  [ snip ]

The solution is to delete this line, or to use cc-cross-prefix like
some architectures do. I chose the latter as a moderate fixup.

I added an alternative 'h8300-linux-' because it is available at:

https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.1.0/

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/h8300/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/h8300/Makefile b/arch/h8300/Makefile
index f801f37..ba0f26c 100644
--- a/arch/h8300/Makefile
+++ b/arch/h8300/Makefile
@@ -27,7 +27,7 @@ KBUILD_LDFLAGS += $(ldflags-y)
 CHECKFLAGS += -msize-long
 
 ifeq ($(CROSS_COMPILE),)
-CROSS_COMPILE := h8300-unknown-linux-
+CROSS_COMPILE := $(call cc-cross-prefix, h8300-unknown-linux- h8300-linux-)
 endif
 
 core-y	+= arch/$(ARCH)/kernel/ arch/$(ARCH)/mm/
-- 
2.7.4

