Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B131BC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC3B2173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="pmbh2Mb6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BC3B2173D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbeI1MpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 08:45:25 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:60507 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeI1MpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 08:45:25 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w8S6MQEh031614;
        Fri, 28 Sep 2018 15:22:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w8S6MQEh031614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538115747;
        bh=XCMtbWC1dd2NZzJypz0SNClMfGNLnw7fq14N44l7HTQ=;
        h=From:To:Cc:Subject:Date:From;
        b=pmbh2Mb6rLrrGrkiK+QegY1XYT/i/Exeyq3SUP1CyeARYwGzqhz313C/mdQCNHdw5
         dgCmgSnfalX+SN8ZoHqOOAeyPU/aw4pKkNFjT4NDaaSCdL+WlbRJKSrrstyEBjyxp6
         FRV9Aq7w177TR7CG3vm8BHLRJBcfK1BrxqCzWiQ7oeK+YQkmbXJCAu3UzT0gxrXgDl
         /PV/orEQA2gS7R58N3B82sfehsU7XW2tR6V8tA7NAeRasAkGBLuw87NGQogkSSb6aZ
         xL79+qURwyqpb8tLtc2NYaB+YpqCsD3fhqe4E13sP5BP+Vh7xIDR1uhJrdip8sB+9E
         KS+ye4zTtV2GQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Rusty Russell <rusty@rustcorp.com.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] modpost: remove leftover symbol prefix handling for module device table
Date:   Fri, 28 Sep 2018 15:21:55 +0900
Message-Id: <1538115715-10078-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Blackfin and metag were the only architectures that prefix symbols with
an underscore.  They were removed by commit 4ba66a976072 ("arch: remove
blackfin port"), commit bb6fb6dfcc17 ("metag: Remove arch/metag/"),
respectively.

It is no longer necessary to handle <prefix> part of module device
table symbols.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/mod/file2alias.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 7be4369..ba4ebc4 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1415,11 +1415,10 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
 	if (ELF_ST_TYPE(sym->st_info) != STT_OBJECT)
 		return;
 
-	/* All our symbols are of form <prefix>__mod_<name>__<identifier>_device_table. */
-	name = strstr(symname, "__mod_");
-	if (!name)
+	/* All our symbols are of form __mod_<name>__<identifier>_device_table. */
+	if (strncmp(symname, "__mod_", strlen("__mod_")))
 		return;
-	name += strlen("__mod_");
+	name = symname + strlen("__mod_");
 	namelen = strlen(name);
 	if (namelen < strlen("_device_table"))
 		return;
-- 
2.7.4

