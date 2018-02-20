Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751520AbeBTLlv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 06:41:51 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:43752 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbeBTLlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 06:41:46 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w1KBeVbJ032618
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: Don't leak choice names during parsing
Date: Tue, 20 Feb 2018 20:40:29 +0900
Message-Id: <1519126829-7257-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The named choice is not used in the kernel tree, but if it were used,
it would not be freed.

The intention of the named choice can be seen in the log of
commit 5a1aa8a1aff6 ("kconfig: add named choice group").

There is room for argument if this is useful in practice, but anyway
I am fixing the memory leak.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/zconf.y | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index 4be9805..4893676 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -276,6 +276,7 @@ choice: T_CHOICE word_opt T_EOL
 	sym->flags |= SYMBOL_AUTO;
 	menu_add_entry(sym);
 	menu_add_expr(P_CHOICE, NULL, NULL);
+	free($2);
 	printd(DEBUG_PARSE, "%s:%d:choice\n", zconf_curname(), zconf_lineno());
 };
 
-- 
2.7.4
