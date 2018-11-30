Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3427CC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9A720868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Gif4TJI6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9A720868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbeK3UZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:25:53 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:53049 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeK3UZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:25:53 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wAU9GEaa028692;
        Fri, 30 Nov 2018 18:16:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wAU9GEaa028692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543569375;
        bh=Ila7IG6OhXb9xuIrOHlsnG2ifWK5+2r1WBzDYAzsmws=;
        h=From:To:Cc:Subject:Date:From;
        b=Gif4TJI61WXA20XdCFtR8WvqtE/MizphhVqSZHUA78BzkR/Ss3W4wPL6uvnu6H2bg
         ABzKR0tlVB78fsJnJcbV7QPsMVJECqtkYDnEc1Al1psH4hwM8c9YKH+RHD6v058bLe
         hxlkXtPathYat5hV3nES5jJCpVtiJFgFFQPUtQglzzenMuwRnGw6TsPaZuBX3I8/Jn
         hGlP0/ZMK0A8IsQ9Hrr71Jq0alR0qu6toZWoEcrk6HEy8yQjOTtgcxECQrVk5Oprfy
         HD6s40BUCsV6pZS0xQGhGcP/t1k5ptoZma1lJwwzTEhQN3uR+VJ3QmhvLJtWUetvQh
         a7zetDD7fHxag==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] kconfig: remove unneeded setsym label in conf_read_simple()
Date:   Fri, 30 Nov 2018 18:15:48 +0900
Message-Id: <1543569352-4899-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two 'goto setsym' statements are reachable only when sym == NULL.

The code below the 'setsym:' label does nothing when sym == NULL
since there is just one if-block guarded by 'if (sym && ...)'.

Hence, 'goto setsym' can be replaced with 'continue'.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/confdata.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 91d0a5c..1e35529 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -363,7 +363,7 @@ int conf_read_simple(const char *name, int def)
 				sym = sym_find(line + 2 + strlen(CONFIG_));
 				if (!sym) {
 					sym_add_change_count(1);
-					goto setsym;
+					continue;
 				}
 			} else {
 				sym = sym_lookup(line + 2 + strlen(CONFIG_), 0);
@@ -397,7 +397,7 @@ int conf_read_simple(const char *name, int def)
 				sym = sym_find(line + strlen(CONFIG_));
 				if (!sym) {
 					sym_add_change_count(1);
-					goto setsym;
+					continue;
 				}
 			} else {
 				sym = sym_lookup(line + strlen(CONFIG_), 0);
@@ -416,7 +416,7 @@ int conf_read_simple(const char *name, int def)
 
 			continue;
 		}
-setsym:
+
 		if (sym && sym_is_choice_value(sym)) {
 			struct symbol *cs = prop_get_symbol(sym_get_choice_prop(sym));
 			switch (sym->def[def].tri) {
-- 
2.7.4

