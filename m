Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A234FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101EF24095
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="h3nowq4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101EF24095
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932562AbeGFGex (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:34:53 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:41225 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753224AbeGFGev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:34:51 -0400
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w666Y6xF022276;
        Fri, 6 Jul 2018 15:34:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w666Y6xF022276
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530858847;
        bh=7GX18oZJST8/k1SjpZDzbu+MZYATUT0/OJ/lJ3BFPGI=;
        h=From:To:Cc:Subject:Date:From;
        b=h3nowq4Wjomg7PodKdV442Kaw59Z7skRWnfzIsRBt8AztqbapWgdhUrW5zb3WOM0J
         4D5tJ+POu9F9U3wPG1JCgG05VrELH+VJ10K01K5g4vYZg1Is6owpZPRlsh9FMXQXQw
         m5mE/Mp3m/IYWZwj/dVEJTRxZ39cX6IkpXy2usUHIx1u/0/5iLP+ErbCmdaxg2YKKH
         lCfA8Sf8NChpcSQY6cXWbXXQqO+JX0hfY7SKXMMeOl9TunEP+M3RG49uT+/hjJgLm4
         oqUTh6rVPUbGFENUJ198DbRNJ6xWkA40aZ3Nu8nEcl1pzouY+elp1fX8d1cynyI3wH
         6AZ2Pqi6yvEzg==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH] kbuild: add LDFLAGS_KERNEL to pass additional linker flags for vmlinux
Date:   Fri,  6 Jul 2018 15:34:03 +0900
Message-Id: <1530858843-14997-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kbuild provides LDFLAGS_MODULE to allows users to give additional
options for linking modules, but there is no way to append flags for
linking vmlinux.

It is true LDFLAGS_vmlinux specifies the linker options for vmlinux,
but it is only for internal-use.

We have CFLAGS_KERNEL, AFLAGS_KERNEL already, so LDFLAGS_KERNEL is
the same pattern.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Documentation/kbuild/kbuild.txt | 4 ++++
 Makefile                        | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/kbuild/kbuild.txt b/Documentation/kbuild/kbuild.txt
index 6c9c69e..f3a0a47 100644
--- a/Documentation/kbuild/kbuild.txt
+++ b/Documentation/kbuild/kbuild.txt
@@ -46,6 +46,10 @@ CFLAGS_MODULE
 --------------------------------------------------
 Additional module specific options to use for $(CC).
 
+LDFLAGS_KERNEL
+--------------------------------------------------
+Additional options used for $(LD) when linking vmlinux.
+
 LDFLAGS_MODULE
 --------------------------------------------------
 Additional options used for $(LD) when linking modules.
diff --git a/Makefile b/Makefile
index 58bd78b..6f9f4b1 100644
--- a/Makefile
+++ b/Makefile
@@ -848,6 +848,8 @@ ifeq ($(CONFIG_STRIP_ASM_SYMS),y)
 LDFLAGS_vmlinux	+= $(call ld-option, -X,)
 endif
 
+LDFLAGS_vmlinux += $(LDFLAGS_KERNEL)
+
 # insure the checker run with the right endianness
 CHECKFLAGS += $(if $(CONFIG_CPU_BIG_ENDIAN),-mbig-endian,-mlittle-endian)
 
-- 
2.7.4

