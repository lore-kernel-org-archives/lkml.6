Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693FCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB822177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FYW9W60g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390534AbfAKT5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:57:30 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42982 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732130AbfAKT5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:57:23 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0BJvL3w117494;
        Fri, 11 Jan 2019 13:57:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547236641;
        bh=V0zif8M5Prr9GJZkntL1+MXxqIO4koRpaEMxGVE5C+Q=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FYW9W60gy/PdPXdQn2UkHcLwl9Qvf8sMPOYGE0vt7qF76HmJ03GPm3pRpzc8PYQzK
         +9Rp5xYE2oqyEVnGM0ZSbzmkmzhgoLRfitvlGLuGKy2fWfKaZsk7mJFe6ccFp720/s
         2VcXCb+M/4ygHdGGfukZyAUvQFRVpkSOSLNGIQJA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0BJvLLp107640
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 13:57:21 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 11
 Jan 2019 13:57:21 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 11 Jan 2019 13:57:21 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0BJvKnD031049;
        Fri, 11 Jan 2019 13:57:20 -0600
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.73.213])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x0BJvKU18769;
        Fri, 11 Jan 2019 13:57:20 -0600 (CST)
From:   Dan Murphy <dmurphy@ti.com>
To:     <linux-iio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v3 3/3] iio: ti-ads8688: Update buffer allocation for timestamps
Date:   Fri, 11 Jan 2019 13:57:07 -0600
Message-ID: <20190111195707.2086-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20190111195707.2086-1-dmurphy@ti.com>
References: <20190111195707.2086-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per Jonathan Cameron, the buffer needs to allocate room for a
64 bit timestamp as well as the channels.  Change the buffer
to allocate this additional space.

Fixes: 2a86487786b5c ("iio: adc: ti-ads8688: add trigger and buffer support")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v3 - Updated the buffer allocation definition I also dropped the device managed
patch as I don't have time to invest in that code - https://lore.kernel.org/patchwork/patch/1023971/
v2 - New patch suggested change by maintainer - https://lore.kernel.org/patchwork/patch/1021048/

 drivers/iio/adc/ti-ads8688.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index 184d686ebd99..8b4568edd5cb 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -41,6 +41,7 @@
 
 #define ADS8688_VREF_MV			4096
 #define ADS8688_REALBITS		16
+#define ADS8688_MAX_CHANNELS		8
 
 /*
  * enum ads8688_range - ADS8688 reference voltage range
@@ -385,7 +386,7 @@ static irqreturn_t ads8688_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	u16 buffer[8];
+	u16 buffer[ADS8688_MAX_CHANNELS + sizeof(s64)/sizeof(u16)];
 	int i, j = 0;
 
 	for (i = 0; i < indio_dev->masklength; i++) {
-- 
2.20.1.98.gecbdaf0899

