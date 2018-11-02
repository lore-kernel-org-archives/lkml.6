Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD5CC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA972084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjUoGqSt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA972084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbeKCEBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:01:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbeKCEBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:01:09 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8583220848;
        Fri,  2 Nov 2018 18:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184774;
        bh=Drq+2IODeZNFXBZwmAYmUpT/3yif3DDDVSOw/lLtYzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LjUoGqStptvx+z082srCZTXggC4mvrzvhGtoLn7IhnlzkV+rcwGMzrHaAAigW3et0
         +rS/u8ZsAtrpqyGUgnAJ/b00Lua2Ch43+E2n2lyxPISvGGbxY0rIsLs4390LmMRNwP
         yNsipvRI+U+xAuJur5+AbH9nm7a7kXCTYFCDAq/8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 093/143] kconfig: fix the rule of mainmenu_stmt symbol
Date:   Fri,  2 Nov 2018 19:34:38 +0100
Message-Id: <20181102182905.343948618@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 56869d45e364244a721de34ce9c5dc9ed022779e ]

The rule of mainmenu_stmt does not have debug print of zconf_lineno(),
but if it had, it would print a wrong line number for the same reason
as commit b2d00d7c61c8 ("kconfig: fix line numbers for if-entries in
menu tree").

The mainmenu_stmt does not need to eat following empty lines because
they are reduced to common_stmt.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/kconfig/zconf.y | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index 126e3f2e1ed7..2b0adeb5fc42 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -31,7 +31,7 @@ struct symbol *symbol_hash[SYMBOL_HASHSIZE];
 static struct menu *current_menu, *current_entry;
 
 %}
-%expect 31
+%expect 30
 
 %union
 {
@@ -112,7 +112,7 @@ start: mainmenu_stmt stmt_list | no_mainmenu_stmt stmt_list;
 
 /* mainmenu entry */
 
-mainmenu_stmt: T_MAINMENU prompt nl
+mainmenu_stmt: T_MAINMENU prompt T_EOL
 {
 	menu_add_prompt(P_MENU, $2, NULL);
 };
-- 
2.17.1



