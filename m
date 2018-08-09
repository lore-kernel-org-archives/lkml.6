Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6041C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7988C21DEC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpQBG07R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7988C21DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731123AbeHIO47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:56:59 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40304 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeHIO47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:56:59 -0400
Received: by mail-lj1-f196.google.com with SMTP id j19-v6so4339952ljc.7;
        Thu, 09 Aug 2018 05:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D1sDPXhQQniTLXmTuOm/gef4RBax2tMfAQNSYiTIeu8=;
        b=PpQBG07RN67b9OPaVVaXqGxajSHMb3y+0QNIGN+nI3V9EsckPO80ONqzo6Js9tFb5y
         XopHvrvgCqXnmkHrL6Tm5KhQSHCfIRvYa3RpmMOP2cl+hcssbSgN2Wsdvwp2eOE2QJqs
         nSvA7ON48Bo1jg9X8TIE5VOhiy9f4H2X7FlUNnyv20zOSFyFFdN7k0gl+QPyyaviUjXh
         bOTGkPBhG/In8FUJcN5clEKj57Q0OcPfKQmAf6wD+NXSUS99wpHBQgZFlfrne1DPRz34
         UBafTuhIRI/nvfxDrWmUPnspMYYtiQ8Kb8IOFjujr4WgbEOZn5s1GUSbt3xoWZjREQUX
         vNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=D1sDPXhQQniTLXmTuOm/gef4RBax2tMfAQNSYiTIeu8=;
        b=GZWMykg3gDrluXOKG0Wwf527d2IzwuoEz+l8eFrDnSTBdH/ndK0xtedTSM4BeVuve8
         duz6C0xi/koFEf+VOaUYygNqetuL9ndCLIvf15/wejcd5UK1C942YumhAPsIVntDgBg7
         dZRdJRXIMnGmfyO9dq7LuBD3xVtFNKGOZqpj9km7mWcvfignxG4u+uhknkSMhoenOlKO
         nlQ9rr9GeE8g3XQpE/vkLCBUh/a8bzrzfiAWl33ewr2aC7tMBasoc9CabwpSIheDragQ
         2Fab++b2XUC+x4K+fd8K1oR0Rb8tppw4YdmrUPGc+YuIgiscaMNtK49yWf46z0XJEdLz
         WRWQ==
X-Gm-Message-State: AOUpUlGRLCyTYz1LnZj3QrKlMWNtFz4LdvDC9+cNMvnB4qSuf4l980B6
        T1cVwFk/KyniRUal82gnWJvIB0oK4ng=
X-Google-Smtp-Source: AA+uWPznEjMGqhbhV2LvaFkX+D88CNgDEkao5vMbc/rzqfiwyJ0eX3Qtddmd0bvgFuVFgAxn/GkLiA==
X-Received: by 2002:a2e:10ca:: with SMTP id 71-v6mr1625229ljq.59.1533817936346;
        Thu, 09 Aug 2018 05:32:16 -0700 (PDT)
Received: from localhost (87-57-30-174-static.dk.customer.tdc.net. [87.57.30.174])
        by smtp.gmail.com with ESMTPSA id v9-v6sm1131927lje.20.2018.08.09.05.32.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 05:32:15 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     linux-i2c@vger.kernel.org
Cc:     Esben Haabendal <eha@deif.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Wei Jinhua <wei.jinhua1@zte.com.cn>,
        Phil Reid <preid@electromag.com.au>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] i2c: imx: Simplify stopped state tracking
Date:   Thu,  9 Aug 2018 14:32:06 +0200
Message-Id: <20180809123207.9732-3-esben.haabendal@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809123207.9732-1-esben.haabendal@gmail.com>
References: <20180809123207.9732-1-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <eha@deif.com>

Always update the stopped state when busy status have been checked.
This is identical to what was done before, with the exception of error
handling.
Without this change, some errors cause the stopped state to be left in
incorrect state in i2c_imx_stop(), i2c_imx_dma_read(), i2c_imx_read() and
i2c_imx_xfer().

Signed-off-by: Esben Haabendal <eha@deif.com>
---
 drivers/i2c/busses/i2c-imx.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index f7bd6c21da27..8fb61691e226 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -421,10 +421,14 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy)
 			return -EAGAIN;
 		}
 
-		if (for_busy && (temp & I2SR_IBB))
+		if (for_busy && (temp & I2SR_IBB)) {
+			i2c_imx->stopped = 0;
 			break;
-		if (!for_busy && !(temp & I2SR_IBB))
+		}
+		if (!for_busy && !(temp & I2SR_IBB)) {
+			i2c_imx->stopped = 1;
 			break;
+		}
 		if (time_after(jiffies, orig_jiffies + msecs_to_jiffies(500))) {
 			dev_dbg(&i2c_imx->adapter.dev,
 				"<%s> I2C bus is busy\n", __func__);
@@ -538,7 +542,6 @@ static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
 	result = i2c_imx_bus_busy(i2c_imx, 1);
 	if (result)
 		return result;
-	i2c_imx->stopped = 0;
 
 	temp |= I2CR_IIEN | I2CR_MTX | I2CR_TXAK;
 	temp &= ~I2CR_DMAEN;
@@ -567,10 +570,8 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
 		udelay(i2c_imx->disable_delay);
 	}
 
-	if (!i2c_imx->stopped) {
+	if (!i2c_imx->stopped)
 		i2c_imx_bus_busy(i2c_imx, 0);
-		i2c_imx->stopped = 1;
-	}
 
 	/* Disable I2C controller */
 	temp = i2c_imx->hwdata->i2cr_ien_opcode ^ I2CR_IEN,
@@ -724,7 +725,6 @@ static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
 		temp &= ~(I2CR_MSTA | I2CR_MTX);
 		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
 		i2c_imx_bus_busy(i2c_imx, 0);
-		i2c_imx->stopped = 1;
 	} else {
 		/*
 		 * For i2c master receiver repeat restart operation like:
@@ -849,7 +849,6 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs, bo
 				temp &= ~(I2CR_MSTA | I2CR_MTX);
 				imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
 				i2c_imx_bus_busy(i2c_imx, 0);
-				i2c_imx->stopped = 1;
 			} else {
 				/*
 				 * For i2c master receiver repeat restart operation like:
-- 
2.18.0

