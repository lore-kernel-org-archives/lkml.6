Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E25BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5762087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5762087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389799AbeKPXBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:01:54 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54191 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728035AbeKPXBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 18:01:54 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id wAGCmdE3029115;
        Fri, 16 Nov 2018 13:49:19 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2nr7cwyw1h-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 16 Nov 2018 13:49:19 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3B29F31;
        Fri, 16 Nov 2018 12:49:19 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1EDF22B44;
        Fri, 16 Nov 2018 12:49:19 +0000 (GMT)
Received: from localhost (10.75.127.46) by SFHDAG5NODE2.st.com (10.75.127.14)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 16 Nov 2018 13:49:18
 +0100
From:   Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v1] dmaengine: stm32-dma: check FIFO error interrupt enable
Date:   Fri, 16 Nov 2018 13:49:15 +0100
Message-ID: <1542372555-18283-1-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-16_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For avoiding false FIFO detection, check FIFO Error interrupt is
enabled prior raising any errors.
This will prevent having spurious FIFO error where it shouldn't.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 drivers/dma/stm32-dma.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 4903a40..48f7c0f 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -641,12 +641,13 @@ static irqreturn_t stm32_dma_chan_irq(int irq, void *devid)
 {
 	struct stm32_dma_chan *chan = devid;
 	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
-	u32 status, scr;
+	u32 status, scr, sfcr;
 
 	spin_lock(&chan->vchan.lock);
 
 	status = stm32_dma_irq_status(chan);
 	scr = stm32_dma_read(dmadev, STM32_DMA_SCR(chan->id));
+	sfcr = stm32_dma_read(dmadev, STM32_DMA_SFCR(chan->id));
 
 	if (status & STM32_DMA_TCI) {
 		stm32_dma_irq_clear(chan, STM32_DMA_TCI);
@@ -661,10 +662,12 @@ static irqreturn_t stm32_dma_chan_irq(int irq, void *devid)
 	if (status & STM32_DMA_FEI) {
 		stm32_dma_irq_clear(chan, STM32_DMA_FEI);
 		status &= ~STM32_DMA_FEI;
-		if (!(scr & STM32_DMA_SCR_EN))
-			dev_err(chan2dev(chan), "FIFO Error\n");
-		else
-			dev_dbg(chan2dev(chan), "FIFO over/underrun\n");
+		if (sfcr & STM32_DMA_SFCR_FEIE) {
+			if (!(scr & STM32_DMA_SCR_EN))
+				dev_err(chan2dev(chan), "FIFO Error\n");
+			else
+				dev_dbg(chan2dev(chan), "FIFO over/underrun\n");
+		}
 	}
 	if (status) {
 		stm32_dma_irq_clear(chan, status);
-- 
2.7.4

