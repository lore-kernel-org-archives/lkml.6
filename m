Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753244AbeDJM6H (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:58:07 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35000 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753164AbeDJM6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:58:04 -0400
X-Google-Smtp-Source: AIpwx4/vyM7dGd7ERS+7RkgBkXywwrfEsmIP9rlvkUor81hB65uVGwIK+o+2WxXyBRgw30V2aesDUQ==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: dvhart@infradead.org, andy@infradead.org
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] platform: x86: intel_scu_ipc: Replace mdelay with usleep_range in intel_scu_ipc_i2c_cntrl
Date: Tue, 10 Apr 2018 20:57:56 +0800
Message-Id: <1523365076-31461-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

intel_scu_ipc_i2c_cntrl() calls mutex_lock(), which indicates
this function is not called in atomic context.

Despite never getting called from atomic context, 
intel_scu_ipc_i2c_cntrl() calls mdelay to busily wait.
This is not necessary and can be replaced with usleep_range to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/platform/x86/intel_scu_ipc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 2c85f75..75c8fef 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -584,11 +584,11 @@ int intel_scu_ipc_i2c_cntrl(u32 addr, u32 *data)
 	if (cmd == IPC_I2C_READ) {
 		writel(addr, scu->i2c_base + IPC_I2C_CNTRL_ADDR);
 		/* Write not getting updated without delay */
-		mdelay(1);
+		usleep_range(1000, 2000);
 		*data = readl(scu->i2c_base + I2C_DATA_ADDR);
 	} else if (cmd == IPC_I2C_WRITE) {
 		writel(*data, scu->i2c_base + I2C_DATA_ADDR);
-		mdelay(1);
+		usleep_range(1000, 2000);
 		writel(addr, scu->i2c_base + IPC_I2C_CNTRL_ADDR);
 	} else {
 		dev_err(scu->dev,
-- 
1.9.1
