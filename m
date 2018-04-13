Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754334AbeDMNwk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 09:52:40 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:26197 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754285AbeDMNwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 09:52:37 -0400
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Vinod Koul <vinod.koul@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v3 1/2] dmaengine: stm32-mdma: align TLEN and buffer length on burst
Date: Fri, 13 Apr 2018 15:52:12 +0200
Message-ID: <1523627533-7184-2-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523627533-7184-1-git-send-email-pierre-yves.mordret@st.com>
References: <1523627533-7184-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-13_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both buffer Transfer Length (TLEN if any) and transfer size have to be
aligned on burst size (burst beats*bus width).

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
    v2:
    v3:
       * Get rid of while loop in favor of computed values
---
---
 drivers/dma/stm32-mdma.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index daa1602..4c7634c 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -410,13 +410,10 @@ static enum dma_slave_buswidth stm32_mdma_get_max_width(dma_addr_t addr,
 static u32 stm32_mdma_get_best_burst(u32 buf_len, u32 tlen, u32 max_burst,
 				     enum dma_slave_buswidth width)
 {
-	u32 best_burst = max_burst;
-	u32 burst_len = best_burst * width;
+	u32 best_burst;
 
-	while ((burst_len > 0) && (tlen % burst_len)) {
-		best_burst = best_burst >> 1;
-		burst_len = best_burst * width;
-	}
+	best_burst = min((u32)1 << __ffs(tlen | buf_len),
+			 max_burst * width) / width;
 
 	return (best_burst > 0) ? best_burst : 1;
 }
-- 
2.7.4
