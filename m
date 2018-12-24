Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC0CC64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969BD21850
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McwmtjNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbeLXWA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:00:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32801 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXWA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:00:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id r24so19886503wmh.0;
        Mon, 24 Dec 2018 14:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lHFX12DgGW+zTzGc5a848Bc5uC876FgFYUc+YWPtWvM=;
        b=McwmtjNp6/axCPfNmGt5fzAS0Msh6jstn67m7iK/rmbAKHAcCJ9BVS+VadBtbmFQEf
         d5QCPBtc5AATaNk8ChmRGB6ap8jyJY+QY1VeqTrNPBRqN2TL46Dn/7wPXrAbBzVNsrRb
         xxZyPeq/joy8IOCT9peXvCDBiZbZ4I7WzTlRHAvliO39t6uS6RhW8lxWvkt2xNiDctXO
         K9IUCu91tLxlZxzAXOEjnhCz3/Dt0i54oYThFNiKwn1KMfQ2T68D1GWEixsMIsvYyWPx
         glIQL9KA57jBAjPj7/S6XI5113bJDWsgkq5ay9r60ptzsMCb8cNaIkxxh8YVFhx+xKgT
         8abA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lHFX12DgGW+zTzGc5a848Bc5uC876FgFYUc+YWPtWvM=;
        b=BIeAvCh7zxAgO2FURCi/kPA3j4s92hlULPEPukm6IBPz4RTlzXRvlPcpbCRo5IOjUf
         9D32LINck747elMMoels8FhFVWej6ha+nX+AQ3xXINyAq4B/tORHUf/EbUKkrDxmR2dA
         Y8kIFpNeAcysTUoxo8vJykPeH3IQ9OyrB/ETnWZXwaVT9eaS9fJm/IYnOILpUkVg1Nop
         /ugiatz15Pp+q7uVAr5aQrcFldRFVo8bD+9miOo8pghywwcEA9Hm5rYAbMieQ5xeRKS4
         OzWxlWawgxZlYAgwxaakFkMghR+KZj+LqFRc1uleVIH0bDyucLxVydmagPLNrDoljTfM
         zyoQ==
X-Gm-Message-State: AJcUukdcNCZLoQxKBkT5EwQ8t0XW9GcKt3z3Xc4eNyCvBNxTwJZieEqx
        GdxghO+CYKBsLT7e0+2idsU=
X-Google-Smtp-Source: ALg8bN7R2kRNFTbUYyGu0FySRHrQ0YHLM2W+FDSoVw+BsSCQ0kP6PevrUiPdA67OF/r8XcleIH7T3w==
X-Received: by 2002:a1c:a401:: with SMTP id n1mr602766wme.101.1545688855770;
        Mon, 24 Dec 2018 14:00:55 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (daw20.neoplus.adsl.tpnet.pl. [83.23.22.20])
        by smtp.gmail.com with ESMTPSA id d4sm23970153wrp.89.2018.12.24.14.00.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 14:00:55 -0800 (PST)
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
Subject: [PATCH v2 02/14] spi: stm32: use NULL pointer instead of plain integer
Date:   Mon, 24 Dec 2018 23:00:28 +0100
Message-Id: <1545688840-23992-3-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

Patch fixes sparse warning: Using plain integer as NULL pointer. Replaces
second argument of function devm_clk_get from 0 to NULL.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 drivers/spi/spi-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 5f30578..51d7f72 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1100,7 +1100,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 		goto err_master_put;
 	}
 
-	spi->clk = devm_clk_get(&pdev->dev, 0);
+	spi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(spi->clk)) {
 		ret = PTR_ERR(spi->clk);
 		dev_err(&pdev->dev, "clk get failed: %d\n", ret);
-- 
2.7.4

