Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4809C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A5F2089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kq/LgO9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A5F2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeJBRtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:49:47 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43531 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbeJBRtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:49:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id 30-v6so1050838plb.10;
        Tue, 02 Oct 2018 04:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xKOWY3ZtkI/ivBPYkF7de7JpAw2y8izYnMGez5xJs+8=;
        b=Kq/LgO9+GZgtGNbTAlTSnV3cAW6ceQ5KgmQ8aSnTgyhusHLf3WtYrBgjPpMpg0rK+s
         gJFHyOfXP/F0iT0NqLHp6JHuXigd27qTx32pSMjkKX6y8X64pUyDpT4Bek+bPNHFuUd1
         X1STTO6FvrtO4BH5DpnwoBUv5l2JBZzGE73pWTUwfXJTqzmKCq4sTV7mtTDxMQ9dIROs
         uuFQA/gbdCrxjCZgj/ejeZY0z0LbqfEp+g1KAduXHHPCly+fw+IQqY7Aj/HKolLFF1wh
         8DxdVERWU5SaRHYvOkNWRD0P9GC0SgqPWlPnsf+bWfhO8Bv7Ag/U1WXicKFv400QVIhx
         ZX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xKOWY3ZtkI/ivBPYkF7de7JpAw2y8izYnMGez5xJs+8=;
        b=JR4+l4DqI80xp+1i+D68QqKt6KiVr/BJjaG4GPkAJWsGQp1JFt/Gc0+t/nLBTVklmm
         ExXsXN7/ns3Jp32kzY8tuUzC20cZgA97qdBvp+hDgNweQZgbGAzsmGld3BxPA5ctc8is
         +68lUAT8XYte0A+V0SOGH5WSYrV9rAdnGsmGI95mE++kRbIfoEe1eMJJfoEWBFSc+Aev
         ASxh03ucSOtemhNA2Vn2vATARCXTkwyIHoyfFY43TZJs4g8andKDYwseczrLORYLt18k
         9dB1haPikGILmNHKHwgs/b6LW0edsEtRKlkOzQ7r1dZq9va/OGwdtW9vJcULn1u2mC/v
         jQ/Q==
X-Gm-Message-State: ABuFfojW49I8lYx5LeXV+afZvmq/UICYEJn9b9GI5bIDt7eBI/HAUjKZ
        rpgqbEbputaJsCamyzDVY6GWb/EOYDo=
X-Google-Smtp-Source: ACcGV63x6la2ew6DEodlzLnHfUt18/5CuiRJOIcwsHx38aibRvqla5tfwod0Hsc/j8a+NK/obSHX1w==
X-Received: by 2002:a63:145f:: with SMTP id 31-v6mr13786962pgu.35.1538478422865;
        Tue, 02 Oct 2018 04:07:02 -0700 (PDT)
Received: from hieu-Inspiron-7577.net.fpt ([1.54.224.16])
        by smtp.gmail.com with ESMTPSA id f1-v6sm22917929pgc.4.2018.10.02.04.07.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 04:07:01 -0700 (PDT)
From:   Hieu Tran Dang <dangtranhieu2012@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Hieu Tran Dang <dangtranhieu2012@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: fsl-lpspi: Prevent FIFO under/overrun by default
Date:   Tue,  2 Oct 2018 18:06:36 +0700
Message-Id: <20181002110636.5052-1-dangtranhieu2012@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain devices don't work well when a transmit FIFO underrun or
receive FIFO overrun occurs. Example is the SAF400x radio chip when
running at high speed which leads to garbage being sent to/received from
the chip. In which case, it should stall waiting for further data to be
available before proceeding. This patch unset the NOSTALL bit in CFGR1
by default to prevent this issue.

Signed-off-by: Hieu Tran Dang <dangtranhieu2012@gmail.com>
---
 drivers/spi/spi-fsl-lpspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index e6d5cc6ab108..51670976faa3 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -276,7 +276,7 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
 
 	fsl_lpspi_set_watermark(fsl_lpspi);
 
-	temp = CFGR1_PCSCFG | CFGR1_MASTER | CFGR1_NOSTALL;
+	temp = CFGR1_PCSCFG | CFGR1_MASTER;
 	if (fsl_lpspi->config.mode & SPI_CS_HIGH)
 		temp |= CFGR1_PCSPOL;
 	writel(temp, fsl_lpspi->base + IMX7ULP_CFGR1);
-- 
2.17.1

