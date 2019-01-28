Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EAFC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7A621916
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691363;
	bh=ksyqAxsdi17NA/ckmWFnZP/js1AKsQqIMJxepDtbAW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pPyNKabBjKEPoAjACu9JHkghwRXQuSqTkefz+qpz342/3R/8JG4Hmt4jol8uT5uAD
	 WP+/DxL+Irr8y0IcTYNQXKGECAyNiBW7smePu6u4glmvQU4GFeynTyA+VxnDPUPdcO
	 Z9Vpmeg01RgUYUG1vC3U1WRU286OgHu/5gaI9cb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731265AbfA1QCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:02:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:47936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731254AbfA1QCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:02:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1AC721848;
        Mon, 28 Jan 2019 16:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691356;
        bh=ksyqAxsdi17NA/ckmWFnZP/js1AKsQqIMJxepDtbAW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GdgDTy+jIvL7zpkiWdr7jHFwNUVteNskTZw0EwcYiffD7N1e3RlVVcrmPQK+97Vwb
         FwEVY0q6rdzc0HgYCbUpZaWIMn+BHB5I6KqnFi6GgGt586ohV4i94JwmJEdouGiahj
         KNeTelOFb2+XwLoGtcxsElv5pF21+jaHsqfODjxU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 066/258] iio: adc: meson-saradc: check for devm_kasprintf failure
Date:   Mon, 28 Jan 2019 10:56:12 -0500
Message-Id: <20190128155924.51521-66-sashal@kernel.org>
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

From: Nicholas Mc Guire <hofrat@osadl.org>

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
index da2d16dfa63e..da4c391b8977 100644
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

