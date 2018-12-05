Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B24C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EC42084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13EC42084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mansr.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeLENxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 08:53:10 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:54966 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727491AbeLENxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 08:53:09 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id CE282149B5; Wed,  5 Dec 2018 13:53:06 +0000 (GMT)
From:   Mans Rullgard <mans@mansr.com>
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] auxdisplay: charlcd: fix x/y command parsing
Date:   Wed,  5 Dec 2018 13:52:47 +0000
Message-Id: <20181205135247.7964-1-mans@mansr.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b34050fadb86 ("auxdisplay: charlcd: Fix and clean up handling of
x/y commands") fixed some problems by rewriting the parsing code,
but also broke things further by removing the check for a complete
command before attempting to parse it.  As a result, parsing is
terminated at the first x or y character.

This reinstates the check for a final semicolon.  Whereas the original
code use strchr(), this is wasteful seeing as the semicolon is always
at the end of the buffer.  Thus check this character directly instead.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/auxdisplay/charlcd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 81c22d20d9d9..60e0b772673f 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -538,6 +538,9 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 	}
 	case 'x':	/* gotoxy : LxXXX[yYYY]; */
 	case 'y':	/* gotoxy : LyYYY[xXXX]; */
+		if (priv->esc_seq.buf[priv->esc_seq.len - 1] != ';')
+			break;
+
 		/* If the command is valid, move to the new address */
 		if (parse_xy(esc, &priv->addr.x, &priv->addr.y))
 			charlcd_gotoxy(lcd);
-- 
2.19.2

