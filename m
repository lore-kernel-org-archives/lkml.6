Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A61C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F74F208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F74F208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730791AbeHWLvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:51:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47060 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729923AbeHWLvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:51:23 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5E2F4C93;
        Thu, 23 Aug 2018 08:22:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dirk Gouders <dirk@gouders.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 090/217] kconfig: fix line numbers for if-entries in menu tree
Date:   Thu, 23 Aug 2018 09:53:23 +0200
Message-Id: <20180823075509.568181118@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dirk Gouders <dirk@gouders.net>

[ Upstream commit b2d00d7c61c84edd150310af3f556f8a3c6e2e67 ]

The line numers for if-entries in the menu tree are off by one or more
lines which is confusing when debugging for correctness of unrelated changes.

According to the git log, commit a02f0570ae201c49 (kconfig: improve
error handling in the parser) was the last one that changed that part
of the parser and replaced

	"if_entry: T_IF expr T_EOL"
by
	"if_entry: T_IF expr nl"

but the commit message does not state why this has been done.

When reverting that part of the commit, only the line numers are
corrected (checked with cdebug = DEBUG_PARSE in zconf.y), otherwise
the menu tree remains unchanged (checked with zconfdump() enabled in
conf.c).

An example for the corrected line numbers:

drivers/soc/Kconfig:15:source drivers/soc/tegra/Kconfig
drivers/soc/tegra/Kconfig:4:if
drivers/soc/tegra/Kconfig:6:if

changes to:

drivers/soc/Kconfig:15:source drivers/soc/tegra/Kconfig
drivers/soc/tegra/Kconfig:1:if
drivers/soc/tegra/Kconfig:4:if

Signed-off-by: Dirk Gouders <dirk@gouders.net>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/kconfig/zconf.y |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -31,7 +31,7 @@ struct symbol *symbol_hash[SYMBOL_HASHSI
 static struct menu *current_menu, *current_entry;
 
 %}
-%expect 32
+%expect 31
 
 %union
 {
@@ -345,7 +345,7 @@ choice_block:
 
 /* if entry */
 
-if_entry: T_IF expr nl
+if_entry: T_IF expr T_EOL
 {
 	printd(DEBUG_PARSE, "%s:%d:if\n", zconf_curname(), zconf_lineno());
 	menu_add_entry(NULL);


