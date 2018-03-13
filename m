Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3447179-1520955369-2-15746934086013049273
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520955368; b=mg3EcUWLXB0ECuyrsLm89RtBTWspSdG/Ovi0BTnmQBsETS9
    9nNS6QZlnZHv4vytPG1+KBMUw5RtasDEIuYUvlQlcl8znwzjFr7wYZMZD6nnmHkm
    cWbUwuDeo3pdKTTrbNBq4RS6SDGf3UoN9IPlKeHNO7iNMW0vODUQBV4Fn0L1IqNr
    N7BqZIq8ETKBwPLaRSfwYD+9jJOViOd2w4fylVFlRx9KpQXWtVuNY8dSmkGpc9bV
    zJ3vK8v7s03kodFcbGsYEjTN7HzgqixPyelwkKUUPaspf7oK6LeDZDwbqi+zpJWY
    WllisKmDRGytHV+/wRJ4wJMeJC2usr5/eCIlozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520955368; bh=lJWanP6gnG0qzE8TawkiSBNS4B
    p5zZwAgXISVsr9SMA=; b=vpylqAKS18+X19rXZDczuW3xrjl1Gbh2trugXypYpr
    XDeJTkdTmqEnakRnCIu95DtYril4LXuUz8kCzW0V6W8u1DwEuMVjXM3UGHjASnkf
    s+lFQ7C48wCsH6uikwNWi019QKqY24aWba8juvsQwGtSli8VZS3zd9dY1XWUMNZh
    Ttgr5D1FryOsMSVsmCU3ZlmyNfqbiD6XRqTyHLU7lI6AQwAxLKgm+WMBRk+qKir5
    lJkNimH4V7yy60YgYvJlwqKUsOqZ5HprUItIZUGg2g18GBTA2R0Q2vvClYukjNbZ
    r5fBQ/1Ish7lubTbAkthKsJ7IUTgDqT3GUoMZjkUBB/A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933484AbeCMPfy (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:35:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33286 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934094AbeCMPfu (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 11:35:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Azhar Shaikh <azhar.shaikh@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 4.14 020/140] tpm: Keep CLKRUN enabled throughout the duration of transmit_cmd()
Date: Tue, 13 Mar 2018 16:23:43 +0100
Message-Id: <20180313152459.429147192@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -132,79 +132,17 @@ static int check_acpi_tpm2(struct device
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
 
@@ -213,13 +151,12 @@ static int tpm_tcg_write_bytes(struct tp
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
 
@@ -227,12 +164,11 @@ static int tpm_tcg_read16(struct tpm_tis
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
 
@@ -240,12 +176,11 @@ static int tpm_tcg_read32(struct tpm_tis
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
 
@@ -253,12 +188,11 @@ static int tpm_tcg_write32(struct tpm_ti
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
 
@@ -340,9 +274,6 @@ static void tpm_tis_pnp_remove(struct pn
 
 	tpm_chip_unregister(chip);
 	tpm_tis_remove(chip);
-	if (is_bsw())
-		iounmap(priv->ilb_base_addr);
-
 }
 
 static struct pnp_driver tis_pnp_driver = {
@@ -394,9 +325,6 @@ static int tpm_tis_plat_remove(struct pl
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
