Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54055C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A8D2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LJLQScGS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10A8D2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbeLKLCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:02:49 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:36705 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbeLKLBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:01:43 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wBBB1C5c017210;
        Tue, 11 Dec 2018 20:01:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBBB1C5c017210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544526074;
        bh=mncNGlTLnxVAb43S35qXiIVRiqRfjL/tj0kSfjctkSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LJLQScGS95+DMJ0pUZ4F4ERVfNgBRNdjKdJyw2Jh4YoLQ90RWS1fJqRp1ns8p0P3d
         3bp8GbpD9Y1wWxsww3uUKJBrjm0BSjNPhQCnUanWCRK48hKpp63ZQtM8PRZkQEgufF
         mvrwB2ZRU7VjpeA4mF5+K4B4RTLMYXvkundt6I+l0qbbAx8UHgnMwifvvUgjitNtDo
         XWbNIDGfNJevM2Wi4y03cvQFURMNHmvoWdx7DA3mPeIQJEbYpcKR4e/WulRz+1x6h4
         P7MeFFffvsqg7Fc6wNHG2rQeqDrAKi0ZxlmXn3IJNCxXTKS4MEa3uJaCoI39oedbVn
         yd799o5r/5Bzg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 01/27] kconfig: fix file name and line number of warn_ignored_character()
Date:   Tue, 11 Dec 2018 20:00:44 +0900
Message-Id: <1544526070-16690-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, warn_ignore_character() displays invalid file name and
line number.

The lexer should use current_file->name and yylineno, while the parser
should use zconf_curname() and zconf_lineno().

This difference comes from that the lexer is always going ahead
of the parser. The parser needs to look ahead one token to make a
shift/reduce decision, so the lexer is requested to scan more text
from the input file.

This commit fixes the warning message from warn_ignored_character().

[Test Code]

  ----(Kconfig begin)----
  /
  -----(Kconfig end)-----

[Output]

  Before the fix:

  <none>:0:warning: ignoring unsupported character '/'

  After the fix:

  Kconfig:1:warning: ignoring unsupported character '/'

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/zconf.l | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index 25bd2b8..eeac64c 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -73,7 +73,7 @@ static void warn_ignored_character(char chr)
 {
 	fprintf(stderr,
 	        "%s:%d:warning: ignoring unsupported character '%c'\n",
-	        zconf_curname(), zconf_lineno(), chr);
+	        current_file->name, yylineno, chr);
 }
 %}
 
-- 
2.7.4

