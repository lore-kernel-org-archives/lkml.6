Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751221AbeD3EZ6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 00:25:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60479 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbeD3EZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 00:25:56 -0400
From: Shrirang Bagul <shrirang.bagul@canonical.com>
To: jic23@kernel.org
Cc: lorenzo.bianconi83@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: humidity: hts221: Fix sensor reads after resume
Date: Mon, 30 Apr 2018 12:25:46 +0800
Message-Id: <20180430042546.8801-1-shrirang.bagul@canonical.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CTRL1 register (ODR & BDU settings) gets reset after system comes back
from suspend, causing subsequent reads from the sensor to fail.

This patch restores the CTRL1 register after resume.

Based on:
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git iio-fixes-for-4.14b

Since 4.17.rc1, this driver uses REGMAP; I'll send a separate patch to
address this issue.

Cc: stable@vger.kernel.org
Fixes: ffebe74b7c95 (iio: humidity: hts221: avoid useless ODR reconfiguration)
Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
---
 drivers/iio/humidity/hts221_core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index 32524a8dc66f..fed2da64fa3b 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -674,11 +674,15 @@ static int __maybe_unused hts221_resume(struct device *dev)
 	struct hts221_hw *hw = iio_priv(iio_dev);
 	int err = 0;
 
-	if (hw->enabled)
-		err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
-					     HTS221_ENABLE_MASK, true);
+	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
+				     HTS221_BDU_MASK, 1);
+	if (err < 0)
+		goto fail_err;
 
-	return err;
+	err = hts221_update_odr(hw, hw->odr);
+
+fail_err:
+	return err < 0 ? err : 0;
 }
 
 const struct dev_pm_ops hts221_pm_ops = {
-- 
2.14.1
