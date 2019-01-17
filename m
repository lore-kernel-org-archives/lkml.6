Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F21C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CBD20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="MgsLoJd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfAQKDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:03:37 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:49355 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfAQKDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:03:35 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x0HA38Gr009525;
        Thu, 17 Jan 2019 19:03:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x0HA38Gr009525
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547719389;
        bh=902g5stAYeaTwKaSHNz9A+gKSBiLuWQijr3nV3dwP7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MgsLoJd1U5FBVQDQFfoZt9g7h2takvZTZsPGLHCFhCJHlRmW7z/6sDFsiNI33ziih
         Xhof5XdgjMZaXEXJ4J4yD+ebl6SKTWey9Khz2dVELVb0NF48IoheeFE99b+z8hnBuh
         ybzpYRgATFO8F3+2F7DTjcND4pXAknMAOw7NvRhOrzB4ygjr+dSwYxy+DnwoFqFMDq
         OCXhuWk5fqNsRF2FZX1vl/4DN0KAmAtM57wgNULOCSm5mXIix0zx8Lhb883m0fJFk1
         uAAL6o2c6zdTahJ5iZOZKrs2FhCEtbKq7ggYE/Ik70e8oWgoDdX31//1OP/2/C6y3X
         YjoelzfgE0CiA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] s390: make thin archives not directly depend on *.o.chkbss files
Date:   Thu, 17 Jan 2019 19:02:42 +0900
Message-Id: <1547719364-18849-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547719364-18849-1-git-send-email-yamada.masahiro@socionext.com>
References: <1547719364-18849-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I was refactoring cmd_ar_builtin in scripts/Makefile.build,
I noticed the build breakage of s390.

Some Makefiles of s390 add extra dependencies to built-in.a;
built-in.a depends on timestamp files *.o.chkbss, but $(AR) does
not want to include them into built-in.a.

Insert a phony target 'chkbss' in between so that $(AR) can take
$(filter-out $(PHONY), $^) as input.

While I was here, I refactored Makefile.chkbss a little bit.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---
I want Acked-by from a s390 maintainer so this series can go
into kbuild tree.

Changes in v2:
 - New patch

 arch/s390/boot/Makefile            |  4 ++--
 arch/s390/boot/compressed/Makefile |  4 ++--
 arch/s390/scripts/Makefile.chkbss  | 25 +++++++++++--------------
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
index d5ad724..b4d8a42 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -67,6 +67,6 @@ install: $(CONFIGURE) $(obj)/bzImage
 	sh -x  $(srctree)/$(obj)/install.sh $(KERNELRELEASE) $(obj)/bzImage \
 	      System.map "$(INSTALL_PATH)"
 
-chkbss := $(OBJECTS)
-chkbss-target := $(obj)/startup.a
+chkbss := $(obj-y)
+chkbss-target := startup.a
 include $(srctree)/arch/s390/scripts/Makefile.chkbss
diff --git a/arch/s390/boot/compressed/Makefile b/arch/s390/boot/compressed/Makefile
index b1bdd15..fa529c5 100644
--- a/arch/s390/boot/compressed/Makefile
+++ b/arch/s390/boot/compressed/Makefile
@@ -63,6 +63,6 @@ OBJCOPYFLAGS_piggy.o := -I binary -O elf64-s390 -B s390:64-bit --rename-section
 $(obj)/piggy.o: $(obj)/vmlinux.bin$(suffix-y) FORCE
 	$(call if_changed,objcopy)
 
-chkbss := $(filter-out $(obj)/piggy.o $(obj)/info.o,$(OBJECTS))
-chkbss-target := $(obj)/vmlinux.bin
+chkbss := $(filter-out piggy.o info.o, $(obj-y))
+chkbss-target := vmlinux.bin
 include $(srctree)/arch/s390/scripts/Makefile.chkbss
diff --git a/arch/s390/scripts/Makefile.chkbss b/arch/s390/scripts/Makefile.chkbss
index 9bba2c1..cd7e8f44 100644
--- a/arch/s390/scripts/Makefile.chkbss
+++ b/arch/s390/scripts/Makefile.chkbss
@@ -1,23 +1,20 @@
 # SPDX-License-Identifier: GPL-2.0
 
+chkbss-target ?= built-in.a
+$(obj)/$(chkbss-target): chkbss
+
+chkbss-files := $(addsuffix .chkbss, $(chkbss))
+clean-files += $(chkbss-files)
+
+PHONY += chkbss
+chkbss: $(addprefix $(obj)/, $(chkbss-files))
+
 quiet_cmd_chkbss = CHKBSS  $<
-define cmd_chkbss
-	rm -f $@; \
+      cmd_chkbss = \
 	if ! $(OBJDUMP) -j .bss -w -h $< | awk 'END { if ($$3) exit 1 }'; then \
 		echo "error: $< .bss section is not empty" >&2; exit 1; \
 	fi; \
 	touch $@;
-endef
-
-chkbss-target ?= $(obj)/built-in.a
-ifneq (,$(findstring /,$(chkbss)))
-chkbss-files := $(patsubst %, %.chkbss, $(chkbss))
-else
-chkbss-files := $(patsubst %, $(obj)/%.chkbss, $(chkbss))
-endif
-
-$(chkbss-target): $(chkbss-files)
-targets += $(notdir $(chkbss-files))
 
-%.o.chkbss: %.o
+$(obj)/%.o.chkbss: $(obj)/%.o
 	$(call cmd,chkbss)
-- 
2.7.4

