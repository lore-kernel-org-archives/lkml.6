Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E3AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6286B2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="tDkykB5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbfBTDil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 22:38:41 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:41817 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfBTDil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 22:38:41 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x1K3cX4H029864;
        Wed, 20 Feb 2019 12:38:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x1K3cX4H029864
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550633914;
        bh=UxMuinGDS1/f2cFuVBBDQD0EBncNX2Vm4RGjqVgQHqw=;
        h=From:To:Cc:Subject:Date:From;
        b=tDkykB5NIEXP2G8pyMrf7/8bSQWGuQQQUHjbLIILdf/jcjt4T+nrvr+7MT9zct3yd
         b8QyjS5hZ2C9xsh03WFItSNJMBJSmb07C30PTeMTAHaLDjzzdT4NWk9xOioSIKobXk
         jC6CbCWLyrkgnlLBloavadPLuAB35ZFeoWhnlIvy8fCfiTQ1fxcsTi16heOlgZEb+P
         RcUZB2qUV3ZHuxolDqoUYFK3KdTjaO2uCy3Sgpao7nw4YSUWjc8jaGBx+b9VB0deEs
         RXzGF9El58K/khqLjN9LlAT3osXrBarJ1t1n9OxjXF5HNRWXyQe1C6yPzMyA29LwmJ
         3TcHLavbTGdxw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: hardcode genksyms path and remove GENKSYMS variable
Date:   Wed, 20 Feb 2019 12:38:31 +0900
Message-Id: <1550633911-11741-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The genksyms source was integrated into the kernel tree in 2003.

I do not expect anybody still using the external /sbin/genksyms.
Kbuild does not need to provide the ability to override GENKSYMS.

Let's remove the GENKSYMS variable, and use the hardcoded path.

Since it occurred in the pre-git era, I attached the commit message
in case somebody is interested in the historical background.

  | Author: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
  | Date:   Wed Feb 19 04:17:28 2003 -0600
  |
  | kbuild: [PATCH] put genksyms in scripts dir
  |
  | This puts genksyms into scripts/genksyms/.
  |
  | genksyms used to be maintained externally, though the only possible user
  | was the kernel build. Moving it into the kernel sources makes it easier to
  | keep it uptodate, like for example updating it to generate linker scripts
  | directly instead of postprocessing the generated header file fragments
  | with sed, as we do currently.
  |
  | Also, genksyms does not handle __typeof__, which needs to be fixed since
  | some of the exported symbol in the kernel are defined using __typeof__.
  |
  | (Rusty Russell/me)

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile               | 3 +--
 scripts/Makefile.build | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index def7c79..e19a3e3 100644
--- a/Makefile
+++ b/Makefile
@@ -390,7 +390,6 @@ OBJDUMP		= $(CROSS_COMPILE)objdump
 LEX		= flex
 YACC		= bison
 AWK		= awk
-GENKSYMS	= scripts/genksyms/genksyms
 INSTALLKERNEL  := installkernel
 DEPMOD		= /sbin/depmod
 PERL		= perl
@@ -443,7 +442,7 @@ GCC_PLUGINS_CFLAGS :=
 
 export ARCH SRCARCH CONFIG_SHELL HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE AS LD CC
 export CPP AR NM STRIP OBJCOPY OBJDUMP KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS
-export MAKE LEX YACC AWK GENKSYMS INSTALLKERNEL PERL PYTHON PYTHON2 PYTHON3 UTS_MACHINE
+export MAKE LEX YACC AWK INSTALLKERNEL PERL PYTHON PYTHON2 PYTHON3 UTS_MACHINE
 export HOSTCXX KBUILD_HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
 
 export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS KBUILD_LDFLAGS
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 89debbe..f013182 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -120,7 +120,7 @@ $(obj)/%.i: $(src)/%.c FORCE
 # These mirror gensymtypes_S and co below, keep them in synch.
 cmd_gensymtypes_c =                                                         \
     $(CPP) -D__GENKSYMS__ $(c_flags) $< |                                   \
-    $(GENKSYMS) $(if $(1), -T $(2))                                         \
+    scripts/genksyms/genksyms $(if $(1), -T $(2))                           \
      $(patsubst y,-R,$(CONFIG_MODULE_REL_CRCS))                             \
      $(if $(KBUILD_PRESERVE),-p)                                            \
      -r $(firstword $(wildcard $(2:.symtypes=.symref) /dev/null))
@@ -320,7 +320,7 @@ cmd_gensymtypes_S =                                                         \
      grep "\<___EXPORT_SYMBOL\>" |                                          \
      sed 's/.*___EXPORT_SYMBOL[[:space:]]*\([a-zA-Z0-9_]*\)[[:space:]]*,.*/EXPORT_SYMBOL(\1);/' ; } | \
     $(CPP) -D__GENKSYMS__ $(c_flags) -xc - |                                \
-    $(GENKSYMS) $(if $(1), -T $(2))                                         \
+    scripts/genksyms/genksyms $(if $(1), -T $(2))                           \
      $(patsubst y,-R,$(CONFIG_MODULE_REL_CRCS))                             \
      $(if $(KBUILD_PRESERVE),-p)                                            \
      -r $(firstword $(wildcard $(2:.symtypes=.symref) /dev/null))
-- 
2.7.4

