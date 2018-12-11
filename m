Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFEEC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147052081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mwktbhaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 147052081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbeLKLES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:04:18 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:36636 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeLKLBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:01:41 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wBBB1C5m017210;
        Tue, 11 Dec 2018 20:01:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBBB1C5m017210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544526081;
        bh=m3JoEOK4UyUXfBThLu/B9ZmqSbB1lwgoGZ57SfpSYt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mwktbhaKxhmw4kY34rRDJAxpw9leZBIb9cARnQonmsiG9nNbnMVN16D0mJR6L1kba
         TwW5um939Ev7xYqLI4/+Nzzjwh+cAFgVNIzw4fuWesfNe/oN27iu6LjPuClBm+7PbV
         h/4SL+0Bzz0bQ7aWOCzQLjIsEuEkzviEwA+kEIqNBJJEMcxdU4oQVbLjNpmE+c1uKj
         X/y9fxXI4mSMrH9kPauyG/cgduRN5p0lJ73mkz218dHkCVCjA2mP/f/+xiXimO/QXd
         ChCChhfo1FCEl6T2vrxtNs4pi93MxHxuRoKOKpboUqzRm9PnaKMcJUwZIUqlUj8QZD
         v51cCD6xhP/ZQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 11/27] kconfig: remove redundant if_block rule
Date:   Tue, 11 Dec 2018 20:00:54 +0900
Message-Id: <1544526070-16690-12-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code block surrounded by "if" ... "endif" is stmt_list.

Remove the redundant if_block symbol entirely.

Remove "stmt_list: stmt_list end" rule as well since it would
obviously cause conflicts.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/zconf.y | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index a92f167..dcbf643 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -123,7 +123,6 @@ stmt_list:
 	| stmt_list common_stmt
 	| stmt_list choice_stmt
 	| stmt_list menu_stmt
-	| stmt_list end			{ zconf_error("unexpected end statement"); }
 	| stmt_list T_WORD error T_EOL	{ zconf_error("unknown statement \"%s\"", $2); }
 	| stmt_list error T_EOL		{ zconf_error("invalid statement"); }
 ;
@@ -330,14 +329,7 @@ if_end: end
 	}
 };
 
-if_stmt: if_entry if_block if_end
-;
-
-if_block:
-	  /* empty */
-	| if_block common_stmt
-	| if_block menu_stmt
-	| if_block choice_stmt
+if_stmt: if_entry stmt_list if_end
 ;
 
 /* menu entry */
-- 
2.7.4

