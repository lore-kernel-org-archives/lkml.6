Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7809ECE566
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7180120858
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="d1v74CtG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7180120858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbeIROR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:17:59 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:55700 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbeIROR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:17:58 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w8I8juLR029470;
        Tue, 18 Sep 2018 17:45:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w8I8juLR029470
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1537260358;
        bh=tpqAk1tRE54kXw4Ec4Ttm2Zhd5ozu9gJ+O1B/hU+QsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d1v74CtGFJeP8/UF4eD0/R2oSHnqUjcF4Pie6pqXlkd+Miklc21KED7QxDnLDbTfI
         P17FFsc/2b79Xah38ch6HKRfPlV69bOrl0x9g0a6CD4hvjjC+cKKIsZC3yffxMpLJz
         D1KU//qJXk8/X3mEDh8aasYKC9CEndZavCiU1HxgFbBKPFGh9/oBiPYIVVYPR1uIHL
         Ltm9kBsMwQON2KKOm5+qu0OgM4qgQY3gjwvsG7m9YsnLgXOZ0NdFAvQVJR20Uexd2n
         7Nra9iWsCT97AhMyJJyJ9cfjUJzfJztVPJcKJ5NX4LjcfoqBrk8WFBV+HXFaBfd3e7
         VwnfA/4sFZ75w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] kbuild: remove user ID check in scripts/mkmakefile
Date:   Tue, 18 Sep 2018 17:45:52 +0900
Message-Id: <1537260354-30082-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537260354-30082-1-git-send-email-yamada.masahiro@socionext.com>
References: <1537260354-30082-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This line was added by commit fd5f0cd6b0ce ("kbuild: Do not overwrite
makefile as anohter user").  Its commit description says the intention
was to prevent $(objtree)/Makefile from being owned by root when e.g.
running 'make install'.

However, as commit 19514fc665ff ("arm, kbuild: make "make install" not
depend on vmlinux") stated, installation targets must not modify the
source tree in the first place.  If they do, we are already screwed up.
We must fix the root cause.

Installation targets should just copy files verbatim, hence we never
expect $(objtree)/Makefile is touched by root.  The user ID check in
scripts/mkmakefile is unneeded.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/mkmakefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/mkmakefile b/scripts/mkmakefile
index e2106444..2435428 100755
--- a/scripts/mkmakefile
+++ b/scripts/mkmakefile
@@ -8,7 +8,6 @@
 # $1 - Kernel src directory
 # $2 - Output directory
 
-test ! -r $2/Makefile -o -O $2/Makefile || exit 0
 # Only overwrite automatically generated Makefiles
 # (so we do not overwrite kernel Makefile)
 if test -e $2/Makefile && ! grep -q Automatically $2/Makefile
-- 
2.7.4

