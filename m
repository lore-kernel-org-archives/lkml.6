Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF88CECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1F62075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="d8nSAKHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D1F62075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbeGRKF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:05:28 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49038 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730112AbeGRKF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:05:28 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6I9SPn6070890;
        Wed, 18 Jul 2018 04:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531906105;
        bh=9Juan+gsib1qp+5tidK3/xZxUUiyr97+f79NSQmcAkA=;
        h=From:To:CC:Subject:Date;
        b=d8nSAKHqYEyUKO3CP8SptKWQ5HwI1A5/JfeZ1DHl2RrKTYdlfg+i00A7KuoS89RFm
         mV+K6oOSF59kNt/WMh9UwQ+EGlzhi3QELz8S0G6X219Cvvl4lS/nPkjpufd30ddRVh
         eMzgxtKWbjlknuTaay5HhztmxpfoAej0L79fESuM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6I9SP3F027010;
        Wed, 18 Jul 2018 04:28:25 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 18
 Jul 2018 04:28:24 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 18 Jul 2018 04:28:24 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6I9SMT9027651;
        Wed, 18 Jul 2018 04:28:23 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] dmaengine: dma_request_chan_by_mask() to handle deferred probing
Date:   Wed, 18 Jul 2018 12:29:57 +0300
Message-ID: <20180718092957.1934-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there are no DMA devices registered yet, return with EPROBE_DEFER
similarly to the case when requesting a slave channel.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/dmaengine.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index d8fc7b58e506..f62e59e1a264 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -768,8 +768,14 @@ struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask)
 		return ERR_PTR(-ENODEV);
 
 	chan = __dma_request_channel(mask, NULL, NULL);
-	if (!chan)
-		chan = ERR_PTR(-ENODEV);
+	if (!chan) {
+		mutex_lock(&dma_list_mutex);
+		if (list_empty(&dma_device_list))
+			chan = ERR_PTR(-EPROBE_DEFER);
+		else
+			chan = ERR_PTR(-ENODEV);
+		mutex_unlock(&dma_list_mutex);
+	}
 
 	return chan;
 }
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

