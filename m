Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x226RuMesam/gUyRWh1cTzreHWRjYy6rN4+rTjD0GnZ5kg1tlUg0CUyQy/bLr94l6U1r5DK6Q
ARC-Seal: i=1; a=rsa-sha256; t=1517877367; cv=none;
        d=google.com; s=arc-20160816;
        b=CZ4BcAHJIat+6GN+9pmdc2jtX7sAhW+TdDkhHU73iFFehWSzVcUXoX7/e2PP2kxuP2
         0yooVaheIITmJF+u5CgXIZPcbWE3dFr2BaX1cuNDqq0Sn03YZ6km1AqR/5aofL84mCsH
         A0bGtpFyngVAPzPdf9z8vomn3srE2G7Nym/T97cLEQErawK/OEqa4P+AqnkT/6lVw2Aq
         P2RgiHxfxTVIfYzIPMLKfd3LO5iGYkr0cN+ro4EfaU8vtLlbeF6zL9jN5B6yRDasPUtF
         4ez2iYJa/yy2WemlENszdAwIYyfb006RfW0rGkwiLZlB+7qH4OwwjEp+xC996s2GAa8Y
         fPJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=T9u7K+hmWKfvjcjjYHb1paogJ/PbBcbc8jyZmrvK6GA=;
        b=tc2GhPD7/anS12HIchNANID3q37sNs10eMkAmHsSfOmt88QJ5cEZcrEIgjxdJtDV84
         Y7lnwaMsvC8Z0z2+GA6eqpdjPOLLy0Nf3szon13DGfg5k5GanSWvwRBD1+AvjU7hKNRv
         iJ+tWgsICxO72f6hxM19nAdBn2m+ayczMd/Ko9c/ESc/+QhFh+QYasanePMN4ibibcmi
         s7lPHR26z8a2I/XcKM+OGiNvpxAMB+qORhRge2tHQ3LrOwcah3sXBrAw4MXRxJV7j4VN
         Du6Tj5zlbcNx5DWOZNYZfAUdtOUQ/H7w/dSPGCO63ZntxpibatjDTXKYK8ub7WgzW87r
         9+Vw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=rjWn4lBQ;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=rjWn4lBQ;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w160ZHAg011351
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Marc Herbert <marc.herbert@intel.com>
Subject: [PATCH 01/14] kconfig: send error messages to stderr
Date: Tue,  6 Feb 2018 09:34:41 +0900
Message-Id: <1517877294-4826-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609778719993235?=
X-GMAIL-MSGID: =?utf-8?q?1591609778719993235?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These messages should be directed to stderr.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/conf.c  | 18 +++++++++++-------
 scripts/kconfig/zconf.l | 27 +++++++++++++++------------
 2 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 307bc3f..90a76aa2 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -75,9 +75,11 @@ static void strip(char *str)
 static void check_stdin(void)
 {
 	if (!valid_stdin) {
-		printf(_("aborted!\n\n"));
-		printf(_("Console input/output is redirected. "));
-		printf(_("Run 'make oldconfig' to update configuration.\n\n"));
+		fprintf(stderr,
+			_("Aborted!\n"
+			  "Console input/output is redirected.\n"
+			  "Run 'make oldconfig' to update configuration.\n\n")
+			);
 		exit(1);
 	}
 }
@@ -565,7 +567,7 @@ int main(int ac, char **av)
 		}
 	}
 	if (ac == optind) {
-		printf(_("%s: Kconfig file missing\n"), av[0]);
+		fprintf(stderr, _("%s: Kconfig file missing\n"), av[0]);
 		conf_usage(progname);
 		exit(1);
 	}
@@ -590,9 +592,11 @@ int main(int ac, char **av)
 		if (!defconfig_file)
 			defconfig_file = conf_get_default_confname();
 		if (conf_read(defconfig_file)) {
-			printf(_("***\n"
-				"*** Can't find default configuration \"%s\"!\n"
-				"***\n"), defconfig_file);
+			fprintf(stderr,
+				_("***\n"
+				  "*** Can't find default configuration \"%s\"!\n"
+				  "***\n"),
+				defconfig_file);
 			exit(1);
 		}
 		break;
diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index 07e074d..0ba4900 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -184,7 +184,9 @@ n	[A-Za-z0-9_-]
 			append_string(yytext, 1);
 	}
 	\n	{
-		printf("%s:%d:warning: multi-line strings not supported\n", zconf_curname(), zconf_lineno());
+		fprintf(stderr,
+			"%s:%d:warning: multi-line strings not supported\n",
+			zconf_curname(), zconf_lineno());
 		current_file->lineno++;
 		BEGIN(INITIAL);
 		return T_EOL;
@@ -294,7 +296,7 @@ void zconf_initscan(const char *name)
 {
 	yyin = zconf_fopen(name);
 	if (!yyin) {
-		printf("can't find file %s\n", name);
+		fprintf(stderr, "can't find file %s\n", name);
 		exit(1);
 	}
 
@@ -315,8 +317,8 @@ void zconf_nextfile(const char *name)
 	current_buf->state = YY_CURRENT_BUFFER;
 	yyin = zconf_fopen(file->name);
 	if (!yyin) {
-		printf("%s:%d: can't open file \"%s\"\n",
-		    zconf_curname(), zconf_lineno(), file->name);
+		fprintf(stderr, "%s:%d: can't open file \"%s\"\n",
+			zconf_curname(), zconf_lineno(), file->name);
 		exit(1);
 	}
 	yy_switch_to_buffer(yy_create_buffer(yyin, YY_BUF_SIZE));
@@ -325,20 +327,21 @@ void zconf_nextfile(const char *name)
 
 	for (iter = current_file->parent; iter; iter = iter->parent ) {
 		if (!strcmp(current_file->name,iter->name) ) {
-			printf("%s:%d: recursive inclusion detected. "
-			       "Inclusion path:\n  current file : '%s'\n",
-			       zconf_curname(), zconf_lineno(),
-			       zconf_curname());
+			fprintf(stderr,
+				"%s:%d: recursive inclusion detected. "
+				"Inclusion path:\n  current file : '%s'\n",
+				zconf_curname(), zconf_lineno(),
+				zconf_curname());
 			iter = current_file->parent;
 			while (iter && \
 			       strcmp(iter->name,current_file->name)) {
-				printf("  included from: '%s:%d'\n",
-				       iter->name, iter->lineno-1);
+				fprintf(stderr, "  included from: '%s:%d'\n",
+					iter->name, iter->lineno-1);
 				iter = iter->parent;
 			}
 			if (iter)
-				printf("  included from: '%s:%d'\n",
-				       iter->name, iter->lineno+1);
+				fprintf(stderr, "  included from: '%s:%d'\n",
+					iter->name, iter->lineno+1);
 			exit(1);
 		}
 	}
-- 
2.7.4
