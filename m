Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283EDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93812086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jL+0VfmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfARIRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:17:03 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:23399 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbfARIRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:17:02 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x0I8Gvkf027563;
        Fri, 18 Jan 2019 17:16:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x0I8Gvkf027563
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547799418;
        bh=Fn9NCCeBsEzUwoyGuZ00xfmK9ZjqHUvhAUj1QG8J3EU=;
        h=From:To:Cc:Subject:Date:From;
        b=jL+0VfmLMhbqpqH4Kv5U6eydUUMR9lean+qZ1JiM5bTyk7AndGANXbR0iR7dTcYdc
         i/3wJNf2JtCKZqoPs3NViXdoHV6bUmz7VGiJSXPp+hvUCRKsNSgitMwW+SbNNq/iLd
         GtEwazqNZYE7YW7eilc2Kz0v9EqCyo8QLulSvox/ovUE0qU9aW+Smk6P4n2+O6Ocet
         U70c5jTyd+Db6NGX3+6CX0aWD5a+Ay67q67k+iza4g7QCr7ZHP4b1pOh0r/XdSs2Fa
         5W4hCLZOascqRxNHRUjC2TzaNTvT0zL7cr5KjqLWlAR8Lz5PVaPk9xn0Lz7RiQclIt
         i1Bz3CBK/a5eA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: descend to scripts/kconfig/ directly when syncconfig is needed
Date:   Fri, 18 Jan 2019 17:16:52 +0900
Message-Id: <1547799412-20120-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recursion of the top Makefile is inefficient.
Just descend to scripts/kconfig/.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9851a44..d5f0ac4 100644
--- a/Makefile
+++ b/Makefile
@@ -631,7 +631,7 @@ $(KCONFIG_CONFIG) include/config/auto.conf.cmd: ;
 # include/generated/ and include/config/. Update them if .config is newer than
 # include/config/auto.conf (which mirrors .config).
 include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
-	$(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
+	$(Q)$(MAKE) $(build)=scripts/kconfig syncconfig
 else
 # External modules and some install targets need include/generated/autoconf.h
 # and include/config/auto.conf but do not care if they are up-to-date.
-- 
2.7.4

