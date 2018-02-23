Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751682AbeBWMwm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 07:52:42 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41962 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751432AbeBWMwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 07:52:04 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <benjamin.gaignard@linaro.org>, <arnaud.pouliquen@st.com>
Subject: [PATCH 3/7] iio: adc: stm32-dfsdm: fix clock source selection
Date: Fri, 23 Feb 2018 13:50:57 +0100
Message-ID: <1519390261-25453-4-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
References: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-23_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing clock source selection. In case "audio" clock is provided,
it's unused currently: "dfsdm" clock is wrongly used by default.

Fixes: bed73904e76f ("IIO: ADC: add stm32 DFSDM core support")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-dfsdm-core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
index 0635f93..e50efdc 100644
--- a/drivers/iio/adc/stm32-dfsdm-core.c
+++ b/drivers/iio/adc/stm32-dfsdm-core.c
@@ -83,7 +83,7 @@ int stm32_dfsdm_start_dfsdm(struct stm32_dfsdm *dfsdm)
 {
 	struct dfsdm_priv *priv = container_of(dfsdm, struct dfsdm_priv, dfsdm);
 	struct device *dev = &priv->pdev->dev;
-	unsigned int clk_div = priv->spi_clk_out_div;
+	unsigned int clk_div = priv->spi_clk_out_div, clk_src;
 	int ret;
 
 	if (atomic_inc_return(&priv->n_active_ch) == 1) {
@@ -100,6 +100,14 @@ int stm32_dfsdm_start_dfsdm(struct stm32_dfsdm *dfsdm)
 			}
 		}
 
+		/* select clock source, e.g. 0 for "dfsdm" or 1 for "audio" */
+		clk_src = priv->aclk ? 1 : 0;
+		ret = regmap_update_bits(dfsdm->regmap, DFSDM_CHCFGR1(0),
+					 DFSDM_CHCFGR1_CKOUTSRC_MASK,
+					 DFSDM_CHCFGR1_CKOUTSRC(clk_src));
+		if (ret < 0)
+			goto disable_aclk;
+
 		/* Output the SPI CLKOUT (if clk_div == 0 clock if OFF) */
 		ret = regmap_update_bits(dfsdm->regmap, DFSDM_CHCFGR1(0),
 					 DFSDM_CHCFGR1_CKOUTDIV_MASK,
-- 
1.9.1
