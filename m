Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933749AbeE1J2w (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:28:52 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:21628 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754334AbeE1JYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:24:17 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4S9MInZ027506
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v5 18/31] kconfig: error out if a recursive variable references itself
Date: Mon, 28 May 2018 18:21:55 +0900
Message-Id: <1527499328-13213-19-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
References: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
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

Changes in v5: None
Changes in v4:
 - Newly added

Changes in v3: None
Changes in v2: None

 scripts/kconfig/preprocess.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index 0574039..65da87f 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -229,6 +229,7 @@ struct variable {
 	char *name;
 	char *value;
 	enum variable_flavor flavor;
+	int exp_count;
 	struct list_head node;
 };
 
@@ -253,11 +254,22 @@ static char *variable_expand(const char *name, int argc, char *argv[])
 	if (!v)
 		return NULL;
 
+	if (argc == 0 && v->exp_count)
+		pperror("Recursive variable '%s' references itself (eventually)",
+			name);
+
+	if (v->exp_count > 1000)
+		pperror("Too deep recursive expansion");
+
+	v->exp_count++;
+
 	if (v->flavor == VAR_RECURSIVE)
 		res = expand_string_with_args(v->value, argc, argv);
 	else
 		res = xstrdup(v->value);
 
+	v->exp_count--;
+
 	return res;
 }
 
@@ -284,6 +296,7 @@ void variable_add(const char *name, const char *value,
 
 		v = xmalloc(sizeof(*v));
 		v->name = xstrdup(name);
+		v->exp_count = 0;
 		list_add_tail(&v->node, &variable_list);
 	}
 
-- 
2.7.4
