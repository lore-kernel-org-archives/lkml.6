Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8B2C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF162173C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694188;
	bh=65gwSfesfSfyJF/C6wfrxZjGPV4Mpw08s7RADtFNgWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tpyvN1fJOjF0DAXhr0hvAM52GJ0tzIE+Tx1zdXwqbsvguw8Ks8g81i8nM61NPR8/t
	 G0Zd88tUrpfsN6v/DFEJwzxJ4gO9JNluL1sDwWziR3b0FIg7Sxr095h/OOVFWvrWsu
	 rpstteQ/ASt4qcfMQoKzSQE9r1Jt7n0IDKVCSB6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388839AbfA1QUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:20:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:55994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388793AbfA1QUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:20:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C3792171F;
        Mon, 28 Jan 2019 16:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692429;
        bh=65gwSfesfSfyJF/C6wfrxZjGPV4Mpw08s7RADtFNgWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0vI/1OqZgEFX/N/QYV46p4MfZeeG1HWSIL3pvp6I8QXbKcBHFCZ4zNpTCtdt+dzqB
         nqY6pCoruDyLom4Mdr0m6e5jOZeCkjtC3+tkRDfjITu4SnIVQBkL0zTfORttEllpxP
         ZT0RwwkhMlF1vBRBvb0XlJUjuzHBIOySZGo4WkPA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Renato Lui Geh <renatogeh@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.9 017/107] staging: iio: ad7780: update voltage on read
Date:   Mon, 28 Jan 2019 11:18:17 -0500
Message-Id: <20190128161947.57405-17-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Renato Lui Geh <renatogeh@gmail.com>

[ Upstream commit 336650c785b62c3bea7c8cf6061c933a90241f67 ]

The ad7780 driver previously did not read the correct device output, as
it read an outdated value set at initialization. It now updates its
voltage on read.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/iio/adc/ad7780.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index c9a0c2aa602f..5d163386ab6e 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -87,12 +87,16 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
 			   long m)
 {
 	struct ad7780_state *st = iio_priv(indio_dev);
+	int voltage_uv;
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
 		return ad_sigma_delta_single_conversion(indio_dev, chan, val);
 	case IIO_CHAN_INFO_SCALE:
-		*val = st->int_vref_mv * st->gain;
+		voltage_uv = regulator_get_voltage(st->reg);
+		if (voltage_uv < 0)
+			return voltage_uv;
+		*val = (voltage_uv / 1000) * st->gain;
 		*val2 = chan->scan_type.realbits - 1;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_OFFSET:
-- 
2.19.1

