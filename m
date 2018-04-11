Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753662AbeDKOpF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:45:05 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:49281 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753077AbeDKOpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:45:02 -0400
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Vinod Koul <vinod.koul@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v2 1/2] dmaengine: stm32-mdma: align TLEN and buffer length on burst
Date: Wed, 11 Apr 2018 16:44:38 +0200
Message-ID: <1523457879-9869-2-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523457879-9869-1-git-send-email-pierre-yves.mordret@st.com>
References: <1523457879-9869-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_07:,,
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
---
---
 drivers/dma/stm32-mdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index daa1602..fbcffa2 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -413,7 +413,7 @@ static u32 stm32_mdma_get_best_burst(u32 buf_len, u32 tlen, u32 max_burst,
 	u32 best_burst = max_burst;
 	u32 burst_len = best_burst * width;
 
-	while ((burst_len > 0) && (tlen % burst_len)) {
+	while ((burst_len > 0) && (((tlen | buf_len) & (burst_len - 1)) != 0)) {
 		best_burst = best_burst >> 1;
 		burst_len = best_burst * width;
 	}
-- 
2.7.4
