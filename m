Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47F7C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6788321726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359754;
	bh=zP1Da8OP0wecU5KsqhdTtuzojtqWoOhuOdCnLgmpKUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E3WT2YAgWpaH2hnS8sr0Q0YOuJjtHk0RkilgrvZFuDcpSx3geSm4HFtItMd1GUPK4
	 xs14Vxbb0bRhSIPikN1TxseXVl38Vi92CX38x7vwbbI1KJLvj3AXRCevNlhoTpuy8e
	 kUGVd4kIVjvczoQJmkLrZFcGxp2QGqZS987pwK2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbfAXTg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:36:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:36410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730196AbfAXTgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:36:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25817218FC;
        Thu, 24 Jan 2019 19:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358582;
        bh=zP1Da8OP0wecU5KsqhdTtuzojtqWoOhuOdCnLgmpKUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RjMPARzN7m2NXYmWKHAB+LO8XsdpPIiZ7EYso0k/QGNlTyTXxXNzM8rdrpPIiIqdy
         IveXK/Fqg9indq16F+7AsdLkPXWHfBgAmBqFNp1zVh6WJFHtGLGnhYUQC9r2un+7eT
         er4cJ3Y5Xi9ZGIbHDkNbB+Ue3cQ7AbsuA0dkzSmU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 058/106] kconfig: fix memory leak when EOF is encountered in quotation
Date:   Thu, 24 Jan 2019 20:20:15 +0100
Message-Id: <20190124190210.115544268@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit fbac5977d81cb2b2b7e37b11c459055d9585273c ]

An unterminated string literal followed by new line is passed to the
parser (with "multi-line strings not supported" warning shown), then
handled properly there.

On the other hand, an unterminated string literal at end of file is
never passed to the parser, then results in memory leak.

[Test Code]

  ----------(Kconfig begin)----------
  source "Kconfig.inc"

  config A
          bool "a"
  -----------(Kconfig end)-----------

  --------(Kconfig.inc begin)--------
  config B
          bool "b\No new line at end of file
  ---------(Kconfig.inc end)---------

[Summary from Valgrind]

  Before the fix:

    LEAK SUMMARY:
       definitely lost: 16 bytes in 1 blocks
       ...

  After the fix:

    LEAK SUMMARY:
       definitely lost: 0 bytes in 0 blocks
       ...

Eliminate the memory leak path by handling this case. Of course, such
a Kconfig file is wrong already, so I will add an error message later.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/kconfig/zconf.l | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index eeac64ccc730..c2f577d71964 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -221,6 +221,8 @@ n	[A-Za-z0-9_-]
 	}
 	<<EOF>>	{
 		BEGIN(INITIAL);
+		yylval.string = text;
+		return T_WORD_QUOTE;
 	}
 }
 
-- 
2.19.1



