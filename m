Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751624AbeBWMwR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 07:52:17 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53978 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751586AbeBWMwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 07:52:16 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <benjamin.gaignard@linaro.org>, <arnaud.pouliquen@st.com>
Subject: [PATCH 6/7] iio: adc: stm32-dfsdm: add check on max filter id
Date: Fri, 23 Feb 2018 13:51:00 +0100
Message-ID: <1519390261-25453-7-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
References: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-23_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reg property should be checked against number of available filters.
BTW, dfsdm->num_fls wasn't used. But it can be used for this purpose.
This prevents using data out of allocated dfsdm->fl_list array.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 57bcb45..1b78bec 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1111,8 +1111,8 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, adc);
 
 	ret = of_property_read_u32(dev->of_node, "reg", &adc->fl_id);
-	if (ret != 0) {
-		dev_err(dev, "Missing reg property\n");
+	if (ret != 0 || adc->fl_id >= adc->dfsdm->num_fls) {
+		dev_err(dev, "Missing or bad reg property\n");
 		return -EINVAL;
 	}
 
-- 
1.9.1
