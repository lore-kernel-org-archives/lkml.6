Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A61AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C00C20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JFyW2Ngv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbfAONrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:47:33 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43552 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbfAONrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:47:33 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so1308593plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 05:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iJghhK3Ea6pnQ7EyMrgiOwYdRz+yXPK9qPAyKingmVg=;
        b=JFyW2Ngva1MEGl5CSZA9zej4PRgkR2zxRydccPGGi39cRrIlXpZV5LpQJJ8Iw91xpe
         gnYDGJIJPDn5YomZAbLU/4xUwd5FhY1agHUl+GeVMoWGkbBpSbgT9h2lPe1tE+MdD+t8
         bUXu2f/mvfYWsoJatf0b3EfzoA6hnt1PA47AE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iJghhK3Ea6pnQ7EyMrgiOwYdRz+yXPK9qPAyKingmVg=;
        b=TUgD3jYVg7LaiaBgI7s0yzNc5ORMF2ziaw9ch0CQWWJwpIC8OJlrvb2LBcVI9MQWIW
         TlGZYgZxPt2bEewR/j3rbIf/z2r0v7270PPi6xkirLQuSAEugbi81+OopKLa+yjCEzmR
         d+W3YhA5hNSv2eH2KddHhr1cWkhCBA4dlbGKVQJMkU3ZVH7vvHGGrzpK8KRB7XkMkcO0
         VhwO3ZyddIVOC7ttGUj7qMmnuvvkh7DiYqKdR6ApqaIDFrNllnnCWZlmVPdAUnwib6Z+
         tyk+dX8GKBwOpSjWp2iiTSYKTjG6YmmHtxUmGmTp2xaGLraCGZHSDk1cunrokomhU6XB
         OsPg==
X-Gm-Message-State: AJcUukffE3vEmUm/6QEgObcoccilobCWq+MbHuqDXNIwruXQdgM1Izuj
        rhxUL4QiMRbciua+hw+O1YvTRA==
X-Google-Smtp-Source: ALg8bN5RXrkNjYkoeMFqGqGkePgB60PfAXAnbWptk+6kRGFjPfeGWKsAR9I2NsxKU5bFHEslAVFfmA==
X-Received: by 2002:a17:902:aa4c:: with SMTP id c12mr4261453plr.48.1547560052298;
        Tue, 15 Jan 2019 05:47:32 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id y71sm5979422pfi.123.2019.01.15.05.47.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jan 2019 05:47:31 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, lanqing.liu@unisoc.com,
        baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] spi: sprd: Fix the error data length in SPI read-only mode
Date:   Tue, 15 Jan 2019 21:46:50 +0800
Message-Id: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lanqing Liu <lanqing.liu@spreadtrum.com>

In SPI read-only mode, we will always return the writing length,
which is always the power of "bits_per_word", but the length unit
using by users is byte.

Thus this patch fixes the returning length by getting from
read_bufs() function to get the correct length.

Signed-off-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/spi/spi-sprd.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 8daa24e..fa324ce 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -380,7 +380,7 @@ static int sprd_spi_txrx_bufs(struct spi_device *sdev, struct spi_transfer *t)
 {
 	struct sprd_spi *ss = spi_controller_get_devdata(sdev->controller);
 	u32 trans_len = ss->trans_len, len;
-	int ret, write_size = 0;
+	int ret, write_size = 0, read_size = 0;
 
 	while (trans_len) {
 		len = trans_len > SPRD_SPI_FIFO_SIZE ? SPRD_SPI_FIFO_SIZE :
@@ -416,13 +416,15 @@ static int sprd_spi_txrx_bufs(struct spi_device *sdev, struct spi_transfer *t)
 			goto complete;
 
 		if (ss->trans_mode & SPRD_SPI_RX_MODE)
-			ss->read_bufs(ss, len);
+			read_size += ss->read_bufs(ss, len);
 
 		trans_len -= len;
 	}
 
-	ret = write_size;
-
+	if (ss->trans_mode & SPRD_SPI_TX_MODE)
+		ret = write_size;
+	else
+		ret = read_size;
 complete:
 	sprd_spi_enter_idle(ss);
 
-- 
1.7.9.5

