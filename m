Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8998DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA1320651
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863950;
	bh=VOoY67vQRUaEKEWFrxKEc2fdNZgo3zbaYvObTwnxrFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JgwxS7vzt/0b3W0AAPTvFytE6M8mo5To/JjueQN1jGY4cMmEYIbEaiZbodNTIAB6X
	 mm43ANBM8l8LM/U5seBeBrY24KnePMMtqCcwrVPgHGdqF/Oyw1km3sxhzc40jXCfDn
	 RVqTMsPfr5li0YMF1ALBSQ+5npxdERmFZotHwrY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbeLZWjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:39:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:38948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbeLZWij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:38:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69B0A20651;
        Wed, 26 Dec 2018 22:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863919;
        bh=VOoY67vQRUaEKEWFrxKEc2fdNZgo3zbaYvObTwnxrFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dlaRaC+TENtEg+lKFE31WGMLWqKm3KYVugX37+UaTYw6g0a7cBWoQyx/B0uCfi1jY
         E6IwW6UvqkRJYzQmM8vJVSTL6rHkQawvTPXHTVuTApsrjmdwIr/3+77pK/j/ChSheR
         aofpHCQm3AnpMD80hGzAspuoPupko8msvF+oUoxU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mans Rullgard <mans@mansr.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 97/97] auxdisplay: charlcd: fix x/y command parsing
Date:   Wed, 26 Dec 2018 17:35:57 -0500
Message-Id: <20181226223557.149329-97-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mans Rullgard <mans@mansr.com>

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

