Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AF3C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC92720880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4nDvzcS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC92720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeIZCrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:47:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43865 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeIZCrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:47:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id j26-v6so12007670pfi.10;
        Tue, 25 Sep 2018 13:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8cIOTAx+7VXlfn2x3x167xXUWgOaxDYMOONYDEeIta8=;
        b=e4nDvzcSi/gud+1QWXzhlPJlrkHRsOyqMEcvA0i4CkEpdme7f4tDEgechBXdCSIMFs
         bLRNMw7zmOLLrRVXaeQeNbck89EXG3gJAXfgLevVbtwKl0U6/jpoW08dp2bo3CqYid0K
         njkYrXi2T9PpKrlR86CSXKRV8EYhyT7SbvE+Z4KgmOMcW7NkLzaKRmyQ9Ed1RTOU20UV
         WwvdLTqyGwxPjs95yjNJP2eyuzak65As3zoUW2uoPrHktdd81N0Cc5oQScFvjqJ4GxUI
         xUYjxVxN5lnLWP/REWfBxhlptKMoLkdye6Sp7cffkwQAy6pAcy/JW1jYvVUPHCcRiUsJ
         NUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8cIOTAx+7VXlfn2x3x167xXUWgOaxDYMOONYDEeIta8=;
        b=dJpEdvAb/zyInoza2mK9iKSJsUGH3jFfgCzZm/T67hru19nud+I0xUjOP4xoQy3SYD
         su0MnZrFVzb2c4ZIWj8SJubZLxkjCYHFOssZbcHEo+FehBe/HmMkSdX6EXDTWOHF+E98
         QmK9IxZVZd1boMWz/9t8ZewfBh0Qmc0949SawtGZ2ZsB3mWPsR1CTH4qWB3t0aKqerGJ
         zDY3C6NSSFO1+ECnxn8hy0F9KOhq6tQOYQPpoRW79UbDQRraHkCozNEyqgEfky6bdu4C
         AT5G5h7JSnjjI/JCRYO879dPg9UkymNgTTG7FOrklkSRXl7v+CpQXLdAWoIeviNd/RSk
         XqXw==
X-Gm-Message-State: ABuFfohKPtzvDA7yxml/588PlWSzyzkxd9zFcwReYS7tEdtjhcFJvLAk
        KAVBPQXBskqx+EcJsU4o+10=
X-Google-Smtp-Source: ACcGV62JyWII1J8LZ9acsSxdyPnOmjxah0DehZk2r6A9kNvfvC4riDvQ9bxcAHBDlsRhnsQomDnARA==
X-Received: by 2002:a63:1021:: with SMTP id f33-v6mr2571845pgl.72.1537907861429;
        Tue, 25 Sep 2018 13:37:41 -0700 (PDT)
Received: from hieu-Inspiron-7577.net.fpt ([1.54.224.16])
        by smtp.gmail.com with ESMTPSA id g3-v6sm4042129pfi.9.2018.09.25.13.37.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 13:37:40 -0700 (PDT)
From:   Hieu Tran Dang <dangtranhieu2012@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Gao Pan <pandy.gao@nxp.com>
Cc:     Hieu Tran Dang <dangtranhieu2012@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] spi: fsl-lpspi: Option to prevent FIFO under/overrun
Date:   Wed, 26 Sep 2018 03:37:01 +0700
Message-Id: <20180925203701.13605-3-dangtranhieu2012@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925203701.13605-1-dangtranhieu2012@gmail.com>
References: <20180925203701.13605-1-dangtranhieu2012@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain devices don't work well when a transmit FIFO underrun or
receive FIFO overrun occurs. Example is the SAF400x radio chip when
running at high speed which leads to garbage being sent to/received from
the chip. In which case, it should stall waiting for further data to be
available before proceeding. This patch add option to configure the SPI
controller to allow stalling (unset NOSTALL bit in CFGR1).

Signed-off-by: Hieu Tran Dang <dangtranhieu2012@gmail.com>
---
 drivers/spi/spi-fsl-lpspi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index e6d5cc6ab108..7588b62ef08b 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -73,6 +73,7 @@ struct lpspi_config {
 	u8 prescale;
 	u16 mode;
 	u32 speed_hz;
+	bool nostall;
 };
 
 struct fsl_lpspi_data {
@@ -276,7 +277,11 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
 
 	fsl_lpspi_set_watermark(fsl_lpspi);
 
-	temp = CFGR1_PCSCFG | CFGR1_MASTER | CFGR1_NOSTALL;
+	temp = CFGR1_PCSCFG | CFGR1_MASTER;
+
+	if (fsl_lpspi->config.nostall)
+		temp |= CFGR1_NOSTALL;
+
 	if (fsl_lpspi->config.mode & SPI_CS_HIGH)
 		temp |= CFGR1_PCSPOL;
 	writel(temp, fsl_lpspi->base + IMX7ULP_CFGR1);
@@ -475,6 +480,9 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 
 	clk_disable_unprepare(fsl_lpspi->clk);
 
+	fsl_lpspi->config.nostall =
+		!of_get_property(pdev->dev.of_node, "fsl,allow-stall", NULL);
+
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "spi_register_master error.\n");
-- 
2.17.1

