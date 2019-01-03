Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8F8C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004A520815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730903AbfACKRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 05:17:45 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:8463 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726618AbfACKRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 05:17:44 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x03AG1vW024886;
        Thu, 3 Jan 2019 11:17:32 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2pny93a8s9-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 03 Jan 2019 11:17:32 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9C9C438;
        Thu,  3 Jan 2019 10:17:31 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7C3142C6C;
        Thu,  3 Jan 2019 10:17:31 +0000 (GMT)
Received: from localhost (10.75.127.47) by SFHDAG5NODE2.st.com (10.75.127.14)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 3 Jan 2019 11:17:30
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
Subject: [RESEND PATCH v1] dmaengine: stm32-dma: check FIFO error interrupt enable
Date:   Thu, 3 Jan 2019 11:17:29 +0100
Message-ID: <1546510649-16744-1-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-03_04:,,
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

