Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4B4C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915B3208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="JVTi2EUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 915B3208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbeLGLei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:34:38 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:45833 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbeLGLeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 06:34:36 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wB7BY6re020070;
        Fri, 7 Dec 2018 20:34:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wB7BY6re020070
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544182448;
        bh=ivFgaDo0g7XPKa5r9gRej5aUPRGIiJLbRoRae7zdj6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JVTi2EUa+qQue5dSdxR0r6bNknXhq2MlEsinLwfDvJ72mot/DsKSAbEO14SxiH3Lx
         ADkhrCV0faPuAZNywAsznOP1vdIZwXLA+ku51bM4iXhAx6zBu2RosaQH5X7ZaFxI2e
         H3gMjpPQSjLjgQFFZAnctl5iTCcygCnkTpCnKa4oAzL9PZRAT/4CXoy/As2yGkfbUd
         PohOr0x3UoiSeJBIwxMNFGmNhMEYgv+PE/ZJ9A5C5Mlskwe8hmLWw2PoA+aMYXnWCx
         AM+oNObRrgCrbq8idw8p5wiKs+w4tplIgwOdZsZ8vvGsjSOYqmJ5m9k6/7bvg3aAL5
         Q/1jFzEe5x4Lg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Michal Simek <monstr@monstr.eu>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] microblaze: fix multiple bugs in arch/microblaze/boot/Makefile
Date:   Fri,  7 Dec 2018 20:33:54 +0900
Message-Id: <1544182437-26660-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544182437-26660-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544182437-26660-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes some build issues.

The first issue is the breakage of linux.bin.ub target since commit
ece97f3a5fb5 ("microblaze: Fix simpleImage format generation")
because the addition of UIMAGE_{IN,OUT} affected it.

make ARCH=microblaze CROSS_COMPILE=microblaze-linux- linux.bin.ub
  [ snip ]
  OBJCOPY arch/microblaze/boot/linux.bin
  UIMAGE  arch/microblaze/boot/linux.bin.ub.ub
/usr/bin/mkimage: Can't open arch/microblaze/boot/linux.bin.ub: No such file or directory
make[1]: *** [arch/microblaze/boot/Makefile;14: arch/microblaze/boot/linux.bin.ub] Error 1
make: *** [arch/microblaze/Makefile;83: linux.bin.ub] Error 2

The second issue is the use of the "if_changed" multiple times for
the same target.

As commit 92a4728608a8 ("x86/boot: Fix if_changed build flip/flop bug")
pointed out, this never works properly. Moreover, generating multiple
images as a side-effect is confusing.

Let's split the build recipe for each image.

simpleImage.<dt>*.unstrip is just a copy of vmlinux.

simpleImage.<dt> and simpleImage.<dt>.ub are created in the same way
as linux.bin and linux.bin.ub, respectively.

I kept simpleImage.* recipes independent of linux.bin.* ones to not
change the behavior.

Lastly, this commit fixes "make ARCH=microblaze clean". Previously,
it only cleaned up the unstrip image. Now, all the simpleImage files
are cleaned.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Squash the first patch into this
  - Separate simpleImage recipes from linux.bin* recipes

 arch/microblaze/Makefile      |  2 +-
 arch/microblaze/boot/Makefile | 19 +++++++++----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
index 6cee1ca..ff5abbd 100644
--- a/arch/microblaze/Makefile
+++ b/arch/microblaze/Makefile
@@ -87,7 +87,7 @@ linux.bin linux.bin.gz linux.bin.ub: vmlinux
 	@echo 'Kernel: $(boot)/$@ is ready' ' (#'`cat .version`')'
 
 simpleImage.%: vmlinux
-	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
+	$(Q)$(MAKE) $(build)=$(boot) $(addprefix $(boot)/$@., ub unstrip strip)
 	@echo 'Kernel: $(boot)/$@ is ready' ' (#'`cat .version`')'
 
 define archhelp
diff --git a/arch/microblaze/boot/Makefile b/arch/microblaze/boot/Makefile
index 96eefdc..cff570a 100644
--- a/arch/microblaze/boot/Makefile
+++ b/arch/microblaze/boot/Makefile
@@ -3,7 +3,7 @@
 # arch/microblaze/boot/Makefile
 #
 
-targets := linux.bin linux.bin.gz linux.bin.ub simpleImage.%
+targets := linux.bin linux.bin.gz linux.bin.ub simpleImage.*
 
 OBJCOPYFLAGS := -R .note -R .comment -R .note.gnu.build-id -O binary
 
@@ -16,21 +16,20 @@ $(obj)/linux.bin.ub: $(obj)/linux.bin FORCE
 $(obj)/linux.bin.gz: $(obj)/linux.bin FORCE
 	$(call if_changed,gzip)
 
-quiet_cmd_cp = CP      $< $@$2
-	cmd_cp = cat $< >$@$2 || (rm -f $@ && echo false)
-
 quiet_cmd_strip = STRIP   $< $@$2
 	cmd_strip = $(STRIP) -K microblaze_start -K _end -K __log_buf \
 				-K _fdt_start $< -o $@$2
 
 UIMAGE_LOADADDR = $(CONFIG_KERNEL_BASE_ADDR)
-UIMAGE_IN = $@
-UIMAGE_OUT = $@.ub
 
-$(obj)/simpleImage.%: vmlinux FORCE
-	$(call if_changed,cp,.unstrip)
+$(obj)/simpleImage.$(DTB): vmlinux FORCE
 	$(call if_changed,objcopy)
+
+$(obj)/simpleImage.$(DTB).ub: $(obj)/simpleImage.$(DTB) FORCE
 	$(call if_changed,uimage)
-	$(call if_changed,strip,.strip)
 
-clean-files += simpleImage.*.unstrip linux.bin.ub
+$(obj)/simpleImage.$(DTB).unstrip: vmlinux FORCE
+	$(call if_changed,shipped)
+
+$(obj)/simpleImage.$(DTB).strip: vmlinux FORCE
+	$(call if_changed,strip)
-- 
2.7.4

