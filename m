Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71954C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 06:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4C32173F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 06:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jnuSCB2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4C32173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbeHNJa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 05:30:56 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:55701 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730664AbeHNJaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 05:30:55 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w7E6hiBA014737;
        Tue, 14 Aug 2018 15:43:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w7E6hiBA014737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534229025;
        bh=jtf4RvAwN2yQhiQjgNRLjBjwVs832IxjSWznJdaeOY4=;
        h=From:To:Cc:Subject:Date:From;
        b=jnuSCB2eLbcYnPMHJRUBSEoFHt2DwjoJv64B5Oxy3z+dF54JBjci5cE6PQFnbgoBa
         NY58nAKVzF3YhTBGgvjF7oTSHH9thqXAX+1Ukf1/BCmpywbwOih02Sspum3etj0KdR
         GtABssbUrl8jjqA+87FgQC0YPtv8C25Zu9GP2UQS1I+P3tkGKvKLm800QGejDfPncy
         Ox20nEi1di90xW33WlDFXHSOv1r3kM6ehS8rI0Ww4t+R/9tLQrSSneUuNK7XRh68xk
         AqD0ibB82AiAShbgIuuVHswQep/iiPUjUYD2VVv53g8wXZswoez3D2nnRQoV/xmytE
         rkY/6OXOk4lBw==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kconfig: report recursive dependency involving 'imply'
Date:   Tue, 14 Aug 2018 15:43:40 +0900
Message-Id: <1534229021-8056-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, Kconfig does not report anything about the recursive
dependency where 'imply' keywords are involved.

[Test Code]

  config A
          bool "a"

  config B
          bool "b"
          imply A
          depends on A

In the code above, Kconfig cannot calculate the symbol values correctly
due to the circular dependency.  For example, allyesconfig followed by
syncconfig results in an odd behavior because CONFIG_B becomes visible
in syncconfig.

  $ make allyesconfig
  scripts/kconfig/conf  --allyesconfig Kconfig
  #
  # configuration written to .config
  #
  $ cat .config
  #
  # Automatically generated file; DO NOT EDIT.
  # Main menu
  #
  CONFIG_A=y
  $ make syncconfig
  scripts/kconfig/conf  --syncconfig Kconfig
  *
  * Restart config...
  *
  *
  * Main menu
  *
  a (A) [Y/n/?] y
    b (B) [N/y/?] (NEW)

To report this correctly, sym_check_expr_deps() should recurse to
not only sym->rev_dep.expr but also sym->implied.expr .

At this moment, sym_check_print_recursive() cannot distinguish
'select' and 'imply' since it does not know the precise context
where the recursive dependency is hit.  This will be solved by
the next commit.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/symbol.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 4ec8b1f..7de7463a 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -1098,7 +1098,7 @@ static void sym_check_print_recursive(struct symbol *last_sym)
 				sym->name ? sym->name : "<choice>",
 				next_sym->name ? next_sym->name : "<choice>");
 		} else {
-			fprintf(stderr, "%s:%d:\tsymbol %s is selected by %s\n",
+			fprintf(stderr, "%s:%d:\tsymbol %s is selected or implied by %s\n",
 				prop->file->name, prop->lineno,
 				sym->name ? sym->name : "<choice>",
 				next_sym->name ? next_sym->name : "<choice>");
@@ -1161,8 +1161,13 @@ static struct symbol *sym_check_sym_deps(struct symbol *sym)
 	if (sym2)
 		goto out;
 
+	sym2 = sym_check_expr_deps(sym->implied.expr);
+	if (sym2)
+		goto out;
+
 	for (prop = sym->prop; prop; prop = prop->next) {
-		if (prop->type == P_CHOICE || prop->type == P_SELECT)
+		if (prop->type == P_CHOICE || prop->type == P_SELECT ||
+		    prop->type == P_IMPLY)
 			continue;
 		stack.prop = prop;
 		sym2 = sym_check_expr_deps(prop->visible.expr);
-- 
2.7.4

