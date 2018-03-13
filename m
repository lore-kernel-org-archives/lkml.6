Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752307AbeCMRQb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:16:31 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34205 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751467AbeCMRQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:16:28 -0400
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Vinod Koul <vinod.koul@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v1 1/2] dmaengine: stm32-mdma: align TLEN and buffer length on burst
Date: Tue, 13 Mar 2018 18:16:05 +0100
Message-ID: <1520961366-27473-2-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520961366-27473-1-git-send-email-pierre-yves.mordret@st.com>
References: <1520961366-27473-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_08:,,
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
