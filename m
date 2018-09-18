Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5FBECE568
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC02206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC02206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbeIRPJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:09:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:30811 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729667AbeIRPJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:09:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 02:38:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,389,1531810800"; 
   d="scan'208";a="71724123"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2018 02:38:02 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH v3 04/20] tpm: add tpm_calc_ordinal_duration wrapper
Date:   Tue, 18 Sep 2018 12:34:43 +0300
Message-Id: <20180918093459.19165-5-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180918093459.19165-1-tomas.winkler@intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
V2-V3: Rebase
 drivers/char/tpm/st33zp24/st33zp24.c |  2 +-
 drivers/char/tpm/tpm-interface.c     | 14 ++++++++++----
 drivers/char/tpm/tpm.h               |  1 +
 drivers/char/tpm/tpm1-cmd.c          |  1 -
 drivers/char/tpm/tpm2-cmd.c          |  1 -
 drivers/char/tpm/tpm_i2c_nuvoton.c   |  2 +-
 drivers/char/tpm/tpm_tis_core.c      |  6 +-----
 drivers/char/tpm/xen-tpmfront.c      |  2 +-
 8 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
index 16be974955ea..abd675bec88c 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.c
+++ b/drivers/char/tpm/st33zp24/st33zp24.c
@@ -430,7 +430,7 @@ static int st33zp24_send(struct tpm_chip *chip, unsigned char *buf,
 		ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
 
 		ret = wait_for_stat(chip, TPM_STS_DATA_AVAIL | TPM_STS_VALID,
-				tpm1_calc_ordinal_duration(chip, ordinal),
+				tpm_calc_ordinal_duration(chip, ordinal),
 				&tpm_dev->read_queue, false);
 		if (ret < 0)
 			goto out_err;
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index bb3eed907c72..7b460f646781 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -47,6 +47,15 @@ module_param_named(suspend_pcr, tpm_suspend_pcr, uint, 0644);
 MODULE_PARM_DESC(suspend_pcr,
 		 "PCR to use for dummy writes to facilitate flush on suspend.");
 
+unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
+{
+	if (chip->flags & TPM_CHIP_FLAG_TPM2)
+		return tpm2_calc_ordinal_duration(chip, ordinal);
+	else
+		return tpm1_calc_ordinal_duration(chip, ordinal);
+}
+EXPORT_SYMBOL_GPL(tpm_calc_ordinal_duration);
+
 static int tpm_validate_command(struct tpm_chip *chip,
 				 struct tpm_space *space,
 				 const u8 *cmd,
@@ -220,10 +229,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
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
index c59d2c20c339..73511cd89bef 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -547,6 +547,7 @@ int tpm_get_timeouts(struct tpm_chip *);
 int tpm1_auto_startup(struct tpm_chip *chip);
 int tpm_do_selftest(struct tpm_chip *chip);
 unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
+unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 int tpm_pm_suspend(struct device *dev);
 int tpm_pm_resume(struct device *dev);
 
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index fa6ba8d3458c..7e7fa94c095c 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -306,5 +306,4 @@ unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 	else
 		return duration;
 }
-EXPORT_SYMBOL_GPL(tpm1_calc_ordinal_duration);
 
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 9c3c5c0628d9..f6c981f3ee12 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -712,7 +712,6 @@ unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 	else
 		return msecs_to_jiffies(TPM2_DURATION_DEFAULT);
 }
-EXPORT_SYMBOL_GPL(tpm2_calc_ordinal_duration);
 
 /**
  * tpm2_do_selftest() - ensure that all self tests have passed
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
index 14c332104de4..f9e73d0f9386 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -473,11 +473,7 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
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
diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
index c7ded298617d..911475d36800 100644
--- a/drivers/char/tpm/xen-tpmfront.c
+++ b/drivers/char/tpm/xen-tpmfront.c
@@ -164,7 +164,7 @@ static int vtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
 	notify_remote_via_evtchn(priv->evtchn);
 
 	ordinal = be32_to_cpu(((struct tpm_input_header*)buf)->ordinal);
-	duration = tpm1_calc_ordinal_duration(chip, ordinal);
+	duration = tpm_calc_ordinal_duration(chip, ordinal);
 
 	if (wait_for_tpm_stat(chip, VTPM_STATUS_IDLE, duration,
 			&priv->read_queue, true) < 0) {
-- 
2.14.4

