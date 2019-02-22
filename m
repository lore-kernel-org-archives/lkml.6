Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFCFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C6E20823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="d1VCRaOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfBVHkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 02:40:43 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:53323 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfBVHkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 02:40:22 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x1M7eEN3013122;
        Fri, 22 Feb 2019 16:40:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x1M7eEN3013122
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550821216;
        bh=UcWNwsux7b1JpeJdXT16j2ZgXx6alk2fUysrOhB9agQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d1VCRaOUNPYV1EmPwqZ2gKCkt7j4bSA6poEYuGWUcvxPOg9a+Igydih6CmYtl/T12
         /tAUcE1p6hv3o6AZBCecFoy2oG/HRE2uIt1QIXrXYZVHBw3vNs+zAxhgArylt4GJFd
         wp92HZ9Ju5ph5ZYc/FIRKzcnnF3EzJT3RZm1hAAEM6krFIyUb0Soqv1iDk5cU6TeU2
         Ny8X4wV3Jo9zIQ+nIiPRosnZQtFZOBLUj2R46SEl8eRM8qcylSG9XiJ+8d3NOft8X5
         167HDIJLYNsmVJrMN8A27kLRQvdNHZLuaawYY2+3DepfmBCFx7vD4Ks3dUvCAQAXyN
         rqLZ1JLb8/mSA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] kbuild: simplify single target rules
Date:   Fri, 22 Feb 2019 16:40:09 +0900
Message-Id: <1550821211-30324-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550821211-30324-1-git-send-email-yamada.masahiro@socionext.com>
References: <1550821211-30324-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dependency will be checked anyway after Kbuild descends into a
sub-directory. Skip object/source dependency checks in top Makefile.

VPATH can be simpler since the top Makefile no longer checks the
presence of the source file, which is located in in the external
module directory.

One good thing is, it can compile an object from a generated source
file.

  $ make crypto/rsapubkey.asn1.o
    ...
  ASN.1   crypto/rsapubkey.asn1.c
  CC      crypto/rsapubkey.asn1.o

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Do not merge pattern rules

 Makefile | 47 ++++++++++++++++++-----------------------------
 1 file changed, 18 insertions(+), 29 deletions(-)

diff --git a/Makefile b/Makefile
index 538a4f1..4d8516e 100644
--- a/Makefile
+++ b/Makefile
@@ -219,7 +219,7 @@ objtree		:= .
 src		:= $(srctree)
 obj		:= $(objtree)
 
-VPATH		:= $(srctree)$(if $(KBUILD_EXTMOD),:$(KBUILD_EXTMOD))
+VPATH		:= $(srctree)
 
 export srctree objtree VPATH
 
@@ -1703,31 +1703,23 @@ tools/%: FORCE
 #  target-dir => where to store outputfile
 #  build-dir  => directory in kernel source tree to use
 
-ifeq ($(KBUILD_EXTMOD),)
-        build-dir  = $(patsubst %/,%,$(dir $@))
-        target-dir = $(dir $@)
-else
-        zap-slash=$(filter-out .,$(patsubst %/,%,$(dir $@)))
-        build-dir  = $(KBUILD_EXTMOD)$(if $(zap-slash),/$(zap-slash))
-        target-dir = $(if $(KBUILD_EXTMOD),$(dir $<),$(dir $@))
-endif
-
-%.s: %.c prepare FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.i: %.c prepare FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.o: %.c prepare FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.lst: %.c prepare FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.s: %.S prepare FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.o: %.S prepare FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.symtypes: %.c prepare FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.ll: %.c prepare FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
+build-target = $(if $(KBUILD_EXTMOD), $(KBUILD_EXTMOD)/)$@
+build-dir = $(patsubst %/,%,$(dir $(build-target)))
+
+%.i: prepare FORCE
+	$(Q)$(MAKE) $(build)=$(build-dir) $(build-target)
+%.ll: prepare FORCE
+	$(Q)$(MAKE) $(build)=$(build-dir) $(build-target)
+%.lst: prepare FORCE
+	$(Q)$(MAKE) $(build)=$(build-dir) $(build-target)
+%.o: prepare FORCE
+	$(Q)$(MAKE) $(build)=$(build-dir) $(build-target)
+%.s: prepare FORCE
+	$(Q)$(MAKE) $(build)=$(build-dir) $(build-target)
+%.symtypes: prepare FORCE
+	$(Q)$(MAKE) $(build)=$(build-dir) $(build-target)
+%.ko: %.o
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
 
 # Modules
 PHONY += /
@@ -1737,9 +1729,6 @@ PHONY += /
 Documentation/ samples/: headers_install
 %/: prepare FORCE
 	$(Q)$(MAKE) KBUILD_MODULES=1 $(build)=$(build-dir)
-%.ko: prepare FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(@:.ko=.o)
-	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
 
 # FIXME Should go into a make.lib or something
 # ===========================================================================
-- 
2.7.4

