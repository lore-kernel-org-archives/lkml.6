Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E9EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353DA2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="oDBbG5lr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfBVHkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 02:40:22 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:53328 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfBVHkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 02:40:22 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x1M7eEN0013122;
        Fri, 22 Feb 2019 16:40:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x1M7eEN0013122
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550821214;
        bh=DQ+BN3fwZB03g2y4k35iROrRq0d7oQO8BBS0JgSdlB0=;
        h=From:To:Cc:Subject:Date:From;
        b=oDBbG5lrr/abbSDWjIP9610qGqd5cIRV7P8tuLxOrYoqsXVBmgGqJLO293TFf8uWr
         OTlkUAW2LXdMy5iqu7Fsd2tBfGB8s0kNYZ2IE78y1HrtteOLLE9H7gypV/3jduILhN
         1DVpkBa3+eU4pM+oLBx7M3WvnjdFWdsKQxrhywOut8I5//SUzKbjCJOkwflAuCDQm3
         u/JUAAW6xywYA50BXNolHXbCNqH6Erkpf7GJninlo1jUqlPnzMuhRLK8HQuSsX05BQ
         OCYyB6Qjp6k+5gRCcLd/yOpmID38SeJ7yp6klTbt9Q1iF4k3Pe+GLuoW9ChbiRBOdH
         /VKS1mIQsIJIw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] kbuild: move tools_silent to a more relevant place
Date:   Fri, 22 Feb 2019 16:40:06 +0900
Message-Id: <1550821211-30324-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This would disturb the change the sub-make part. Move it near the
tools/ target.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index bf4e77b..82091b8 100644
--- a/Makefile
+++ b/Makefile
@@ -90,7 +90,6 @@ endif
 
 ifneq ($(findstring s,$(filter-out --%,$(MAKEFLAGS))),)
   quiet=silent_
-  tools_silent=s
 endif
 
 export quiet Q KBUILD_VERBOSE
@@ -1678,6 +1677,11 @@ image_name:
 	@echo $(KBUILD_IMAGE)
 
 # Clear a bunch of variables before executing the submake
+
+ifeq ($(quiet),silent_)
+tools_silent=s
+endif
+
 tools/: FORCE
 	$(Q)mkdir -p $(objtree)/tools
 	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(tools_silent) $(filter --j% -j,$(MAKEFLAGS))" O=$(abspath $(objtree)) subdir=tools -C $(src)/tools/
-- 
2.7.4

