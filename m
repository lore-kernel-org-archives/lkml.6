Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6294C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B774D21852
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691367;
	bh=1SU7FDjCTgi/NU6y4Ir9NbYfENcBQ6hC0LaIvq3qu7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AIeRdIlfGiH1uZ3SLy16ujG/1xXSoLVlOxw3fkj/FhKUKwMDc0xWhrzQsdNFmfYw6
	 kddvCIcruwSt+0wioGx9LB5FNc1cJPgIlQieczGlYuyrSVdvQp8RrDSlTl8Aq2e5bW
	 k/es/qzyCJ/Ope03PgkdW7Ao2QhHUChHQvK5ktrs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731274AbfA1QCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:02:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:48000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731260AbfA1QCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:02:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 543B621852;
        Mon, 28 Jan 2019 16:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691360;
        bh=1SU7FDjCTgi/NU6y4Ir9NbYfENcBQ6hC0LaIvq3qu7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nWsJRCewwXWH9M5g2treyfNGCK3gx0dcXsNWx3FoJyr7sFsWxZ9qlmFLDzaPFsEXA
         Nzunt+qkfMcVdj+oq9xVtUwYfMA+R2AQOeQgj9S+JrIzrMlMoZNQ1D3A71pf+JtG3y
         HuI8e7up6GQ5iIsXE6ns/2fsxbtMwm7gLpZIyiTs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 067/258] iio: adc: meson-saradc: fix internal clock names
Date:   Mon, 28 Jan 2019 10:56:13 -0500
Message-Id: <20190128155924.51521-67-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
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
index da4c391b8977..5dd104cf0939 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -587,8 +587,8 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
 	struct clk_init_data init;
 	const char *clk_parents[1];
 
-	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%pOF#adc_div",
-				   indio_dev->dev.of_node);
+	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%s#adc_div",
+				   dev_name(indio_dev->dev.parent));
 	if (!init.name)
 		return -ENOMEM;
 
@@ -609,8 +609,8 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
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

