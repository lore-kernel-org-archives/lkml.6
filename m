Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933469AbeCMQz5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:55:57 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:60862 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752163AbeCMQzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:55:55 -0400
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Vinod Koul <vinod.koul@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v1 1/1] dmaengine: stm32-dmamux: fix a potential buffer overflow
Date: Tue, 13 Mar 2018 17:55:35 +0100
Message-ID: <1520960135-26575-1-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bitfield dma_inuse is allocated of size dma_requests bits, thus a
valid bit address is from 0 to (dma_requests - 1).
When find_first_zero_bit() fails, it returns dma_requests as invalid
address.
Using such address for the following set_bit() is incorrect and, if
dma_requests is a multiple of BITS_PER_LONG, it will cause a buffer
overflow.
Currently this driver is only used in DT stm32h743.dtsi where a safe value
dma_requests=16 is not triggering the buffer overflow.

Fixed by checking the return value of find_first_zero_bit() _before_
using it.

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 drivers/dma/stm32-dmamux.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
index 4dbb30c..b922db9 100644
--- a/drivers/dma/stm32-dmamux.c
+++ b/drivers/dma/stm32-dmamux.c
@@ -118,14 +118,15 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	spin_lock_irqsave(&dmamux->lock, flags);
 	mux->chan_id = find_first_zero_bit(dmamux->dma_inuse,
 					   dmamux->dma_requests);
-	set_bit(mux->chan_id, dmamux->dma_inuse);
-	spin_unlock_irqrestore(&dmamux->lock, flags);
 
 	if (mux->chan_id == dmamux->dma_requests) {
+		spin_unlock_irqrestore(&dmamux->lock, flags);
 		dev_err(&pdev->dev, "Run out of free DMA requests\n");
 		ret = -ENOMEM;
-		goto error;
+		goto error_chan_id;
 	}
+	set_bit(mux->chan_id, dmamux->dma_inuse);
+	spin_unlock_irqrestore(&dmamux->lock, flags);
 
 	/* Look for DMA Master */
 	for (i = 1, min = 0, max = dmamux->dma_reqs[i];
@@ -173,6 +174,8 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 
 error:
 	clear_bit(mux->chan_id, dmamux->dma_inuse);
+
+error_chan_id:
 	kfree(mux);
 	return ERR_PTR(ret);
 }
-- 
2.7.4
