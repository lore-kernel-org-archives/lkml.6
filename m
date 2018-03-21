Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751912AbeCUIak (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 04:30:40 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:50108 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751658AbeCUIai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 04:30:38 -0400
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <vinod.koul@intel.com>
CC: <linux-arm-kernel@lists.infradead.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <dan.j.williams@intel.com>
Subject: [PATCH] dmaengine: edma: Check the memory allocation for the memcpy dma device
Date: Wed, 21 Mar 2018 10:30:22 +0200
Message-ID: <20180321083022.32616-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the allocation fails then disable the memcpy support.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 5b197473106b..519e69e81fca 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -1899,6 +1899,11 @@ static void edma_dma_init(struct edma_cc *ecc, bool legacy_mode)
 
 	if (memcpy_channels) {
 		m_ddev = devm_kzalloc(ecc->dev, sizeof(*m_ddev), GFP_KERNEL);
+		if (!m_ddev) {
+			dev_warn(ecc->dev, "memcpy is disabled due to OoM\n");
+			memcpy_channels = NULL;
+			goto ch_setup;
+		}
 		ecc->dma_memcpy = m_ddev;
 
 		dma_cap_zero(m_ddev->cap_mask);
@@ -1926,6 +1931,7 @@ static void edma_dma_init(struct edma_cc *ecc, bool legacy_mode)
 		dev_info(ecc->dev, "memcpy is disabled\n");
 	}
 
+ch_setup:
 	for (i = 0; i < ecc->num_channels; i++) {
 		struct edma_chan *echan = &ecc->slave_chans[i];
 		echan->ch_num = EDMA_CTLR_CHAN(ecc->id, i);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
