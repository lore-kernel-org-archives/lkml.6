Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FFAC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE41205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="kV/KIjbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE41205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeJPRBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:01:37 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:57572 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeJPRBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:01:37 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w9G9BLLw029692;
        Tue, 16 Oct 2018 18:11:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w9G9BLLw029692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539681084;
        bh=CqiDXGBClPJg3L6ZPE6aRkpV3O7/PTqNTFi2pZNHYq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kV/KIjbDjvBKMNqpBjOjPliwu/kMV3OXCe1rYCNAfeed8Gq/HGtuvjgEe6H4mJrAx
         QEtcVb+1J/UIMOlVk2ndoZCTBeap2GzeDIQTZ04nv3jh2EMi38SyF+h2Bgm37w5W0x
         A1PPBLwDW5vRDKgh33gEAOg1YO2eoz52YrB0yPuLJCMFW9zX8dz4HivQQiwJMq2UeT
         wSsRNbH1U1KxUhZ2ZtnZFEjWF22d9WP3MKbmAoNB4mIHzFQt2Spuvn3/4Rm5zrwy5u
         WSfKlt/NwwYC2trosg4jfuCFPFOUaSmZnbMlLlN+RBqdblRvIXV3/UTj6OPXla1kau
         n7Qh/p6XHG1cg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Borislav Petkov <bp@suse.de>, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] objtool: move libelf check out of top Makefile
Date:   Tue, 16 Oct 2018 18:10:52 +0900
Message-Id: <1539681053-24388-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539681053-24388-1-git-send-email-yamada.masahiro@socionext.com>
References: <1539681053-24388-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Edlinger reports:

  The next make after an oldconfig reads in the outdated
  include/config/auto.conf which can kill the make before
  it is able to call the syncconfig target.

  $ make defconfig
  *** Default configuration is based on 'x86_64_defconfig'
  $ make
  scripts/kconfig/conf  --syncconfig Kconfig
  Makefile:936: *** "Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y,
  please install libelf-dev, libelf-devel or elfutils-libelf-devel".  Stop.

  $ sed -i s/CONFIG_UNWINDER_ORC=y// .configs
  $ make oldconfig
  Choose kernel unwinder
  > 1. ORC unwinder (UNWINDER_ORC) (NEW)
    2. Frame pointer unwinder (UNWINDER_FRAME_POINTER)
  choice[1-2?]: 2
  $ make
  Makefile:936: *** "Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y,
  please install libelf-dev, libelf-devel or elfutils-libelf-devel".  Stop.

I tried to fix it by moving the libelf evaluation to the Kconfig
stage [1], but it was rejected.

Kconfig is now able to run shell commands to evaluate any prerequisites
needed to enable CONFIG options.

For example, as shown in commit 2a61f4747eea ("stack-protector: test
compiler capability in Kconfig and drop AUTO mode"), the new Kconfig
syntax is useful to evaluate target compiler capabilities.

However, disabling the CONFIG option silently just because of missing
libelf would not be a preferred behavior; in this case, installing an
appropriate package will solve the problem. Hence, this check will be
kept in a makefile, but somewhere else than the top Makefile.

Move the check to scripts/Makefile.toolcheck so that it is run after
syncconfig.

Another behavioral change is, missing libelf for CONFIG_STACK_VALIDATION
was previously a warning, but now a error.

[1] https://patchwork.kernel.org/patch/10516049/

Reported-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile                   | 21 +++------------------
 scripts/Makefile.build     |  2 --
 scripts/Makefile.toolcheck |  5 +++++
 3 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/Makefile b/Makefile
index 23a204a..71940b7 100644
--- a/Makefile
+++ b/Makefile
@@ -949,23 +949,6 @@ mod_sign_cmd = true
 endif
 export mod_sign_cmd
 
-ifdef CONFIG_STACK_VALIDATION
-  has_libelf := $(call try-run,\
-		echo "int main() {}" | $(HOSTCC) -xc -o /dev/null -lelf -,1,0)
-  ifeq ($(has_libelf),1)
-    objtool_target := tools/objtool FORCE
-  else
-    ifdef CONFIG_UNWINDER_ORC
-      $(error "Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel")
-    else
-      $(warning "Cannot use CONFIG_STACK_VALIDATION=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel")
-    endif
-    SKIP_STACK_VALIDATION := 1
-    export SKIP_STACK_VALIDATION
-  endif
-endif
-
-
 ifeq ($(KBUILD_EXTMOD),)
 core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
 
@@ -1115,7 +1098,9 @@ uapi-asm-generic:
 	            src=uapi/asm obj=arch/$(SRCARCH)/include/generated/uapi/asm
 
 PHONY += prepare-objtool
-prepare-objtool: $(objtool_target)
+ifdef CONFIG_STACK_VALIDATION
+prepare-objtool: tools/objtool
+endif
 
 # Generate some files
 # ---------------------------------------------------------------------------
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 54da4b0..e9dabe4 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -233,7 +233,6 @@ endif # CC_USING_RECORD_MCOUNT
 endif # CONFIG_FTRACE_MCOUNT_RECORD
 
 ifdef CONFIG_STACK_VALIDATION
-ifneq ($(SKIP_STACK_VALIDATION),1)
 
 __objtool_obj := $(objtree)/tools/objtool/objtool
 
@@ -270,7 +269,6 @@ objtool_obj = $(if $(patsubst y%,, \
 	$(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n), \
 	$(__objtool_obj))
 
-endif # SKIP_STACK_VALIDATION
 endif # CONFIG_STACK_VALIDATION
 
 # Rebuild all objects when objtool changes, or is enabled/disabled.
diff --git a/scripts/Makefile.toolcheck b/scripts/Makefile.toolcheck
index f3c165d..bc26fc0 100644
--- a/scripts/Makefile.toolcheck
+++ b/scripts/Makefile.toolcheck
@@ -12,6 +12,11 @@ include include/config/auto.conf
 __toolcheck:
 	@:
 
+chk_stack_validation = echo "int main() {}" | $(HOSTCC) -xc -o /dev/null -lelf -
+msg_stack_validation = "libelf is necessary for building the objtool." \
+		       "Please install libelf-dev, libelf-devel or elfutils-libelf-devel."
+toolcheck-$(CONFIG_STACK_VALIDATION) += stack_validation
+
 PHONY += $(toolcheck-y)
 __toolcheck: $(toolcheck-y)
 
-- 
2.7.4

