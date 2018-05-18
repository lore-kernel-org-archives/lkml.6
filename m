Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752469AbeERPZP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:25:15 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:24708 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751569AbeERPZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:25:09 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <lee.jones@linaro.org>, <thierry.reding@gmail.com>
CC: <rdunlap@infradead.org>, <sfr@canb.auug.org.au>, <gerald.baeza@st.com>,
        <alexandre.torgue@st.com>, <mcoquelin.stm32@gmail.com>,
        <linux-next@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: [PATCH 1/2] mfd: stm32-timers: fix pwm-stm32 linker issue with COMPILE_TEST
Date: Fri, 18 May 2018 17:24:03 +0200
Message-ID: <1526657044-14879-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526657044-14879-1-git-send-email-fabrice.gasnier@st.com>
References: <1526657044-14879-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-18_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is seen when COMPILE_TEST=y and MFD_STM32_TIMERS=n.
drivers/pwm/pwm-stm32.o: In function 'stm32_pwm_raw_capture':
pwm-stm32.c:... undefined reference to 'stm32_timers_dma_burst_read'
Fixes: 0c6609805b63 ("mfd: stm32-timers: Add support for DMAs")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 include/linux/mfd/stm32-timers.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
index 9da1d7e..067d146 100644
--- a/include/linux/mfd/stm32-timers.h
+++ b/include/linux/mfd/stm32-timers.h
@@ -124,8 +124,20 @@ struct stm32_timers {
 	struct stm32_timers_dma dma; /* Only to be used by the parent */
 };
 
+#if IS_REACHABLE(CONFIG_MFD_STM32_TIMERS)
 int stm32_timers_dma_burst_read(struct device *dev, u32 *buf,
 				enum stm32_timers_dmas id, u32 reg,
 				unsigned int num_reg, unsigned int bursts,
 				unsigned long tmo_ms);
+#else
+static inline int stm32_timers_dma_burst_read(struct device *dev, u32 *buf,
+					      enum stm32_timers_dmas id,
+					      u32 reg,
+					      unsigned int num_reg,
+					      unsigned int bursts,
+					      unsigned long tmo_ms)
+{
+	return -ENODEV;
+}
+#endif
 #endif
-- 
1.9.1
