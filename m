Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2536AC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E923620879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078525;
	bh=BrIJf3qDF4kvvKWYTwgIa4kBQO+ZIRVqJLgyNXOsCPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0DjVlmqWMeFeB+EzDEcf9gBMNQWwiEcpZ8ahMk6wMLfGq6LiiSQi2nztjK7MiotLP
	 +U+RwM83q3/FIGKjtVBoeQjxDVC0ROOgQkkXvTlfO5uqNd2kWVwtQuSvbwqgZS6fW+
	 2UvMCpwsfIuvok+zwdMPBmOmWSlt3mEv5hM9JG+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbfAUNsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:48:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:58706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729397AbfAUNsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:48:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D23820861;
        Mon, 21 Jan 2019 13:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078518;
        bh=BrIJf3qDF4kvvKWYTwgIa4kBQO+ZIRVqJLgyNXOsCPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FV4pDzlJ1wFusqGdNfJOu0TyDZAnA1a26Choth5dYs5CcZ/G4ElNpgNR0Qu9v7sBr
         CMVUMQoiOHqtk7drhbehpZ0nhAC/w5OxcZy+RqNYvx/yjFNAl5OVYIHAjRbUGTnbX7
         xESJs4S0vGpT3Vin5xeoo8Fyg5CusVowxVj+3AHY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 4.20 061/111] kbuild: fix single target build for external module
Date:   Mon, 21 Jan 2019 14:42:55 +0100
Message-Id: <20190121122502.851674683@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <yamada.masahiro@socionext.com>

commit e07db28eea38ed4e332b3a89f3995c86b713cb5b upstream.

Building a single target in an external module fails due to missing
.tmp_versions directory.

For example,

  $ make -C /lib/modules/$(uname -r)/build M=$PWD foo.o

will fail in the following way:

  CC [M]  /home/masahiro/foo/foo.o
/bin/sh: 1: cannot create /home/masahiro/foo/.tmp_versions/foo.mod: Directory nonexistent

This is because $(cmd_crmodverdir) is executed only before building
/, %/, %.ko single targets of external modules. Create .tmp_versions
in the 'prepare' target.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Makefile |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -1545,9 +1545,6 @@ else # KBUILD_EXTMOD
 
 # We are always building modules
 KBUILD_MODULES := 1
-PHONY += crmodverdir
-crmodverdir:
-	$(cmd_crmodverdir)
 
 PHONY += $(objtree)/Module.symvers
 $(objtree)/Module.symvers:
@@ -1559,7 +1556,7 @@ $(objtree)/Module.symvers:
 
 module-dirs := $(addprefix _module_,$(KBUILD_EXTMOD))
 PHONY += $(module-dirs) modules
-$(module-dirs): crmodverdir $(objtree)/Module.symvers
+$(module-dirs): prepare $(objtree)/Module.symvers
 	$(Q)$(MAKE) $(build)=$(patsubst _module_%,%,$@)
 
 modules: $(module-dirs)
@@ -1600,7 +1597,8 @@ help:
 
 # Dummies...
 PHONY += prepare scripts
-prepare: ;
+prepare:
+	$(cmd_crmodverdir)
 scripts: ;
 endif # KBUILD_EXTMOD
 
@@ -1724,17 +1722,14 @@ endif
 
 # Modules
 /: prepare scripts FORCE
-	$(cmd_crmodverdir)
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
 	$(build)=$(build-dir)
 # Make sure the latest headers are built for Documentation
 Documentation/ samples/: headers_install
 %/: prepare scripts FORCE
-	$(cmd_crmodverdir)
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
 	$(build)=$(build-dir)
 %.ko: prepare scripts FORCE
-	$(cmd_crmodverdir)
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1)   \
 	$(build)=$(build-dir) $(@:.ko=.o)
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost


