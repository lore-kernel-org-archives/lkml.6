Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD3BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1866520656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298327;
	bh=P6XxFcKtyUcYaxiBzU4OaGBPNAjzM0dcifkcIV2QUX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bl9OgS51YnAdzsE6MD/d7aCWbuxG0UTJNYtFQhxNeTWDcLdzKslvYBGJbiiXmzbJJ
	 3zoZkl3BGA6XkLnzpOiS3l9R2TOJ6Tgozzn3MyvkAz+Jcj5b54A3tlOi99lk2YeVzM
	 kqTyjRpOU+PqfhOUhkpuVUWRO25n8AUkt5WHlzQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733212AbeLTJcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:32:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:48768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733149AbeLTJbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:31:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 366D820989;
        Thu, 20 Dec 2018 09:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298293;
        bh=P6XxFcKtyUcYaxiBzU4OaGBPNAjzM0dcifkcIV2QUX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UsZg8KSmAVj5QmgahiyjB5iPp5HN1XkrW5/5W8SWUcROzG2kdmvMxgjZpbUQWU1lb
         b16SbaC9G5AiKljjCuDQXm+Jg+YyAL8aoG1tARvmd6QCREzEEfwGtgLaoGZ/aX73iS
         HwNKRrC2F3lNP/g0DSi3z7YJsMuXLiXh+Q4GGnYA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 64/67] i2c: uniphier-f: fix violation of tLOW requirement for Fast-mode
Date:   Thu, 20 Dec 2018 10:19:16 +0100
Message-Id: <20181220085906.072456413@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
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

[ Upstream commit ece27a337d42a3197935711997f2880f0957ed7e ]

Currently, the clock duty is set as tLOW/tHIGH = 1/1. For Fast-mode,
tLOW is set to 1.25 us while the I2C spec requires tLOW >= 1.3 us.

tLOW/tHIGH = 5/4 would meet both Standard-mode and Fast-mode:
  Standard-mode: tLOW = 5.56 us, tHIGH = 4.44 us
  Fast-mode:     tLOW = 1.39 us, tHIGH = 1.11 us

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-uniphier-f.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index a403e8579b65..bc26ec822e26 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -470,9 +470,26 @@ static void uniphier_fi2c_hw_init(struct uniphier_fi2c_priv *priv)
 
 	uniphier_fi2c_reset(priv);
 
+	/*
+	 *  Standard-mode: tLOW + tHIGH = 10 us
+	 *  Fast-mode:     tLOW + tHIGH = 2.5 us
+	 */
 	writel(cyc, priv->membase + UNIPHIER_FI2C_CYC);
-	writel(cyc / 2, priv->membase + UNIPHIER_FI2C_LCTL);
+	/*
+	 *  Standard-mode: tLOW = 4.7 us, tHIGH = 4.0 us, tBUF = 4.7 us
+	 *  Fast-mode:     tLOW = 1.3 us, tHIGH = 0.6 us, tBUF = 1.3 us
+	 * "tLow/tHIGH = 5/4" meets both.
+	 */
+	writel(cyc * 5 / 9, priv->membase + UNIPHIER_FI2C_LCTL);
+	/*
+	 *  Standard-mode: tHD;STA = 4.0 us, tSU;STA = 4.7 us, tSU;STO = 4.0 us
+	 *  Fast-mode:     tHD;STA = 0.6 us, tSU;STA = 0.6 us, tSU;STO = 0.6 us
+	 */
 	writel(cyc / 2, priv->membase + UNIPHIER_FI2C_SSUT);
+	/*
+	 *  Standard-mode: tSU;DAT = 250 ns
+	 *  Fast-mode:     tSU;DAT = 100 ns
+	 */
 	writel(cyc / 16, priv->membase + UNIPHIER_FI2C_DSUT);
 
 	uniphier_fi2c_prepare_operation(priv);
-- 
2.19.1



