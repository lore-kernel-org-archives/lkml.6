Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6E0C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB8A2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1Nk2d1fX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB8A2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbeLKLBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:01:42 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:36643 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbeLKLBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:01:41 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wBBB1C5p017210;
        Tue, 11 Dec 2018 20:01:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBBB1C5p017210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544526083;
        bh=1t+Q4fwv0SRz2WilTNb/OLgd9pvAOdz79A9TL0DwMJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Nk2d1fX7ADINjEyR7E4QMZIWWLrhhJzFkvXc0QwOL1jgBEgl3uAjbseNp0Wfsf/Z
         rBuFgs9sWDTyyANy7FmlfqhFmngmMkiDSiGarBC6SRIlftMxdW+7wWqofE/KW/9cVo
         ZvsdtROPWUd3bN+pye77gTxzGmcDrkk1BZeMt7WqdXpVYhkjwliNQAN4CU+i3fSQJ2
         2JvvnrKbrpsA3VSLt/8DwJi1hWlS3V76mgeSUayQgz0Z0mgoVpHy8A1srp7HuDm3dt
         AFDIFcQlH5Fte6ZmPGciie3PR3WNsVMT1sguxqzyTumAKBW/hessqZvybOmlyiJhJP
         avrjdrm8IEEng==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 14/27] kconfig: rename depends_list to comment_option_list
Date:   Tue, 11 Dec 2018 20:00:57 +0900
Message-Id: <1544526070-16690-15-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the comment_stmt is the only user of depends_list. Rename it to
comment_option_list

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/zconf.y | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index 7cc8244..7a4bc58 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -379,7 +379,12 @@ comment: T_COMMENT prompt T_EOL
 	printd(DEBUG_PARSE, "%s:%d:comment\n", zconf_curname(), zconf_lineno());
 };
 
-comment_stmt: comment depends_list
+comment_stmt: comment comment_option_list
+;
+
+comment_option_list:
+	  /* empty */
+	| comment_option_list depends
 ;
 
 /* help option */
@@ -408,11 +413,6 @@ help: help_start T_HELPTEXT
 
 /* depends option */
 
-depends_list:
-	  /* empty */
-	| depends_list depends
-;
-
 depends: T_DEPENDS T_ON expr T_EOL
 {
 	menu_add_dep($3);
-- 
2.7.4

