Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE06C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3362177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692026;
	bh=lkyY0tObXL8LZJZtu8aaksFzniZLcRHe6ULix8ZaTjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qVbPr0mpcvnZN2lmAJAYxvIOS9uXEbmUKTTmdAyyDQEM64Y3nIkye50sihGBvPyPE
	 L4YB0tEZGeXbk0b+8fVmI4cBsj0R0Mz2vL7HP62QgtCc+IyVaQqD0KuFK/22LZ7YzX
	 psC09l8J5wQKgoym9v58UCTpkFSn/eNrejAXUHmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387470AbfA1QNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:13:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:42352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732873AbfA1QNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:13:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CDDE2148E;
        Mon, 28 Jan 2019 16:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692019;
        bh=lkyY0tObXL8LZJZtu8aaksFzniZLcRHe6ULix8ZaTjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f1XRwJU7TPEKtFxrzSIbapEF3VaBUVGfHWkdtRqqxS4cWLq85B3V8j3oZR939ctoY
         FS117MqthBeOokCQnRDxja2Zwtv+oKj0rkdDc/3h2MXTIbyVIwIsVOV4PIGNnNlRxk
         7+TLwsWH3XLCZo5EM3tGYL0WSJLazGK9IgWYpgeU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 040/170] iio: adc: meson-saradc: fix internal clock names
Date:   Mon, 28 Jan 2019 11:09:50 -0500
Message-Id: <20190128161200.55107-40-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 50314f98b0ac468218e7c9af8c99f215a35436df ]

Before this patch we are registering the internal clocks (for example on
Meson8b, where the SAR ADC IP block implements the divider and gate
clocks) with the following names:
- /soc/cbus@c1100000/adc@8680#adc_div
- /soc/cbus@c1100000/adc@8680#adc_en

This is bad because the common clock framework uses the clock to create
a directory in <debugfs>/clk. With such name, the directory creation
(silently) fails and the debugfs entry ends up being created at the
debugfs root.

With this change, the new clock names are:
- c1108680.adc#adc_div
- c1108680.adc#adc_en

This matches the clock naming scheme used in the PWM, Ethernet and MMC
drivers. It also fixes the problem with debugfs.
The idea is shamelessly taken from commit b96e9eb62841c5 ("pwm: meson:
Fix mux clock names").

Fixes: 3921db46a8c5bc ("iio: Convert to using %pOF instead of full_name")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/meson_saradc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 9a52a91166d2..2515badf8b28 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -583,8 +583,8 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
 	struct clk_init_data init;
 	const char *clk_parents[1];
 
-	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%pOF#adc_div",
-				   indio_dev->dev.of_node);
+	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%s#adc_div",
+				   dev_name(indio_dev->dev.parent));
 	if (!init.name)
 		return -ENOMEM;
 
@@ -605,8 +605,8 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
 	if (WARN_ON(IS_ERR(priv->adc_div_clk)))
 		return PTR_ERR(priv->adc_div_clk);
 
-	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%pOF#adc_en",
-				   indio_dev->dev.of_node);
+	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%s#adc_en",
+				   dev_name(indio_dev->dev.parent));
 	if (!init.name)
 		return -ENOMEM;
 
-- 
2.19.1

