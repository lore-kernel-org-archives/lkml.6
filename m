Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1108DC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC49206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC49206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbeLDNlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 08:41:12 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:55838 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726165AbeLDNlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 08:41:11 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id wB4DAcSu010699;
        Tue, 4 Dec 2018 15:10:38 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 5D82E62DA6; Tue,  4 Dec 2018 15:40:36 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        yuenn@google.com, venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au
Cc:     linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1] spi: npcm: Modify pspi send function
Date:   Tue,  4 Dec 2018 15:40:35 +0200
Message-Id: <20181204134035.124079-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align pspi send function code with the recieve function
code, Also simplify the code a bit with early return.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/spi/spi-npcm-pspi.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
index dda91c19af93..e1dca79b9090 100644
--- a/drivers/spi/spi-npcm-pspi.c
+++ b/drivers/spi/spi-npcm-pspi.c
@@ -199,14 +199,22 @@ static void npcm_pspi_send(struct npcm_pspi *priv)
 	wsize = min(bytes_per_word(priv->bits_per_word), priv->tx_bytes);
 	priv->tx_bytes -= wsize;
 
-	if (priv->tx_buf) {
-		if (wsize == 1)
-			iowrite8(*priv->tx_buf, NPCM_PSPI_DATA + priv->base);
-		if (wsize == 2)
-			iowrite16(*priv->tx_buf, NPCM_PSPI_DATA + priv->base);
+	if (!priv->tx_buf)
+		return;
 
-		priv->tx_buf += wsize;
+	switch (wsize) {
+	case 1:
+		iowrite8(*priv->tx_buf, NPCM_PSPI_DATA + priv->base);
+		break;
+	case 2:
+		iowrite16(*priv->tx_buf, NPCM_PSPI_DATA + priv->base);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return;
 	}
+
+	priv->tx_buf += wsize;
 }
 
 static void npcm_pspi_recv(struct npcm_pspi *priv)
-- 
2.14.1

