Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D91C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CAA21738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="NBtDSjoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfBSJdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:33:25 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:52670 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfBSJdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:33:25 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x1J9XBkN002572;
        Tue, 19 Feb 2019 18:33:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x1J9XBkN002572
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550568793;
        bh=7gGXpYHokVbBLif6nFDQjQ8PsczV06ea6Pz4i46Teys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NBtDSjoaKI9YCnanZOAMfXNl7l+Krp0LfVGtm2Nx1oIoWIy83i0AA+zYPonFcriDR
         wqemtThqdUEfaUHh4RG7mxtORkPOI7GfBL13sgTAVNobW0hVSjOor8AYo4jpP0ktq4
         zin/vnfEuEhsz034eFCYk6anhtQ+UsVmIkwrpqppIYrvjhGZ+iVUK/79ifzoa2zKHn
         fkS2Jd6NLFKvQc133jTVulKaee5ltE1wXgFQ/TaynGI9klzbdBRRlwmLGxsra8UHO4
         4Q8cVCkFx3s6bP5KxduKezmIPR51qe021OZEugZoFHe55fUnijzJEdhpifhUe92Due
         wmHqbJXU608Pg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Kieran Bingham <kbingham@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] kbuild: create symlink to vmlinux-gdb.py in scripts_gdb target
Date:   Tue, 19 Feb 2019 18:33:05 +0900
Message-Id: <1550568787-18710-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550568787-18710-1-git-send-email-yamada.masahiro@socionext.com>
References: <1550568787-18710-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is weird to create gdb stuff as a side-effect of vmlinux.

Move it to a more relevant place.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index a5762c6..0459260 100644
--- a/Makefile
+++ b/Makefile
@@ -1015,9 +1015,6 @@ cmd_link-vmlinux =                                                 \
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 
 vmlinux: scripts/link-vmlinux.sh autoksyms_recursive $(vmlinux-deps) FORCE
-ifdef CONFIG_GDB_SCRIPTS
-	$(Q)ln -fsn $(abspath $(srctree)/scripts/gdb/vmlinux-gdb.py)
-endif
 	+$(call if_changed,link-vmlinux)
 
 targets := vmlinux
@@ -1519,6 +1516,7 @@ $(DOC_TARGETS): scripts_basic FORCE
 PHONY += scripts_gdb
 scripts_gdb: prepare
 	$(Q)$(MAKE) $(build)=scripts/gdb
+	$(Q)ln -fsn $(abspath $(srctree)/scripts/gdb/vmlinux-gdb.py)
 
 ifdef CONFIG_GDB_SCRIPTS
 all: scripts_gdb
-- 
2.7.4

