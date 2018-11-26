Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA256C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39B92089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQTTO+4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39B92089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbeKZVtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:49:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:58090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbeKZVtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:49:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C6452089F;
        Mon, 26 Nov 2018 10:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229729;
        bh=4I7qxp/fUZsbpm/Pj7R9FQCAeCgi+ta56c8M3R8rXyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qQTTO+4p9WwFb3xdH7F5k4rX5atvBxL8RikChDJMoox9WrhG0cPujW8iS/98iJgPL
         uLrOz6UEedp5IktPIu1UHExr+11K8Qmr2gjqwZAl+UTtqHTx2JDf89XyZJ4G00ToKf
         n0V0fSjuzTDuc+ed7DKTVslcPFaaFPraCUPZ0ork=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Vin=C3=ADcius=20Tinti?= <viniciustinti@gmail.com>,
        Behan Webster <behanw@converseincode.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 14/70] kbuild: Add support to generate LLVM assembly files
Date:   Mon, 26 Nov 2018 11:50:29 +0100
Message-Id: <20181126105048.259902707@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105046.722096341@linuxfoundation.org>
References: <20181126105046.722096341@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vinícius Tinti <viniciustinti@gmail.com>

commit 433db3e260bc8134d4a46ddf20b3668937e12556 upstream.

Add rules to kbuild in order to generate LLVM assembly files with the .ll
extension when using clang.

  # from c code
  make CC=clang kernel/pid.ll

Signed-off-by: Vinícius Tinti <viniciustinti@gmail.com>
Signed-off-by: Behan Webster <behanw@converseincode.com>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
[nc: Fix conflicts due to lack of commit 6b90bd4ba40b3 in linux-4.4.y]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .gitignore             |    1 +
 Makefile               |    5 +++++
 scripts/Makefile.build |    8 ++++++++
 3 files changed, 14 insertions(+)

--- a/.gitignore
+++ b/.gitignore
@@ -33,6 +33,7 @@
 *.lzo
 *.patch
 *.gcno
+*.ll
 modules.builtin
 Module.symvers
 *.dwo
--- a/Makefile
+++ b/Makefile
@@ -1307,6 +1307,8 @@ help:
 	@echo  '                    (default: $$(INSTALL_MOD_PATH)/lib/firmware)'
 	@echo  '  dir/            - Build all files in dir and below'
 	@echo  '  dir/file.[ois]  - Build specified target only'
+	@echo  '  dir/file.ll     - Build the LLVM assembly file'
+	@echo  '                    (requires compiler support for LLVM assembly generation)'
 	@echo  '  dir/file.lst    - Build specified mixed source/assembly target only'
 	@echo  '                    (requires a recent binutils and recent build (System.map))'
 	@echo  '  dir/file.ko     - Build module including final link'
@@ -1482,6 +1484,7 @@ clean: $(clean-dirs)
 		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \
 		-o -name '*.symtypes' -o -name 'modules.order' \
 		-o -name modules.builtin -o -name '.tmp_*.o.*' \
+		-o -name '*.ll' \
 		-o -name '*.gcno' \) -type f -print | xargs rm -f
 
 # Generate tags for editors
@@ -1585,6 +1588,8 @@ endif
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
 %.symtypes: %.c prepare scripts FORCE
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
+%.ll: %.c prepare scripts FORCE
+	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
 
 # Modules
 /: prepare scripts FORCE
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -175,6 +175,14 @@ cmd_cc_symtypes_c =
 $(obj)/%.symtypes : $(src)/%.c FORCE
 	$(call cmd,cc_symtypes_c)
 
+# LLVM assembly
+# Generate .ll files from .c
+quiet_cmd_cc_ll_c = CC $(quiet_modtag)  $@
+      cmd_cc_ll_c = $(CC) $(c_flags) -emit-llvm -S -o $@ $<
+
+$(obj)/%.ll: $(src)/%.c FORCE
+	$(call if_changed_dep,cc_ll_c)
+
 # C (.c) files
 # The C file is compiled and updated dependency information is generated.
 # (See cmd_cc_o_c + relevant part of rule_cc_o_c)


