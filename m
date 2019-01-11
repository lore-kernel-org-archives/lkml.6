Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD83C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A07206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218426;
	bh=+xSw01ZDl+AzkFRz29wo2BvvYTGMCQexCU6bgARZ6ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1grq5vcLEdogtU/6CiIbHJILDSe0XeNCJV7c6edh2B+h6DAzDuX8VyGjNj6W7dKVf
	 QV1tFGz8C9BfM1//KLR9l2F3L0RHh/sMaYD0yxy3I0aUJpODpiMmBzluRs8flzwYCN
	 3JjZGL0/nfEKwHmGVK5EnSH2KhmSRMlnPI+7AS0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391157AbfAKOxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:53:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:58554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390727AbfAKOh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:37:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02B562063F;
        Fri, 11 Jan 2019 14:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217478;
        bh=+xSw01ZDl+AzkFRz29wo2BvvYTGMCQexCU6bgARZ6ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UNPP0wMUG1LGDERP15HFxpMlNUltIySifs8KPRIiesMm9VJa0rgV0nvmslq2Tv5lZ
         EXBZhPRhiByD4+ekS6UR3rWnmAD5C5EP9YYXQsaK8eAtz1fTIwvIVLnd4bIORVROxP
         H4GhmhhI7eexIyVe/nL6AbKrQKUMZ4qO2ZT0m+Ek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mans Rullgard <mans@mansr.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 076/148] auxdisplay: charlcd: fix x/y command parsing
Date:   Fri, 11 Jan 2019 15:14:14 +0100
Message-Id: <20190111131117.266402414@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

[ Upstream commit 9bc30ab82108e6a34dc63bf956b49edf71b1681a ]

The x/y command parsing has been broken since commit 129957069e6a
("staging: panel: Fixed checkpatch warning about simple_strtoul()").

Commit b34050fadb86 ("auxdisplay: charlcd: Fix and clean up handling of
x/y commands") fixed some problems by rewriting the parsing code,
but also broke things further by removing the check for a complete
command before attempting to parse it.  As a result, parsing is
terminated at the first x or y character.

This reinstates the check for a final semicolon.  Whereas the original
code use strchr(), this is wasteful seeing as the semicolon is always
at the end of the buffer.  Thus check this character directly instead.

Signed-off-by: Mans Rullgard <mans@mansr.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.19.1



