Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B22C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1456420818
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gogeCQ+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405328AbfBNDGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:06:42 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:64383 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393468AbfBNDGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:06:05 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x1E35Pg4020814;
        Thu, 14 Feb 2019 12:05:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x1E35Pg4020814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550113527;
        bh=qmqFYzrO309vIKYtqQ9mMRdEh6RcNYvW13KnAIs8pHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gogeCQ+aeK2rK/zRoyN4DEr2oaQQkFWJzU1sHYgz8JNh1OEpdRF17PLUQ0EROdROE
         68/9EMAPqH+gcEcLAcLrvGo8YDGs2hEu8dnY7VNZVXSolDGEnMH+DGkSib03Dsw8KA
         LixGtZOySh/1Ya29F+xPK70pPsiPhR0KJnyVJjVN101xAvKRyfbb34mC/KXuTL5tXQ
         EfSW2LsF2T1V1c3kOst+Bgz8+dTo5iARpIx1ZWHBsiKVrWlgOji1TLmJ33Ctd3P2Pp
         XRNBmy0rbkBMcIu9GXuIMaC5wAeP88Qh7OeFNOOvLtI2+Nl79/5laC89j/Ir61c3LX
         Fn3zd9l5sxe0g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] kbuild: set KBUILD_MODULES=1 all the time for single target %/
Date:   Thu, 14 Feb 2019 12:05:16 +0900
Message-Id: <1550113521-23577-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550113521-23577-1-git-send-email-yamada.masahiro@socionext.com>
References: <1550113521-23577-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is fine to set KBUILD_MODULES=1 when CONFIG_MODULES is disabled.
It is actually how "make allnoconfig all" works.

On the other hand, KBUILD_MODULES=1 is unneeded for the %.ko pattern.
It is just a matter of whether modules.order is generated or not.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 3cf253d..fe62de3 100644
--- a/Makefile
+++ b/Makefile
@@ -1710,16 +1710,13 @@ endif
 
 # Modules
 /: prepare FORCE
-	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
-	$(build)=$(build-dir)
+	$(Q)$(MAKE) KBUILD_MODULES=1 $(build)=$(build-dir)
 # Make sure the latest headers are built for Documentation
 Documentation/ samples/: headers_install
 %/: prepare FORCE
-	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
-	$(build)=$(build-dir)
+	$(Q)$(MAKE) KBUILD_MODULES=1 $(build)=$(build-dir)
 %.ko: prepare FORCE
-	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1)   \
-	$(build)=$(build-dir) $(@:.ko=.o)
+	$(Q)$(MAKE) $(build)=$(build-dir) $(@:.ko=.o)
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
 
 # FIXME Should go into a make.lib or something
-- 
2.7.4

