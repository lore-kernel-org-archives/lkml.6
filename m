Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947A3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5978720863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Gls3K74h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5978720863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeK2PBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 10:01:21 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:35915 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbeK2PBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 10:01:21 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wAT3uW9h014059;
        Thu, 29 Nov 2018 12:56:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wAT3uW9h014059
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543463793;
        bh=jenL7MJF+aDHOcehc6CyDTxYWkvnIjepvb/UDlh5RcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gls3K74hUYeFBajD/srbmUekOfwyf79oeV0RuqBsogpOgjktRfJpaUWgwNgonYyoY
         CCiyzQI3NL5MScs24puNrvOyWCDRl41gx1lEfKnraZdfRVOWt5FFmm/YanIbVELqsk
         bdV0d0HuhiU+pWf8d72e1mDNngFZ3QM2odfId5aYQ8j73eXQ5wpdxfe4YEXIOni4LZ
         iOc8xoZjLnd9sQ4je6ypicCfsx2Xd4rZQ0W2AwMGBdN0FRP9M3wmNfi4/uG6uDEiHm
         XY63uoosa+E3nrqR2mQptVbZQLvCFscp+T4iwb3biyM/GfYwo2s2yj24ygdDZBF3SR
         cHX1ElhOIX7Lg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH v2 2/2] kbuild: descend into scripts/gcc-plugins/ via scripts/Makefile
Date:   Thu, 29 Nov 2018 12:56:31 +0900
Message-Id: <1543463791-18391-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543463791-18391-1-git-send-email-yamada.masahiro@socionext.com>
References: <1543463791-18391-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that 'archprepare' depends on 'scripts', Kbuild can descend into
scripts/gcc-plugins in a more standard way.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---

Changes in v2:
  - It turned out UML + CONFIG_GCC_PLUGINS is broken for a long time.
    https://patchwork.kernel.org/patch/10703853/
    Rebased on the top of the fix-up

 Makefile                     | 2 +-
 scripts/Makefile             | 3 ++-
 scripts/Makefile.gcc-plugins | 8 --------
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 9eb3f4f..c1f87cf 100644
--- a/Makefile
+++ b/Makefile
@@ -1112,7 +1112,7 @@ prepare1: prepare2 $(version_h) $(autoksyms_h) include/generated/utsrelease.h
 
 macroprepare: prepare1 archmacros
 
-archprepare: archheaders archscripts macroprepare scripts gcc-plugins
+archprepare: archheaders archscripts macroprepare scripts
 
 prepare0: archprepare
 	$(Q)$(MAKE) $(build)=scripts/mod
diff --git a/scripts/Makefile b/scripts/Makefile
index b48259d..feb1f71 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -36,9 +36,10 @@ PHONY += build_unifdef
 build_unifdef: $(obj)/unifdef
 	@:
 
+subdir-$(CONFIG_GCC_PLUGINS) += gcc-plugins
 subdir-$(CONFIG_MODVERSIONS) += genksyms
 subdir-$(CONFIG_SECURITY_SELINUX) += selinux
 subdir-$(CONFIG_GDB_SCRIPTS) += gdb
 
 # Let clean descend into subdirs
-subdir-	+= basic dtc kconfig mod package gcc-plugins
+subdir-	+= basic dtc kconfig mod package
diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index 46c5c68..c36f199 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -49,11 +49,3 @@ KBUILD_CFLAGS += $(GCC_PLUGINS_CFLAGS)
 # All enabled GCC plugins are collected here for building below.
 GCC_PLUGIN := $(gcc-plugin-y)
 export GCC_PLUGIN
-
-# Actually do the build, if requested.
-PHONY += gcc-plugins
-gcc-plugins: scripts_basic
-ifdef CONFIG_GCC_PLUGINS
-	$(Q)$(MAKE) $(build)=scripts/gcc-plugins
-endif
-	@:
-- 
2.7.4

