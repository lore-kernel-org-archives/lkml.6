Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B78C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8C62082D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="N5WC2H/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8C62082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbeLFD4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 22:56:36 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:58840 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbeLFD4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 22:56:36 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wB63trS8007398;
        Thu, 6 Dec 2018 12:55:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wB63trS8007398
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544068556;
        bh=i2DTwxcgMHeHYcJ2f2azxuoZs+0qhk4Q7YQ7oWQJxew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N5WC2H/19yIcfPFEM11mY3qrS+Dnr9VtgGLKAPEEzKvosZOQB6FhhFkTUJ+ME17cq
         qVTZX3NojjlORMZn4SUYlKzCLSyiT+jOJSjEEbeq2m6jv9ipvDARy7mgPgfaBUvp0e
         RzYLffsbwNhdGywqJFTlJC3BKLEsFHI5/Zj37Oslp7noqh+S8yMRWAVJQSq50+Zfyi
         uXP0DA3VZTRrxrJLxJ9MclnSUZIUqUT6wWt5SkTF3SzsQC8af322i9bmWcUqbhn73Y
         BcewCncPKUhKKsp8htfrvPQ9dit9hmtx9vwyyGqNCJ0qJKUfUKVbOBmNU/0iWdE2IS
         mWgghyI6yiowg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-i2c@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] i2c: uniphier: fix violation of tLOW requirement for Fast-mode
Date:   Thu,  6 Dec 2018 12:55:27 +0900
Message-Id: <1544068528-27657-4-git-send-email-yamada.masahiro@socionext.com>
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

 drivers/i2c/busses/i2c-uniphier.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-uniphier.c b/drivers/i2c/busses/i2c-uniphier.c
index 454f914..c488e55 100644
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
2.7.4

