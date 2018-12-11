Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0E2C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE16220879
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ktpdQXGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE16220879
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeLKTMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:12:23 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46420 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeLKTMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:12:16 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBBJCE6h068867;
        Tue, 11 Dec 2018 13:12:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544555534;
        bh=4GmxVsEkvur/HocmJaaz385vAXn4ukjjWJj68nJCE5w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ktpdQXGiZdtYYB32VJRL68g95GI7Yhsv7DIhK1ziGwlF2BVvlqMo1leXMxXEPoepq
         iLrKwXk/M4tSySC5Vez2kMKRfHpTxkiyhynBsXvusiCA4UmwxXR1qZ0/QpGdoh+6X3
         RLrl58Z78Wh+3ihT50YDQjbayx6IfdY4SRGtAPUs=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBBJCEtC010258
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Dec 2018 13:12:14 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 11
 Dec 2018 13:12:14 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 11 Dec 2018 13:12:14 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBBJCEdu012041;
        Tue, 11 Dec 2018 13:12:14 -0600
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.100.89])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id wBBJCDU05313;
        Tue, 11 Dec 2018 13:12:13 -0600 (CST)
From:   Dan Murphy <dmurphy@ti.com>
To:     <linux-iio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2 3/4] iio: ti-ads8688: Update buffer allocation for timestamps
Date:   Tue, 11 Dec 2018 13:12:06 -0600
Message-ID: <20181211191207.21900-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20181211191207.21900-1-dmurphy@ti.com>
References: <20181211191207.21900-1-dmurphy@ti.com>
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

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v2 - New patch suggested change by maintainer - https://lore.kernel.org/patchwork/patch/1021048/

 drivers/iio/adc/ti-ads8688.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index 184d686ebd99..3597bc0697ee 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -385,7 +385,7 @@ static irqreturn_t ads8688_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	u16 buffer[8];
+	unsigned short buffer[8 + sizeof(s64)/sizeof(short)];
 	int i, j = 0;
 
 	for (i = 0; i < indio_dev->masklength; i++) {
-- 
2.20.0.rc2.7.g965798d1f2

