Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400D0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EFA221904
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="U2L+ckxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfBSJdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:33:37 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:52939 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfBSJdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:33:35 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x1J9XBkO002572;
        Tue, 19 Feb 2019 18:33:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x1J9XBkO002572
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550568794;
        bh=6wrERf29hesZXgquMmrDWBzvVksZP5BU5OXJ1r+sURQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U2L+ckxPzqR3/OKKx4x8xdvNNP0cs6m2bw/kKVa2BlY57bgG4qKLLa+cmOplneZAr
         bXv25/29kCDxo1dANx4lQJqloag4X0haUF3BAM/ZnEk9dRR5thhbHvJyUCCmWWX5s3
         zFYkNXZJXMfBGO1ONrNq6QCmvL2imiBAZZR0gsKYmTmRuJPWz0OE4QFIsg2RoqPnzK
         8x0QzJ9ooPaHLLS+/08WQAn3NYzd+lJSfjS4PiXN9Aj5CC8ShgYiEZDZ0+TyTX+uG+
         IUEkI+TibQhR/mvemANw9KJWokorKgyy+eTV9uks8WYi6ZhKsWAyoaASAxghlAQzg/
         KFOUidpbpdfJQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Kieran Bingham <kbingham@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] scripts/gdb: refactor rules for symlink creation
Date:   Tue, 19 Feb 2019 18:33:06 +0900
Message-Id: <1550568787-18710-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550568787-18710-1-git-send-email-yamada.masahiro@socionext.com>
References: <1550568787-18710-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gdb-scripts is not a real object, but (ab)used like a phony target.

Rewrite the code in a more Kbuild-ish way. Add symlinks to extra-y
and use if_changed.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/gdb/linux/Makefile | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/scripts/gdb/linux/Makefile b/scripts/gdb/linux/Makefile
index 7545806..3df395a 100644
--- a/scripts/gdb/linux/Makefile
+++ b/scripts/gdb/linux/Makefile
@@ -1,13 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0
-always := gdb-scripts
 
-SRCTREE := $(abspath $(srctree))
-
-$(obj)/gdb-scripts:
 ifneq ($(KBUILD_SRC),)
-	$(Q)ln -fsn $(SRCTREE)/$(obj)/*.py $(objtree)/$(obj)
+
+symlinks := $(patsubst $(srctree)/$(src)/%,%,$(wildcard $(srctree)/$(src)/*.py))
+
+quiet_cmd_symlink = SYMLINK $@
+      cmd_symlink = ln -fsn $(patsubst $(obj)/%,$(abspath $(srctree))/$(src)/%,$@) $@
+
+extra-y += $(symlinks)
+$(addprefix $(obj)/, $(symlinks)): FORCE
+	$(call if_changed,symlink)
+
 endif
-	@:
 
 quiet_cmd_gen_constants_py = GEN     $@
       cmd_gen_constants_py = \
@@ -18,4 +22,4 @@ extra-y += constants.py
 $(obj)/constants.py: $(src)/constants.py.in FORCE
 	$(call if_changed_dep,gen_constants_py)
 
-clean-files := *.pyc *.pyo $(if $(KBUILD_SRC),*.py)
+clean-files := *.pyc *.pyo
-- 
2.7.4

