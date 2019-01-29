Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC6CC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D45A20869
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="R2s3ESfn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbfA2UzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:55:18 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35760 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729516AbfA2UzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:55:10 -0500
Received: by mail-lf1-f66.google.com with SMTP id e26so15722503lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 12:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Adu7r7feIgD220eJhrZ8nREsuxr7WzIV5vIaaUUOmX8=;
        b=R2s3ESfnLLcxPKelxgl+NXEG8xnvOoijCdQhE07518wuxwwp0VMih0qBEWxulr+AsV
         q6sFN/bNB/N+ZAoRy5S/+rJDQOR4bMFDOVunBdWem8tPCRvchZt0Gk9QMyS6vRV6+9vU
         HFnDNPmjjWj/revgDQRb9LK2xRBiPB8dFhr2T1VEVB/1xEBB9s42JNyRyrozyTwy5bqI
         6nDwfnhs1c8RofkvOYeGxPAnrs+yMnif1a1pSa0R19GVUL/oi7YgREisDqDUa7wbUUYH
         pKdL2rxbl/m6EYvYhVaZpAh6YmM3SkDS1TBXXYXDi2tWQ7jjP+Yv/6QKPr4SRiG6g1gO
         38pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Adu7r7feIgD220eJhrZ8nREsuxr7WzIV5vIaaUUOmX8=;
        b=f0ldbuhLua4872/CIePNeMDwtMaeju2eidhgJdfSxAq17l3hIsxWhJB3VV5aI957Dk
         Wbb8m7hl2zsBZIkiNDhY0gLifZ8bmW98Qnz4CScKLPRSfZ1/bjAUb3C0q0uGdiA9XfmF
         EdjlAaUNoWOucps5bKYxVclo2Wk8F+88xhs/FKsws97y/Abx/zufvxuwpZpH1tq8XqHH
         s/922yPMlkbu1RWLGf2hzotY2/teI8WJct6wkZoR4sWbKA0PbxJvy7N7kkBCCav9Jmzv
         Q3KKkNabQ8plTfl4Er0H2YZ0LgC7JAP/T0WzJtaQU7BjC6nWRRksiG4ZlxUhxjUV3B8r
         EpHw==
X-Gm-Message-State: AJcUukeIjhQViDKJtK4Tf64XagTNUuiGewsafRU+D4xqD3fVx9vQtCqY
        16fFbvlFKble6aLaz/O/uOP3JzC1iis=
X-Google-Smtp-Source: ALg8bN4tEAq/wKoIVj0YK0yHNk+mhqAeMD87gXVK3Y26fyShCMUnlSClIx4Kj+/8zfro6UrYIRvSZA==
X-Received: by 2002:a19:980f:: with SMTP id a15mr21220369lfe.103.1548795307852;
        Tue, 29 Jan 2019 12:55:07 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id o17sm3677287lff.77.2019.01.29.12.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 12:55:07 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     linux-kernel@vger.kernel.org
Cc:     Jonas Bonn <jonas@norrbonn.se>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 2/2] spi-atmel: support inter-word delay
Date:   Tue, 29 Jan 2019 21:55:02 +0100
Message-Id: <20190129205502.7741-3-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190129205502.7741-1-jonas@norrbonn.se>
References: <20190129205502.7741-1-jonas@norrbonn.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the SPI slave requires an inter-word delay, configure the DLYBCT
register accordingly.

Tested on a SAMA5D2 board (derived from SAMA5D2-Xplained reference
board).

Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>
CC: Mark Brown <broonie@kernel.org>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Ludovic Desroches <ludovic.desroches@microchip.com>
CC: linux-spi@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
---
 drivers/spi/spi-atmel.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index f53f0c5e63da..57cc7110f9e8 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1201,13 +1201,14 @@ static int atmel_spi_setup(struct spi_device *spi)
 		csr |= SPI_BIT(CSAAT);
 
 	/* DLYBS is mostly irrelevant since we manage chipselect using GPIOs.
-	 *
-	 * DLYBCT would add delays between words, slowing down transfers.
-	 * It could potentially be useful to cope with DMA bottlenecks, but
-	 * in those cases it's probably best to just use a lower bitrate.
 	 */
 	csr |= SPI_BF(DLYBS, 0);
-	csr |= SPI_BF(DLYBCT, 0);
+
+	/* DLYBCT adds delays between words.  This is useful for slow devices
+	 * that need a bit of time to setup the next transfer.
+	 */
+	csr |= SPI_BF(DLYBCT,
+			(as->spi_clk / 1000000 * spi->word_delay_us) >> 5);
 
 	asd = spi->controller_state;
 	if (!asd) {
-- 
2.19.1

