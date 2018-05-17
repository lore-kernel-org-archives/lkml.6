Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbeEQGTU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:19:20 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:24994 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbeEQGTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:19:16 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4H6HbUG002841
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 18/31] kconfig: error out if a recursive variable references itself
Date: Thu, 17 May 2018 15:16:57 +0900
Message-Id: <1526537830-22606-19-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using a recursively expanded variable, it is a common mistake
to make circular reference.

For example, Make terminates the following code:

  X = $(X)
  Y := $(X)

Let's detect the circular expansion in Kconfig, too.

On the other hand, a function that recurses itself is a commonly-used
programming technique.  So, Make does not check recursion in the
reference with 'call'.  For example, the following code continues
running eternally:

  X = $(call X)
  Y := $(X)

Kconfig allows circular expansion if one or more arguments are given,
but terminates when the same function is recursively invoked 1000 times,
assuming it is a programming mistake.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v4:
 - Newly added

Changes in v3: None
Changes in v2: None

 scripts/kconfig/preprocess.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index c39e30e..246f879 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -276,6 +276,7 @@ struct variable {
 	char *name;
 	char *value;
 	enum variable_flavor flavor;
+	int exp_count;
 	struct list_head node;
 };
 
@@ -306,8 +307,19 @@ static char *variable_expand(const char *name, int argc, char *argv[],
 		expanded_argv[i] = expand_string_with_args(argv[i],
 							   old_argc, old_argv);
 
+	if (argc == 0 && v->exp_count)
+		pperror("Recursive variable '%s' references itself (eventually)",
+			name);
+
+	if (v->exp_count > 1000)
+		pperror("Too deep recursive expansion");
+
+	v->exp_count++;
+
 	res = expand_string_with_args(v->value, argc, expanded_argv);
 
+	v->exp_count--;
+
 	for (i = 0; i < argc; i++)
 		free(expanded_argv[i]);
 
@@ -337,6 +349,7 @@ void variable_add(const char *name, const char *value,
 
 		v = xmalloc(sizeof(*v));
 		v->name = xstrdup(name);
+		v->exp_count = 0;
 		list_add_tail(&v->node, &variable_list);
 	}
 
-- 
2.7.4
