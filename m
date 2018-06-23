Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58CFC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 13:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFF224C1B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 13:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1Iaqp/EV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFF224C1B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbeFWN6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 09:58:18 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:44605 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbeFWN6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 09:58:13 -0400
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w5NDvYBU015690;
        Sat, 23 Jun 2018 22:57:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w5NDvYBU015690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529762255;
        bh=v6NARSvF1UqBTvB6pr8gmxA1bLYv2eXXGO7gcMxQNZ0=;
        h=From:To:Cc:Subject:Date:From;
        b=1Iaqp/EVhNjHBgpUr4UWufcGiyqjvj7AuPsqZOYTZVQmx41NulFOS/LwfKjEaHgun
         wV2rNuDFF7Pa86FFiNwtL34vDqEVrdwj1wOLyG9B+Q/mgI/Mg86hibtvQlgzQd6BVp
         8BB9erTO71djodbIx3IlcIzSAZX03MnexbcMzpGn1UigpTaJ9oPPRU28mGRj7Kv/36
         DAJRSMMV0vKdu2uHnGH8qrw9R71aAaAOxPUKuKNuZEA4OD3bh8nUX/igFHiMibDM5D
         cTnGzRpMVlvrs3xGT534uES8xIqlyhhV+ndeItVgTiUuPmCDLWMyGIQDustn1HX6+j
         SfNh+Wvo6tPlA==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] kbuild: use 'include' directive to load auto.conf from top Makefile
Date:   Sat, 23 Jun 2018 22:56:07 +0900
Message-Id: <1529762169-13488-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When you build targets that require the kernel configuration, dot-config
is set to 1, then the top-level Makefile includes auto.conf.  However,
Make considers its inclusion is optional because the '-include' directive
is used.

If a necessary configuration file is missing for the external module
building, the following error message is displayed:

  ERROR: Kernel configuration is invalid.
         include/generated/autoconf.h or include/config/auto.conf are missing.
         Run 'make oldconfig && make prepare' on kernel src to fix it.

However, Make still continues building; /bin/false let the creation of
'include/config/auto.config' fail, but Make can ignore the error since
it is included by the '-include' directive.

Use the 'include' directive instead.  This allows the /bin/false
to correctly terminate the whole build process.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - New patch

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index ca2af1a..413c2ed 100644
--- a/Makefile
+++ b/Makefile
@@ -589,7 +589,7 @@ virt-y		:= virt/
 endif # KBUILD_EXTMOD
 
 ifeq ($(dot-config),1)
--include include/config/auto.conf
+include include/config/auto.conf
 endif
 
 # The all: target is the default when no target is given on the
-- 
2.7.4

