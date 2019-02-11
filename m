Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE9BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4EC920700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549901524;
	bh=2dlgSEQPCNM64eZ0TiG0I4uzFbDv5MmULrbjeJa7DEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PEJB0pWQyM9MxejJDZxFLjyjE980tkECkpKQmp2Hg3dKIWM0vABJAVNb8KRTOIV/Y
	 IYfJfGWCLV/FCBfUdpBAd6elK2036gMDB1DygaNPXn+hvanaraCffQCrtpCxwbhjOx
	 D1gs1r0rQcMr/BmwvRq/isjMw38HqCy5gQD0VwzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbfBKQMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:12:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:56658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729018AbfBKOXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:23:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1573222A1;
        Mon, 11 Feb 2019 14:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895014;
        bh=2dlgSEQPCNM64eZ0TiG0I4uzFbDv5MmULrbjeJa7DEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dtvDgkQxh+6TYD5uxovsl5aZ4R5egR2GjMe65X1gzVHilUBFWnVXmbPhns3wqwAYk
         vKcL47wmJCCd5Jg/DGW0s0nB5Pr8HZIguNQ6WenX4g1N60aNp9TFIRiMw2BDyaml19
         q25a42nbKBK8pgYJ6EYuHPeGQZDdjBTscby84BZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Renato Lui Geh <renatogeh@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 045/352] staging: iio: ad7780: update voltage on read
Date:   Mon, 11 Feb 2019 15:14:32 +0100
Message-Id: <20190211141849.159022864@linuxfoundation.org>
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
index b67412db0318..c7cb05cedbbc 100644
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



