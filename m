Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F88C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1D32080C
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="OzRsh/ul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1D32080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbeKTLeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:34:04 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:35780 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730331AbeKTLeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:34:04 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wAK15ZEZ029284;
        Tue, 20 Nov 2018 10:05:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wAK15ZEZ029284
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542675938;
        bh=DcxqWVdkNj8Wczcg0ZI9J/L3Bu3CGzT+kUES+YoZcV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OzRsh/ul2gyDxuvbaiLE3LBQCzuMN9rhUWJPoqZjLflNzxslwOrwcooVaeifMwafZ
         wMJcq8pvGcyoGJlhSzd3Y54962UH0HCPWi59g3SLPC9gRetb3YhEycCFrb0nwje8UU
         DqcPA6pnLV7kCaS9Oic0xx20ZEVor0iStDCYo6UF9aQZwE4IZ0CzxCzyYLM8guvm+Y
         H+7TcacU1jiGwU6OsQF+ZXoDo/Pb2+i16p4XypHTb7NUlSOVic7nQNVXkXUxRBJkXF
         0LfviB/MKeaB/T4qojoqXfMaD7OtHsPGecvgk5e25WCVRlkBX6zWIfMto0V5xy0oaw
         42tOTGGxv+e2A==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>
Subject: [PATCH v2 2/9] kbuild: remove redundant 'set -e' from filechk_* defines
Date:   Tue, 20 Nov 2018 10:05:23 +0900
Message-Id: <1542675930-21114-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542675930-21114-1-git-send-email-yamada.masahiro@socionext.com>
References: <1542675930-21114-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The filechk macro in scripts/Kbuild.include already sets 'set -e'.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 arch/um/Makefile     | 2 +-
 scripts/Makefile.lib | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index ab1066c..71ff3d0 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -152,7 +152,7 @@ $(HOST_DIR)/um/user-offsets.s: __headers FORCE
 	$(Q)$(MAKE) $(build)=$(HOST_DIR)/um $@
 
 define filechk_gen-asm-offsets
-        (set -e; \
+        ( \
          echo "/*"; \
          echo " * DO NOT MODIFY."; \
          echo " *"; \
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 8fe4468..ae3ae97 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -406,7 +406,7 @@ endef
 # Use filechk to avoid rebuilds when a header changes, but the resulting file
 # does not
 define filechk_offsets
-	(set -e; \
+	( \
 	 echo "#ifndef $2"; \
 	 echo "#define $2"; \
 	 echo "/*"; \
-- 
2.7.4

