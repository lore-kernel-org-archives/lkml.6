Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815B4C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B41621850
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZ23oMi6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbeLXWCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:02:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34348 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeLXWBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:01:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id j2so12577088wrw.1;
        Mon, 24 Dec 2018 14:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GGnsImLEJas/NCseLAI8aIfWslIulfuhj1PcOtADAf8=;
        b=CZ23oMi6wENbcxj7WbCjP5YgM+0Dd+MD748+cmAHihjwVZJh84iUpzLtoU3aGf2l/W
         ZSY1mfxTel8ODCp/HT19RfKKwryTggajfhV9XAJWuL1pMFyAJrZhFkmdii83N9U8sZtk
         /86wVqxuT2fmIWn/r/y37fN53hGVMhpLRzNXllxmfjXX38+K6W1dTWmnCcTvLhFJPCW7
         oNfP8kL9zvptaBc5Xx6m3qVs/nZhKVzepQX47du4hq+H0JeVXDCkgMmeWavus44L3bk3
         BkBOP5Y3/1zg7FTN84UwbpE3TrdanW+UOAygHR0NsJeBZKfiBCA23xy8sFof9BXK47+X
         cZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GGnsImLEJas/NCseLAI8aIfWslIulfuhj1PcOtADAf8=;
        b=Kp9Ara8B3nuYUzNBz5XF6ht2m2+ISuTxLQ2e1Jw1efkoxLWK16f/sc53SLiD88tHzl
         kl8cp3rMHw4IDW02tB3Fqm2nlf0a5f8kjXQMhjG/iv+jEa6qUkx63M/y2FnnG77HG17T
         HcCApQjy6arktj7r+jnDkmlpEkZCMk/crs+CX9AsbCVWpQYBBMhJ6ajLcwjrO4YcbqrV
         gamXjKjAA9cWhHaoCd2VdZ0zTSUVF8Q/DE0QXnsSu2DDFhH2Iqik3e6pah8iBKIq6HtX
         NJ5HN0kbf+K4nWD8dFwpcSVkUHMs2Pt/nBN4+i79nzbMA0emOWfAJkOOJg7PiT41PW7C
         gaiw==
X-Gm-Message-State: AJcUukeHkHSHiZ5F0Dh15czf8e0TaVAE8ZLMtCvp4/2FwazWC0RUzhES
        8WXwWK692bBwwq488MDcOWo=
X-Google-Smtp-Source: ALg8bN40hFS++7/EeyfQeA3w3xfLqb4EK61aM566f0n123LvqurVUABzjFeqmBv8CMt9u8EZnA2x3g==
X-Received: by 2002:a5d:40c1:: with SMTP id b1mr13673585wrq.133.1545688862368;
        Mon, 24 Dec 2018 14:01:02 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (daw20.neoplus.adsl.tpnet.pl. [83.23.22.20])
        by smtp.gmail.com with ESMTPSA id d4sm23970153wrp.89.2018.12.24.14.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 14:01:01 -0800 (PST)
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
Subject: [PATCH v2 06/14] spi: stm32: remove SPI LOOP mode
Date:   Mon, 24 Dec 2018 23:00:32 +0100
Message-Id: <1545688840-23992-7-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

This driver does not support SPI LOOP mode by configuration
in registers.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 drivers/spi/spi-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index f7056b7..b639be7 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1143,7 +1143,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	master->auto_runtime_pm = true;
 	master->bus_num = pdev->id;
 	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LSB_FIRST |
-			    SPI_3WIRE | SPI_LOOP;
+			    SPI_3WIRE;
 	master->bits_per_word_mask = stm32_spi_get_bpw_mask(spi);
 	master->max_speed_hz = spi->clk_rate / SPI_MBR_DIV_MIN;
 	master->min_speed_hz = spi->clk_rate / SPI_MBR_DIV_MAX;
-- 
2.7.4

