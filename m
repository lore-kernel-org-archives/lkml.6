Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8743EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284E7208F7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="e28hnICl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284E7208F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbeHXCwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 22:52:49 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:53324 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbeHXCwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 22:52:49 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w7NNKenU013265;
        Fri, 24 Aug 2018 08:20:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w7NNKenU013265
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535066441;
        bh=3iWWddn5RngUSQ5ZqlvQcN+Ijg9OJuMFOeb8XxVzA1A=;
        h=From:To:Cc:Subject:Date:From;
        b=e28hnIClPhQtsFVs9bzqv+cD7W+VHsHOdIyGXMCVVhTIU0Zpom8HXK2y9lWokMma4
         JdJCfVrOQ3Ybpa74idX7ficABKdbwGdX8Q/mBxHXe3yZ8uRqUekx8xVEMKnOYXGiPq
         k/37+HD8+3ah6oJ6PvL3+Fk7HlXV8vQ3+scLD/K/HudPWyV5bhLcpvjEwMmQd9dfAQ
         9BUi58E51EbZs8/o/80+hOjdU1eXKuvsZqbO98gkYK/RAh8hnMhyCn7gvv+h4eBLM3
         t4pIewwej5ucyJlvi521j2uClD2K4PJouPQW4cTcgzoHkqExyVevmoh6Rq3MUCmCsA
         wl/tXEjXjo9Jg==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 1/2] kbuild: pass LDFLAGS to recordmcount.pl
Date:   Fri, 24 Aug 2018 08:20:38 +0900
Message-Id: <1535066439-11259-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0fbe9a245c60 ("microblaze: add endianness options to
LDFLAGS instead of LD"), you cannot build the kernel for microblaze
with CONFIG_DYNAMIC_FTRACE.

Fixes: 0fbe9a245c60 ("microblaze: add endianness options to LDFLAGS instead of LD")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3:
  - New patch

Changes in v2: None

 scripts/Makefile.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 93b8e24..f5d7612 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -220,7 +220,7 @@ sub_cmd_record_mcount = set -e ; perl $(srctree)/scripts/recordmcount.pl "$(ARCH
 	"$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
 	"$(if $(CONFIG_64BIT),64,32)" \
 	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CFLAGS)" \
-	"$(LD)" "$(NM)" "$(RM)" "$(MV)" \
+	"$(LD) $(LDFLAGS)" "$(NM)" "$(RM)" "$(MV)" \
 	"$(if $(part-of-module),1,0)" "$(@)";
 recordmcount_source := $(srctree)/scripts/recordmcount.pl
 endif # BUILD_C_RECORDMCOUNT
-- 
2.7.4

