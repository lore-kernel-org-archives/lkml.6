Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932514AbeCLUxa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:53:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:50803 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932326AbeCLUx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:53:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,463,1515484800";
   d="scan'208";a="33247882"
From: Tomas Winkler <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH] tpm: add tpm_calc_ordinal_duration wrapper
Date: Mon, 12 Mar 2018 22:50:07 +0200
Message-Id: <20180312205007.29461-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add convenient wrapper for ordinal duration computation
to remove boiler plate if else statement over TPM2.

if (chip->flags & TPM_CHIP_FLAG_TPM2)
	tpm2_calc_ordinal_duration(chip, ordinal);
else
	tpm1_calc_ordinal_duration(chip, ordinal);

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/char/tpm/st33zp24/st33zp24.c |  2 +-
 drivers/char/tpm/tpm-interface.c     | 14 ++++++++++----
 drivers/char/tpm/tpm.h               |  1 +
 drivers/char/tpm/tpm1-cmd.c          |  1 -
 drivers/char/tpm/tpm2-cmd.c          |  1 -
 drivers/char/tpm/tpm_i2c_nuvoton.c   |  2 +-
 drivers/char/tpm/tpm_tis_core.c      |  6 +-----
 7 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
index 575b7c2eab25..dad7b9d4e90d 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.c
+++ b/drivers/char/tpm/st33zp24/st33zp24.c
@@ -432,7 +432,7 @@ static int st33zp24_send(struct tpm_chip *chip, unsigned char *buf,
 		ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
 
 		ret = wait_for_stat(chip, TPM_STS_DATA_AVAIL | TPM_STS_VALID,
-				tpm1_calc_ordinal_duration(chip, ordinal),
+				tpm_calc_ordinal_duration(chip, ordinal),
 				&tpm_dev->read_queue, false);
 		if (ret < 0)
 			goto out_err;
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 93f7c12d4c4d..a5536d6888fa 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -91,6 +91,15 @@ static void tpm_relinquish_locality(struct tpm_chip *chip)
 	chip->locality = -1;
 }
 
+unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
+{
+	if (chip->flags & TPM_CHIP_FLAG_TPM2)
+		return tpm2_calc_ordinal_duration(chip, ordinal);
+	else
+		return tpm1_calc_ordinal_duration(chip, ordinal);
+}
+EXPORT_SYMBOL_GPL(tpm_calc_ordinal_duration);
+
 /**
  * tpm_transmit - Internal kernel interface to transmit TPM commands.
  *
@@ -179,10 +188,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	if (chip->flags & TPM_CHIP_FLAG_IRQ)
 		goto out_recv;
 
-	if (chip->flags & TPM_CHIP_FLAG_TPM2)
-		stop = jiffies + tpm2_calc_ordinal_duration(chip, ordinal);
-	else
-		stop = jiffies + tpm1_calc_ordinal_duration(chip, ordinal);
+	stop = jiffies + tpm_calc_ordinal_duration(chip, ordinal);
 	do {
 		u8 status = chip->ops->status(chip);
 		if ((status & chip->ops->req_complete_mask) ==
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 730ee50f93fa..be58c1936729 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -549,6 +549,7 @@ static inline void tpm_msleep(unsigned int delay_msec)
 		     delay_msec * 1000);
 };
 
+unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 struct tpm_chip *tpm_chip_find_get(struct tpm_chip *chip);
 __must_check int tpm_try_get_ops(struct tpm_chip *chip);
 void tpm_put_ops(struct tpm_chip *chip);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 85dd0fcbd4cc..f232238dd418 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -305,7 +305,6 @@ unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 	else
 		return duration;
 }
-EXPORT_SYMBOL_GPL(tpm1_calc_ordinal_duration);
 
 #define TPM_ORD_STARTUP 153
 #define TPM_ST_CLEAR 1
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 6db13cf801b4..fc39545b121a 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -810,7 +810,6 @@ unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 	else
 		return msecs_to_jiffies(TPM2_DURATION_DEFAULT);
 }
-EXPORT_SYMBOL_GPL(tpm2_calc_ordinal_duration);
 
 #define TPM2_SELF_TEST_IN_SIZE \
 	(sizeof(struct tpm_input_header) + \
diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
index 5d20e98b844f..4146f822fba9 100644
--- a/drivers/char/tpm/tpm_i2c_nuvoton.c
+++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
@@ -456,7 +456,7 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t len)
 		return rc;
 	}
 	ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
-	duration = tpm1_calc_ordinal_duration(chip, ordinal);
+	duration = tpm_calc_ordinal_duration(chip, ordinal);
 	rc = i2c_nuvoton_wait_for_data_avail(chip, duration, &priv->read_queue);
 	if (rc) {
 		dev_err(dev, "%s() timeout command duration %ld\n",
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 87f63c500956..a64548807af2 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -433,11 +433,7 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
 		ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
 
-		if (chip->flags & TPM_CHIP_FLAG_TPM2)
-			dur = tpm2_calc_ordinal_duration(chip, ordinal);
-		else
-			dur = tpm1_calc_ordinal_duration(chip, ordinal);
-
+		dur = tpm_calc_ordinal_duration(chip, ordinal);
 		if (wait_for_tpm_stat
 		    (chip, TPM_STS_DATA_AVAIL | TPM_STS_VALID, dur,
 		     &priv->read_queue, false) < 0) {
-- 
2.14.3
