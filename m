Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0563DC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FAED2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="2J5LnYnC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FAED2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeJDLQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 07:16:51 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:34180 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbeJDLQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 07:16:50 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w944PPWW030457;
        Thu, 4 Oct 2018 13:25:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w944PPWW030457
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538627125;
        bh=Tu5EgNC+a2nzWof8zRD+kOXG3bSs+w0fmQrPdRjIFSc=;
        h=From:To:Cc:Subject:Date:From;
        b=2J5LnYnCNn9twb2YKBZBKOdTiyNCFuYko3MqdQGx2C2mOZG9HVcUFgHtmFZCyrdnK
         FuU7SCNQQMjCj0YAYCv+H6X9JIS/YZm5mLLR3pLuJVYt9aTD5y5T4TdPsuMEzsuLqW
         wrqoFd+ooiiUXL8jjZgfUFo443As0XECdZ1DMQXelW9zn/yMQV3vvjWynaRVNHo2mj
         AnIPLhUhtP0Xm19UTJ0gHuokiurfwN+uKEcYdhqlBu6Z2twFdNqRQYGuBl8er8QZFR
         81URaqcrJwoHQj/6dZ6bAvKzAel4YqQ9FAbbMgeGOeltIPZycyTvPu1BUr50buIe9K
         /gDFIw4McozRw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kbuild: remove unneeded link_multi_deps
Date:   Thu,  4 Oct 2018 13:25:19 +0900
Message-Id: <1538627119-11346-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit c8589d1e9e01 ("kbuild: handle multi-objs dependency
appropriately"), $^ really represents all the prerequisite of the
composite object being built.

Hence, $(filter %.o,$^) contains all the objects to link together,
which is much simpler than link_multi_deps calculation.

Please note $(filter-out FORCE,$^) does not work here.  When a
single object module is turned into a multi object module, $^ will
contain header files that were previously included for building the
single object, and recorded in the .*.cmd file.  $(filter %.o,$^)
should be used to filter out such headers.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Fix regression reported in linux-next.
    https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1779047.html

 scripts/Makefile.build | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index cb03774..f21b48d 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -485,28 +485,12 @@ targets += $(obj)/lib-ksyms.o
 
 endif
 
-#
-# Rule to link composite objects
-#
-#  Composite objects are specified in kbuild makefile as follows:
-#    <composite-object>-objs := <list of .o files>
-#  or
-#    <composite-object>-y    := <list of .o files>
-#  or
-#    <composite-object>-m    := <list of .o files>
-#  The -m syntax only works if <composite object> is a module
-link_multi_deps =                     \
-$(filter $(addprefix $(obj)/,         \
-$($(subst $(obj)/,,$(@:.o=-objs)))    \
-$($(subst $(obj)/,,$(@:.o=-y)))       \
-$($(subst $(obj)/,,$(@:.o=-m)))), $^)
-
 quiet_cmd_link_multi-m = LD [M]  $@
-cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(link_multi_deps) $(cmd_secanalysis)
+cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(filter %.o,$^) $(cmd_secanalysis)
 
 $(multi-used-m): FORCE
 	$(call if_changed,link_multi-m)
-	@{ echo $(@:.o=.ko); echo $(link_multi_deps); \
+	@{ echo $(@:.o=.ko); echo $(filter %.o,$^); \
 	   $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod)
 $(call multi_depend, $(multi-used-m), .o, -objs -y -m)
 
-- 
2.7.4

