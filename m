Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510C7C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 20:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57F125311
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 20:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57F125311
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751895AbeFXUxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 16:53:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:35794 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751575AbeFXUxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 16:53:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2018 13:53:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,267,1526367600"; 
   d="scan'208";a="240219123"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.43])
  by fmsmga006.fm.intel.com with ESMTP; 24 Jun 2018 13:53:36 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>, stable@vger.kernel.org
Subject: [PATCH v7] tpm: separate cmd_ready/go_idle from runtime_pm
Date:   Sun, 24 Jun 2018 23:52:02 +0300
Message-Id: <20180624205202.6597-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix tpm ptt initialization error:
tpm tpm0: A TPM error (378) occurred get tpm pcr allocation.

We cannot use go_idle cmd_ready commands via runtime_pm handles
as with the introduction of localities this is no longer an optional
feature, while runtime pm can be not enabled.
Though cmd_ready/go_idle provides a power saving, it's also a part of
TPM2 protocol and should be called explicitly.
This patch exposes cmd_read/go_idle via tpm class ops and removes
runtime pm support as it is not used by any driver.

A new tpm transmit flag is added TPM_TRANSMIT_NESTED, which implies
TPM_TRANSMIT_UNLOCKED and TPM_TRANSMIT_RAW. Both are needed to resolve
tpm spaces and locality request recursive calls to tpm_transmit().

New wrappers are added tpm_cmd_ready() and tpm_go_idle() to
streamline tpm_try_transmit code.

tpm_crb no longer needs own power saving functions and can drop using
tpm_pm_suspend/resume.

This patch cannot be really separated from the locality fix.
Fixes: 888d867df441 (tpm: cmd_ready command can be issued only after granting locality)

Cc: stable@vger.kernel.org
Fixes: 888d867df441 (tpm: cmd_ready command can be issued only after granting locality)
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V2-3:resent
V4: 1. Use tpm_pm_suspend/resume in tpm_crb
    2. Drop cmd_ready/go_idle around tpm_chip_register, as there is no
       usage counter like in runtime_pm.
V5: 1. add tpm_cmd_ready and tpm_go_idle wrappers.
    2. Abuse TPM_TRANSMIT_UNLOCKED flag to resolve tpm space
       recursion.
V6: 1. Add new flags TPM_TRANSMIT_NESTED which implies
       TPM_TRANSMIT_UNLOCKED and TPM_TRANSMIT_RAW, as not all
       unlocked flows are recursive i.e. tpm2_unseal_trusted.
V7: 1. Add dmesg dump.

 drivers/char/tpm/tpm-interface.c  |  51 +++++++++++++++----
 drivers/char/tpm/tpm.h            |  13 ++++-
 drivers/char/tpm/tpm2-space.c     |  12 ++---
 drivers/char/tpm/tpm_crb.c        | 101 ++++++++++----------------------------
 drivers/char/tpm/tpm_vtpm_proxy.c |   2 +-
 include/linux/tpm.h               |   2 +
 6 files changed, 88 insertions(+), 93 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index e32f6e85dc6d..1abd8261651b 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -29,7 +29,6 @@
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/freezer.h>
-#include <linux/pm_runtime.h>
 #include <linux/tpm_eventlog.h>
 
 #include "tpm.h"
@@ -369,10 +368,13 @@ static int tpm_validate_command(struct tpm_chip *chip,
 	return -EINVAL;
 }
 
-static int tpm_request_locality(struct tpm_chip *chip)
+static int tpm_request_locality(struct tpm_chip *chip, unsigned int flags)
 {
 	int rc;
 
+	if (flags & __TPM_TRANSMIT_RAW)
+		return 0;
+
 	if (!chip->ops->request_locality)
 		return 0;
 
@@ -385,10 +387,13 @@ static int tpm_request_locality(struct tpm_chip *chip)
 	return 0;
 }
 
-static void tpm_relinquish_locality(struct tpm_chip *chip)
+static void tpm_relinquish_locality(struct tpm_chip *chip, unsigned int flags)
 {
 	int rc;
 
+	if (flags & __TPM_TRANSMIT_RAW)
+		return;
+
 	if (!chip->ops->relinquish_locality)
 		return;
 
@@ -399,6 +404,28 @@ static void tpm_relinquish_locality(struct tpm_chip *chip)
 	chip->locality = -1;
 }
 
+static int tpm_cmd_ready(struct tpm_chip *chip, unsigned int flags)
+{
+	if (flags & __TPM_TRANSMIT_RAW)
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
+	if (flags & __TPM_TRANSMIT_RAW)
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
@@ -449,14 +476,15 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 	/* Store the decision as chip->locality will be changed. */
 	need_locality = chip->locality == -1;
 
-	if (!(flags & TPM_TRANSMIT_RAW) && need_locality) {
-		rc = tpm_request_locality(chip);
+	if (need_locality) {
+		rc = tpm_request_locality(chip, flags);
 		if (rc < 0)
 			goto out_no_locality;
 	}
 
-	if (chip->dev.parent)
-		pm_runtime_get_sync(chip->dev.parent);
+	rc = tpm_cmd_ready(chip, flags);
+	if (rc)
+		goto out;
 
 	rc = tpm2_prepare_space(chip, space, ordinal, buf);
 	if (rc)
@@ -516,13 +544,16 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 	}
 
 	rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
+	if (rc)
+		dev_err(&chip->dev, "tpm2_commit_space: error %d\n", rc);
 
 out:
-	if (chip->dev.parent)
-		pm_runtime_put_sync(chip->dev.parent);
+	rc = tpm_go_idle(chip, flags);
+	if (rc)
+		goto out;
 
 	if (need_locality)
-		tpm_relinquish_locality(chip);
+		tpm_relinquish_locality(chip, flags);
 
 out_no_locality:
 	if (chip->ops->clk_enable != NULL)
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 9824cccb2c76..a711901a9cf5 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -512,9 +512,18 @@ extern const struct file_operations tpm_fops;
 extern const struct file_operations tpmrm_fops;
 extern struct idr dev_nums_idr;
 
+/**
+ * enum tpm_transmit_flags
+ *
+ * @TPM_TRANSMIT_UNLOCKED: used to lock sequence of tpm_transmit calls.
+ * @__TPM_TRANSMIT_RAW: prevent recursive calls into setup steps
+ *                    (go idle, locality,..). Don't use directly.
+ * @TPM_TRANSMIT_NESTED: Use from nested tpm_transmit calls
+ */
 enum tpm_transmit_flags {
-	TPM_TRANSMIT_UNLOCKED	= BIT(0),
-	TPM_TRANSMIT_RAW	= BIT(1),
+	TPM_TRANSMIT_UNLOCKED   = BIT(0),
+	__TPM_TRANSMIT_RAW      = BIT(1),
+	TPM_TRANSMIT_NESTED     = TPM_TRANSMIT_UNLOCKED | __TPM_TRANSMIT_RAW,
 };
 
 ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 6122d3276f72..d2e101b32482 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -39,7 +39,7 @@ static void tpm2_flush_sessions(struct tpm_chip *chip, struct tpm_space *space)
 	for (i = 0; i < ARRAY_SIZE(space->session_tbl); i++) {
 		if (space->session_tbl[i])
 			tpm2_flush_context_cmd(chip, space->session_tbl[i],
-					       TPM_TRANSMIT_UNLOCKED);
+					       TPM_TRANSMIT_NESTED);
 	}
 }
 
@@ -84,7 +84,7 @@ static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
 	tpm_buf_append(&tbuf, &buf[*offset], body_size);
 
 	rc = tpm_transmit_cmd(chip, NULL, tbuf.data, PAGE_SIZE, 4,
-			      TPM_TRANSMIT_UNLOCKED, NULL);
+			      TPM_TRANSMIT_NESTED, NULL);
 	if (rc < 0) {
 		dev_warn(&chip->dev, "%s: failed with a system error %d\n",
 			 __func__, rc);
@@ -133,7 +133,7 @@ static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
 	tpm_buf_append_u32(&tbuf, handle);
 
 	rc = tpm_transmit_cmd(chip, NULL, tbuf.data, PAGE_SIZE, 0,
-			      TPM_TRANSMIT_UNLOCKED, NULL);
+			      TPM_TRANSMIT_NESTED, NULL);
 	if (rc < 0) {
 		dev_warn(&chip->dev, "%s: failed with a system error %d\n",
 			 __func__, rc);
@@ -170,7 +170,7 @@ static void tpm2_flush_space(struct tpm_chip *chip)
 	for (i = 0; i < ARRAY_SIZE(space->context_tbl); i++)
 		if (space->context_tbl[i] && ~space->context_tbl[i])
 			tpm2_flush_context_cmd(chip, space->context_tbl[i],
-					       TPM_TRANSMIT_UNLOCKED);
+					       TPM_TRANSMIT_NESTED);
 
 	tpm2_flush_sessions(chip, space);
 }
@@ -377,7 +377,7 @@ static int tpm2_map_response_header(struct tpm_chip *chip, u32 cc, u8 *rsp,
 
 	return 0;
 out_no_slots:
-	tpm2_flush_context_cmd(chip, phandle, TPM_TRANSMIT_UNLOCKED);
+	tpm2_flush_context_cmd(chip, phandle, TPM_TRANSMIT_NESTED);
 	dev_warn(&chip->dev, "%s: out of slots for 0x%08X\n", __func__,
 		 phandle);
 	return -ENOMEM;
@@ -465,7 +465,7 @@ static int tpm2_save_space(struct tpm_chip *chip)
 			return rc;
 
 		tpm2_flush_context_cmd(chip, space->context_tbl[i],
-				       TPM_TRANSMIT_UNLOCKED);
+				       TPM_TRANSMIT_NESTED);
 		space->context_tbl[i] = ~0;
 	}
 
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
diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index e4f79f920450..87a0ce47f201 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -418,7 +418,7 @@ static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
 	proxy_dev->state |= STATE_DRIVER_COMMAND;
 
 	rc = tpm_transmit_cmd(chip, NULL, buf.data, tpm_buf_length(&buf), 0,
-			      TPM_TRANSMIT_UNLOCKED | TPM_TRANSMIT_RAW,
+			      TPM_TRANSMIT_NESTED,
 			      "attempting to set locality");
 
 	proxy_dev->state &= ~STATE_DRIVER_COMMAND;
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
2.14.4

