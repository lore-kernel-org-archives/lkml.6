Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbeDIGlX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 02:41:23 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35249 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751886AbeDIGlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 02:41:21 -0400
X-Google-Smtp-Source: AIpwx4+2WxvZDekq6ceX2LW8o5mJV9W2hYP7GlIgXKp9NqNUZswT/scyrhf3ar6Gbu8o0sDZdUM/KQ==
From: Baolin Wang <baolin.wang@linaro.org>
To: wsa@the-dreams.de
Cc: broonie@kernel.org, baolin.wang@linaro.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] i2c: sprd: Prevent i2c accesses after suspend is called
Date: Mon,  9 Apr 2018 14:40:54 +0800
Message-Id: <99031524fa147e72451d26f54b24f36093c0d3fa.1523255712.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one flag to indicate if the i2c controller has been in suspend state,
which can prevent i2c accesses after i2c controller is suspended following
system suspend.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/i2c/busses/i2c-sprd.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
index 25fcc3c..2fdad63 100644
--- a/drivers/i2c/busses/i2c-sprd.c
+++ b/drivers/i2c/busses/i2c-sprd.c
@@ -86,6 +86,7 @@ struct sprd_i2c {
 	u32 count;
 	int irq;
 	int err;
+	bool is_suspended;
 };
 
 static void sprd_i2c_set_count(struct sprd_i2c *i2c_dev, u32 count)
@@ -283,6 +284,9 @@ static int sprd_i2c_master_xfer(struct i2c_adapter *i2c_adap,
 	struct sprd_i2c *i2c_dev = i2c_adap->algo_data;
 	int im, ret;
 
+	if (i2c_dev->is_suspended)
+		return -EBUSY;
+
 	ret = pm_runtime_get_sync(i2c_dev->dev);
 	if (ret < 0)
 		return ret;
@@ -586,11 +590,23 @@ static int sprd_i2c_remove(struct platform_device *pdev)
 
 static int __maybe_unused sprd_i2c_suspend_noirq(struct device *pdev)
 {
+	struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
+
+	i2c_lock_adapter(&i2c_dev->adap);
+	i2c_dev->is_suspended = true;
+	i2c_unlock_adapter(&i2c_dev->adap);
+
 	return pm_runtime_force_suspend(pdev);
 }
 
 static int __maybe_unused sprd_i2c_resume_noirq(struct device *pdev)
 {
+	struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
+
+	i2c_lock_adapter(&i2c_dev->adap);
+	i2c_dev->is_suspended = false;
+	i2c_unlock_adapter(&i2c_dev->adap);
+
 	return pm_runtime_force_resume(pdev);
 }
 
-- 
1.7.9.5
