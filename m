Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D131C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC882177E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298115;
	bh=xjd4CMKf4nrJG2aTgG2ooCwurgC4yhBLa0VbeH7+8dw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JrMULKfzIU0kMC2Adj64I2getLG+i3rs/qCPLyVBzFek49DuqvHTUd2qScDhVNeSr
	 qevdZw/6FamYa++ZiMcLaWXx0SA03BcAzr7D0gtx9fioes/o5WcnxiGVZgwmwEiyxm
	 8shmLAotGAAAo8rtu3sD7iPoTSn1AH2I6XUTWdPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732538AbeLTJ2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:28:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:47018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732522AbeLTJ2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:28:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 759F921741;
        Thu, 20 Dec 2018 09:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298109;
        bh=xjd4CMKf4nrJG2aTgG2ooCwurgC4yhBLa0VbeH7+8dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yCvVEXVgwDvrj9676IExoRVlBZFweb+hBzjkO5JNZyRc9yPAK2dZIQ3D+o3pQZGtp
         DMTJwcy6bAnG1g8BkZC2xzyzy/jSlGxOOMcOIxGnvmaytNFSxvxPOHdPyKWyHfAfoy
         PLF6BTBc1oyq351CHiQEydFSDDvDv+I5hCQNO4KQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 68/72] i2c: uniphier: fix violation of tLOW requirement for Fast-mode
Date:   Thu, 20 Dec 2018 10:19:07 +0100
Message-Id: <20181220085925.011761909@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8469636ab5d8c77645b953746c10fda6983a8830 ]

Currently, the clock duty is set as tLOW/tHIGH = 1/1. For Fast-mode,
tLOW is set to 1.25 us while the I2C spec requires tLOW >= 1.3 us.

tLOW/tHIGH = 5/4 would meet both Standard-mode and Fast-mode:
  Standard-mode: tLOW = 5.56 us, tHIGH = 4.44 us
  Fast-mode:     tLOW = 1.39 us, tHIGH = 1.11 us

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-uniphier.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-uniphier.c b/drivers/i2c/busses/i2c-uniphier.c
index 454f914ae66d..c488e558aef7 100644
--- a/drivers/i2c/busses/i2c-uniphier.c
+++ b/drivers/i2c/busses/i2c-uniphier.c
@@ -320,7 +320,13 @@ static void uniphier_i2c_hw_init(struct uniphier_i2c_priv *priv)
 
 	uniphier_i2c_reset(priv, true);
 
-	writel((cyc / 2 << 16) | cyc, priv->membase + UNIPHIER_I2C_CLK);
+	/*
+	 * Bit30-16: clock cycles of tLOW.
+	 *  Standard-mode: tLOW = 4.7 us, tHIGH = 4.0 us
+	 *  Fast-mode:     tLOW = 1.3 us, tHIGH = 0.6 us
+	 * "tLow/tHIGH = 5/4" meets both.
+	 */
+	writel((cyc * 5 / 9 << 16) | cyc, priv->membase + UNIPHIER_I2C_CLK);
 
 	uniphier_i2c_reset(priv, false);
 }
-- 
2.19.1



