Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEB7C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 06:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5EB216E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 06:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0nvR7fB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5EB216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbeHOIwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 04:52:09 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:54027 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbeHOIwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 04:52:08 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w7F5xsZk013655;
        Wed, 15 Aug 2018 14:59:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w7F5xsZk013655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534312796;
        bh=p4Q4Z5Gs1yt+lCyn3wpiQ3ldS/HwZ89fTXOgjslf4FU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0nvR7fB9NRfTd2X2nqTni1brG1azxLAQelcdwqEDxX46DzBy9/gFuI59V55nXQ+LC
         RZ1C8m3H99/vafQmpit87hMWsBDStyIgeicxHbz3kdBQ4nJfBbPQBpTgQn8gyZzkOV
         XDRRwOsArczD1PxLYTa95fGh3AQw4mIgd7JW1/fE7PquAf9BObXjNhxvt/ZhNRyAIz
         fv2VoDIfuhmEOMBHW9RpBMWji1jge5vGYa+tGgC/HhQ9Y1n/s5BmK/S599i0ZHRucX
         QCqA6Zo53zPkbXUO/gtMoNpkFae6wlSGpHMsHLK4JOWjf2k1vFWlMQofyPjXv4kFvw
         p3HZ3KepqfO/w==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] kconfig: improve the recursive dependency report
Date:   Wed, 15 Aug 2018 14:59:45 +0900
Message-Id: <1534312785-28434-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534312785-28434-1-git-send-email-yamada.masahiro@socionext.com>
References: <1534312785-28434-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit improves the messages of the recursive dependency.
Currently, sym->dir_dep.expr is not checked.  Hence, any dependency
in property visibility is regarded as the dependency of the symbol.

[Test Code 1]

  config A
          bool "a"
          depends on B

  config B
          bool "b"
          depends on A

[Test Code 2]

  config A
          bool "a" if B

  config B
          bool "b"
          depends on A

For both cases above, the same message is displayed:

        symbol B depends on A
        symbol A depends on B

This commit changes the message for the latter case like this:

        symbol B depends on A
        symbol A prompt is visible depending on B

Also, 'select' and 'imply' are distinguished.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
 - Update unit test

 scripts/kconfig/symbol.c                           | 48 +++++++++++++++-------
 .../tests/err_recursive_dep/expected_stderr        |  6 +--
 2 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 90e70609..703b9b8 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -1011,7 +1011,7 @@ static struct dep_stack {
 	struct dep_stack *prev, *next;
 	struct symbol *sym;
 	struct property *prop;
-	struct expr *expr;
+	struct expr **expr;
 } *check_top;
 
 static void dep_stack_insert(struct dep_stack *stack, struct symbol *sym)
@@ -1076,31 +1076,42 @@ static void sym_check_print_recursive(struct symbol *last_sym)
 			fprintf(stderr, "%s:%d:error: recursive dependency detected!\n",
 				prop->file->name, prop->lineno);
 
-		if (stack->expr) {
-			fprintf(stderr, "%s:%d:\tsymbol %s %s value contains %s\n",
-				prop->file->name, prop->lineno,
+		if (sym_is_choice(sym)) {
+			fprintf(stderr, "%s:%d:\tchoice %s contains symbol %s\n",
+				menu->file->name, menu->lineno,
+				sym->name ? sym->name : "<choice>",
+				next_sym->name ? next_sym->name : "<choice>");
+		} else if (sym_is_choice_value(sym)) {
+			fprintf(stderr, "%s:%d:\tsymbol %s is part of choice %s\n",
+				menu->file->name, menu->lineno,
 				sym->name ? sym->name : "<choice>",
-				prop_get_type_name(prop->type),
 				next_sym->name ? next_sym->name : "<choice>");
-		} else if (stack->prop) {
+		} else if (stack->expr == &sym->dir_dep.expr) {
 			fprintf(stderr, "%s:%d:\tsymbol %s depends on %s\n",
 				prop->file->name, prop->lineno,
 				sym->name ? sym->name : "<choice>",
 				next_sym->name ? next_sym->name : "<choice>");
-		} else if (sym_is_choice(sym)) {
-			fprintf(stderr, "%s:%d:\tchoice %s contains symbol %s\n",
-				menu->file->name, menu->lineno,
+		} else if (stack->expr == &sym->rev_dep.expr) {
+			fprintf(stderr, "%s:%d:\tsymbol %s is selected by %s\n",
+				prop->file->name, prop->lineno,
 				sym->name ? sym->name : "<choice>",
 				next_sym->name ? next_sym->name : "<choice>");
-		} else if (sym_is_choice_value(sym)) {
-			fprintf(stderr, "%s:%d:\tsymbol %s is part of choice %s\n",
-				menu->file->name, menu->lineno,
+		} else if (stack->expr == &sym->implied.expr) {
+			fprintf(stderr, "%s:%d:\tsymbol %s is implied by %s\n",
+				prop->file->name, prop->lineno,
 				sym->name ? sym->name : "<choice>",
 				next_sym->name ? next_sym->name : "<choice>");
+		} else if (stack->expr) {
+			fprintf(stderr, "%s:%d:\tsymbol %s %s value contains %s\n",
+				prop->file->name, prop->lineno,
+				sym->name ? sym->name : "<choice>",
+				prop_get_type_name(prop->type),
+				next_sym->name ? next_sym->name : "<choice>");
 		} else {
-			fprintf(stderr, "%s:%d:\tsymbol %s is selected or implied by %s\n",
+			fprintf(stderr, "%s:%d:\tsymbol %s %s is visible depending on %s\n",
 				prop->file->name, prop->lineno,
 				sym->name ? sym->name : "<choice>",
+				prop_get_type_name(prop->type),
 				next_sym->name ? next_sym->name : "<choice>");
 		}
 	}
@@ -1157,14 +1168,23 @@ static struct symbol *sym_check_sym_deps(struct symbol *sym)
 
 	dep_stack_insert(&stack, sym);
 
+	stack.expr = &sym->dir_dep.expr;
+	sym2 = sym_check_expr_deps(sym->dir_dep.expr);
+	if (sym2)
+		goto out;
+
+	stack.expr = &sym->rev_dep.expr;
 	sym2 = sym_check_expr_deps(sym->rev_dep.expr);
 	if (sym2)
 		goto out;
 
+	stack.expr = &sym->implied.expr;
 	sym2 = sym_check_expr_deps(sym->implied.expr);
 	if (sym2)
 		goto out;
 
+	stack.expr = NULL;
+
 	for (prop = sym->prop; prop; prop = prop->next) {
 		if (prop->type == P_CHOICE || prop->type == P_SELECT ||
 		    prop->type == P_IMPLY)
@@ -1175,7 +1195,7 @@ static struct symbol *sym_check_sym_deps(struct symbol *sym)
 			break;
 		if (prop->type != P_DEFAULT || sym_is_choice(sym))
 			continue;
-		stack.expr = prop->expr;
+		stack.expr = &prop->expr;
 		sym2 = sym_check_expr_deps(prop->expr);
 		if (sym2)
 			break;
diff --git a/scripts/kconfig/tests/err_recursive_dep/expected_stderr b/scripts/kconfig/tests/err_recursive_dep/expected_stderr
index 2eb2528..84679b1 100644
--- a/scripts/kconfig/tests/err_recursive_dep/expected_stderr
+++ b/scripts/kconfig/tests/err_recursive_dep/expected_stderr
@@ -1,5 +1,5 @@
 Kconfig:11:error: recursive dependency detected!
-Kconfig:11:	symbol B is selected or implied by B
+Kconfig:11:	symbol B is selected by B
 For a resolution refer to Documentation/kbuild/kconfig-language.txt
 subsection "Kconfig recursive dependency limitations"
 
@@ -15,14 +15,14 @@ For a resolution refer to Documentation/kbuild/kconfig-language.txt
 subsection "Kconfig recursive dependency limitations"
 
 Kconfig:32:error: recursive dependency detected!
-Kconfig:32:	symbol D2 is selected or implied by D1
+Kconfig:32:	symbol D2 is selected by D1
 Kconfig:27:	symbol D1 depends on D2
 For a resolution refer to Documentation/kbuild/kconfig-language.txt
 subsection "Kconfig recursive dependency limitations"
 
 Kconfig:37:error: recursive dependency detected!
 Kconfig:37:	symbol E1 depends on E2
-Kconfig:42:	symbol E2 is selected or implied by E1
+Kconfig:42:	symbol E2 is implied by E1
 For a resolution refer to Documentation/kbuild/kconfig-language.txt
 subsection "Kconfig recursive dependency limitations"
 
-- 
2.7.4

