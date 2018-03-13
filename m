Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsDepS8/WhL2J//1Khn0fHgD6TNOcernihPDG3oK95fcsy7pN3LZG4VXOSmxrKl7BwE6QsP
ARC-Seal: i=1; a=rsa-sha256; t=1520955187; cv=none;
        d=google.com; s=arc-20160816;
        b=WplMlDxC7o+DU1QL9ujvuACnEvKnPZeTNhzsOUcctLD7tUDtX/+CdZaTxebMFbHyLk
         ir8Qjxp7nBJVM5T8cCK5MC9+kVi2JXao6sYmAg0ID+pX5LTGv+2DHpdqZj304pcyM4CM
         fZqbYIcKAZrb5VZaJKbKnWJadloAyzeZAymnR0GaiX7cMTIK2Is7LvLdB49hAma0KPVo
         B2J3W6ISiZMF2irkW56Pz6amnIVszNlHToB+h/L1/Y+B2YyYbaXcvn+Z8QQR1e2uyddf
         QoXbk3WbvLvvRaBcddV6+5B/j5tcMgblrvoWU6aK2IwUtYMTNARIZhjAma5zJkJlxSbH
         6jWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ub4NCw3ok3NLSRwdVl6tbx7GaitVkMpB6D4DF78yIpA=;
        b=a2gRpMLY43/JnAip5pH/QxeWyPnQ71PZTriPF40vWACzYMPDwUEHCKJO42RLifb/SS
         WZVpto4CuRnTkRBVsej8gBEqltUagquGJe3nK6ifz9cNXkZ7S5jxmZmkPIv7bgk0jcE9
         LkP922shjSAk2+lC+1JFUmYHwSSWsO2Kefy3J8nuDXIqiSlvSzAfr1C1nsIqQDKX7KMH
         Iw/CIujbb+QwqZrY2QpNRClhbqC/ssTK8FtNlfyHPbl3y3kpm0g963gTD5mUnraIGNFr
         z1dFSyPZYD3jwdpWUC+XXIY+88ssXWHVTaXUuUIyASd+ihDgG0S2dhb5T6+KnDzAcS55
         AVnw==
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
Subject: [PATCH 4.15 118/146] tpm_tis: Move ilb_base_addr to tpm_tis_data
Date: Tue, 13 Mar 2018 16:24:45 +0100
Message-Id: <20180313152329.437505787@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837106638182523?=
X-GMAIL-MSGID: =?utf-8?q?1594837106638182523?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Azhar Shaikh <azhar.shaikh@intel.com>

commit c382babccba2c82fe57f9e647f290fb7bf4d130d upstream.

Move static variable ilb_base_addr to tpm_tis_data.

Cc: stable@vger.kernel.org
Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
Reviewed-by: Jarkko Sakkinen  <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen  <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen  <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm_tis.c      |   75 ++++++++++++++--------------------------
 drivers/char/tpm/tpm_tis_core.c |   16 ++++++++
 drivers/char/tpm/tpm_tis_core.h |   13 ++++++
 3 files changed, 56 insertions(+), 48 deletions(-)

--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -134,33 +134,24 @@ static int check_acpi_tpm2(struct device
 #endif
 
 #ifdef CONFIG_X86
-#define INTEL_LEGACY_BLK_BASE_ADDR      0xFED08000
-#define ILB_REMAP_SIZE			0x100
-#define LPC_CNTRL_REG_OFFSET            0x84
-#define LPC_CLKRUN_EN                   (1 << 2)
-
-static void __iomem *ilb_base_addr;
-
-static inline bool is_bsw(void)
-{
-	return ((boot_cpu_data.x86_model == INTEL_FAM6_ATOM_AIRMONT) ? 1 : 0);
-}
+#define LPC_CNTRL_OFFSET		0x84
+#define LPC_CLKRUN_EN			(1 << 2)
 
 /**
  * tpm_platform_begin_xfer() - clear LPC CLKRUN_EN i.e. clocks will be running
  */
-static void tpm_platform_begin_xfer(void)
+static void tpm_platform_begin_xfer(struct tpm_tis_data *data)
 {
 	u32 clkrun_val;
 
 	if (!is_bsw())
 		return;
 
-	clkrun_val = ioread32(ilb_base_addr + LPC_CNTRL_REG_OFFSET);
+	clkrun_val = ioread32(data->ilb_base_addr + LPC_CNTRL_OFFSET);
 
 	/* Disable LPC CLKRUN# */
 	clkrun_val &= ~LPC_CLKRUN_EN;
-	iowrite32(clkrun_val, ilb_base_addr + LPC_CNTRL_REG_OFFSET);
+	iowrite32(clkrun_val, data->ilb_base_addr + LPC_CNTRL_OFFSET);
 
 	/*
 	 * Write any random value on port 0x80 which is on LPC, to make
@@ -173,18 +164,18 @@ static void tpm_platform_begin_xfer(void
 /**
  * tpm_platform_end_xfer() - set LPC CLKRUN_EN i.e. clocks can be turned off
  */
-static void tpm_platform_end_xfer(void)
+static void tpm_platform_end_xfer(struct tpm_tis_data *data)
 {
 	u32 clkrun_val;
 
 	if (!is_bsw())
 		return;
 
-	clkrun_val = ioread32(ilb_base_addr + LPC_CNTRL_REG_OFFSET);
+	clkrun_val = ioread32(data->ilb_base_addr + LPC_CNTRL_OFFSET);
 
 	/* Enable LPC CLKRUN# */
 	clkrun_val |= LPC_CLKRUN_EN;
-	iowrite32(clkrun_val, ilb_base_addr + LPC_CNTRL_REG_OFFSET);
+	iowrite32(clkrun_val, data->ilb_base_addr + LPC_CNTRL_OFFSET);
 
 	/*
 	 * Write any random value on port 0x80 which is on LPC, to make
@@ -194,16 +185,11 @@ static void tpm_platform_end_xfer(void)
 
 }
 #else
-static inline bool is_bsw(void)
-{
-	return false;
-}
-
-static void tpm_platform_begin_xfer(void)
+static void tpm_platform_begin_xfer(struct tpm_tis_data *data)
 {
 }
 
-static void tpm_platform_end_xfer(void)
+static void tpm_platform_end_xfer(struct tpm_tis_data *data)
 {
 }
 #endif
@@ -213,12 +199,12 @@ static int tpm_tcg_read_bytes(struct tpm
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	tpm_platform_begin_xfer();
+	tpm_platform_begin_xfer(data);
 
 	while (len--)
 		*result++ = ioread8(phy->iobase + addr);
 
-	tpm_platform_end_xfer();
+	tpm_platform_end_xfer(data);
 
 	return 0;
 }
@@ -228,12 +214,12 @@ static int tpm_tcg_write_bytes(struct tp
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	tpm_platform_begin_xfer();
+	tpm_platform_begin_xfer(data);
 
 	while (len--)
 		iowrite8(*value++, phy->iobase + addr);
 
-	tpm_platform_end_xfer();
+	tpm_platform_end_xfer(data);
 
 	return 0;
 }
@@ -242,11 +228,11 @@ static int tpm_tcg_read16(struct tpm_tis
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	tpm_platform_begin_xfer();
+	tpm_platform_begin_xfer(data);
 
 	*result = ioread16(phy->iobase + addr);
 
-	tpm_platform_end_xfer();
+	tpm_platform_end_xfer(data);
 
 	return 0;
 }
@@ -255,11 +241,11 @@ static int tpm_tcg_read32(struct tpm_tis
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	tpm_platform_begin_xfer();
+	tpm_platform_begin_xfer(data);
 
 	*result = ioread32(phy->iobase + addr);
 
-	tpm_platform_end_xfer();
+	tpm_platform_end_xfer(data);
 
 	return 0;
 }
@@ -268,11 +254,11 @@ static int tpm_tcg_write32(struct tpm_ti
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	tpm_platform_begin_xfer();
+	tpm_platform_begin_xfer(data);
 
 	iowrite32(value, phy->iobase + addr);
 
-	tpm_platform_end_xfer();
+	tpm_platform_end_xfer(data);
 
 	return 0;
 }
@@ -351,9 +337,13 @@ MODULE_DEVICE_TABLE(pnp, tpm_pnp_tbl);
 static void tpm_tis_pnp_remove(struct pnp_dev *dev)
 {
 	struct tpm_chip *chip = pnp_get_drvdata(dev);
+	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 
 	tpm_chip_unregister(chip);
 	tpm_tis_remove(chip);
+	if (is_bsw())
+		iounmap(priv->ilb_base_addr);
+
 }
 
 static struct pnp_driver tis_pnp_driver = {
@@ -400,10 +390,14 @@ static int tpm_tis_plat_probe(struct pla
 static int tpm_tis_plat_remove(struct platform_device *pdev)
 {
 	struct tpm_chip *chip = dev_get_drvdata(&pdev->dev);
+	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 
 	tpm_chip_unregister(chip);
 	tpm_tis_remove(chip);
 
+	if (is_bsw())
+		iounmap(priv->ilb_base_addr);
+
 	return 0;
 }
 
@@ -461,11 +455,6 @@ static int __init init_tis(void)
 	if (rc)
 		goto err_force;
 
-#ifdef CONFIG_X86
-	if (is_bsw())
-		ilb_base_addr = ioremap(INTEL_LEGACY_BLK_BASE_ADDR,
-					ILB_REMAP_SIZE);
-#endif
 	rc = platform_driver_register(&tis_drv);
 	if (rc)
 		goto err_platform;
@@ -484,10 +473,6 @@ err_pnp:
 err_platform:
 	if (force_pdev)
 		platform_device_unregister(force_pdev);
-#ifdef CONFIG_X86
-	if (is_bsw())
-		iounmap(ilb_base_addr);
-#endif
 err_force:
 	return rc;
 }
@@ -497,10 +482,6 @@ static void __exit cleanup_tis(void)
 	pnp_unregister_driver(&tis_pnp_driver);
 	platform_driver_unregister(&tis_drv);
 
-#ifdef CONFIG_X86
-	if (is_bsw())
-		iounmap(ilb_base_addr);
-#endif
 	if (force_pdev)
 		platform_device_unregister(force_pdev);
 }
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -701,6 +701,13 @@ int tpm_tis_core_init(struct device *dev
 	priv->phy_ops = phy_ops;
 	dev_set_drvdata(&chip->dev, priv);
 
+	if (is_bsw()) {
+		priv->ilb_base_addr = ioremap(INTEL_LEGACY_BLK_BASE_ADDR,
+					ILB_REMAP_SIZE);
+		if (!priv->ilb_base_addr)
+			return -ENOMEM;
+	}
+
 	if (wait_startup(chip, 0) != 0) {
 		rc = -ENODEV;
 		goto out_err;
@@ -791,9 +798,16 @@ int tpm_tis_core_init(struct device *dev
 		}
 	}
 
-	return tpm_chip_register(chip);
+	rc = tpm_chip_register(chip);
+	if (rc && is_bsw())
+		iounmap(priv->ilb_base_addr);
+
+	return rc;
 out_err:
 	tpm_tis_remove(chip);
+	if (is_bsw())
+		iounmap(priv->ilb_base_addr);
+
 	return rc;
 }
 EXPORT_SYMBOL_GPL(tpm_tis_core_init);
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -79,6 +79,9 @@ enum tis_defaults {
 #define	TPM_DID_VID(l)			(0x0F00 | ((l) << 12))
 #define	TPM_RID(l)			(0x0F04 | ((l) << 12))
 
+#define INTEL_LEGACY_BLK_BASE_ADDR	0xFED08000
+#define ILB_REMAP_SIZE			0x100
+
 enum tpm_tis_flags {
 	TPM_TIS_ITPM_WORKAROUND		= BIT(0),
 };
@@ -89,6 +92,7 @@ struct tpm_tis_data {
 	int irq;
 	bool irq_tested;
 	unsigned int flags;
+	void __iomem *ilb_base_addr;
 	wait_queue_head_t int_queue;
 	wait_queue_head_t read_queue;
 	const struct tpm_tis_phy_ops *phy_ops;
@@ -144,6 +148,15 @@ static inline int tpm_tis_write32(struct
 	return data->phy_ops->write32(data, addr, value);
 }
 
+static inline bool is_bsw(void)
+{
+#ifdef CONFIG_X86
+	return ((boot_cpu_data.x86_model == INTEL_FAM6_ATOM_AIRMONT) ? 1 : 0);
+#else
+	return false;
+#endif
+}
+
 void tpm_tis_remove(struct tpm_chip *chip);
 int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		      const struct tpm_tis_phy_ops *phy_ops,
