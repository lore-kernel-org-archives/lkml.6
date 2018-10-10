Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEACEC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7395221502
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSejjSeZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7395221502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=esmil.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeJJQXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:23:03 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46517 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbeJJQXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:23:02 -0400
Received: by mail-lj1-f195.google.com with SMTP id x3-v6so4142101lji.13;
        Wed, 10 Oct 2018 02:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WLfksrGx9Fi3iwQ2Hcus/p3nhLsfw8qp1vLf53uAlEc=;
        b=RSejjSeZ6UhaZsuSXgI45iX6TxJslop2N/nCVC7r68sgO1ItowxP8go10qsOGLPH2k
         eGjBrF23DYoa/pAorVvh8BJfb3Tp5YbSYmI1IeRCUVP/s1PA8DacTRK75UiGUlVE67xr
         SukxDBWAQ0AhhSRfmBQtyn9aE00Dm6771pCaB15GT5tAg8b+Fk2R+aU0Nyi72CEufsyK
         CF8QVG8oCTTDQ+j/EkC92rmDN4m4ZfwQ717ZKhzTPUFZnat4x7bzvMokQ/KQhkDVFHQ7
         lFu7X6bAI45pylKqJpBRYBEjjU6C8pbVhVc/xTGPAdEU0FEZSuutx04Mv2o3yBET/Pom
         QBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=WLfksrGx9Fi3iwQ2Hcus/p3nhLsfw8qp1vLf53uAlEc=;
        b=k85Apm2dTmD/+ROeHLpyH+RTzyKDJEvILkST1GzZVrKuPMEaRbbCT4WJIj1HsIAxkV
         NItybGfL4QnHPbeqlAoAnypdoeQFnXqRHxR3jgNk576Yuv+GhbruIEhMKZIbBrzAsHTC
         eNSTiL8q2DQ+aa9gykr3DJrhvdvJ4PhRWcgWfCIw+mUxWSbv+wOjoHCxlbH+DRWlJNy/
         6st44QahszrdECAojgp6xbIX63Ctl66CagjKj4WBhZZiUVLnZUanZ3VEuAkCkqJNXmcF
         dhIcAou8PWm5E1bHxxyW3kh/vKeEAdrtwTva06lS5kMV7szshqaqUyKTnKcdbGoM/ZZJ
         xX1w==
X-Gm-Message-State: ABuFfoijNVudwPFUlNBZ6SpvDdFJYfC3DTKlU0WwveMpFJ55k4n6H1Iz
        5RHIZeqdNUi97wod5CzlmJQ=
X-Google-Smtp-Source: ACcGV62ST321hoWnmn1sD9Ow7VAjsVxgvBxPdyTAUZv0RRCfGXsbbXLP0VSGim+kpzKLjBePZ/2W0w==
X-Received: by 2002:a2e:87da:: with SMTP id v26-v6mr21776381ljj.13.1539162108528;
        Wed, 10 Oct 2018 02:01:48 -0700 (PDT)
Received: from localhost.localdomain ([5.57.50.195])
        by smtp.gmail.com with ESMTPSA id q2-v6sm2150078lfc.67.2018.10.10.02.01.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 02:01:47 -0700 (PDT)
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-rockchip@lists.infradead.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Mark Brown <broonie@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Randy Li <ayaka@soulik.info>, Chris Zhong <zyw@rock-chips.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Huibin Hong <huibin.hong@rock-chips.com>
Subject: [PATCH 2/7] spi: rockchip: adjust dma watermark and burstlen
Date:   Wed, 10 Oct 2018 11:00:33 +0200
Message-Id: <20181010090038.20834-3-kernel@esmil.dk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181010090038.20834-1-kernel@esmil.dk>
References: <20181010090038.20834-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huibin Hong <huibin.hong@rock-chips.com>

Signal tx dma when spi fifo is less than half full,
and limit tx bursts to half the fifo length.

Clamp rx burst length to 1 to avoid alignment issues.

Signed-off-by: Huibin Hong <huibin.hong@rock-chips.com>
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 185bbdce62b1..ede3002215cd 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -458,10 +458,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		rxconf.direction = rs->dma_rx.direction;
 		rxconf.src_addr = rs->dma_rx.addr;
 		rxconf.src_addr_width = rs->n_bytes;
-		if (rs->dma_caps.max_burst > 4)
-			rxconf.src_maxburst = 4;
-		else
-			rxconf.src_maxburst = 1;
+		rxconf.src_maxburst = 1;
 		dmaengine_slave_config(rs->dma_rx.ch, &rxconf);
 
 		rxdesc = dmaengine_prep_slave_sg(
@@ -480,10 +477,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		txconf.direction = rs->dma_tx.direction;
 		txconf.dst_addr = rs->dma_tx.addr;
 		txconf.dst_addr_width = rs->n_bytes;
-		if (rs->dma_caps.max_burst > 4)
-			txconf.dst_maxburst = 4;
-		else
-			txconf.dst_maxburst = 1;
+		txconf.dst_maxburst = rs->fifo_len / 2;
 		dmaengine_slave_config(rs->dma_tx.ch, &txconf);
 
 		txdesc = dmaengine_prep_slave_sg(
@@ -581,7 +575,7 @@ static void rockchip_spi_config(struct rockchip_spi *rs)
 	writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_TXFTLR);
 	writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_RXFTLR);
 
-	writel_relaxed(0, rs->regs + ROCKCHIP_SPI_DMATDLR);
+	writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_DMATDLR);
 	writel_relaxed(0, rs->regs + ROCKCHIP_SPI_DMARDLR);
 	writel_relaxed(dmacr, rs->regs + ROCKCHIP_SPI_DMACR);
 
-- 
2.19.1

