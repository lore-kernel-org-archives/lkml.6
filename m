Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsW8iFX7D5gJrFlPQ9AwASd2iA/5OlCqGLVLhyZXURXZermjma65UNzW9HO0DBoSi4XcExM
ARC-Seal: i=1; a=rsa-sha256; t=1520955191; cv=none;
        d=google.com; s=arc-20160816;
        b=RVT4KLUE8o9+cIglub8MlLzERRxYdqmruzCmUxO+f9jglORGOwpGfi/bDlhGujfdx3
         cixP4ZObJRF0JnhlhbD4DJTd1yAXKlEJlVQIcuKqhBys5NHh5mSVF8+WDhnZJvSkD+p8
         YNcdVKB37aRSM7us0YspVQ3hfXmYNUeeCis7vl4AufBl/j8y0Y1k5/1+SVu86XfgqgPA
         ZdZunRin/fQI20+RUVetXHU+uOSeBK2qVEuvsm2cwZkBrbe4rcQGN/XUJL0zX9DFTgeU
         51svtY/vBvyR4hD7jN9IB/Kwz9h65tCecmJclNEwdQaIhDdxnJodBIzzLT0gEQwamAsS
         scSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8FJJnCa+vdbH+217QP46xJVKurReDJwlOLzjKQyvuRo=;
        b=UO30Ivtn+j8IbQ/eego8/b9Lw7IIgdb+pINLMcrW9ojdJO6NCyqThgf/y2UJ41m4Vx
         2fACCWeDCOip70PsFrmj9uiTdbn69y/aeDvhrr4pZ76yNhjV5C1Ux0riO3aaejHU95ma
         skODjkgDj9bXvdGJYtf7HQgWbiXcixWCWb0ErJvBxLlKHVJEh2XPVc2GaF8NDlTGvDqq
         K8Gnd6zjNnLN92vrbdaYSQ33RbmH1RG7eOnU2gfJjLN7YJ7EY9LfbygN6H8uY4SF3f7l
         2JY30HnUiAG4ahcapOauf35zBe2353EaPXBR1U/2000hCaAHwPWR9gXFB7d0tvhrgwzN
         5sVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Azhar Shaikh <azhar.shaikh@intel.com>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 4.15 119/146] tpm: Keep CLKRUN enabled throughout the duration of transmit_cmd()
Date: Tue, 13 Mar 2018 16:24:46 +0100
Message-Id: <20180313152329.487403397@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837110415263613?=
X-GMAIL-MSGID: =?utf-8?q?1594837110415263613?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Azhar Shaikh <azhar.shaikh@intel.com>

commit b3e958ce4c585bf666de249dc794971ebc62d2d3 upstream.

Commit 5e572cab92f0bb5 ("tpm: Enable CLKRUN protocol for Braswell
systems") disabled CLKRUN protocol during TPM transactions and re-enabled
once the transaction is completed. But there were still some corner cases
observed where, reading of TPM header failed for savestate command
while going to suspend, which resulted in suspend failure.
To fix this issue keep the CLKRUN protocol disabled for the entire
duration of a single TPM command and not disabling and re-enabling
again for every TPM transaction. For the other TPM accesses outside
TPM command flow, add a higher level of disabling and re-enabling
the CLKRUN protocol, instead of doing for every TPM transaction.

Fixes: 5e572cab92f0bb5 ("tpm: Enable CLKRUN protocol for Braswell systems")
Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
Reviewed-by: Jarkko Sakkinen  <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen  <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen  <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm-interface.c |    6 ++
 drivers/char/tpm/tpm_tis.c       |   92 +++------------------------------
 drivers/char/tpm/tpm_tis_core.c  |  108 +++++++++++++++++++++++++++++++++++----
 drivers/char/tpm/tpm_tis_core.h  |    4 +
 include/linux/tpm.h              |    1 
 5 files changed, 119 insertions(+), 92 deletions(-)

--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -413,6 +413,9 @@ ssize_t tpm_transmit(struct tpm_chip *ch
 	if (chip->dev.parent)
 		pm_runtime_get_sync(chip->dev.parent);
 
+	if (chip->ops->clk_enable != NULL)
+		chip->ops->clk_enable(chip, true);
+
 	/* Store the decision as chip->locality will be changed. */
 	need_locality = chip->locality == -1;
 
@@ -489,6 +492,9 @@ out:
 		chip->locality = -1;
 	}
 out_no_locality:
+	if (chip->ops->clk_enable != NULL)
+		chip->ops->clk_enable(chip, false);
+
 	if (chip->dev.parent)
 		pm_runtime_put_sync(chip->dev.parent);
 
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -133,79 +133,17 @@ static int check_acpi_tpm2(struct device
 }
 #endif
 
-#ifdef CONFIG_X86
-#define LPC_CNTRL_OFFSET		0x84
-#define LPC_CLKRUN_EN			(1 << 2)
-
-/**
- * tpm_platform_begin_xfer() - clear LPC CLKRUN_EN i.e. clocks will be running
- */
-static void tpm_platform_begin_xfer(struct tpm_tis_data *data)
-{
-	u32 clkrun_val;
-
-	if (!is_bsw())
-		return;
-
-	clkrun_val = ioread32(data->ilb_base_addr + LPC_CNTRL_OFFSET);
-
-	/* Disable LPC CLKRUN# */
-	clkrun_val &= ~LPC_CLKRUN_EN;
-	iowrite32(clkrun_val, data->ilb_base_addr + LPC_CNTRL_OFFSET);
-
-	/*
-	 * Write any random value on port 0x80 which is on LPC, to make
-	 * sure LPC clock is running before sending any TPM command.
-	 */
-	outb(0xCC, 0x80);
-
-}
-
-/**
- * tpm_platform_end_xfer() - set LPC CLKRUN_EN i.e. clocks can be turned off
- */
-static void tpm_platform_end_xfer(struct tpm_tis_data *data)
-{
-	u32 clkrun_val;
-
-	if (!is_bsw())
-		return;
-
-	clkrun_val = ioread32(data->ilb_base_addr + LPC_CNTRL_OFFSET);
-
-	/* Enable LPC CLKRUN# */
-	clkrun_val |= LPC_CLKRUN_EN;
-	iowrite32(clkrun_val, data->ilb_base_addr + LPC_CNTRL_OFFSET);
-
-	/*
-	 * Write any random value on port 0x80 which is on LPC, to make
-	 * sure LPC clock is running before sending any TPM command.
-	 */
-	outb(0xCC, 0x80);
-
-}
-#else
-static void tpm_platform_begin_xfer(struct tpm_tis_data *data)
-{
-}
-
-static void tpm_platform_end_xfer(struct tpm_tis_data *data)
-{
-}
-#endif
-
 static int tpm_tcg_read_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
 			      u8 *result)
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	tpm_platform_begin_xfer(data);
+	if (is_bsw() && !(data->flags & TPM_TIS_CLK_ENABLE))
+		WARN(1, "CLKRUN not enabled!\n");
 
 	while (len--)
 		*result++ = ioread8(phy->iobase + addr);
 
-	tpm_platform_end_xfer(data);
-
 	return 0;
 }
 
@@ -214,13 +152,12 @@ static int tpm_tcg_write_bytes(struct tp
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	tpm_platform_begin_xfer(data);
+	if (is_bsw() && !(data->flags & TPM_TIS_CLK_ENABLE))
+		WARN(1, "CLKRUN not enabled!\n");
 
 	while (len--)
 		iowrite8(*value++, phy->iobase + addr);
 
-	tpm_platform_end_xfer(data);
-
 	return 0;
 }
 
@@ -228,12 +165,11 @@ static int tpm_tcg_read16(struct tpm_tis
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	tpm_platform_begin_xfer(data);
+	if (is_bsw() && !(data->flags & TPM_TIS_CLK_ENABLE))
+		WARN(1, "CLKRUN not enabled!\n");
 
 	*result = ioread16(phy->iobase + addr);
 
-	tpm_platform_end_xfer(data);
-
 	return 0;
 }
 
@@ -241,12 +177,11 @@ static int tpm_tcg_read32(struct tpm_tis
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	tpm_platform_begin_xfer(data);
+	if (is_bsw() && !(data->flags & TPM_TIS_CLK_ENABLE))
+		WARN(1, "CLKRUN not enabled!\n");
 
 	*result = ioread32(phy->iobase + addr);
 
-	tpm_platform_end_xfer(data);
-
 	return 0;
 }
 
@@ -254,12 +189,11 @@ static int tpm_tcg_write32(struct tpm_ti
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	tpm_platform_begin_xfer(data);
+	if (is_bsw() && !(data->flags & TPM_TIS_CLK_ENABLE))
+		WARN(1, "CLKRUN not enabled!\n");
 
 	iowrite32(value, phy->iobase + addr);
 
-	tpm_platform_end_xfer(data);
-
 	return 0;
 }
 
@@ -341,9 +275,6 @@ static void tpm_tis_pnp_remove(struct pn
 
 	tpm_chip_unregister(chip);
 	tpm_tis_remove(chip);
-	if (is_bsw())
-		iounmap(priv->ilb_base_addr);
-
 }
 
 static struct pnp_driver tis_pnp_driver = {
@@ -395,9 +326,6 @@ static int tpm_tis_plat_remove(struct pl
 	tpm_chip_unregister(chip);
 	tpm_tis_remove(chip);
 
-	if (is_bsw())
-		iounmap(priv->ilb_base_addr);
-
 	return 0;
 }
 
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -31,6 +31,8 @@
 #include "tpm.h"
 #include "tpm_tis_core.h"
 
+static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value);
+
 /* Before we attempt to access the TPM we must see that the valid bit is set.
  * The specification says that this bit is 0 at reset and remains 0 until the
  * 'TPM has gone through its self test and initialization and has established
@@ -422,19 +424,28 @@ static bool tpm_tis_update_timeouts(stru
 	int i, rc;
 	u32 did_vid;
 
+	if (chip->ops->clk_enable != NULL)
+		chip->ops->clk_enable(chip, true);
+
 	rc = tpm_tis_read32(priv, TPM_DID_VID(0), &did_vid);
 	if (rc < 0)
-		return rc;
+		goto out;
 
 	for (i = 0; i != ARRAY_SIZE(vendor_timeout_overrides); i++) {
 		if (vendor_timeout_overrides[i].did_vid != did_vid)
 			continue;
 		memcpy(timeout_cap, vendor_timeout_overrides[i].timeout_us,
 		       sizeof(vendor_timeout_overrides[i].timeout_us));
-		return true;
+		rc = true;
 	}
 
-	return false;
+	rc = false;
+
+out:
+	if (chip->ops->clk_enable != NULL)
+		chip->ops->clk_enable(chip, false);
+
+	return rc;
 }
 
 /*
@@ -654,14 +665,74 @@ void tpm_tis_remove(struct tpm_chip *chi
 	u32 interrupt;
 	int rc;
 
+	tpm_tis_clkrun_enable(chip, true);
+
 	rc = tpm_tis_read32(priv, reg, &interrupt);
 	if (rc < 0)
 		interrupt = 0;
 
 	tpm_tis_write32(priv, reg, ~TPM_GLOBAL_INT_ENABLE & interrupt);
+
+	tpm_tis_clkrun_enable(chip, false);
+
+	if (priv->ilb_base_addr)
+		iounmap(priv->ilb_base_addr);
 }
 EXPORT_SYMBOL_GPL(tpm_tis_remove);
 
+/**
+ * tpm_tis_clkrun_enable() - Keep clkrun protocol disabled for entire duration
+ *                           of a single TPM command
+ * @chip:	TPM chip to use
+ * @value:	1 - Disable CLKRUN protocol, so that clocks are free running
+ *		0 - Enable CLKRUN protocol
+ * Call this function directly in tpm_tis_remove() in error or driver removal
+ * path, since the chip->ops is set to NULL in tpm_chip_unregister().
+ */
+static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value)
+{
+	struct tpm_tis_data *data = dev_get_drvdata(&chip->dev);
+	u32 clkrun_val;
+
+	if (!IS_ENABLED(CONFIG_X86) || !is_bsw())
+		return;
+
+	if (value) {
+		data->flags |= TPM_TIS_CLK_ENABLE;
+		data->clkrun_enabled++;
+		if (data->clkrun_enabled > 1)
+			return;
+		clkrun_val = ioread32(data->ilb_base_addr + LPC_CNTRL_OFFSET);
+
+		/* Disable LPC CLKRUN# */
+		clkrun_val &= ~LPC_CLKRUN_EN;
+		iowrite32(clkrun_val, data->ilb_base_addr + LPC_CNTRL_OFFSET);
+
+		/*
+		 * Write any random value on port 0x80 which is on LPC, to make
+		 * sure LPC clock is running before sending any TPM command.
+		 */
+		outb(0xCC, 0x80);
+	} else {
+		data->clkrun_enabled--;
+		if (data->clkrun_enabled)
+			return;
+
+		clkrun_val = ioread32(data->ilb_base_addr + LPC_CNTRL_OFFSET);
+
+		/* Enable LPC CLKRUN# */
+		clkrun_val |= LPC_CLKRUN_EN;
+		iowrite32(clkrun_val, data->ilb_base_addr + LPC_CNTRL_OFFSET);
+
+		/*
+		 * Write any random value on port 0x80 which is on LPC, to make
+		 * sure LPC clock is running before sending any TPM command.
+		 */
+		outb(0xCC, 0x80);
+		data->flags &= ~TPM_TIS_CLK_ENABLE;
+	}
+}
+
 static const struct tpm_class_ops tpm_tis = {
 	.flags = TPM_OPS_AUTO_STARTUP,
 	.status = tpm_tis_status,
@@ -674,6 +745,7 @@ static const struct tpm_class_ops tpm_ti
 	.req_canceled = tpm_tis_req_canceled,
 	.request_locality = request_locality,
 	.relinquish_locality = release_locality,
+	.clk_enable = tpm_tis_clkrun_enable,
 };
 
 int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
@@ -708,6 +780,9 @@ int tpm_tis_core_init(struct device *dev
 			return -ENOMEM;
 	}
 
+	if (chip->ops->clk_enable != NULL)
+		chip->ops->clk_enable(chip, true);
+
 	if (wait_startup(chip, 0) != 0) {
 		rc = -ENODEV;
 		goto out_err;
@@ -799,14 +874,18 @@ int tpm_tis_core_init(struct device *dev
 	}
 
 	rc = tpm_chip_register(chip);
-	if (rc && is_bsw())
-		iounmap(priv->ilb_base_addr);
+	if (rc)
+		goto out_err;
 
-	return rc;
+	if (chip->ops->clk_enable != NULL)
+		chip->ops->clk_enable(chip, false);
+
+	return 0;
 out_err:
+	if ((chip->ops != NULL) && (chip->ops->clk_enable != NULL))
+		chip->ops->clk_enable(chip, false);
+
 	tpm_tis_remove(chip);
-	if (is_bsw())
-		iounmap(priv->ilb_base_addr);
 
 	return rc;
 }
@@ -819,22 +898,31 @@ static void tpm_tis_reenable_interrupts(
 	u32 intmask;
 	int rc;
 
+	if (chip->ops->clk_enable != NULL)
+		chip->ops->clk_enable(chip, true);
+
 	/* reenable interrupts that device may have lost or
 	 * BIOS/firmware may have disabled
 	 */
 	rc = tpm_tis_write8(priv, TPM_INT_VECTOR(priv->locality), priv->irq);
 	if (rc < 0)
-		return;
+		goto out;
 
 	rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
 	if (rc < 0)
-		return;
+		goto out;
 
 	intmask |= TPM_INTF_CMD_READY_INT
 	    | TPM_INTF_LOCALITY_CHANGE_INT | TPM_INTF_DATA_AVAIL_INT
 	    | TPM_INTF_STS_VALID_INT | TPM_GLOBAL_INT_ENABLE;
 
 	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
+
+out:
+	if (chip->ops->clk_enable != NULL)
+		chip->ops->clk_enable(chip, false);
+
+	return;
 }
 
 int tpm_tis_resume(struct device *dev)
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -79,11 +79,14 @@ enum tis_defaults {
 #define	TPM_DID_VID(l)			(0x0F00 | ((l) << 12))
 #define	TPM_RID(l)			(0x0F04 | ((l) << 12))
 
+#define LPC_CNTRL_OFFSET		0x84
+#define LPC_CLKRUN_EN			(1 << 2)
 #define INTEL_LEGACY_BLK_BASE_ADDR	0xFED08000
 #define ILB_REMAP_SIZE			0x100
 
 enum tpm_tis_flags {
 	TPM_TIS_ITPM_WORKAROUND		= BIT(0),
+	TPM_TIS_CLK_ENABLE		= BIT(1),
 };
 
 struct tpm_tis_data {
@@ -93,6 +96,7 @@ struct tpm_tis_data {
 	bool irq_tested;
 	unsigned int flags;
 	void __iomem *ilb_base_addr;
+	u16 clkrun_enabled;
 	wait_queue_head_t int_queue;
 	wait_queue_head_t read_queue;
 	const struct tpm_tis_phy_ops *phy_ops;
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -50,6 +50,7 @@ struct tpm_class_ops {
 				unsigned long *timeout_cap);
 	int (*request_locality)(struct tpm_chip *chip, int loc);
 	void (*relinquish_locality)(struct tpm_chip *chip, int loc);
+	void (*clk_enable)(struct tpm_chip *chip, bool value);
 };
 
 #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
