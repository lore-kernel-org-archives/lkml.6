Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF7CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D366021473
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdzAc55g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D366021473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbeHQKEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 06:04:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47077 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeHQKEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 06:04:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id a108-v6so3507769wrc.13;
        Fri, 17 Aug 2018 00:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SLbivYki1CbLJzHE+oM4arJt0Rz+WMuscuVKppNN3mY=;
        b=WdzAc55g+TV5bFtAmpGtBNIl+8uTLPuTq8Mz9IOQXkhKYKmvtHreLLC1JB+PwlOOLE
         uCdLYUSUOCZa78sbf2i1nE9JfgNE7K1cTuPTF6fpOu8tVUUqhgHkz++WPLPPNmUvigX0
         Cv+h7oVWXzeafBbWbuOzDGQ2X5vFSH+76Fyqm4FSMepT8u9/2vSDZuMPk8rEJd5XiDAF
         iNWgYTi4scA8eSuB4uJkNGL1rI+STEaDeQZ49xctw50Zvjg+dMIiaE/C61DphFO8M2VA
         XoZ0AoBmq87FFcWMsP3iFkZsQpaT3yWXC64f3IiSSsjcTqMSspJ6jX4DGWmI1QYs6Iuk
         znxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SLbivYki1CbLJzHE+oM4arJt0Rz+WMuscuVKppNN3mY=;
        b=nJ1OadXCTnZm/6/SkGmW3PsDCP8/lfzxEBxzL+DmJPWLO4WRlDn7vI9Mn7NbZpr2Kh
         1R4CL7CqJfqluWEqAAh2dJZ8asuzxjLN5TWbqqBUioPoXHZShqZhkKF5husw5jXVzmun
         sh8dZ+H1T4RWaCMU7ns7Fhnc6HHTd8YQIRDc+cXcPXrTEFhW0+2mjwVtoip6bxrpldj8
         L9JuTxc28JrIiwoM+wIVj5Pl3Ol1zeK/0Hf0rGt6JFsEVbAt5z15ETqeW7UH7MVY2IIi
         tQRRGXz/zMC10TCbGXCyQQyDKCNzdtXtUni7pPxATm0AmvAdGKnGKqB/9kFFiYSaffSp
         9oTw==
X-Gm-Message-State: AOUpUlEEUIB8Qad1b5SVv3idLhtYDZhc2xyQU8OvV9HNT3GOCaEl0xYC
        cb2BnBZfqPhXTcqYk0RIGB4=
X-Google-Smtp-Source: AA+uWPx7Stiw5BzdwbV2K9v2abc+bLyjnqgiS4SWeMVjTyl5XIGzH0aUuIiNEKnB94NG9cxTr996sw==
X-Received: by 2002:adf:ff82:: with SMTP id j2-v6mr3032420wrr.165.1534489325090;
        Fri, 17 Aug 2018 00:02:05 -0700 (PDT)
Received: from ubuntu.home ([2a02:8071:6a3:700:f8c7:c68b:c526:ae6a])
        by smtp.gmail.com with ESMTPSA id l16-v6sm1867518wme.36.2018.08.17.00.02.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 00:02:04 -0700 (PDT)
From:   Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Subject: [PATCH v2] spi: dw: support 4-16 bits per word
Date:   Fri, 17 Aug 2018 09:01:05 +0200
Message-Id: <20180817070105.1725-1-simon.k.r.goldschmidt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180808071421.32707-1-simon.k.r.goldschmidt@gmail.com>
References: <20180808071421.32707-1-simon.k.r.goldschmidt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spi-dw driver currently only supports 8 or 16 bits per word.

Since the hardware supports 4-16 bits per word, adapt the driver
to also support this.

Tested on socfpga cyclone5 with a 9-bit SPI display.

Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
---

Changes in v2:
- use DIV_ROUND_UP to calculate number of bytes per word instead of
  if/else range checks

 drivers/spi/spi-dw.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index f693bfe95ab9..58a7caf31d59 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -307,15 +307,13 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 		dws->current_freq = transfer->speed_hz;
 		spi_set_clk(dws, chip->clk_div);
 	}
-	if (transfer->bits_per_word == 8) {
-		dws->n_bytes = 1;
-		dws->dma_width = 1;
-	} else if (transfer->bits_per_word == 16) {
-		dws->n_bytes = 2;
-		dws->dma_width = 2;
-	} else {
+
+	if ((transfer->bits_per_word < 4) || (transfer->bits_per_word > 16))
 		return -EINVAL;
-	}
+
+	dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
+	dws->dma_width = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
+
 	/* Default SPI mode is SCPOL = 0, SCPH = 0 */
 	cr0 = (transfer->bits_per_word - 1)
 		| (chip->type << SPI_FRF_OFFSET)
@@ -493,7 +491,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	}
 
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
-	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
+	master->bits_per_word_mask =  SPI_BPW_RANGE_MASK(4, 16);
 	master->bus_num = dws->bus_num;
 	master->num_chipselect = dws->num_cs;
 	master->setup = dw_spi_setup;
-- 
2.17.1

