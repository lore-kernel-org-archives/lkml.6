Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40578C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 04:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055E220685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 04:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Rw30CJTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055E220685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408147AbeKWPe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 10:34:58 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:49080 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730451AbeKWPe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 10:34:58 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id wAN4pTNN020182;
        Fri, 23 Nov 2018 13:51:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com wAN4pTNN020182
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542948690;
        bh=aM+gs7PxzxzFrVNFpMVUiiP1VJPNQgasYQmq9JMtCZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rw30CJTFv99+lViRfCG0ocwdgtzNxGnGp8/vroShy90ESFV1aC1PbJJ4b3SVAw2Zl
         RdDJg7YVOF+TefhDlP1c1GEGpvO+V/Q7bua6eqfTE1H4xllbQPv1KlySExqGut2N4p
         o2tzYC4b7Bc5nIPdM8regrT0FfGmOE+DpchSymnBGc1Uh+Y7UO7aL026s29jIVjKGM
         lj754hl5yV1bwbWlQ63N9ClUPnCzO/n51gHIHggTQVrqAaOwjO2TGrWHl1sr0YDFQk
         DkIr9KUGzamPza0T1bzYBECgH0RO0hFafUY8pe0erkv1GrKzJG7CDejJhsst5ZRNbB
         MagAlnZ4mxEjA==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        kernel-hardening@lists.openwall.com,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Emese Revfy <re.emese@gmail.com>
Subject: [PATCH 2/2] kbuild: descend into scripts/gcc-plugins/ via scripts/Makefile
Date:   Fri, 23 Nov 2018 13:51:27 +0900
Message-Id: <1542948687-7326-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542948687-7326-1-git-send-email-yamada.masahiro@socionext.com>
References: <1542948687-7326-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that 'prepare0' depends on 'scripts', building GCC plugins can
go into scripts/Makefile, which is a more standard way.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile                     | 2 +-
 scripts/Makefile             | 3 ++-
 scripts/Makefile.gcc-plugins | 8 --------
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index cee4cec..a8bbe68 100644
--- a/Makefile
+++ b/Makefile
@@ -1114,7 +1114,7 @@ macroprepare: prepare1 archmacros
 
 archprepare: archheaders archscripts macroprepare scripts_basic
 
-prepare0: scripts archprepare gcc-plugins
+prepare0: scripts archprepare
 	$(Q)$(MAKE) $(build)=scripts/mod
 	$(Q)$(MAKE) $(build)=.
 
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

