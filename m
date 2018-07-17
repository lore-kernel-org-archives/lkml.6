Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B26ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A9D20C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaaxZRFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A9D20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbeGQFEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 01:04:38 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45683 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbeGQFEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 01:04:37 -0400
Received: by mail-pf0-f195.google.com with SMTP id i26-v6so15972578pfo.12;
        Mon, 16 Jul 2018 21:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AGNgRg8aDtRLLaXwMD+ZgahrOOM+jS0eTUlWzkM0Xxc=;
        b=jaaxZRFX+vhW4bGNew6Wc9iqSkKujFObpMF45jQkssnwo6xaZ2th2CmLuU88Ohpg1g
         JRn1NTJr6LA3a0BumDGr67aHHLcinmJdv87rQQDFxBVPSiKQ6pRQn/PRzvOqgcB5VbV5
         9t5UzkuFjfTaU4DyvbcRqQ2hDfTV31jMLazcQFDZTWbDH9p2JjVw3qNwZ6mh+OBw4gzL
         TDYokB3+IRQtzVVl+gPUvDFVs1xkZlnc9qoBiowgEUCZyMALcyfpvP+u1O7bxZg8OON1
         o83EyaYHzai8M1gwjEgJiTgnbDx1KmrD4RduwKLtY/OOW4MBKF/QGrl+juX2Gyf8e7B7
         ShPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AGNgRg8aDtRLLaXwMD+ZgahrOOM+jS0eTUlWzkM0Xxc=;
        b=t1ET3X5zbWWMe7A+AQ26xa+eEJkSUJqPIRRMdkdTlE62NqMmQczxsFqgaaTcpE4687
         5tukFclhezeuajqsTum4vvFoA4Vn9SZwcXBvFZQVEqO+Xu0ak3VZOnPnUDE6Pbz3NqRa
         nQEHPTtk+QSYdUfneSkSV6SUnU44Mt16VfpXwsAt9okGkqhYMooBICUrEE89D5QJp7K7
         hTIPMrGlBZB99WEpj2+pYYB4CXJQQtDhsYPg97HkJimjoSph1KdbZPz77Icnorq/4Svk
         sje0kQ0TMmwOt1WiJMB7K/0Ns3HKZy8Zowj+ZCX5lRJxRl4+5KDfvSQgoPxRR3+aTZuf
         qldw==
X-Gm-Message-State: AOUpUlFQaaB4HX2GROc8zbWwOZHWgZFzUjgCQuezI1hNe9Nm315hu17+
        3HXF2C1JgZIVJjmb9qK4T50iOvrI
X-Google-Smtp-Source: AAOMgpcSMExBOX3VzCe8o1v1Ky+1WNB9s41xBZVt/vVoPuYXtM2ru55AkzeYm52+zBOxu33YTYuV6Q==
X-Received: by 2002:a62:9849:: with SMTP id q70-v6mr55832pfd.178.1531802039347;
        Mon, 16 Jul 2018 21:33:59 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id j75-v6sm35316904pfj.102.2018.07.16.21.33.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 21:33:58 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Stefan Agner <stefan@agner.ch>, cphealy@gmail.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] spi: spi-fsl-dspi: Fill actual_length when doing DMA transfer
Date:   Mon, 16 Jul 2018 21:33:29 -0700
Message-Id: <20180717043329.4209-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upper layer users of SPI device drivers may rely on 'actual_length',
so it is important that information is correctly reported. One such
example is spi_mem_exec_op() function that will fail if
'actual_length' of the data transferred is not what was requested. Add
necessary code to populate 'actual_length.

Cc: Mark Brown <broonie@kernel.org>
Cc: Sanchayan Maity <maitysanchayan@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: cphealy@gmail.com
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Changes since [v1]

    - Patch rebase on for-next branch of SPI sybsytem's git tree

[v1] lkml.kernel.org/r/20180716062508.7726-1-andrew.smirnov@gmail.com

 drivers/spi/spi-fsl-dspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 89a1e7a4fe5d..9e598642ca66 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -358,6 +358,7 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 {
 	struct fsl_dspi_dma *dma = dspi->dma;
 	struct device *dev = &dspi->pdev->dev;
+	struct spi_message *message = dspi->cur_msg;
 	int curr_remaining_bytes;
 	int bytes_per_buffer;
 	int ret = 0;
@@ -377,8 +378,10 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 			goto exit;
 
 		} else {
-			curr_remaining_bytes -= dma->curr_xfer_len
-				* dspi->bytes_per_word;
+			const int len =
+				dma->curr_xfer_len * dspi->bytes_per_word;
+			curr_remaining_bytes -= len;
+			message->actual_length += len;
 			if (curr_remaining_bytes < 0)
 				curr_remaining_bytes = 0;
 		}
-- 
2.17.1

