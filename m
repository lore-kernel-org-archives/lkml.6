Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43677C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D1F20811
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="o9Udx84v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405244AbfBNDGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:06:23 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:64386 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393527AbfBNDGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:06:06 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x1E35Pg9020814;
        Thu, 14 Feb 2019 12:05:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x1E35Pg9020814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550113530;
        bh=VnFzu1pRBkse1rgGgc43E28soFZDRai0oiY6uEajTrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o9Udx84v3yeIM0EAKBWQuWLIjCN5zZoaes7EcO/oM3OqAil+9BT3IM8dWkAQZVOez
         A6xzIGv4dQjpPG4qm7Apl4rCZV75ZHN4jNNOKcRZQospeyxDXuUdvQY6TSUHRrE2dA
         5u6iVZwUNa5TYa6H4fHf//Id/NaiOnO5b8nWLGPtY8MgsM3wymuzgI+m7J0bHvmdOX
         MHZpc4mwPBey7X6YpF9WEForOxFl8IdNVUqdQxckfSRMlpHNSEnsbUCT1jSFij8mZz
         mBhkswIpVFnP+89h3pTKIfaVgGg74pnXYLHIurShSmFk3LR57wpUvJZmfKug5jhVZl
         h06Vnc05KqBkg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] kbuild: simplify single targets
Date:   Thu, 14 Feb 2019 12:05:21 +0900
Message-Id: <1550113521-23577-8-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550113521-23577-1-git-send-email-yamada.masahiro@socionext.com>
References: <1550113521-23577-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dependency will be checked anyway after Kbuild descends into a
sub-directory. Skip object/source dependency checks in top Makefile.

VPATH can be simpler since the top Makefile no longer checks the
preprense of the source file, which is located in in the external
module directory.

[Pros]

- Code is cleaner

- It can compile an object from a generated source file

For example,

  $ make crypto/rsapubkey.asn1.o
    ...
  ASN.1   crypto/rsapubkey.asn1.c
  CC      crypto/rsapubkey.asn1.o

[Cons]

- The top Makefile does not let it fail immediately when a user tries
  to build a wrong object.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 38 +++++++++-----------------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/Makefile b/Makefile
index f7f1aa1..8bf0ed6 100644
--- a/Makefile
+++ b/Makefile
@@ -219,7 +219,7 @@ objtree		:= .
 src		:= $(srctree)
 obj		:= $(objtree)
 
-VPATH		:= $(srctree)$(if $(KBUILD_EXTMOD),:$(KBUILD_EXTMOD))
+VPATH		:= $(srctree)
 
 export srctree objtree VPATH
 
@@ -1686,31 +1686,14 @@ tools/%: FORCE
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
+%.i %.ll %.lst %.o %.s %.symtypes: prepare FORCE
+	$(Q)$(MAKE) $(build)=$(build-dir) $(build-target)
+
+%.ko: %.o
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
 
 # Modules
 PHONY += /
@@ -1720,9 +1703,6 @@ PHONY += /
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

