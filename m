Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5E2C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 07:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09722080A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 07:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Zn038/3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfBEHd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 02:33:57 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:32747 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfBEHd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 02:33:56 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x157XeZ3021016;
        Tue, 5 Feb 2019 16:33:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x157XeZ3021016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549352021;
        bh=bsp0oZDCWMj5clsmjWUwXR/WzLE4a8svWWlCVYi63uA=;
        h=From:To:Cc:Subject:Date:From;
        b=Zn038/3JI1UlCCg9lx0j6MqK7kdx3ZjlASJG2vIW3UkwqFThmBq7ptjlzeeUchTAS
         mcrbWSSAUkA2Xb8A5Zuo/+A7aLWDFGHwKvD0vmjFCYXKgmwQq57XaqpVseVHnNHu7H
         LtgGInGpPuhP6aCkljeGDAQMKOBR8oId9YOmKs5GaXLJx9mdG8sUINpiJ/hHpDf/9R
         dMdBUMfpF7/YPu3Uqz1h5wfkEfeKD7KVoHEPg8eE632zWjcAv/bNnYWfLowaE9UFZV
         3EWi3JJ8TUeewROkWybs+c+RNAxN+NnDfXKp/YQK9CkVGmRNOKBsY01cHKUXbwYsI5
         Gp6NHg+KM1QHg==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH] kbuild: move archive command to scripts/Makefile.lib
Date:   Tue,  5 Feb 2019 16:33:37 +0900
Message-Id: <1549352017-3503-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/Makefile.build and arch/s390/boot/Makefile use the same
command (thin archiving with symbol table creation).

Avoid the code duplication, and move it to scripts/Makefile.lib.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/s390/boot/Makefile | 3 ---
 scripts/Makefile.build  | 6 +-----
 scripts/Makefile.lib    | 6 ++++++
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
index 11ca879..c844eaf 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -57,9 +57,6 @@ $(obj)/section_cmp%: vmlinux $(obj)/compressed/vmlinux FORCE
 $(obj)/compressed/vmlinux: $(obj)/startup.a FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/compressed $@
 
-quiet_cmd_ar = AR      $@
-      cmd_ar = rm -f $@; $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
-
 $(obj)/startup.a: $(OBJECTS) FORCE
 	$(call if_changed,ar)
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index f8e2794..99be01c 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -424,13 +424,9 @@ $(modorder-target): $(subdir-ym) FORCE
 # Rule to compile a set of .o files into one .a file (with symbol table)
 #
 ifdef lib-target
-quiet_cmd_link_l_target = AR      $@
-
-# lib target archives do get a symbol table and index
-cmd_link_l_target = rm -f $@; $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
 
 $(lib-target): $(lib-y) FORCE
-	$(call if_changed,link_l_target)
+	$(call if_changed,ar)
 
 targets += $(lib-target)
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index c0abd9a..8a1f64f 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -233,6 +233,12 @@ $(obj)/%: $(src)/%_shipped
 quiet_cmd_ld = LD      $@
       cmd_ld = $(LD) $(ld_flags) $(real-prereqs) -o $@
 
+# Archive
+# ---------------------------------------------------------------------------
+
+quiet_cmd_ar = AR      $@
+      cmd_ar = rm -f $@; $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
+
 # Objcopy
 # ---------------------------------------------------------------------------
 
-- 
2.7.4

