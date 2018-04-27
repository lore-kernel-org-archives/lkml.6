Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqj3hTjV5X+Ny+p7r9+5L0k9iXJqHjGF3LmmiH8inl7yMgm/y6lH3cxWyxRfuqGKEAssYnD
ARC-Seal: i=1; a=rsa-sha256; t=1524838033; cv=none;
        d=google.com; s=arc-20160816;
        b=tSZx/TdUlMM7Cwx8ObHif99MeYRYYq7Io+JZknz58HG9uAzWPNlu2+UQ5+Q8EVGRon
         Za8hRAoYJwbpSscjeKiNh55OG1Xaef0SGsc3qy9YgaPnxBwPpF4fcvdhpq9C31rwjLwT
         HjfveWLNfQgDZi0U5XqgEKcDImIcXfFWWQvq9tu4PQPMrEoSoK7EGreIp2B55KngLQeC
         mD2gyMSZkNVjTWxCyFbLuyapGZKFsUfoW08yLU8twsX+gwnzty9ljm1T/rl3Mm2JxeU9
         nmAsyzfuZDtWekpo48d0RG9upMB47AUes2PM3d8TQLl0ojHJC1xod6x8Q6EwlQkky3Hj
         4Wxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=ePhnXzvFzefE97HVwckxzdYWg6udcgbf7WoL+lKdqbw=;
        b=u6MsMgSDuqAguN+t9Z2B3Vb893SYuLBWakmEiphy4glpDwlvCKdOASTPIJweGr94FD
         yTwZIl+nLRSS4VKLoTVB6myHGcn0lho+cZWk+S8e0WgDhrJrh53og/T6eU6aCDekYcZb
         SOBywtjaBzp+or+D5LxmPIn3r0Krgq6kAyDHrZRDQ4QHCrYzGvEDSs11nJG3lupdk9OL
         rH4XRZIumIZougOrec3WCH2zRHDBIkmKcF2V61yLRvsDiQ0L4YSy+AmO4puQJkXkYvIK
         2fXAJWfYy6zVTU5cc/nt6C8KnJK1Mu3Asld59iyCx2Js5lBrg7iDJqy+6pH+eL6RG1s7
         q9Tg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82AAE21864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>,
	Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>
Subject: [PATCH 4.14 04/80] tpm: cmd_ready command can be issued only after granting locality
Date: Fri, 27 Apr 2018 15:57:57 +0200
Message-Id: <20180427135733.145580503@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908566239145064?=
X-GMAIL-MSGID: =?utf-8?q?1598908566239145064?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomas Winkler <tomas.winkler@intel.com>

commit 888d867df4417deffc33927e6fc2c6925736fe92 upstream.

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
Reviewed-by: Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm-interface.c |   54 ++++++++++++++-----
 drivers/char/tpm/tpm_crb.c       |  108 +++++++++++++++++++++++++++------------
 drivers/char/tpm/tpm_tis_core.c  |    4 +
 include/linux/tpm.h              |    2 
 4 files changed, 120 insertions(+), 48 deletions(-)

--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -369,6 +369,36 @@ err_len:
 	return -EINVAL;
 }
 
+static int tpm_request_locality(struct tpm_chip *chip)
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
+static void tpm_relinquish_locality(struct tpm_chip *chip)
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
@@ -422,8 +452,6 @@ ssize_t tpm_transmit(struct tpm_chip *ch
 	if (!(flags & TPM_TRANSMIT_UNLOCKED))
 		mutex_lock(&chip->tpm_mutex);
 
-	if (chip->dev.parent)
-		pm_runtime_get_sync(chip->dev.parent);
 
 	if (chip->ops->clk_enable != NULL)
 		chip->ops->clk_enable(chip, true);
@@ -431,14 +459,15 @@ ssize_t tpm_transmit(struct tpm_chip *ch
 	/* Store the decision as chip->locality will be changed. */
 	need_locality = chip->locality == -1;
 
-	if (!(flags & TPM_TRANSMIT_RAW) &&
-	    need_locality && chip->ops->request_locality)  {
-		rc = chip->ops->request_locality(chip, 0);
+	if (!(flags & TPM_TRANSMIT_RAW) && need_locality) {
+		rc = tpm_request_locality(chip);
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
@@ -499,17 +528,16 @@ out_recv:
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
+		tpm_relinquish_locality(chip);
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
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -117,6 +117,25 @@ struct tpm2_crb_smc {
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
@@ -132,37 +151,24 @@ struct tpm2_crb_smc {
  *
  * Return: 0 always
  */
-static int __maybe_unused crb_go_idle(struct device *dev, struct crb_priv *priv)
+static int crb_go_idle(struct device *dev, struct crb_priv *priv)
 {
 	if ((priv->flags & CRB_FL_ACPI_START) ||
 	    (priv->flags & CRB_FL_CRB_SMC_START))
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
@@ -177,8 +183,7 @@ static bool crb_wait_for_reg_32(u32 __io
  *
  * Return: 0 on success -ETIME on timeout;
  */
-static int __maybe_unused crb_cmd_ready(struct device *dev,
-					struct crb_priv *priv)
+static int crb_cmd_ready(struct device *dev, struct crb_priv *priv)
 {
 	if ((priv->flags & CRB_FL_ACPI_START) ||
 	    (priv->flags & CRB_FL_CRB_SMC_START))
@@ -196,11 +201,11 @@ static int __maybe_unused crb_cmd_ready(
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
@@ -208,21 +213,45 @@ static int crb_request_locality(struct t
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
@@ -466,6 +495,10 @@ static int crb_map_io(struct acpi_device
 			dev_warn(dev, FW_BUG "Bad ACPI memory layout");
 	}
 
+	ret = __crb_request_locality(dev, priv, 0);
+	if (ret)
+		return ret;
+
 	priv->regs_t = crb_map_res(dev, priv, &io_res, buf->control_address,
 				   sizeof(struct crb_regs_tail));
 	if (IS_ERR(priv->regs_t))
@@ -522,6 +555,8 @@ out:
 
 	crb_go_idle(dev, priv);
 
+	__crb_relinquish_locality(dev, priv, 0);
+
 	return ret;
 }
 
@@ -589,10 +624,14 @@ static int crb_acpi_add(struct acpi_devi
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
@@ -602,12 +641,15 @@ static int crb_acpi_add(struct acpi_devi
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
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -77,11 +77,13 @@ static bool check_locality(struct tpm_ch
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
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -49,7 +49,7 @@ struct tpm_class_ops {
 	bool (*update_timeouts)(struct tpm_chip *chip,
 				unsigned long *timeout_cap);
 	int (*request_locality)(struct tpm_chip *chip, int loc);
-	void (*relinquish_locality)(struct tpm_chip *chip, int loc);
+	int (*relinquish_locality)(struct tpm_chip *chip, int loc);
 	void (*clk_enable)(struct tpm_chip *chip, bool value);
 };
 
