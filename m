Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753930AbeFDHFL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753913AbeFDHFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:05:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabrice Gasnier <fabrice.gasnier@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.16 29/47] iio: adc: stm32-dfsdm: fix successive oversampling settings
Date: Mon,  4 Jun 2018 08:58:41 +0200
Message-Id: <20180604065550.696409642@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065549.468488465@linuxfoundation.org>
References: <20180604065549.468488465@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabrice Gasnier <fabrice.gasnier@st.com>

commit 7531cf59bfa082769887ec70c2029838ea139f11 upstream.

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
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/stm32-dfsdm-adc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -144,6 +144,7 @@ static int stm32_dfsdm_set_osrs(struct s
 	 * Leave as soon as if exact resolution if reached.
 	 * Otherwise the higher resolution below 32 bits is kept.
 	 */
+	fl->res = 0;
 	for (fosr = 1; fosr <= DFSDM_MAX_FL_OVERSAMPLING; fosr++) {
 		for (iosr = 1; iosr <= DFSDM_MAX_INT_OVERSAMPLING; iosr++) {
 			if (fast)
@@ -193,7 +194,7 @@ static int stm32_dfsdm_set_osrs(struct s
 		}
 	}
 
-	if (!fl->fosr)
+	if (!fl->res)
 		return -EINVAL;
 
 	return 0;
