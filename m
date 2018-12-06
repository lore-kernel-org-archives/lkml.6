Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9BFC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B618F2082D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="k1ewxlKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B618F2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbeLFD4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 22:56:47 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:59102 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbeLFD4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 22:56:45 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wB63trS9007398;
        Thu, 6 Dec 2018 12:55:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wB63trS9007398
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544068556;
        bh=vq9iTJECSWUXoTz65/XclZ3Mf1gaCLqGMYaa34hNQzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k1ewxlKKR/XsG0V3d2Akt8g4TCv+aHm8a3OUtlC8uoyfqlPwXE86mMbvpBNYHAlGk
         BFw+pLk33zxTefChgiYmvRz76SlVxWnBLj35a8HUEWMpcUJvqzCTkbzMoN2pUZkxVO
         Aqgk9SixT51vdYPldt7PYFF3ed0DzNmduOj+Q644GKI6qusqPACK6k1PxU+L4pmCMi
         qJHrijhwNA+bowo36nqA7rR6QrV4MySgNH/FvcX0nvGW4lGgfRtR/KRfMYth4XZPhf
         VIM1lNbkIJWyYvU3QofXTnynRpj/7Xjn0nbU2rsVxvBhaxfCe/4mWpILRNuQCp570B
         x4fQeA+ztAolA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-i2c@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] i2c: uniphier-f: fix violation of tLOW requirement for Fast-mode
Date:   Thu,  6 Dec 2018 12:55:28 +0900
Message-Id: <1544068528-27657-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544068528-27657-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544068528-27657-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the clock duty is set as tLOW/tHIGH = 1/1. For Fast-mode,
tLOW is set to 1.25 us while the I2C spec requires tLOW >= 1.3 us.

tLOW/tHIGH = 5/4 would meet both Standard-mode and Fast-mode:
  Standard-mode: tLOW = 5.56 us, tHIGH = 4.44 us
  Fast-mode:     tLOW = 1.39 us, tHIGH = 1.11 us

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/i2c-uniphier-f.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index d8a5db14..03da4a5 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -518,9 +518,26 @@ static void uniphier_fi2c_hw_init(struct uniphier_fi2c_priv *priv)
 
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
2.7.4

