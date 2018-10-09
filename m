Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F20C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F69A213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="BOLhU9/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F69A213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbeJIWXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:23:17 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:38211 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbeJIWXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:23:17 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w99F5fpm002181;
        Wed, 10 Oct 2018 00:05:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w99F5fpm002181
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539097542;
        bh=cKq9pBsUaG08Aurz84EMNuwZ5UKcOcz3K/IVYI+bKjk=;
        h=From:To:Cc:Subject:Date:From;
        b=BOLhU9/w+47SvgYdtJhr2zVqKQKCT9YjIfFxz7sRA4nFqrV00kmL1iV/yYqYDoIyw
         t4FDaQcZchX4sAhAS3Z/7Va6HyDNmLE7IcgK9EmYZ9+kZH3w2tDTbrkjH+nBbT0WdU
         sJjsNExAycCDTUgH35c/5/00KowOVHVQ85T95thGEBvJ7ajhMRAT/kU8x689GyfAAM
         cyOGuVtM7FRNHZeq3cjOEI6AiLEtxsM+V/8XRn+FhxX5JWrN+XmVigRgFQLl5FjtFZ
         FYt/Dws3nQkjWOtsxfkDrII8Obd0muCIWCwWIYaN6XoRj0CoTOjGg+Klx3wFGo37Pg
         23w4rH0TyPgWw==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: use 'else ifeq' for checksrc to improve readability
Date:   Wed, 10 Oct 2018 00:05:39 +0900
Message-Id: <1539097539-26985-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'ifeq ... else ifeq ... endif' notation is supported by GNU Make 3.81
or later, which is the requirement for building the kernel since
commit 37d69ee30808 ("docs: bump minimal GNU Make version to 3.81").

Use it to improve the readability.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.build | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index f21b48d..7d884d8 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -73,14 +73,12 @@ __build: $(if $(KBUILD_BUILTIN),$(builtin-target) $(lib-target) $(extra-y)) \
 	@:
 
 # Linus' kernel sanity checking tool
-ifneq ($(KBUILD_CHECKSRC),0)
-  ifeq ($(KBUILD_CHECKSRC),2)
-    quiet_cmd_force_checksrc = CHECK   $<
-          cmd_force_checksrc = $(CHECK) $(CHECKFLAGS) $(c_flags) $< ;
-  else
-      quiet_cmd_checksrc     = CHECK   $<
-            cmd_checksrc     = $(CHECK) $(CHECKFLAGS) $(c_flags) $< ;
-  endif
+ifeq ($(KBUILD_CHECKSRC),1)
+  quiet_cmd_checksrc       = CHECK   $<
+        cmd_checksrc       = $(CHECK) $(CHECKFLAGS) $(c_flags) $< ;
+else ifeq ($(KBUILD_CHECKSRC),2)
+  quiet_cmd_force_checksrc = CHECK   $<
+        cmd_force_checksrc = $(CHECK) $(CHECKFLAGS) $(c_flags) $< ;
 endif
 
 ifneq ($(KBUILD_ENABLE_EXTRA_GCC_CHECKS),)
-- 
2.7.4

