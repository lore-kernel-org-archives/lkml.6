Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161906AbeCAVLm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:11:42 -0500
Received: from mga02.intel.com ([134.134.136.20]:60984 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161764AbeCAVLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:11:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="33967884"
From: Tomas Winkler <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 1/2 v6] tpm: cmd_ready command can be issued only after granting locality
Date: Thu,  1 Mar 2018 23:08:13 +0200
Message-Id: <20180301210813.21349-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct sequence is to first request locality and only after
that perform cmd_ready handshake, otherwise the hardware will drop
the subsequent message as from the device point of view the cmd_ready
handshake wasn't performed. Symmetrically locality has to be relinquished
only after going idle handshake has completed, this requires that
go_idle has to poll for the completion and as well locality
relinquish has to poll for completion so it is not overridden
in back to back commands flow.

Two wrapper functions are added (request_locality relinquish_locality)
to simplify the error handling.

The issue is only visible on devices that support multiple localities.

Fixes: 877c57d0d0ca ("tpm_crb: request and relinquish locality 0")
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V2: 1. Poll for locality relinquish completion.
V3: 1. Print error message upon locality relinquish failure
    2. Don't override rc code on error path with locality relinquish
       return value.
V4: 1. Don't capture locality relinquish error code in rc, just print
       the error message.
V5: 1. Fix a coding style issue.
    2. Add Fixes: reference.
V6: 1. Add locality wrappers.

 drivers/char/tpm/tpm-interface.c |  54 +++++++++++++++-----
 drivers/char/tpm/tpm_crb.c       | 108 +++++++++++++++++++++++++++------------
 drivers/char/tpm/tpm_tis_core.c  |   4 +-
 include/linux/tpm.h              |   2 +-
 4 files changed, 120 insertions(+), 48 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 9e80a953d693..b57bf449abfc 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -369,6 +369,36 @@ static int tpm_validate_command(struct tpm_chip *chip,
 	return -EINVAL;
 }
 
+static int request_locality(struct tpm_chip *chip)
+{
+	int rc;
+
+	if (!chip->ops->request_locality)
+		return 0;
+
+	rc = chip->ops->request_locality(chip, 0);
+	if (rc < 0)
+		return rc;
+
+	chip->locality = rc;
+
+	return 0;
+}
+
+static void relinquish_locality(struct tpm_chip *chip)
+{
+	int rc;
+
+	if (!chip->ops->relinquish_locality)
+		return;
+
+	rc = chip->ops->relinquish_locality(chip, chip->locality);
+	if (rc)
+		dev_err(&chip->dev, "%s: : error %d\n", __func__, rc);
+
+	chip->locality = -1;
+}
+
 /**
  * tmp_transmit - Internal kernel interface to transmit TPM commands.
  *
@@ -422,8 +452,6 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	if (!(flags & TPM_TRANSMIT_UNLOCKED))
 		mutex_lock(&chip->tpm_mutex);
 
-	if (chip->dev.parent)
-		pm_runtime_get_sync(chip->dev.parent);
 
 	if (chip->ops->clk_enable != NULL)
 		chip->ops->clk_enable(chip, true);
@@ -431,14 +459,15 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	/* Store the decision as chip->locality will be changed. */
 	need_locality = chip->locality == -1;
 
-	if (!(flags & TPM_TRANSMIT_RAW) &&
-	    need_locality && chip->ops->request_locality)  {
-		rc = chip->ops->request_locality(chip, 0);
+	if (!(flags & TPM_TRANSMIT_RAW) && need_locality) {
+		rc = request_locality(chip);
 		if (rc < 0)
 			goto out_no_locality;
-		chip->locality = rc;
 	}
 
+	if (chip->dev.parent)
+		pm_runtime_get_sync(chip->dev.parent);
+
 	rc = tpm2_prepare_space(chip, space, ordinal, buf);
 	if (rc)
 		goto out;
@@ -499,17 +528,16 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
 
 out:
-	if (need_locality && chip->ops->relinquish_locality) {
-		chip->ops->relinquish_locality(chip, chip->locality);
-		chip->locality = -1;
-	}
+	if (chip->dev.parent)
+		pm_runtime_put_sync(chip->dev.parent);
+
+	if (need_locality)
+		relinquish_locality(chip);
+
 out_no_locality:
 	if (chip->ops->clk_enable != NULL)
 		chip->ops->clk_enable(chip, false);
 
-	if (chip->dev.parent)
-		pm_runtime_put_sync(chip->dev.parent);
-
 	if (!(flags & TPM_TRANSMIT_UNLOCKED))
 		mutex_unlock(&chip->tpm_mutex);
 	return rc ? rc : len;
diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 7b3c2a8aa9de..497edd9848cd 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -112,6 +112,25 @@ struct tpm2_crb_smc {
 	u32 smc_func_id;
 };
 
+static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
+				unsigned long timeout)
+{
+	ktime_t start;
+	ktime_t stop;
+
+	start = ktime_get();
+	stop = ktime_add(start, ms_to_ktime(timeout));
+
+	do {
+		if ((ioread32(reg) & mask) == value)
+			return true;
+
+		usleep_range(50, 100);
+	} while (ktime_before(ktime_get(), stop));
+
+	return ((ioread32(reg) & mask) == value);
+}
+
 /**
  * crb_go_idle - request tpm crb device to go the idle state
  *
@@ -128,7 +147,7 @@ struct tpm2_crb_smc {
  *
  * Return: 0 always
  */
-static int __maybe_unused crb_go_idle(struct device *dev, struct crb_priv *priv)
+static int crb_go_idle(struct device *dev, struct crb_priv *priv)
 {
 	if ((priv->sm == ACPI_TPM2_START_METHOD) ||
 	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) ||
@@ -136,30 +155,17 @@ static int __maybe_unused crb_go_idle(struct device *dev, struct crb_priv *priv)
 		return 0;
 
 	iowrite32(CRB_CTRL_REQ_GO_IDLE, &priv->regs_t->ctrl_req);
-	/* we don't really care when this settles */
 
+	if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_req,
+				 CRB_CTRL_REQ_GO_IDLE/* mask */,
+				 0, /* value */
+				 TPM2_TIMEOUT_C)) {
+		dev_warn(dev, "goIdle timed out\n");
+		return -ETIME;
+	}
 	return 0;
 }
 
-static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
-				unsigned long timeout)
-{
-	ktime_t start;
-	ktime_t stop;
-
-	start = ktime_get();
-	stop = ktime_add(start, ms_to_ktime(timeout));
-
-	do {
-		if ((ioread32(reg) & mask) == value)
-			return true;
-
-		usleep_range(50, 100);
-	} while (ktime_before(ktime_get(), stop));
-
-	return false;
-}
-
 /**
  * crb_cmd_ready - request tpm crb device to enter ready state
  *
@@ -175,8 +181,7 @@ static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
  *
  * Return: 0 on success -ETIME on timeout;
  */
-static int __maybe_unused crb_cmd_ready(struct device *dev,
-					struct crb_priv *priv)
+static int crb_cmd_ready(struct device *dev, struct crb_priv *priv)
 {
 	if ((priv->sm == ACPI_TPM2_START_METHOD) ||
 	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) ||
@@ -195,11 +200,11 @@ static int __maybe_unused crb_cmd_ready(struct device *dev,
 	return 0;
 }
 
-static int crb_request_locality(struct tpm_chip *chip, int loc)
+static int __crb_request_locality(struct device *dev,
+				  struct crb_priv *priv, int loc)
 {
-	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
 	u32 value = CRB_LOC_STATE_LOC_ASSIGNED |
-		CRB_LOC_STATE_TPM_REG_VALID_STS;
+		    CRB_LOC_STATE_TPM_REG_VALID_STS;
 
 	if (!priv->regs_h)
 		return 0;
@@ -207,21 +212,45 @@ static int crb_request_locality(struct tpm_chip *chip, int loc)
 	iowrite32(CRB_LOC_CTRL_REQUEST_ACCESS, &priv->regs_h->loc_ctrl);
 	if (!crb_wait_for_reg_32(&priv->regs_h->loc_state, value, value,
 				 TPM2_TIMEOUT_C)) {
-		dev_warn(&chip->dev, "TPM_LOC_STATE_x.requestAccess timed out\n");
+		dev_warn(dev, "TPM_LOC_STATE_x.requestAccess timed out\n");
 		return -ETIME;
 	}
 
 	return 0;
 }
 
-static void crb_relinquish_locality(struct tpm_chip *chip, int loc)
+static int crb_request_locality(struct tpm_chip *chip, int loc)
 {
 	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
 
+	return __crb_request_locality(&chip->dev, priv, loc);
+}
+
+static int __crb_relinquish_locality(struct device *dev,
+				     struct crb_priv *priv, int loc)
+{
+	u32 mask = CRB_LOC_STATE_LOC_ASSIGNED |
+		   CRB_LOC_STATE_TPM_REG_VALID_STS;
+	u32 value = CRB_LOC_STATE_TPM_REG_VALID_STS;
+
 	if (!priv->regs_h)
-		return;
+		return 0;
 
 	iowrite32(CRB_LOC_CTRL_RELINQUISH, &priv->regs_h->loc_ctrl);
+	if (!crb_wait_for_reg_32(&priv->regs_h->loc_state, mask, value,
+				 TPM2_TIMEOUT_C)) {
+		dev_warn(dev, "TPM_LOC_STATE_x.requestAccess timed out\n");
+		return -ETIME;
+	}
+
+	return 0;
+}
+
+static int crb_relinquish_locality(struct tpm_chip *chip, int loc)
+{
+	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
+
+	return __crb_relinquish_locality(&chip->dev, priv, loc);
 }
 
 static u8 crb_status(struct tpm_chip *chip)
@@ -475,6 +504,10 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 			dev_warn(dev, FW_BUG "Bad ACPI memory layout");
 	}
 
+	ret = __crb_request_locality(dev, priv, 0);
+	if (ret)
+		return ret;
+
 	priv->regs_t = crb_map_res(dev, priv, &io_res, buf->control_address,
 				   sizeof(struct crb_regs_tail));
 	if (IS_ERR(priv->regs_t))
@@ -531,6 +564,8 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 
 	crb_go_idle(dev, priv);
 
+	__crb_relinquish_locality(dev, priv, 0);
+
 	return ret;
 }
 
@@ -588,10 +623,14 @@ static int crb_acpi_add(struct acpi_device *device)
 	chip->acpi_dev_handle = device->handle;
 	chip->flags = TPM_CHIP_FLAG_TPM2;
 
-	rc  = crb_cmd_ready(dev, priv);
+	rc = __crb_request_locality(dev, priv, 0);
 	if (rc)
 		return rc;
 
+	rc  = crb_cmd_ready(dev, priv);
+	if (rc)
+		goto out;
+
 	pm_runtime_get_noresume(dev);
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
@@ -601,12 +640,15 @@ static int crb_acpi_add(struct acpi_device *device)
 		crb_go_idle(dev, priv);
 		pm_runtime_put_noidle(dev);
 		pm_runtime_disable(dev);
-		return rc;
+		goto out;
 	}
 
-	pm_runtime_put(dev);
+	pm_runtime_put_sync(dev);
 
-	return 0;
+out:
+	__crb_relinquish_locality(dev, priv, 0);
+
+	return rc;
 }
 
 static int crb_acpi_remove(struct acpi_device *device)
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 183a5f54d875..a22b12adbdfd 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -143,11 +143,13 @@ static bool check_locality(struct tpm_chip *chip, int l)
 	return false;
 }
 
-static void release_locality(struct tpm_chip *chip, int l)
+static int release_locality(struct tpm_chip *chip, int l)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 
 	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
+
+	return 0;
 }
 
 static int request_locality(struct tpm_chip *chip, int l)
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index bcdd3790e94d..06639fb6ab85 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -44,7 +44,7 @@ struct tpm_class_ops {
 	bool (*update_timeouts)(struct tpm_chip *chip,
 				unsigned long *timeout_cap);
 	int (*request_locality)(struct tpm_chip *chip, int loc);
-	void (*relinquish_locality)(struct tpm_chip *chip, int loc);
+	int (*relinquish_locality)(struct tpm_chip *chip, int loc);
 	void (*clk_enable)(struct tpm_chip *chip, bool value);
 };
 
-- 
2.14.3
