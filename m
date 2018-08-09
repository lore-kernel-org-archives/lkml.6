Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21E9C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA7421C39
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ho3n3hqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA7421C39
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbeHIJM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 05:12:26 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:19417 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeHIJM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 05:12:26 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w796lOa2009603;
        Thu, 9 Aug 2018 15:47:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w796lOa2009603
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533797245;
        bh=ASiKMtRc+IY5ZV5HOVjsY/Z2lwC0ArSOr80wR78F9RU=;
        h=From:To:Cc:Subject:Date:From;
        b=ho3n3hqOQVqrK8/tN1TWjp/N+P40fMaqb6on6skRs9k4LrfXrrMBaXhiHMF6TCw/S
         UMQZRv8C2/UnsymZ3YloJiXcaID3x4nHWQgH8SoKmTstf4qli6bghkQ5eIUmrzuxqI
         iSyVfXfFzBO3atRemFsJP6iuOvq3JExAPEpc90zCd+xDM8OBPT6kTA8VgRAyIheH63
         J5MJ/PVNP0Umkr6Uw4BWcM45snw6iqpSDEvK8qqwsZ5H+66oC5DHGVwKhfDVkOulKZ
         8WhepwgdaeoyjvmdCiTAmtv3vgsRYZzK3nsk/MeXOHUH6GaK9vFl68L1hSkdRG0B0L
         mHy2jFQe1f+uA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>, Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: fix the rule of mainmenu_stmt symbol
Date:   Thu,  9 Aug 2018 15:47:06 +0900
Message-Id: <1533797226-6547-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rule of mainmenu_stmt does not have debug print of zconf_lineno(),
but if it had, it would print a wrong line number for the same reason
as commit b2d00d7c61c8 ("kconfig: fix line numbers for if-entries in
menu tree").

The mainmenu_stmt does not need to eat following empty lines because
they are reduced to common_stmt.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/zconf.y | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index 4b68272..95a4fd3 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -31,7 +31,7 @@ struct symbol *symbol_hash[SYMBOL_HASHSIZE];
 static struct menu *current_menu, *current_entry;
 
 %}
-%expect 31
+%expect 30
 
 %union
 {
@@ -117,7 +117,7 @@ start: mainmenu_stmt stmt_list | stmt_list;
 
 /* mainmenu entry */
 
-mainmenu_stmt: T_MAINMENU prompt nl
+mainmenu_stmt: T_MAINMENU prompt T_EOL
 {
 	menu_add_prompt(P_MENU, $2, NULL);
 };
-- 
2.7.4

