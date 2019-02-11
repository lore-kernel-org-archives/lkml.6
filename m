Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663F2C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34ABC20821
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895058;
	bh=Mi37cdZTsuJepmvEeQNEdWYa2jgFa/LerzDtXJWxRkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e+NMdvga+1XWNpPggem7iVaX0m6K+WBN94MDiqAM/olbk475+N8B37P5zOXA1/h2L
	 naRQGKvuXiiG8mM6fVQqYxlWgqctEh4sbOmNPwNyFPqdTnJFYGRjK4T+2Y4Uv5p/qB
	 PRmIhoP4W+sLckxMMSXGSkUNJ9Jz32ImejMONfm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfBKOYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:24:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:57386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727835AbfBKOYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:24:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39B3C214DA;
        Mon, 11 Feb 2019 14:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895053;
        bh=Mi37cdZTsuJepmvEeQNEdWYa2jgFa/LerzDtXJWxRkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l2Q70ib6ZY5Ooi9upN8uhgQheM7K/89uaq45gAtybzfc/O5lqGAV3xwx5hwou9FpE
         b/SuAcAxf4AImx1PS/360E5gS1nVEVGWSA63Tecsmuq6ODz/++to/G0X5WM7nevS6s
         uY+TIHWMTXT89glFLhstoShZbeikBwumZARgYkiQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 074/352] iio: adc: meson-saradc: fix internal clock names
Date:   Mon, 11 Feb 2019 15:15:01 +0100
Message-Id: <20190211141850.772000673@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 672a5dee4a9d..ba4b42429a2a 100644
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



