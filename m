Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D978C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F056214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwX9tbl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F056214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=esmil.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbeJJQXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:23:07 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43822 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbeJJQXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:23:06 -0400
Received: by mail-lj1-f195.google.com with SMTP id r8-v6so4161222ljc.10;
        Wed, 10 Oct 2018 02:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KG0sdeNKejQuoulTZccIXDqy9239NiodF80G4qiM8YQ=;
        b=dwX9tbl84V4YOiGml1DAurWDeR8exFtugbPJNbxcT3UPtyFENSkRyU7ZEQo4JxO3zW
         LL3mP7Pwto6nYU5Rnv1WinEOVonO69hBozgBT71UJrGcC8lEGSjSIo+IjfAko3INSbWk
         t79mekUZ75iYa+X6RUO4Iyh0xOxpAu+yAjTWl4ztfjMBkfvbq01jf0ETYt0KWnXJ1Gir
         UZqORd56eG+GrRYSVcuXJ3uzesS8A4+ya28Fywns7SwZ39Tci6LS2mGP7OoXfm2q2ELm
         IMalUTbuGHegep8O24FSD48kBick+APcQfwuut7nbTTtFnqRPywJL1LbQ5030Wg3kFp3
         i0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KG0sdeNKejQuoulTZccIXDqy9239NiodF80G4qiM8YQ=;
        b=Le2sPOE5FAX/Xzn0R1TVnFYstE0FA7VLEiLRQ5wZB1e+nw5HjX6pDVnZTv4lqXRJ/v
         uFAP5qHlEp2/6Fuf2tTGRlduxXcuUk/uOOMpLNZtlrO7Xi+dm1brr222svCWknuDR6Fs
         Cyn1qIgzoEuCBhtznEAuyeV7alJMacxc/Bz2aMd82Nm6SFHnYOzG9JaEnkZTIJRZ7pq+
         odof2b4QRnwARf93DRy0W/vksyFc8G9l2yAZb1Fk72ES9kULcn6iCgPlt14/eADoBgks
         SlZ85Wf9EGNPBngy5Cm4kPWmSdyflv9DM19kh4s5DxVAzrBgG0vtVeeImbaW/JsvZV51
         sucA==
X-Gm-Message-State: ABuFfoixmrSZ1+b06XtOVDiSqSwJ8OcU2UjkHWdAwzFb5ijM+xPSAq0V
        xkrX1ACM56t87ltrn5PE6j4=
X-Google-Smtp-Source: ACcGV63TMn627laop0LM3zRqknrAUhl3yFoTD9zz7aGaR1gtxHWXJT/rawTYEFsTs7pc0qLsOeK/Bw==
X-Received: by 2002:a2e:8684:: with SMTP id l4-v6mr3079435lji.52.1539162112525;
        Wed, 10 Oct 2018 02:01:52 -0700 (PDT)
Received: from localhost.localdomain ([5.57.50.195])
        by smtp.gmail.com with ESMTPSA id q2-v6sm2150078lfc.67.2018.10.10.02.01.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 02:01:51 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 4/7] spi: rockchip: remove unneeded dma_caps
Date:   Wed, 10 Oct 2018 11:00:35 +0200
Message-Id: <20181010090038.20834-5-kernel@esmil.dk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181010090038.20834-1-kernel@esmil.dk>
References: <20181010090038.20834-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We no longer need the dma_caps since the dma driver
already clamps the burst length to the hardware limit,
so don't request and store dma_caps in device data.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index ede3002215cd..85358f96f78f 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -207,7 +207,6 @@ struct rockchip_spi {
 	struct sg_table rx_sg;
 	struct rockchip_spi_dma_data dma_rx;
 	struct rockchip_spi_dma_data dma_tx;
-	struct dma_slave_caps dma_caps;
 };
 
 static inline void spi_enable_chip(struct rockchip_spi *rs, int enable)
@@ -777,7 +776,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	}
 
 	if (rs->dma_tx.ch && rs->dma_rx.ch) {
-		dma_get_slave_caps(rs->dma_rx.ch, &(rs->dma_caps));
 		rs->dma_tx.addr = (dma_addr_t)(mem->start + ROCKCHIP_SPI_TXDR);
 		rs->dma_rx.addr = (dma_addr_t)(mem->start + ROCKCHIP_SPI_RXDR);
 		rs->dma_tx.direction = DMA_MEM_TO_DEV;
-- 
2.19.1

