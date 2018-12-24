Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42387C64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA7E21850
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YId/c6Kj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbeLXWBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:01:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35977 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbeLXWBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:01:02 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so12529738wrp.3;
        Mon, 24 Dec 2018 14:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P0UBLz95gyX+HkR3MstEbdBikEcyR1+21JmSGtYW5Wo=;
        b=YId/c6KjXM301GLSJhWQkPK6Sl63LZ3wJ9GJNFHaz0Wmn517K9GkX7wTC77kyTD/mC
         txpLZsVo6pFDHtEKCG8gIRZPTEUNn6xNNmP5SD+8HElxQEV/0m2iypXNt5OjK4I2QN2i
         xluOXIzkyCGR6ibK0GJo98nIzPEYSS8UaAVI2buR3gfTxoYbm4D+AuE+5cNMrrISoGAq
         zvyaFs/iuu/gPcCWUQfuy2zoJOPqHtmvCvDX/g8kHkCiyLWCi7+z+ewvc6Oe8HBDikwv
         euUDU+kpSS71DkDgq7EX8IA+GrFZcVkrsQuyBjJJ0FzPZv+azirfLL5idMjksuuuhp2A
         BD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P0UBLz95gyX+HkR3MstEbdBikEcyR1+21JmSGtYW5Wo=;
        b=uEi19Pp1w3JZjXKxHhruNwL8VATI9rN9hA9m4BTE59RV3pbo2+YlN5A2iS22j5d8iN
         LfMIdI74iBa1CQFQqpem01th5uANaWRDmeFca3zmwaV6ANdPrN0ivaFvB/J9iv1XRKzm
         C5rJnpcH8YHqb3vBBpMWAhm1RZZBPqV9PiAPRrKaRb0PX24PFfDvnLCUcsrGKGcW773U
         jl4upZ56bXVm4qc0ZkKEleYf4wW+YtgcH8ztwv5pzuKG7mi1wLddqB6SbI76c+ywhkeV
         jTJBqvsxnhDKzZFd4AmHv8x9oZBhVSdt5R4X4ZGcpIChdlJFBASflJjd11R202uZyFLq
         DuvQ==
X-Gm-Message-State: AJcUukd4G/vni6WcaA7QpGK3I5XnhZqveLDhnL8aHe/1UZIjqYjMnZ9n
        1ktK8mNaftIdGZK9HYsv9W4=
X-Google-Smtp-Source: ALg8bN7MznKbxH3lPj/sc57JkKHfmTgO1k/K2yIWpHaOCRTp1d5Bo0H5hZR4d/Qnj6OO3x5+Ec7/0g==
X-Received: by 2002:a5d:454f:: with SMTP id p15mr13782204wrr.39.1545688860765;
        Mon, 24 Dec 2018 14:01:00 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (daw20.neoplus.adsl.tpnet.pl. [83.23.22.20])
        by smtp.gmail.com with ESMTPSA id d4sm23970153wrp.89.2018.12.24.14.00.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 14:01:00 -0800 (PST)
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
Subject: [PATCH v2 05/14] spi: stm32: use explicit CPOL and CPHA mode bits
Date:   Mon, 24 Dec 2018 23:00:31 +0100
Message-Id: <1545688840-23992-6-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

Driver supports SPI mode 0 to 3 not only the mode 3.
Use SPI_CPOL and SPI_CPHA indicates that these bits
can be changed to obtain modes 0 - 3.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 drivers/spi/spi-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 8310f14..f7056b7 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1142,7 +1142,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	master->dev.of_node = pdev->dev.of_node;
 	master->auto_runtime_pm = true;
 	master->bus_num = pdev->id;
-	master->mode_bits = SPI_MODE_3 | SPI_CS_HIGH | SPI_LSB_FIRST |
+	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LSB_FIRST |
 			    SPI_3WIRE | SPI_LOOP;
 	master->bits_per_word_mask = stm32_spi_get_bpw_mask(spi);
 	master->max_speed_hz = spi->clk_rate / SPI_MBR_DIV_MIN;
-- 
2.7.4

