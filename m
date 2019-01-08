Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688F1C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9D020660
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977891;
	bh=qA+ZXobmVcIpgJuu+++TyxAlXb/AT9HGi40aXvqG8G0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ozxw1arvohSb7pKxXQVvuUpNkL9gXZOPBZym8NA++u4HYINyJDu3E9jbJEfMqJXQk
	 hH81tloWh26gkNMcJiGmMBoOC0STjSTBCDgmQu7wBQXGuGGPY+IKHBznhEn9G6Hqao
	 uClZKSBYE7pzhWnM3E34mXvFDo9hCt3nMWYtTPqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbfAHUEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:04:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:35500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730033AbfAHT21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:28:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88ED520645;
        Tue,  8 Jan 2019 19:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975706;
        bh=qA+ZXobmVcIpgJuu+++TyxAlXb/AT9HGi40aXvqG8G0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZPYffrRqkMMjh4BYVxCvj0suUgY5cYjoDi723AyqoqKtNRyDWcVUstUuB658fzuZl
         KXaMCB8fuXOu09yd6NRK/I/oF0oWA0VRBi2UriBW25hRUeXb+IjtmWI1EXDdhrEXmU
         YIGwlDFKi0tymrd3pTScXFlSNdl740o1+qgSQKpw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 067/117] kconfig: fix file name and line number of warn_ignored_character()
Date:   Tue,  8 Jan 2019 14:25:35 -0500
Message-Id: <20190108192628.121270-67-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
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
index 25bd2b89fe3f..eeac64ccc730 100644
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
2.19.1

