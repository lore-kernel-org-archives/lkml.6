Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D3AECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFFD2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ikyxum6m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFFD2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeJYWow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:44:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728299AbeJYWow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:44:52 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB9922084A;
        Thu, 25 Oct 2018 14:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476716;
        bh=OfIb3tJbSf8EMUDaBaLd/MmMDMaVmV0GpzbdtVabMgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ikyxum6mX/q9xaneH39kPn4v23diqWBYQgeIDt8fd4xV9d3czANRRpXfgz/1BhwW5
         VHepcveqC6UFIUy/JhAH1OoW9fryyueGwpIWggBWlqcI55Ad54tiWQTBQBKBquUOvC
         pvJowRAqJtG8+LcpqmC/9MIGThqGwHlost5GIYjo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 44/46] kconfig: fix the rule of mainmenu_stmt symbol
Date:   Thu, 25 Oct 2018 10:10:51 -0400
Message-Id: <20181025141053.213330-44-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141053.213330-1-sashal@kernel.org>
References: <20181025141053.213330-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

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

