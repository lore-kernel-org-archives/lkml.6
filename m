Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbeEPUv3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 16:51:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:2729 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751013AbeEPUv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 16:51:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,407,1520924400";
   d="scan'208";a="47034659"
From: Tomas Winkler <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH] tpm: separate cmd_ready/go_idle from runtime_pm
Date: Wed, 16 May 2018 22:46:00 +0300
Message-Id: <20180516194600.28189-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We cannot use go_idle cmd_ready commands via runtime_pm handles
as with the introduction of localities this is no longer an optional
feature, while runtime pm can be not enabled.
Though cmd_ready/go_idle provides a power saving, it's also a part of
TPM2 protocol and should be called explicitly.
This patch exposes cmd_read/go_idle via tpm class ops and removes
runtime pm support as it is not used by any driver.
New wrappers are added tpm_cmd_ready() and tpm_go_idle() wrappers to
streamline tpm_try_transmit code. TPM_TRANSMIT_UNLOCKED flag is abused to
resolve tpm spaces recursive calls to tpm_transmit().

tpm_crb no longer needs own power saving functions and can drop using
tpm_pm_suspend/resume.

This patch cannot be really spearated from the locality fix.
Fixes: 888d867df441 (tpm: cmd_ready command can be issued only after granting locality)


Fixes: 888d867df441 (tpm: cmd_ready command can be issued only after granting locality)
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V2:resent
V3:resent
V4: 1. Use tpm_pm_suspend/resume in tpm_crb
    2. Drop cmd_ready/go_idle around tpm_chip_register, as there is no
       usage counter like in runtime_pm.
V5: 1. add tpm_cmd_ready and tpm_go_idle wrappers.
    2. Abuse TPM_TRANSMIT_UNLOCKED flag to resolve tpm space
       recursion.
 drivers/char/tpm/tpm-interface.c |  33 +++++++++++--
 drivers/char/tpm/tpm_crb.c       | 101 +++++++++++----------------------------
 include/linux/tpm.h              |   2 +
 3 files changed, 57 insertions(+), 79 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index e32f6e85dc6d..f802d4ee918c 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -29,7 +29,6 @@
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/freezer.h>
-#include <linux/pm_runtime.h>
 #include <linux/tpm_eventlog.h>
 
 #include "tpm.h"
@@ -399,6 +398,28 @@ static void tpm_relinquish_locality(struct tpm_chip *chip)
 	chip->locality = -1;
 }
 
+static int tpm_cmd_ready(struct tpm_chip *chip, unsigned int flags)
+{
+	if (flags & TPM_TRANSMIT_UNLOCKED)
+		return 0;
+
+	if (!chip->ops->cmd_ready)
+		return 0;
+
+	return chip->ops->cmd_ready(chip);
+}
+
+static int tpm_go_idle(struct tpm_chip *chip, unsigned int flags)
+{
+	if (flags & TPM_TRANSMIT_UNLOCKED)
+		return 0;
+
+	if (!chip->ops->go_idle)
+		return 0;
+
+	return chip->ops->go_idle(chip);
+}
+
 static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 				struct tpm_space *space,
 				u8 *buf, size_t bufsiz,
@@ -455,8 +476,9 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 			goto out_no_locality;
 	}
 
-	if (chip->dev.parent)
-		pm_runtime_get_sync(chip->dev.parent);
+	rc = tpm_cmd_ready(chip, flags);
+	if (rc)
+		goto out;
 
 	rc = tpm2_prepare_space(chip, space, ordinal, buf);
 	if (rc)
@@ -518,8 +540,9 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 	rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
 
 out:
-	if (chip->dev.parent)
-		pm_runtime_put_sync(chip->dev.parent);
+	rc = tpm_go_idle(chip, flags);
+	if (rc)
+		goto out;
 
 	if (need_locality)
 		tpm_relinquish_locality(chip);
diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 34fbc6cb097b..36952ef98f90 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -132,7 +132,7 @@ static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
 }
 
 /**
- * crb_go_idle - request tpm crb device to go the idle state
+ * __crb_go_idle - request tpm crb device to go the idle state
  *
  * @dev:  crb device
  * @priv: crb private data
@@ -147,7 +147,7 @@ static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
  *
  * Return: 0 always
  */
-static int crb_go_idle(struct device *dev, struct crb_priv *priv)
+static int __crb_go_idle(struct device *dev, struct crb_priv *priv)
 {
 	if ((priv->sm == ACPI_TPM2_START_METHOD) ||
 	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) ||
@@ -163,11 +163,20 @@ static int crb_go_idle(struct device *dev, struct crb_priv *priv)
 		dev_warn(dev, "goIdle timed out\n");
 		return -ETIME;
 	}
+
 	return 0;
 }
 
+static int crb_go_idle(struct tpm_chip *chip)
+{
+	struct device *dev = &chip->dev;
+	struct crb_priv *priv = dev_get_drvdata(dev);
+
+	return __crb_go_idle(dev, priv);
+}
+
 /**
- * crb_cmd_ready - request tpm crb device to enter ready state
+ * __crb_cmd_ready - request tpm crb device to enter ready state
  *
  * @dev:  crb device
  * @priv: crb private data
@@ -181,7 +190,7 @@ static int crb_go_idle(struct device *dev, struct crb_priv *priv)
  *
  * Return: 0 on success -ETIME on timeout;
  */
-static int crb_cmd_ready(struct device *dev, struct crb_priv *priv)
+static int __crb_cmd_ready(struct device *dev, struct crb_priv *priv)
 {
 	if ((priv->sm == ACPI_TPM2_START_METHOD) ||
 	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) ||
@@ -200,6 +209,14 @@ static int crb_cmd_ready(struct device *dev, struct crb_priv *priv)
 	return 0;
 }
 
+static int crb_cmd_ready(struct tpm_chip *chip)
+{
+	struct device *dev = &chip->dev;
+	struct crb_priv *priv = dev_get_drvdata(dev);
+
+	return __crb_cmd_ready(dev, priv);
+}
+
 static int __crb_request_locality(struct device *dev,
 				  struct crb_priv *priv, int loc)
 {
@@ -401,6 +418,8 @@ static const struct tpm_class_ops tpm_crb = {
 	.send = crb_send,
 	.cancel = crb_cancel,
 	.req_canceled = crb_req_canceled,
+	.go_idle  = crb_go_idle,
+	.cmd_ready = crb_cmd_ready,
 	.request_locality = crb_request_locality,
 	.relinquish_locality = crb_relinquish_locality,
 	.req_complete_mask = CRB_DRV_STS_COMPLETE,
@@ -520,7 +539,7 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	 * PTT HW bug w/a: wake up the device to access
 	 * possibly not retained registers.
 	 */
-	ret = crb_cmd_ready(dev, priv);
+	ret = __crb_cmd_ready(dev, priv);
 	if (ret)
 		goto out_relinquish_locality;
 
@@ -565,7 +584,7 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	if (!ret)
 		priv->cmd_size = cmd_size;
 
-	crb_go_idle(dev, priv);
+	__crb_go_idle(dev, priv);
 
 out_relinquish_locality:
 
@@ -628,32 +647,7 @@ static int crb_acpi_add(struct acpi_device *device)
 	chip->acpi_dev_handle = device->handle;
 	chip->flags = TPM_CHIP_FLAG_TPM2;
 
-	rc = __crb_request_locality(dev, priv, 0);
-	if (rc)
-		return rc;
-
-	rc  = crb_cmd_ready(dev, priv);
-	if (rc)
-		goto out;
-
-	pm_runtime_get_noresume(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-
-	rc = tpm_chip_register(chip);
-	if (rc) {
-		crb_go_idle(dev, priv);
-		pm_runtime_put_noidle(dev);
-		pm_runtime_disable(dev);
-		goto out;
-	}
-
-	pm_runtime_put_sync(dev);
-
-out:
-	__crb_relinquish_locality(dev, priv, 0);
-
-	return rc;
+	return tpm_chip_register(chip);
 }
 
 static int crb_acpi_remove(struct acpi_device *device)
@@ -663,52 +657,11 @@ static int crb_acpi_remove(struct acpi_device *device)
 
 	tpm_chip_unregister(chip);
 
-	pm_runtime_disable(dev);
-
 	return 0;
 }
 
-static int __maybe_unused crb_pm_runtime_suspend(struct device *dev)
-{
-	struct tpm_chip *chip = dev_get_drvdata(dev);
-	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
-
-	return crb_go_idle(dev, priv);
-}
-
-static int __maybe_unused crb_pm_runtime_resume(struct device *dev)
-{
-	struct tpm_chip *chip = dev_get_drvdata(dev);
-	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
-
-	return crb_cmd_ready(dev, priv);
-}
-
-static int __maybe_unused crb_pm_suspend(struct device *dev)
-{
-	int ret;
-
-	ret = tpm_pm_suspend(dev);
-	if (ret)
-		return ret;
-
-	return crb_pm_runtime_suspend(dev);
-}
-
-static int __maybe_unused crb_pm_resume(struct device *dev)
-{
-	int ret;
-
-	ret = crb_pm_runtime_resume(dev);
-	if (ret)
-		return ret;
-
-	return tpm_pm_resume(dev);
-}
-
 static const struct dev_pm_ops crb_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(crb_pm_suspend, crb_pm_resume)
-	SET_RUNTIME_PM_OPS(crb_pm_runtime_suspend, crb_pm_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(tpm_pm_suspend, tpm_pm_resume)
 };
 
 static const struct acpi_device_id crb_device_ids[] = {
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 06639fb6ab85..8eb5e5ebe136 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -43,6 +43,8 @@ struct tpm_class_ops {
 	u8 (*status) (struct tpm_chip *chip);
 	bool (*update_timeouts)(struct tpm_chip *chip,
 				unsigned long *timeout_cap);
+	int (*go_idle)(struct tpm_chip *chip);
+	int (*cmd_ready)(struct tpm_chip *chip);
 	int (*request_locality)(struct tpm_chip *chip, int loc);
 	int (*relinquish_locality)(struct tpm_chip *chip, int loc);
 	void (*clk_enable)(struct tpm_chip *chip, bool value);
-- 
2.14.3
