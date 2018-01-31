Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753900AbeAaJgz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 04:36:55 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44514 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753822AbeAaJgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 04:36:17 -0500
X-Google-Smtp-Source: AH8x224CdI0Vzkh4LGkDwPWeOaMo0s5oRbNpAyHaJvxfNkeb3wpHK4VOr48yrZtVPflLj09jqtyyrQ==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        mcgrof@kernel.org, rdunlap@infradead.org, dan.carpenter@oracle.com,
        pebolle@tiscali.nl, Ulf Magnusson <ulfalizer@gmail.com>
Subject: [PATCH 11/11] kconfig: Warn if help text is blank
Date: Wed, 31 Jan 2018 10:34:30 +0100
Message-Id: <20180131093434.20050-12-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180131093434.20050-1-ulfalizer@gmail.com>
References: <20180131093434.20050-1-ulfalizer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Blank help texts are probably either a typo, a Kconfig misunderstanding,
or some kind of half-committing to adding a help text (in which case a
TODO comment would be clearer, if the help text really can't be added
right away).

Best to flag them, IMO.

Example warning:

	drivers/mmc/host/Kconfig:877: warning: 'MMC_TOSHIBA_PCI' defined with blank help text

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 scripts/kconfig/zconf.y | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index 21ce883e5d9e..4be98050b961 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -436,6 +436,12 @@ help: help_start T_HELPTEXT
 		zconfprint("warning: '%s' defined with more than one help text -- only the last one will be used",
 			   current_entry->sym->name ?: "<choice>");
 	}
+
+	/* Is the help text empty or all whitespace? */
+	if ($2[strspn($2, " \f\n\r\t\v")] == '\0')
+		zconfprint("warning: '%s' defined with blank help text",
+			   current_entry->sym->name ?: "<choice>");
+
 	current_entry->help = $2;
 };
 
-- 
2.14.1
