Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753967AbeDMFMs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 01:12:48 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:54504 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbeDMFIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 01:08:16 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w3D56lg8029209
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/30] kconfig: support append assignment operator
Date: Fri, 13 Apr 2018 14:06:23 +0900
Message-Id: <1523595999-27433-15-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support += operator.  This appends a space and the text on the
righthand side to a variable.

The timing of the evaluation of the righthand side depends on the
flavor of the variable.  If the lefthand side was originally defined
as a simple variable, the righthand side is expanded immediately.
Otherwise, the expansion is deferred.  Appending something to an
undefined variable results in a recursive variable.

To implement this, we need to remember the flavor of variables.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3:
  - newly added

Changes in v2: None

 scripts/kconfig/lkc_proto.h  |  1 +
 scripts/kconfig/preprocess.c | 29 +++++++++++++++++++++++++++--
 scripts/kconfig/zconf.l      |  1 +
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/lkc_proto.h b/scripts/kconfig/lkc_proto.h
index 6303193..a8b7a33 100644
--- a/scripts/kconfig/lkc_proto.h
+++ b/scripts/kconfig/lkc_proto.h
@@ -52,6 +52,7 @@ const char * prop_get_type_name(enum prop_type type);
 enum variable_flavor {
 	VAR_SIMPLE,
 	VAR_RECURSIVE,
+	VAR_APPEND,
 };
 void env_write_dep(FILE *f, const char *auto_conf_name);
 void variable_add(const char *name, const char *value,
diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index a835c94..85972fb 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -86,6 +86,7 @@ static LIST_HEAD(variable_list);
 struct variable {
 	char *name;
 	char *value;
+	enum variable_flavor flavor;
 	struct list_head node;
 };
 
@@ -116,18 +117,42 @@ void variable_add(const char *name, const char *value,
 		  enum variable_flavor flavor)
 {
 	struct variable *v;
+	char *new_value;
+	bool append = false;
 
 	v = variable_lookup(name);
 	if (v) {
-		free(v->value);
+		/* For defined variables, += inherits the existing flavor */
+		if (flavor == VAR_APPEND) {
+			flavor = v->flavor;
+			append = true;
+		} else {
+			free(v->value);
+		}
 	} else {
+		/* For undefined variables, += assumes the recursive flavor */
+		if (flavor == VAR_APPEND)
+			flavor = VAR_RECURSIVE;
+
 		v = xmalloc(sizeof(*v));
 		v->name = xstrdup(name);
 		list_add_tail(&v->node, &variable_list);
 	}
 
-	v->value = (flavor == VAR_SIMPLE) ? expand_string(value) :
+	v->flavor = flavor;
+
+	new_value = (flavor == VAR_SIMPLE) ? expand_string(value) :
 								xstrdup(value);
+
+	if (append) {
+		v->value = xrealloc(v->value,
+				    strlen(v->value) + strlen(new_value) + 2);
+		strcat(v->value, " ");
+		strcat(v->value, new_value);
+		free(new_value);
+	} else {
+		v->value = new_value;
+	}
 }
 
 static void variable_del(struct variable *v)
diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index aa76942..c68ca56b 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -116,6 +116,7 @@ n	[A-Za-z0-9_-]
 	}
 	"="	{ BEGIN(ASSIGN_VAL); yylval.flavor = VAR_RECURSIVE; return T_ASSIGN; }
 	":="	{ BEGIN(ASSIGN_VAL); yylval.flavor = VAR_SIMPLE; return T_ASSIGN; }
+	"+="	{ BEGIN(ASSIGN_VAL); yylval.flavor = VAR_APPEND; return T_ASSIGN; }
 	[[:blank:]]+
 	.	warn_ignored_character(*yytext);
 	\n	{
-- 
2.7.4
