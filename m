Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B75C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B1E2063F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976755;
	bh=iHmeG4aa7tFGjpHYelRytZzw4dztBtUJgh64Lleuf1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MwM9m/xrGFJ9fPE5ep5cmkiBf+AhmQgxHtK2h7yxPfXyojrGZktbyOyjXcDpukeMj
	 tYlpZ9M4xO6UswVsaga2RZ/uAaaXnsAGA+k2HIgYbQVtsZ7yLFHJ2HKcO3Dhpq43Cc
	 1X7wb9iIE/z5eoSQPb1bHOmJTrBitICGADA28rCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbfAHTdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:33:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:42004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731571AbfAHTdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:33:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80B31218AF;
        Tue,  8 Jan 2019 19:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975991;
        bh=iHmeG4aa7tFGjpHYelRytZzw4dztBtUJgh64Lleuf1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R1LwQf5nO1ci0iA4esbs8LlFPsGHKxYA3N2N5aFnklMh0mocKWQ1DUn3OoAdmBPKo
         36J/WvHn2Fh0zC2Uk05sJXxfBJ0tYx/OcjVXgZD7GTA9D86/LDHZsXtSOsWyASmNGF
         Ug7BOgr4u/FDRQWv7+e0FqAwaOnxyfcXTgIGTDp8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 29/53] kconfig: fix file name and line number of warn_ignored_character()
Date:   Tue,  8 Jan 2019 14:31:57 -0500
Message-Id: <20190108193222.123316-29-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193222.123316-1-sashal@kernel.org>
References: <20190108193222.123316-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit 77c1c0fa8b1477c5799bdad65026ea5ff676da44 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/kconfig/zconf.l | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index c410d257da06..6534dc5ac803 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -71,7 +71,7 @@ static void warn_ignored_character(char chr)
 {
 	fprintf(stderr,
 	        "%s:%d:warning: ignoring unsupported character '%c'\n",
-	        zconf_curname(), zconf_lineno(), chr);
+	        current_file->name, yylineno, chr);
 }
 %}
 
-- 
2.19.1

