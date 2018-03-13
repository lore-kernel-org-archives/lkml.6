Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932572AbeCMOX7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 10:23:59 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:30155 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752279AbeCMOXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 10:23:55 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <benjamin.gaignard@linaro.org>, <arnaud.pouliquen@st.com>
Subject: [PATCH 1/2] iio: adc: stm32-dfsdm: fix successive oversampling settings
Date: Tue, 13 Mar 2018 15:23:05 +0100
Message-ID: <1520950986-23116-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520950986-23116-1-git-send-email-fabrice.gasnier@st.com>
References: <1520950986-23116-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing successive oversampling settings, it may fail to update filter
parameters silently:
- First time oversampling is being set, it will be successful, as fl->res
is 0 initially.
- Next attempts with various oversamp value may return 0 (success), but
keep previous filter parameters, due to 'res' never reaches above or
equal current 'fl->res'.

This is particularly true when setting sampling frequency (that relies on
oversamp). Typical failure without error:
- run 1st test @16kHz samp freq will succeed
- run new test @8kHz will succeed as well
- run new test @16kHz (again): sample rate will remain 8kHz without error

Fixes: e2e6771c6462 ("IIO: ADC: add STM32 DFSDM sigma delta ADC support")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 01422d1..dc911b6 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -144,6 +144,7 @@ static int stm32_dfsdm_set_osrs(struct stm32_dfsdm_filter *fl,
 	 * Leave as soon as if exact resolution if reached.
 	 * Otherwise the higher resolution below 32 bits is kept.
 	 */
+	fl->res = 0;
 	for (fosr = 1; fosr <= DFSDM_MAX_FL_OVERSAMPLING; fosr++) {
 		for (iosr = 1; iosr <= DFSDM_MAX_INT_OVERSAMPLING; iosr++) {
 			if (fast)
@@ -193,7 +194,7 @@ static int stm32_dfsdm_set_osrs(struct stm32_dfsdm_filter *fl,
 		}
 	}
 
-	if (!fl->fosr)
+	if (!fl->res)
 		return -EINVAL;
 
 	return 0;
-- 
1.9.1
