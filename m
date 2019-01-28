Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61008C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320B12173C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694248;
	bh=Y1OaYGxvMY95y2V9hs5/Yy2B2Md+na4IRlsLIgKw8vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YqeNNl6KVjXnH56e0ACQ8Yxa4UzL/sctI8jHc/JCnSqfYN2FVLe68BpgqlVC2An+/
	 OYrOdCqO4EEPWOLSLHs4glrhb6KL60MA3VPXPXFeY63KvkP387C9a+b4pOUPo3E1/4
	 9bv4GjegNStF/XFDpxaL1KPdVn1/ZV1658/TI6EM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388705AbfA1QT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:19:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:54976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388690AbfA1QTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:19:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05D9320663;
        Mon, 28 Jan 2019 16:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692393;
        bh=Y1OaYGxvMY95y2V9hs5/Yy2B2Md+na4IRlsLIgKw8vw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zn/5LwqXfj8O6Xlu3aZEr7hkJpSWB2j5+KNBQrGSt59vF1L9ac6cVsm9OjsIbfpcp
         ArQzkcxA6WwbjC7iRLo8J8oFMjYWdX3RlHITiHW40Q/Z84hF+JS+CHg/BPO14EIlzb
         UBQPXwxqtuOe4zdZh+i57jw4T1/Z1IULzJFWUdVY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Slawomir Stepien <sst@poczta.fm>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.9 002/107] staging: iio: adc: ad7280a: handle error from __ad7280_read32()
Date:   Mon, 28 Jan 2019 11:18:02 -0500
Message-Id: <20190128161947.57405-2-sashal@kernel.org>
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

From: Slawomir Stepien <sst@poczta.fm>

[ Upstream commit 0559ef7fde67bc6c83c6eb6329dbd6649528263e ]

Inside __ad7280_read32(), the spi_sync_transfer() can fail with negative
error code. This change will ensure that this error is being passed up
in the call stack, so it can be handled.

Signed-off-by: Slawomir Stepien <sst@poczta.fm>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/iio/adc/ad7280a.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index b460dda7eb65..dec25fadba8c 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -250,7 +250,9 @@ static int ad7280_read(struct ad7280_state *st, unsigned int devaddr,
 	if (ret)
 		return ret;
 
-	__ad7280_read32(st, &tmp);
+	ret = __ad7280_read32(st, &tmp);
+	if (ret)
+		return ret;
 
 	if (ad7280_check_crc(st, tmp))
 		return -EIO;
@@ -288,7 +290,9 @@ static int ad7280_read_channel(struct ad7280_state *st, unsigned int devaddr,
 
 	ad7280_delay(st);
 
-	__ad7280_read32(st, &tmp);
+	ret = __ad7280_read32(st, &tmp);
+	if (ret)
+		return ret;
 
 	if (ad7280_check_crc(st, tmp))
 		return -EIO;
@@ -321,7 +325,9 @@ static int ad7280_read_all_channels(struct ad7280_state *st, unsigned int cnt,
 	ad7280_delay(st);
 
 	for (i = 0; i < cnt; i++) {
-		__ad7280_read32(st, &tmp);
+		ret = __ad7280_read32(st, &tmp);
+		if (ret)
+			return ret;
 
 		if (ad7280_check_crc(st, tmp))
 			return -EIO;
@@ -364,7 +370,10 @@ static int ad7280_chain_setup(struct ad7280_state *st)
 		return ret;
 
 	for (n = 0; n <= AD7280A_MAX_CHAIN; n++) {
-		__ad7280_read32(st, &val);
+		ret = __ad7280_read32(st, &val);
+		if (ret)
+			return ret;
+
 		if (val == 0)
 			return n - 1;
 
-- 
2.19.1

