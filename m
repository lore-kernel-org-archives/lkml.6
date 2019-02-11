Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F26C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229C620700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549901487;
	bh=iIXdjZZjXEqNj9BM29tlLoq9CPaKv62aGKzTTVnn8iY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PesM5NRxRcGU/rN4iih44v9wLDs02NDfRPI/yX53n8ExPPOKxOOyHhXf4Vz0Q4iLy
	 KiAq2HKAr2uOG9etqb7UGcQmIdSYGmfHaAgEc6g2QFyKDt+ImuhzIt0gbriTE12g/c
	 jxxBxPfu618PgWL5VbxMzMzgs3cLTmKtS4m2D1u8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbfBKQLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:11:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:57312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbfBKOYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:24:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0812120838;
        Mon, 11 Feb 2019 14:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895050;
        bh=iIXdjZZjXEqNj9BM29tlLoq9CPaKv62aGKzTTVnn8iY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FZR3wJlmoi3T6A0fS/QrWVNhHWyj/Q/wz1AMGr5qd61p4d/E+Bapi8Es9/jGcENcr
         S0zreuzt5DHlLH5E67RtmvX6g10xKxpkBKm8fuliPz23b+KYmQs5FASEUQSlzBvNhp
         cVrBPxLnHBmxGWsJHwkYV5nGTYGmJQXiaWRH2IxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 073/352] iio: adc: meson-saradc: check for devm_kasprintf failure
Date:   Mon, 11 Feb 2019 15:15:00 +0100
Message-Id: <20190211141850.714007877@linuxfoundation.org>
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

[ Upstream commit aad172b017617994343e36d8659c69e14cd694fd ]

devm_kasprintf() may return NULL on failure of internal allocation thus
the assignments to  init.name  are not safe if not checked. On error
meson_sar_adc_clk_init() returns negative values so -ENOMEM in the
(unlikely) failure case of devm_kasprintf() should be fine here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs")
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/meson_saradc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 028ccd218f82..672a5dee4a9d 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -589,6 +589,9 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
 
 	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%pOF#adc_div",
 				   indio_dev->dev.of_node);
+	if (!init.name)
+		return -ENOMEM;
+
 	init.flags = 0;
 	init.ops = &clk_divider_ops;
 	clk_parents[0] = __clk_get_name(priv->clkin);
@@ -608,6 +611,9 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
 
 	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%pOF#adc_en",
 				   indio_dev->dev.of_node);
+	if (!init.name)
+		return -ENOMEM;
+
 	init.flags = CLK_SET_RATE_PARENT;
 	init.ops = &clk_gate_ops;
 	clk_parents[0] = __clk_get_name(priv->adc_div_clk);
-- 
2.19.1



