Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751306AbeDXPAS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:00:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:25431 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751251AbeDXPAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:00:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,323,1520924400";
   d="scan'208";a="193997599"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v1] mfd: intel-lpss: Program REMAP register in PIO mode
Date: Tue, 24 Apr 2018 18:00:10 +0300
Message-Id: <20180424150010.60760-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to documentation REMAP register has to be programmed in
either DMA or PIO mode of the slice.

Move the DMA capability check below to let REMAP register be programmed
in PIO mode.

Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index 9e545eb6e8b4..4bcf117a7ba8 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -275,11 +275,11 @@ static void intel_lpss_init_dev(const struct intel_lpss *lpss)
 
 	intel_lpss_deassert_reset(lpss);
 
+	intel_lpss_set_remap_addr(lpss);
+
 	if (!intel_lpss_has_idma(lpss))
 		return;
 
-	intel_lpss_set_remap_addr(lpss);
-
 	/* Make sure that SPI multiblock DMA transfers are re-enabled */
 	if (lpss->type == LPSS_DEV_SPI)
 		writel(value, lpss->priv + LPSS_PRIV_SSP_REG);
-- 
2.17.0
