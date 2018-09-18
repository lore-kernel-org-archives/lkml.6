Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2656DECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D07206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D07206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbeIRPJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:09:55 -0400
Received: from mga14.intel.com ([192.55.52.115]:30811 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729667AbeIRPJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:09:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 02:38:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,389,1531810800"; 
   d="scan'208";a="71724135"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2018 02:38:04 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH v3 05/20] tpm: factor out tpm_get_timeouts
Date:   Tue, 18 Sep 2018 12:34:44 +0300
Message-Id: <20180918093459.19165-6-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180918093459.19165-1-tomas.winkler@intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out tpm_get_timeouts into tpm2_get_timeouts
and tpm1_get_timeouts.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V2-V3: Rebase
 drivers/char/tpm/tpm-interface.c | 127 ++-------------------------------------
 drivers/char/tpm/tpm.h           |   5 +-
 drivers/char/tpm/tpm1-cmd.c      | 106 ++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm2-cmd.c      |  22 +++++++
 4 files changed, 136 insertions(+), 124 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 7b460f646781..55f9094a8f11 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -492,132 +492,13 @@ EXPORT_SYMBOL_GPL(tpm_getcap);
 
 int tpm_get_timeouts(struct tpm_chip *chip)
 {
-	cap_t cap;
-	unsigned long timeout_old[4], timeout_chip[4], timeout_eff[4];
-	ssize_t rc;
-
 	if (chip->flags & TPM_CHIP_FLAG_HAVE_TIMEOUTS)
 		return 0;
 
-	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
-		/* Fixed timeouts for TPM2 */
-		chip->timeout_a = msecs_to_jiffies(TPM2_TIMEOUT_A);
-		chip->timeout_b = msecs_to_jiffies(TPM2_TIMEOUT_B);
-		chip->timeout_c = msecs_to_jiffies(TPM2_TIMEOUT_C);
-		chip->timeout_d = msecs_to_jiffies(TPM2_TIMEOUT_D);
-		chip->duration[TPM_SHORT] =
-		    msecs_to_jiffies(TPM2_DURATION_SHORT);
-		chip->duration[TPM_MEDIUM] =
-		    msecs_to_jiffies(TPM2_DURATION_MEDIUM);
-		chip->duration[TPM_LONG] =
-		    msecs_to_jiffies(TPM2_DURATION_LONG);
-		chip->duration[TPM_LONG_LONG] =
-		    msecs_to_jiffies(TPM2_DURATION_LONG_LONG);
-
-		chip->flags |= TPM_CHIP_FLAG_HAVE_TIMEOUTS;
-		return 0;
-	}
-
-	rc = tpm_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, NULL,
-			sizeof(cap.timeout));
-	if (rc == TPM_ERR_INVALID_POSTINIT) {
-		if (tpm_startup(chip))
-			return rc;
-
-		rc = tpm_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap,
-				"attempting to determine the timeouts",
-				sizeof(cap.timeout));
-	}
-
-	if (rc) {
-		dev_err(&chip->dev,
-			"A TPM error (%zd) occurred attempting to determine the timeouts\n",
-			rc);
-		return rc;
-	}
-
-	timeout_old[0] = jiffies_to_usecs(chip->timeout_a);
-	timeout_old[1] = jiffies_to_usecs(chip->timeout_b);
-	timeout_old[2] = jiffies_to_usecs(chip->timeout_c);
-	timeout_old[3] = jiffies_to_usecs(chip->timeout_d);
-	timeout_chip[0] = be32_to_cpu(cap.timeout.a);
-	timeout_chip[1] = be32_to_cpu(cap.timeout.b);
-	timeout_chip[2] = be32_to_cpu(cap.timeout.c);
-	timeout_chip[3] = be32_to_cpu(cap.timeout.d);
-	memcpy(timeout_eff, timeout_chip, sizeof(timeout_eff));
-
-	/*
-	 * Provide ability for vendor overrides of timeout values in case
-	 * of misreporting.
-	 */
-	if (chip->ops->update_timeouts != NULL)
-		chip->timeout_adjusted =
-			chip->ops->update_timeouts(chip, timeout_eff);
-
-	if (!chip->timeout_adjusted) {
-		/* Restore default if chip reported 0 */
-		int i;
-
-		for (i = 0; i < ARRAY_SIZE(timeout_eff); i++) {
-			if (timeout_eff[i])
-				continue;
-
-			timeout_eff[i] = timeout_old[i];
-			chip->timeout_adjusted = true;
-		}
-
-		if (timeout_eff[0] != 0 && timeout_eff[0] < 1000) {
-			/* timeouts in msec rather usec */
-			for (i = 0; i != ARRAY_SIZE(timeout_eff); i++)
-				timeout_eff[i] *= 1000;
-			chip->timeout_adjusted = true;
-		}
-	}
-
-	/* Report adjusted timeouts */
-	if (chip->timeout_adjusted) {
-		dev_info(&chip->dev,
-			 HW_ERR "Adjusting reported timeouts: A %lu->%luus B %lu->%luus C %lu->%luus D %lu->%luus\n",
-			 timeout_chip[0], timeout_eff[0],
-			 timeout_chip[1], timeout_eff[1],
-			 timeout_chip[2], timeout_eff[2],
-			 timeout_chip[3], timeout_eff[3]);
-	}
-
-	chip->timeout_a = usecs_to_jiffies(timeout_eff[0]);
-	chip->timeout_b = usecs_to_jiffies(timeout_eff[1]);
-	chip->timeout_c = usecs_to_jiffies(timeout_eff[2]);
-	chip->timeout_d = usecs_to_jiffies(timeout_eff[3]);
-
-	rc = tpm_getcap(chip, TPM_CAP_PROP_TIS_DURATION, &cap,
-			"attempting to determine the durations",
-			sizeof(cap.duration));
-	if (rc)
-		return rc;
-
-	chip->duration[TPM_SHORT] =
-		usecs_to_jiffies(be32_to_cpu(cap.duration.tpm_short));
-	chip->duration[TPM_MEDIUM] =
-		usecs_to_jiffies(be32_to_cpu(cap.duration.tpm_medium));
-	chip->duration[TPM_LONG] =
-		usecs_to_jiffies(be32_to_cpu(cap.duration.tpm_long));
-	chip->duration[TPM_LONG_LONG] = 0; /* not used under 1.2 */
-
-	/* The Broadcom BCM0102 chipset in a Dell Latitude D820 gets the above
-	 * value wrong and apparently reports msecs rather than usecs. So we
-	 * fix up the resulting too-small TPM_SHORT value to make things work.
-	 * We also scale the TPM_MEDIUM and -_LONG values by 1000.
-	 */
-	if (chip->duration[TPM_SHORT] < (HZ / 100)) {
-		chip->duration[TPM_SHORT] = HZ;
-		chip->duration[TPM_MEDIUM] *= 1000;
-		chip->duration[TPM_LONG] *= 1000;
-		chip->duration_adjusted = true;
-		dev_info(&chip->dev, "Adjusting TPM timeout parameters.");
-	}
-
-	chip->flags |= TPM_CHIP_FLAG_HAVE_TIMEOUTS;
-	return 0;
+	if (chip->flags & TPM_CHIP_FLAG_TPM2)
+		return tpm2_get_timeouts(chip);
+	else
+		return tpm1_get_timeouts(chip);
 }
 EXPORT_SYMBOL_GPL(tpm_get_timeouts);
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 73511cd89bef..a97d72fcda5b 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -544,8 +544,10 @@ int tpm_startup(struct tpm_chip *chip);
 ssize_t tpm_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		   const char *desc, size_t min_cap_length);
 int tpm_get_timeouts(struct tpm_chip *);
-int tpm1_auto_startup(struct tpm_chip *chip);
 int tpm_do_selftest(struct tpm_chip *chip);
+
+int tpm1_auto_startup(struct tpm_chip *chip);
+int tpm1_get_timeouts(struct tpm_chip *chip);
 unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 int tpm_pm_suspend(struct device *dev);
@@ -585,6 +587,7 @@ static inline u32 tpm2_rc_value(u32 rc)
 	return (rc & BIT(7)) ? rc & 0xff : rc;
 }
 
+int tpm2_get_timeouts(struct tpm_chip *chip);
 int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf);
 int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
 		    struct tpm2_digest *digests);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 7e7fa94c095c..cce2f83d90e3 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -307,3 +307,109 @@ unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 		return duration;
 }
 
+int tpm1_get_timeouts(struct tpm_chip *chip)
+{
+	cap_t cap;
+	unsigned long timeout_old[4], timeout_chip[4], timeout_eff[4];
+	ssize_t rc;
+
+	rc = tpm_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, NULL,
+			sizeof(cap.timeout));
+	if (rc == TPM_ERR_INVALID_POSTINIT) {
+		if (tpm_startup(chip))
+			return rc;
+
+		rc = tpm_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap,
+				"attempting to determine the timeouts",
+				sizeof(cap.timeout));
+	}
+
+	if (rc) {
+		dev_err(&chip->dev,
+			"A TPM error (%zd) occurred attempting to determine the timeouts\n",
+			rc);
+		return rc;
+	}
+
+	timeout_old[0] = jiffies_to_usecs(chip->timeout_a);
+	timeout_old[1] = jiffies_to_usecs(chip->timeout_b);
+	timeout_old[2] = jiffies_to_usecs(chip->timeout_c);
+	timeout_old[3] = jiffies_to_usecs(chip->timeout_d);
+	timeout_chip[0] = be32_to_cpu(cap.timeout.a);
+	timeout_chip[1] = be32_to_cpu(cap.timeout.b);
+	timeout_chip[2] = be32_to_cpu(cap.timeout.c);
+	timeout_chip[3] = be32_to_cpu(cap.timeout.d);
+	memcpy(timeout_eff, timeout_chip, sizeof(timeout_eff));
+
+	/*
+	 * Provide ability for vendor overrides of timeout values in case
+	 * of misreporting.
+	 */
+	if (chip->ops->update_timeouts)
+		chip->timeout_adjusted =
+			chip->ops->update_timeouts(chip, timeout_eff);
+
+	if (!chip->timeout_adjusted) {
+		/* Restore default if chip reported 0 */
+		unsigned int i;
+
+		for (i = 0; i < ARRAY_SIZE(timeout_eff); i++) {
+			if (timeout_eff[i])
+				continue;
+
+			timeout_eff[i] = timeout_old[i];
+			chip->timeout_adjusted = true;
+		}
+
+		if (timeout_eff[0] != 0 && timeout_eff[0] < 1000) {
+			/* timeouts in msec rather usec */
+			for (i = 0; i != ARRAY_SIZE(timeout_eff); i++)
+				timeout_eff[i] *= 1000;
+			chip->timeout_adjusted = true;
+		}
+	}
+
+	/* Report adjusted timeouts */
+	if (chip->timeout_adjusted) {
+		dev_info(&chip->dev, HW_ERR "Adjusting reported timeouts: A %lu->%luus B %lu->%luus C %lu->%luus D %lu->%luus\n",
+			 timeout_chip[0], timeout_eff[0],
+			 timeout_chip[1], timeout_eff[1],
+			 timeout_chip[2], timeout_eff[2],
+			 timeout_chip[3], timeout_eff[3]);
+	}
+
+	chip->timeout_a = usecs_to_jiffies(timeout_eff[0]);
+	chip->timeout_b = usecs_to_jiffies(timeout_eff[1]);
+	chip->timeout_c = usecs_to_jiffies(timeout_eff[2]);
+	chip->timeout_d = usecs_to_jiffies(timeout_eff[3]);
+
+	rc = tpm_getcap(chip, TPM_CAP_PROP_TIS_DURATION, &cap,
+			"attempting to determine the durations",
+			sizeof(cap.duration));
+	if (rc)
+		return rc;
+
+	chip->duration[TPM_SHORT] =
+		usecs_to_jiffies(be32_to_cpu(cap.duration.tpm_short));
+	chip->duration[TPM_MEDIUM] =
+		usecs_to_jiffies(be32_to_cpu(cap.duration.tpm_medium));
+	chip->duration[TPM_LONG] =
+		usecs_to_jiffies(be32_to_cpu(cap.duration.tpm_long));
+	chip->duration[TPM_LONG_LONG] = 0; /* not used under 1.2 */
+
+	/* The Broadcom BCM0102 chipset in a Dell Latitude D820 gets the above
+	 * value wrong and apparently reports msecs rather than usecs. So we
+	 * fix up the resulting too-small TPM_SHORT value to make things work.
+	 * We also scale the TPM_MEDIUM and -_LONG values by 1000.
+	 */
+	if (chip->duration[TPM_SHORT] < (HZ / 100)) {
+		chip->duration[TPM_SHORT] = HZ;
+		chip->duration[TPM_MEDIUM] *= 1000;
+		chip->duration[TPM_LONG] *= 1000;
+		chip->duration_adjusted = true;
+		dev_info(&chip->dev, "Adjusting TPM timeout parameters.");
+	}
+
+	chip->flags |= TPM_CHIP_FLAG_HAVE_TIMEOUTS;
+	return 0;
+}
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index f6c981f3ee12..4ca0555f23c8 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -693,6 +693,28 @@ void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type)
 	tpm_buf_destroy(&buf);
 }
 
+int tpm2_get_timeouts(struct tpm_chip *chip)
+{
+	/* Fixed timeouts for TPM2 */
+	chip->timeout_a = msecs_to_jiffies(TPM2_TIMEOUT_A);
+	chip->timeout_b = msecs_to_jiffies(TPM2_TIMEOUT_B);
+	chip->timeout_c = msecs_to_jiffies(TPM2_TIMEOUT_C);
+	chip->timeout_d = msecs_to_jiffies(TPM2_TIMEOUT_D);
+
+	/* PTP spec timeouts */
+	chip->duration[TPM_SHORT] = msecs_to_jiffies(TPM2_DURATION_SHORT);
+	chip->duration[TPM_MEDIUM] = msecs_to_jiffies(TPM2_DURATION_MEDIUM);
+	chip->duration[TPM_LONG] = msecs_to_jiffies(TPM2_DURATION_LONG);
+
+	/* Key creation commands long timeouts */
+	chip->duration[TPM_LONG_LONG] =
+		msecs_to_jiffies(TPM2_DURATION_LONG_LONG);
+
+	chip->flags |= TPM_CHIP_FLAG_HAVE_TIMEOUTS;
+
+	return 0;
+}
+
 /*
  * tpm2_calc_ordinal_duration() - maximum duration for a command
  *
-- 
2.14.4

