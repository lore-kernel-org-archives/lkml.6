Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95A2C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F14D20865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F14D20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeIKM3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:29:43 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:57411 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726301AbeIKM3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:29:43 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8B7TPNb029826;
        Tue, 11 Sep 2018 09:31:17 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2me62r1020-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 11 Sep 2018 09:31:17 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6274434;
        Tue, 11 Sep 2018 07:31:17 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3EBEC241B;
        Tue, 11 Sep 2018 07:31:17 +0000 (GMT)
Received: from localhost (10.75.127.44) by SFHDAG5NODE2.st.com (10.75.127.14)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 11 Sep 2018 09:31:16
 +0200
From:   Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v1 1/1] dmaengine: stm32-dma: check whether length is aligned on FIFO threshold
Date:   Tue, 11 Sep 2018 09:31:16 +0200
Message-ID: <1536651076-17005-1-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-11_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a period length is not multiple of FIFO some data may be stuck
within FIFO.

Burst/FIFO Threshold/Period or buffer length check has to be hardened

In any case DMA will grant any request from client but will degraded
any parameters whether awkward.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 drivers/dma/stm32-dma.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 379e8d5..4903a40 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -308,20 +308,12 @@ static bool stm32_dma_fifo_threshold_is_allowed(u32 burst, u32 threshold,
 
 static bool stm32_dma_is_burst_possible(u32 buf_len, u32 threshold)
 {
-	switch (threshold) {
-	case STM32_DMA_FIFO_THRESHOLD_FULL:
-		if (buf_len >= STM32_DMA_MAX_BURST)
-			return true;
-		else
-			return false;
-	case STM32_DMA_FIFO_THRESHOLD_HALFFULL:
-		if (buf_len >= STM32_DMA_MAX_BURST / 2)
-			return true;
-		else
-			return false;
-	default:
-		return false;
-	}
+	/*
+	 * Buffer or period length has to be aligned on FIFO depth.
+	 * Otherwise bytes may be stuck within FIFO at buffer or period
+	 * length.
+	 */
+	return ((buf_len % ((threshold + 1) * 4)) == 0);
 }
 
 static u32 stm32_dma_get_best_burst(u32 buf_len, u32 max_burst, u32 threshold,
-- 
2.7.4

