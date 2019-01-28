Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733A5C4151A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E3B2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690422;
	bh=fbFe8DlZvj0NZ61TLj7w1CkS7E42p1s7wUWOC2ZTcIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VJgOuh//cX46of8rcOyAEgOvVXjkRVcILONqiSGfjyeES87IYNRLQvfghBPkCGILe
	 b8qRRBVzTygbpW5ldEP9K5RG7Y/wY3mqPOLslSiPjUkdWqFwxQMEL4sHWqqb47/Jj/
	 RKTuAHCJQvYNVTi4ZuRekgOvbXDMSrypJW0N3Glk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfA1PrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:47:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:60352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728166AbfA1Pq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:46:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDA0B2147A;
        Mon, 28 Jan 2019 15:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690417;
        bh=fbFe8DlZvj0NZ61TLj7w1CkS7E42p1s7wUWOC2ZTcIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=heyLqA2CLY1ZjoiAk/+NnpMu4utADR6WSxkUdhuhGTsw52GfEnpnvekKassvOSwpB
         GjpMNAwgNKV3OeHB3pWufVHjmVfxsHTNmZRqf23PC/qhhIEyWWEq1IFzVqjFi0R9cC
         RI1k89mRpuCMybDN7EYYbIFs8vMMbe26eE8VWX1I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.20 079/304] iio: adc: meson-saradc: check for devm_kasprintf failure
Date:   Mon, 28 Jan 2019 10:39:56 -0500
Message-Id: <20190128154341.47195-79-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
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

