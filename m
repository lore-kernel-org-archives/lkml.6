Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752091AbeBHNny (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 08:43:54 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:31460 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751878AbeBHNnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 08:43:52 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <alexandre.torgue@st.com>, <mcoquelin.stm32@gmail.com>,
        <fabrice.gasnier@st.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] regulator: stm32-vrefbuf: fix check on ready flag
Date: Thu, 8 Feb 2018 14:43:05 +0100
Message-ID: <1518097385-7449-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-08_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stm32_vrefbuf_enable() wrongly checks VRR bit: 0 stands for not ready,
1 for ready. It currently checks the opposite.
This makes enable routine to exit immediately without waiting for ready
flag.

Fixes: 0cdbf481e927 ("regulator: Add support for stm32-vrefbuf")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/regulator/stm32-vrefbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/stm32-vrefbuf.c b/drivers/regulator/stm32-vrefbuf.c
index 72c8b3e..e0a9c44 100644
--- a/drivers/regulator/stm32-vrefbuf.c
+++ b/drivers/regulator/stm32-vrefbuf.c
@@ -51,7 +51,7 @@ static int stm32_vrefbuf_enable(struct regulator_dev *rdev)
 	 * arbitrary timeout.
 	 */
 	ret = readl_poll_timeout(priv->base + STM32_VREFBUF_CSR, val,
-				 !(val & STM32_VRR), 650, 10000);
+				 val & STM32_VRR, 650, 10000);
 	if (ret) {
 		dev_err(&rdev->dev, "stm32 vrefbuf timed out!\n");
 		val = readl_relaxed(priv->base + STM32_VREFBUF_CSR);
-- 
1.9.1
