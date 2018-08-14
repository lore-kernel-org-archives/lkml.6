Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE7AC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 06:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A07D2173F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 06:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0BXxIaJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A07D2173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbeHNJa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 05:30:57 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:55702 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731066AbeHNJa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 05:30:56 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w7E6hiBB014737;
        Tue, 14 Aug 2018 15:43:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w7E6hiBB014737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534229026;
        bh=JwIvDu6TRXCLxKk8WhEsCQ2lFJvY0JE97KL4GS3A8xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0BXxIaJxgzYI9IuDN30bHKIU1yINEYCOltZ7FAaqLv5nS9BOPxSF6tpMj9gy3LAMI
         GPXZs3MoErAKDJ6SgOzvCn9c0qhIjyp94qvvn42o8dEqMH5RWdQWM3bGDxISzFYLFL
         k6TrBmZXK8I5qkMqPOVUj8rBSvQ0pmlW1zrx5yp4NN7ry8eLxvNu4WWLF+rFcPALLT
         55FGDOBc7Ohjl04iwSQ4Ir64GYVLtWc2Po95vnpe1ZRKNWtaUWzqUi4P9E19mVYjLR
         Ghn5oxWQK7sCKjf+kdYQsK9Z7+PZ91Dxcp5mIUHpxMsdFDld1m60xN7E+HX2QEGivC
         ZFDEMoO+pa1LA==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kconfig: improve the recursive dependency report
Date:   Tue, 14 Aug 2018 15:43:41 +0900
Message-Id: <1534229021-8056-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534229021-8056-1-git-send-email-yamada.masahiro@socionext.com>
References: <1534229021-8056-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit improves the warning messages of the recursive dependency.
Currently, sym->dir_dep.expr is not checked.  Hence, any dependency in
property visibility is regarded as the dependency of the symbol.

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

 scripts/kconfig/symbol.c | 48 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 7de7463a..9cc443b 100644
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
-- 
2.7.4

