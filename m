Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C82C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B592A2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="BrC0ZLWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B592A2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeLKLBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:01:44 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:36639 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeLKLBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:01:42 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wBBB1C5k017210;
        Tue, 11 Dec 2018 20:01:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBBB1C5k017210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544526079;
        bh=iNmCjGIrzgz6jSnY2pvpjlrVb4D8VRpuL9G+9Lp30As=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BrC0ZLWvRAna3/LVGAwk2xylPzxljOlcd89yaJUcQgdso53UDFXQUYrBvMyarImXy
         edydHjjz2LO4QMZ2zNrJ8c/A2dwK6wwC+jooYlRwX9R4tFDODf6co72JODXF5W/eep
         PHjHTESyqBfRjXAOQkzGtn+G5lvKeywVIo++jbE6HvJ5/6e6DyL6FZ3h4cAN2cX+sH
         IR8FKsMFqxSXTQPjov3Y0dyqILcG6MmOMFySPW7aljn+EfPad7u7WHTnyJMbo5vgtG
         ERXIgVTtXLjgj6CDqpHZdAyMEbt79RzWVA3HHK3nBeDCqyEMyRNMhaCcDogqT+KesS
         VYKOQzzN7KK7g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 09/27] kconfig: remove grammatically ambiguous "unexpected option" diagnostic
Date:   Tue, 11 Dec 2018 20:00:52 +0900
Message-Id: <1544526070-16690-10-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit decreases 15 shift/reduce conflicts.

The location of this error recovery is ambiguous.

For example, there are two ways to interpret the following code:

  1 config FOO
  2         bool "foo"

 [A] Both lines are reduced together into a config_stmt.

 [B] The only line 1 is reduced into a config_stmt, and the line 2
     matches to "option_name error T_EOL"

Of course, we expect [A], but [B] could be grammatically possible.

Kconfig has no terminator for a config block. So, we cannot detect its
end until we see non-property keywords. People often insert a blank
line between two config blocks, but it is just a coding convention.
Blank lines are actually allowed anywhere in Kconfig files.

The real error is when a property keyword appears right after "endif",
"endchoice", "endmenu",  "source", "comment", or variable assignments.

Instead of fixing the grammatical ambiguity, I chose to simply remove
this error recovery.

The difference is

  unexpected option "bool"

... is turned into a more generic message:

  invalid statement

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/zconf.y | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index 02bfc62..cef6123 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -31,7 +31,7 @@ struct symbol *symbol_hash[SYMBOL_HASHSIZE];
 static struct menu *current_menu, *current_entry;
 
 %}
-%expect 21
+%expect 6
 
 %union
 {
@@ -94,7 +94,6 @@ static struct menu *current_menu, *current_entry;
 %type <expr> expr
 %type <expr> if_expr
 %type <id> end
-%type <id> option_name
 %type <menu> if_entry menu_entry choice_entry
 %type <string> symbol_option_arg word_opt assign_val
 
@@ -127,17 +126,9 @@ stmt_list:
 	| stmt_list menu_stmt
 	| stmt_list end			{ zconf_error("unexpected end statement"); }
 	| stmt_list T_WORD error T_EOL	{ zconf_error("unknown statement \"%s\"", $2); }
-	| stmt_list option_name error T_EOL
-{
-	zconf_error("unexpected option \"%s\"", $2->name);
-}
 	| stmt_list error T_EOL		{ zconf_error("invalid statement"); }
 ;
 
-option_name:
-	T_DEPENDS | T_PROMPT | T_TYPE | T_SELECT | T_IMPLY | T_OPTIONAL | T_RANGE | T_DEFAULT | T_VISIBLE
-;
-
 common_stmt:
 	  if_stmt
 	| comment_stmt
-- 
2.7.4

