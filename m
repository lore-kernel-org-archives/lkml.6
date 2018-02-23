Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbeBWMwG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 07:52:06 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11127 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751404AbeBWMwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 07:52:02 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <benjamin.gaignard@linaro.org>, <arnaud.pouliquen@st.com>
Subject: [PATCH 7/7] iio: adc: stm32-dfsdm: add check on spi-max-frequency
Date: Fri, 23 Feb 2018 13:51:01 +0100
Message-ID: <1519390261-25453-8-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
References: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-23_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spi-max-frequency is requested for SPI master mode (only), to tune output
clock. It may happen requested frequency isn't reachable.
Add explicit check, so probe fails with error in this case. Otherwise,
output clock may simply be silently turned off (conversions fail).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-dfsdm-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
index e50efdc..1d0d823 100644
--- a/drivers/iio/adc/stm32-dfsdm-core.c
+++ b/drivers/iio/adc/stm32-dfsdm-core.c
@@ -227,6 +227,11 @@ static int stm32_dfsdm_parse_of(struct platform_device *pdev,
 	}
 
 	priv->spi_clk_out_div = div_u64_rem(clk_freq, spi_freq, &rem) - 1;
+	if (!priv->spi_clk_out_div) {
+		/* spi_clk_out_div == 0 means ckout is OFF */
+		dev_err(&pdev->dev, "spi-max-frequency not achievable\n");
+		return -EINVAL;
+	}
 	priv->dfsdm.spi_master_freq = spi_freq;
 
 	if (rem) {
-- 
1.9.1
