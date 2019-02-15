Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1568C10F09
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B26E222F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="F46UDRvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405094AbfBOJkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:40:04 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:28898 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405074AbfBOJkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:40:03 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x1F9cjfD023550;
        Fri, 15 Feb 2019 18:38:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x1F9cjfD023550
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550223525;
        bh=CBamstatH6SEE8PkWAfApJMSUCvf06iKMWQVXEv6Ou4=;
        h=From:To:Cc:Subject:Date:From;
        b=F46UDRvVm7YksAnE4Oui19Xld7f5miS164qgKp5ux/DJJOv8ypGdOg8waEhgdRm01
         CA00J8OR8WADqiOGzzFfDIfz4QsEa4QA86HFEnxmkNOok2mI0CWDOXnUrt4lgFpnPs
         PEl3CfjKBdQma0RWR/6N5+zvxL/cmR9EzDUAg9Frar4oo6FBVl5W54CZgNh5aulO/U
         vYW1w7LPYuuj8nr6qx/f2pbPMPN9+7aanLbHdx0rWUxoxRq15bQEOWRvJn3ckSZM3b
         NfnAbrk3v4M6cPfrIti68xhAh9wfq6ryLQfNL30JesTZQAPQ8KNQ4FXCSNtM6Oi+CB
         VwrZEIBe2w8JA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: use $(origin ARCH) to select KBUILD_DEFCONFIG
Date:   Fri, 15 Feb 2019 18:38:39 +0900
Message-Id: <1550223519-18290-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I often test all Kconfig commands for all architectures. To ease my
workflow, I want 'make defconfig' at least working without any cross
compiler.

Currently, arch/powerpc/Makefile checks CROSS_COMPILE to decide the
default defconfig source.

If CROSS_COMPILE is unset, it is likely to be the native build, so
'uname -m' is useful to choose the defconfig. If CROSS_COMPILE is set,
the user is cross-building (i.e. 'uname -m' is probably x86_64), so
it falls back to ppc64_defconfig. Yup, make sense.

However, I want to run 'make ARCH=* defconfig' without setting
CROSS_COMPILE for each architecture.

My suggestion is to check $(origin ARCH).

When you cross-compile the kernel, you need to set ARCH from your
environment or from the command line.

For the native build, you do not need to set ARCH. The default in
the top Makefile is used:

  ARCH            ?= $(SUBARCH)

Hence, $(origin ARCH) returns 'file'.

Before this commit, 'make ARCH=powerpc defconfig' failed:

  $ make ARCH=powerpc defconfig
  *** Default configuration is based on target 'x86_64_defconfig'
  ***
  *** Can't find default configuration "arch/powerpc/configs/x86_64_defconfig"!
  ***

After this commit, it will succeed:

  $ make ARCH=powerpc defconfig
  *** Default configuration is based on 'ppc64_defconfig'
  #
  # configuration written to .config
  #

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/powerpc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index ac03334..f989979 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -34,7 +34,7 @@ ifdef CONFIG_PPC_BOOK3S_32
 KBUILD_CFLAGS		+= -mcpu=powerpc
 endif
 
-ifeq ($(CROSS_COMPILE),)
+ifeq ($(origin ARCH), file)
 KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
 else
 KBUILD_DEFCONFIG := ppc64_defconfig
-- 
2.7.4

