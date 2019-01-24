Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E80EC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B00E218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358187;
	bh=70j49iqFRcDaDcBtI+gOwuhJDthZss4k3p1I9hVuJQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=INvZ9DvW6NThbidIVjVlX5BRXv3VVYYG5yucdi21H6n+E8GPHw73HdL2Lzc+BW+NJ
	 QEwKlXCLBIYSuLlkYBJO1qsiStSSyPKXhoiXuZ/Vx//ZBZnomVmu8ft9rQc3yIIoXa
	 l9zgU927GsZGpJpKrBSntjBCI1Y+5NPBbTsaCyRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbfAXT3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:29:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:56988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731225AbfAXT3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:29:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 643A4218FC;
        Thu, 24 Jan 2019 19:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358180;
        bh=70j49iqFRcDaDcBtI+gOwuhJDthZss4k3p1I9hVuJQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KlbQuvuQbfjHhVHD0TXIjmgLqu9usv+2C0qiLTksmquXR7w51cXE2Db/d3axV8lXM
         4IlrR8s/gf54y6ozLq/2e9g5CnOCo0Q/zGgwsuoE0rj8vqB+k3yiVZIEG7cgyeEz4/
         ArahGtM6ESh0jxs1MNFBkwQIalI2rYiQdNz6hlnQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 21/39] kconfig: fix file name and line number of warn_ignored_character()
Date:   Thu, 24 Jan 2019 20:20:24 +0100
Message-Id: <20190124190448.992143256@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190448.232316246@linuxfoundation.org>
References: <20190124190448.232316246@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



