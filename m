Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeBHF6I (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 00:58:08 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:58454 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbeBHF6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 00:58:04 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w185uhG3007816
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Marc Herbert <marc.herbert@intel.com>
Subject: [PATCH 2/2] kconfig: echo stdin to stdout if either is redirected
Date: Thu,  8 Feb 2018 14:56:40 +0900
Message-Id: <1518069400-7037-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518069400-7037-1-git-send-email-yamada.masahiro@socionext.com>
References: <1518069400-7037-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If stdio is not tty, conf_askvalue() puts additional new line to
prevent prompts are all concatenated into a single line.  This care
is missing in conf_choice(), so a 'choice' prompt and the next prompt
are shown in the same line.

Move the code into xfgets() to take care of all cases.  To improve
this more, echo stdin to stdout.  This clarifies what keys were input
from stdio and the stdout looks like as if it were from tty.

I removed the isatty(2) check since stderr is unrelated here.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/conf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 358e2e4..c5318d3 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -76,6 +76,9 @@ static void xfgets(char *str, int size, FILE *in)
 {
 	if (!fgets(str, size, in))
 		fprintf(stderr, "\nError in reading or end of file.\n");
+
+	if (!tty_stdio)
+		printf("%s", str);
 }
 
 static int conf_askvalue(struct symbol *sym, const char *def)
@@ -106,8 +109,6 @@ static int conf_askvalue(struct symbol *sym, const char *def)
 	case oldaskconfig:
 		fflush(stdout);
 		xfgets(line, sizeof(line), stdin);
-		if (!tty_stdio)
-			printf("\n");
 		return 1;
 	default:
 		break;
@@ -495,7 +496,7 @@ int main(int ac, char **av)
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 
-	tty_stdio = isatty(0) && isatty(1) && isatty(2);
+	tty_stdio = isatty(0) && isatty(1);
 
 	while ((opt = getopt_long(ac, av, "s", long_opts, NULL)) != -1) {
 		if (opt == 's') {
-- 
2.7.4
