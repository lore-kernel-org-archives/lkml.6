Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDFCC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097BC20684
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097BC20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbeI1PAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:00:36 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52821 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728275AbeI1PAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:00:36 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8S8YNS8007704;
        Fri, 28 Sep 2018 10:37:15 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mqd47wx6g-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 28 Sep 2018 10:37:15 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A301538;
        Fri, 28 Sep 2018 08:37:14 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3F005110B;
        Fri, 28 Sep 2018 08:37:14 +0000 (GMT)
Received: from localhost (10.75.127.45) by SFHDAG5NODE2.st.com (10.75.127.14)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 28 Sep 2018 10:37:13
 +0200
From:   Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v2 6/7] dmaengine: stm32-dma: enable descriptor_reuse
Date:   Fri, 28 Sep 2018 10:36:33 +0200
Message-ID: <1538123794-17085-7-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538123794-17085-1-git-send-email-pierre-yves.mordret@st.com>
References: <1538123794-17085-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable client to resubmit already processed descriptors
in order to save descriptor creation time.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 drivers/dma/stm32-dma.c | 84 +++++++++++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 30 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 1571f2f..fac44ed 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -836,34 +836,8 @@ static int stm32_dma_mdma_start(struct stm32_dma_chan *chan,
 {
 	struct stm32_dma_mdma *mchan = &chan->mchan;
 	struct stm32_dma_mdma_desc *m_desc = &sg_req->m_desc;
-	struct dma_slave_config config;
 	int ret;
 
-	/* Configure MDMA channel */
-	memset(&config, 0, sizeof(config));
-	if (mchan->dir == DMA_MEM_TO_DEV)
-		config.dst_addr = mchan->sram_buf;
-	else
-		config.src_addr = mchan->sram_buf;
-
-	ret = dmaengine_slave_config(mchan->chan, &config);
-	if (ret < 0)
-		goto error;
-
-	 /* Prepare MDMA descriptor */
-	m_desc->desc = dmaengine_prep_slave_sg(mchan->chan, m_desc->sgt.sgl,
-					       m_desc->sgt.nents, mchan->dir,
-					       DMA_PREP_INTERRUPT);
-	if (!m_desc->desc) {
-		ret = -EINVAL;
-		goto error;
-	}
-
-	if (mchan->dir != DMA_MEM_TO_DEV) {
-		m_desc->desc->callback_result = stm32_mdma_chan_complete;
-		m_desc->desc->callback_param = chan;
-	}
-
 	ret = dma_submit_error(dmaengine_submit(m_desc->desc));
 	if (ret < 0) {
 		dev_err(chan2dev(chan), "MDMA submit failed\n");
@@ -1001,6 +975,7 @@ static void stm32_dma_start_transfer(struct stm32_dma_chan *chan)
 
 	chan->next_sg++;
 
+	reg->dma_scr &= ~STM32_DMA_SCR_EN;
 	stm32_dma_write(dmadev, STM32_DMA_SCR(chan->id), reg->dma_scr);
 	stm32_dma_write(dmadev, STM32_DMA_SPAR(chan->id), reg->dma_spar);
 	stm32_dma_write(dmadev, STM32_DMA_SM0AR(chan->id), reg->dma_sm0ar);
@@ -1238,9 +1213,11 @@ static void stm32_dma_clear_reg(struct stm32_dma_chan_reg *regs)
 
 static int stm32_dma_mdma_prep_slave_sg(struct stm32_dma_chan *chan,
 					struct scatterlist *sgl, u32 sg_len,
-					struct stm32_dma_desc *desc)
+					struct stm32_dma_desc *desc,
+					unsigned long flags)
 {
 	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
+	struct stm32_dma_mdma *mchan = &chan->mchan;
 	struct scatterlist *sg, *m_sg;
 	dma_addr_t dma_buf;
 	u32 len, num_sgs, sram_period;
@@ -1256,12 +1233,13 @@ static int stm32_dma_mdma_prep_slave_sg(struct stm32_dma_chan *chan,
 
 	for_each_sg(sgl, sg, sg_len, i) {
 		struct stm32_dma_mdma_desc *m_desc = &desc->sg_req[i].m_desc;
+		struct dma_slave_config config;
 
 		len = sg_dma_len(sg);
 		desc->sg_req[i].stm32_sgl_req = *sg;
 		num_sgs = 1;
 
-		if (chan->mchan.dir == DMA_MEM_TO_DEV) {
+		if (mchan->dir == DMA_MEM_TO_DEV) {
 			if (len > chan->sram_size) {
 				dev_err(chan2dev(chan),
 					"max buf size = %d bytes\n",
@@ -1293,6 +1271,38 @@ static int stm32_dma_mdma_prep_slave_sg(struct stm32_dma_chan *chan,
 			dma_buf += bytes;
 			len -= bytes;
 		}
+
+		/* Configure MDMA channel */
+		memset(&config, 0, sizeof(config));
+		if (mchan->dir == DMA_MEM_TO_DEV)
+			config.dst_addr = desc->dma_buf;
+		else
+			config.src_addr = desc->dma_buf;
+
+		ret = dmaengine_slave_config(mchan->chan, &config);
+		if (ret < 0)
+			goto err;
+
+		/* Prepare MDMA descriptor */
+		m_desc->desc = dmaengine_prep_slave_sg(mchan->chan,
+						       m_desc->sgt.sgl,
+						       m_desc->sgt.nents,
+						       mchan->dir,
+						       DMA_PREP_INTERRUPT);
+
+		if (!m_desc->desc) {
+			ret = -EINVAL;
+			goto err;
+		}
+
+		if (flags & DMA_CTRL_REUSE)
+			dmaengine_desc_set_reuse(m_desc->desc);
+
+		if (mchan->dir != DMA_MEM_TO_DEV) {
+			m_desc->desc->callback_result =
+				stm32_mdma_chan_complete;
+			m_desc->desc->callback_param = chan;
+		}
 	}
 
 	chan->mchan.sram_buf = desc->dma_buf;
@@ -1302,8 +1312,12 @@ static int stm32_dma_mdma_prep_slave_sg(struct stm32_dma_chan *chan,
 	return 0;
 
 err:
-	for (j = 0; j < i; j++)
+	for (j = 0; j < i; j++) {
+		struct stm32_dma_mdma_desc *m_desc = &desc->sg_req[j].m_desc;
+
+		m_desc->desc = NULL;
 		sg_free_table(&desc->sg_req[j].m_desc.sgt);
+	}
 free_alloc:
 	gen_pool_free(dmadev->sram_pool, (unsigned long)desc->dma_buf_cpu,
 		      chan->sram_size);
@@ -1385,7 +1399,8 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_slave_sg(
 		struct scatterlist *s, *_sgl;
 
 		chan->mchan.dir = direction;
-		ret = stm32_dma_mdma_prep_slave_sg(chan, sgl, sg_len, desc);
+		ret = stm32_dma_mdma_prep_slave_sg(chan, sgl, sg_len, desc,
+						   flags);
 		if (ret < 0)
 			return NULL;
 
@@ -1791,6 +1806,14 @@ static void stm32_dma_desc_free(struct virt_dma_desc *vdesc)
 	int i;
 
 	if (chan->use_mdma) {
+		struct stm32_dma_mdma_desc *m_desc;
+
+		for (i = 0; i < desc->num_sgs; i++) {
+			m_desc = &desc->sg_req[i].m_desc;
+			dmaengine_desc_free(m_desc->desc);
+			m_desc->desc = NULL;
+		}
+
 		for (i = 0; i < desc->num_sgs; i++)
 			sg_free_table(&desc->sg_req[i].m_desc.sgt);
 
@@ -1934,6 +1957,7 @@ static int stm32_dma_probe(struct platform_device *pdev)
 	dd->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	dd->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 	dd->max_burst = STM32_DMA_MAX_BURST;
+	dd->descriptor_reuse = true;
 	dd->dev = &pdev->dev;
 	INIT_LIST_HEAD(&dd->channels);
 
-- 
2.7.4

