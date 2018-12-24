Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1E4C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB6C218D0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpPOawWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbeLXWBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:01:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46331 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbeLXWBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:01:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so12516961wrt.13;
        Mon, 24 Dec 2018 14:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yuQXdVUQ9R0GH2pEbqaSUK1RsDR3ktcKH1dkIwIBJFk=;
        b=OpPOawWkEWM1Cr2jMu4bxnJQ0drzy3p/rtF9teIe8kKzD04Z7l5Fun8XizxK/+Y/a8
         LIrCZpzlfIp9tPawqE2C8HfxxMemJOpd56zQeA+ressjU/kQ/LNddlHctQpvuT+yHPuP
         AU43U+lMYjcxQFhLux2ItNi2P8oZ/0IGQdqq112Yxvjy/XbpCO1Z7zMzwLOq+tmIvzKA
         er2F+b4F7D0rXu+chMQ8iP5Zb21E68LshPdiRuITFB0su3P5W4s/excYbHJZTPTDWVas
         26cuZO/5oStfeyMlWBpa0XYFeyTx8i5DlgQ7I9XBRk1HdhcGkVxnrxZ9qR4ZXmn3C0Vy
         qYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yuQXdVUQ9R0GH2pEbqaSUK1RsDR3ktcKH1dkIwIBJFk=;
        b=Cb1SFTclHFLiuVxoyrORRpw/uGk1L+Njry0tCxrRcZelopKCgbWVlrJimC/XxaKIeD
         NgwCFO5K81XmIBbwnWThmtP0pJhuRtwi7Bms8Gz2dxkosJP14Ao9YrIN9azGPE0Ntl6o
         A8LgklkYGcODcGX0GrSaY4vQwNmt0VLc8DNaFcpEMztwjbURW1Xcw8Oz15JOxgqpY5mF
         5LSlt69ilTMOvwS0+rF9Vm01/YmOz9mMZeTIDGLnx4sjaGRNsAAbQ8WDa12n64TtRmkY
         bxx0/VteN1J7XoSX+EOO8UuFvO192S+sIg01sIxcG2RENcj4jtWLCw4bU3Nluqk5XRAE
         UaVg==
X-Gm-Message-State: AJcUukclQa1Ns2sFKlCCZB+iz9icDeZR014GgGZBkJGYmiHmvecVeqYB
        XRxFDNHRGvA0JXB+gQrXTXY=
X-Google-Smtp-Source: ALg8bN54HhVK5DC6H4W/r8G3ntxk8eOT6geZZ6jMgRZ4vjY3EzMiL8Ts3gl03YWZX2ys+X4yjjtJDw==
X-Received: by 2002:adf:d089:: with SMTP id y9mr13310723wrh.22.1545688865727;
        Mon, 24 Dec 2018 14:01:05 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (daw20.neoplus.adsl.tpnet.pl. [83.23.22.20])
        by smtp.gmail.com with ESMTPSA id d4sm23970153wrp.89.2018.12.24.14.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 14:01:05 -0800 (PST)
From:   cezary.gapinski@gmail.com
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Cezary Gapinski <cezary.gapinski@gmail.com>
Subject: [PATCH v2 08/14] spi: stm32: rename interrupt function
Date:   Mon, 24 Dec 2018 23:00:34 +0100
Message-Id: <1545688840-23992-9-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

Interrupt function is used as a thread so rename it to express
meaning directly by more clear function name.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 drivers/spi/spi-stm32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 2ece69a..9cb7d33 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -466,11 +466,11 @@ static bool stm32_spi_can_dma(struct spi_master *master,
 }
 
 /**
- * stm32_spi_irq - Interrupt handler for SPI controller events
+ * stm32_spi_irq_thread - Thread of interrupt handler for SPI controller
  * @irq: interrupt line
  * @dev_id: SPI controller master interface
  */
-static irqreturn_t stm32_spi_irq(int irq, void *dev_id)
+static irqreturn_t stm32_spi_irq_thread(int irq, void *dev_id)
 {
 	struct spi_master *master = dev_id;
 	struct stm32_spi *spi = spi_master_get_devdata(master);
@@ -1113,7 +1113,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 		goto err_master_put;
 	}
 	ret = devm_request_threaded_irq(&pdev->dev, spi->irq, NULL,
-					stm32_spi_irq, IRQF_ONESHOT,
+					stm32_spi_irq_thread, IRQF_ONESHOT,
 					pdev->name, master);
 	if (ret) {
 		dev_err(&pdev->dev, "irq%d request failed: %d\n", spi->irq,
-- 
2.7.4

