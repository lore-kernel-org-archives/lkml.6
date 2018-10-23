Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B63EC004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439FA20651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ntqVK65Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439FA20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeJWJ2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 05:28:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42247 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbeJWJ2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 05:28:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id f26-v6so20768302pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 18:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dw8Qjeswo1fiQxpz5TeSz6FDLID6QIN1kVfa3XtAzzU=;
        b=ntqVK65QU4fAuMQ4FX4SADMUkJ+bp8bILQEVaW7MtACQCD19Fy0t2x1cToxowaFqLw
         Yzc0R8+GIGsTqSZl1xb6cbM6vvm9n67vR9K9BB0ntgByDA/vs7dwLCdzLo08Cq1iUioM
         nS0kZ70w1br5uyxJQOxuqRjvCFtu9YuJ74zPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dw8Qjeswo1fiQxpz5TeSz6FDLID6QIN1kVfa3XtAzzU=;
        b=mR4jJQ8ULUxkwM2bamV4YWxf1mxmZgcEyM++9Hp+9dgZZPRQnPHyvJIDgIhD5J4UlX
         vyMJqNLNf9LPAgQhgur0Kb4hRixoauMxDmYCHELq25TbZMloXQ8nQ2ea2cDHILegU95C
         3v1SmIlWyTTTIs2MWh6mbTgr1RD57Frp8OsA3wmWoJN5QPPFWskhW3ZXfzbHfO6xY7Aw
         Ehu42DdQRBt6XwsriAzB4ch/EwJVzOxStv6LyIsoYgo0Esl855UfyNDkpFuTezA6Bo5Z
         UtUDQ0uBRfdtRsoLEo8BDHdqu7Iw+lH1e0apVvs+E7ywyJ9qblut9IEQMZuaYsKmegBJ
         T9ew==
X-Gm-Message-State: ABuFfojkgb3f30qT7flQtr7xORkcvLaOj7tl7hOgrSkVkV9LCSTkG3DS
        9tw+IGpXCLH2Q1rfJEX47OembA==
X-Google-Smtp-Source: ACcGV61w8fPC2BD8dTB3NUJZ6CkLrtqlT2jNwgfTFWLFV2g+NeXsJbAJD+jMZX0k4Eyh3vNW8A/PBA==
X-Received: by 2002:a63:2218:: with SMTP id i24-v6mr44657107pgi.238.1540256868779;
        Mon, 22 Oct 2018 18:07:48 -0700 (PDT)
Received: from ryandcase.mtv.corp.google.com ([2620:15c:202:201:ed1c:3d1c:9d92:99cb])
        by smtp.gmail.com with ESMTPSA id q24-v6sm38104982pff.83.2018.10.22.18.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 18:07:48 -0700 (PDT)
From:   Ryan Case <ryandcase@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v1] spi: spi-qcom-qspi: Fix remaining driver nits
Date:   Mon, 22 Oct 2018 18:07:07 -0700
Message-Id: <20181023010707.153647-1-ryandcase@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Address remaining comments from original driver patch series

* Move RD_FIFO_CFG to be ordered corretly
* Expand spinlock comment

Signed-off-by: Ryan Case <ryandcase@chromium.org>
---

 drivers/spi/spi-qcom-qspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index b8163b40bb92..e0f061139c8f 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -90,6 +90,9 @@
 #define PIO_DATAOUT_1B		0x0020
 #define PIO_DATAOUT_4B		0x0024
 
+#define RD_FIFO_CFG		0x0028
+#define CONTINUOUS_MODE		BIT(0)
+
 #define RD_FIFO_STATUS	0x002c
 #define FIFO_EMPTY	BIT(11)
 #define WR_CNTS_MSK	0x7f0
@@ -99,9 +102,6 @@
 #define RDY_16BYTE	BIT(1)
 #define FIFO_RDY	BIT(0)
 
-#define RD_FIFO_CFG		0x0028
-#define CONTINUOUS_MODE		BIT(0)
-
 #define RD_FIFO_RESET		0x0030
 #define RESET_FIFO		BIT(0)
 
@@ -139,7 +139,7 @@ struct qcom_qspi {
 	struct device *dev;
 	struct clk_bulk_data clks[QSPI_NUM_CLKS];
 	struct qspi_xfer xfer;
-	/* Lock to protect data accessed by IRQs */
+	/* Lock to protect xfer and IRQ accessed registers */
 	spinlock_t lock;
 };
 
-- 
2.19.1.568.g152ad8e336-goog

