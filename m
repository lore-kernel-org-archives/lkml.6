Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E494C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B6B2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B6B2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeI2FB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:01:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:9469 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbeI2FB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:01:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 15:35:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,316,1534834800"; 
   d="scan'208";a="267880354"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga006.fm.intel.com with ESMTP; 28 Sep 2018 15:35:34 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH v5 21/21] tpm: use u32 instead of int for PCR index
Date:   Sat, 29 Sep 2018 01:30:35 +0300
Message-Id: <20180928223035.14471-22-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180928223035.14471-1-tomas.winkler@intel.com>
References: <20180928223035.14471-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TPM specs defines PCR index as a positive number, and there is
no reason to use a signed number. It is also a possible security
issue as currently no functions check for a negative index,
which may become a large number when converted to u32.

Adjust the API to use u32 instead of int in all PCR related
functions.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
V3: New in the series.
V4: Separate unrelated change to another patches.
V5: Fix the commit message.

 drivers/char/tpm/tpm-interface.c    |  6 +++---
 drivers/char/tpm/tpm-sysfs.c        |  2 +-
 drivers/char/tpm/tpm.h              | 10 +++++-----
 drivers/char/tpm/tpm1-cmd.c         |  6 +++---
 drivers/char/tpm/tpm2-cmd.c         |  6 +++---
 include/linux/tpm.h                 | 11 +++++++----
 security/integrity/ima/ima_crypto.c |  5 +++--
 7 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 3d80c5114fec..c27106b4a35e 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -38,7 +38,7 @@
  * recently changed pcr on suspend, so force the flush
  * with an extend to the selected _unused_ non-volatile pcr.
  */
-static int tpm_suspend_pcr;
+static u32 tpm_suspend_pcr;
 module_param_named(suspend_pcr, tpm_suspend_pcr, uint, 0644);
 MODULE_PARM_DESC(suspend_pcr,
 		 "PCR to use for dummy writes to facilitate flush on suspend.");
@@ -454,7 +454,7 @@ EXPORT_SYMBOL_GPL(tpm_is_tpm2);
  *
  * Return: same as with tpm_transmit_cmd()
  */
-int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
+int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 {
 	int rc;
 
@@ -484,7 +484,7 @@ EXPORT_SYMBOL_GPL(tpm_pcr_read);
  *
  * Return: same as with tpm_transmit_cmd()
  */
-int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)
+int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash)
 {
 	int rc;
 
diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 96fc7433c57d..b88e08ec2c59 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -102,7 +102,7 @@ static ssize_t pcrs_show(struct device *dev, struct device_attribute *attr,
 	cap_t cap;
 	u8 digest[TPM_DIGEST_SIZE];
 	ssize_t rc;
-	int i, j, num_pcrs;
+	u32 i, j, num_pcrs;
 	char *str = buf;
 	struct tpm_chip *chip = to_tpm_chip(dev);
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 7ada00f067f1..5d018f61b812 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -509,14 +509,14 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
 int tpm_get_timeouts(struct tpm_chip *);
 int tpm_auto_startup(struct tpm_chip *chip);
 
-int tpm1_pm_suspend(struct tpm_chip *chip, int tpm_suspend_pcr);
+int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr);
 int tpm1_do_selftest(struct tpm_chip *chip);
 int tpm1_auto_startup(struct tpm_chip *chip);
 int tpm1_get_timeouts(struct tpm_chip *chip);
 unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
-int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
+int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 		    const char *log_msg);
-int tpm1_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf);
+int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
 ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		    const char *desc, size_t min_cap_length);
 int tpm1_get_random(struct tpm_chip *chip, u8 *out, size_t max);
@@ -558,8 +558,8 @@ static inline u32 tpm2_rc_value(u32 rc)
 }
 
 int tpm2_get_timeouts(struct tpm_chip *chip);
-int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf);
-int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash);
+int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
+int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash);
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
 void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
 			    unsigned int flags);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 6b04648f8184..6f306338953b 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -449,7 +449,7 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
 }
 
 #define TPM_ORD_PCR_EXTEND 20
-int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
+int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 		    const char *log_msg)
 {
 	struct tpm_buf buf;
@@ -572,7 +572,7 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 }
 
 #define TPM_ORD_PCRREAD 21
-int tpm1_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
+int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 {
 	struct tpm_buf buf;
 	int rc;
@@ -729,7 +729,7 @@ int tpm1_auto_startup(struct tpm_chip *chip)
  * * 0 on success,
  * * < 0 on error.
  */
-int tpm1_pm_suspend(struct tpm_chip *chip, int tpm_suspend_pcr)
+int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
 {
 	u8 dummy_hash[TPM_DIGEST_SIZE] = { 0 };
 	struct tpm_buf buf;
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 2b705b00db78..c2667d3e9dae 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -175,7 +175,7 @@ struct tpm2_pcr_read_out {
  *
  * Return: Same as with tpm_transmit_cmd.
  */
-int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
+int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 {
 	int rc;
 	struct tpm_buf buf;
@@ -224,7 +224,7 @@ struct tpm2_null_auth_area {
  *
  * Return: Same as with tpm_transmit_cmd.
  */
-static int __tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
+static int __tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
 			     struct tpm2_digest *digests)
 {
 	struct tpm_buf buf;
@@ -278,7 +278,7 @@ static int __tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
  *
  * Return: Same as with tpm_transmit_cmd.
  */
-int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)
+int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash)
 {
 	int rc;
 	struct tpm2_digest digest_list[ARRAY_SIZE(chip->active_banks)];
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 4609b94142d4..b49a55cf775f 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -53,8 +53,8 @@ struct tpm_class_ops {
 #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
 
 extern int tpm_is_tpm2(struct tpm_chip *chip);
-extern int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf);
-extern int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash);
+extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
+extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash);
 extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
 extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
 extern int tpm_seal_trusted(struct tpm_chip *chip,
@@ -69,15 +69,18 @@ static inline int tpm_is_tpm2(struct tpm_chip *chip)
 {
 	return -ENODEV;
 }
-static inline int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
+
+static inline int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 {
 	return -ENODEV;
 }
-static inline int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx,
+
+static inline int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 				 const u8 *hash)
 {
 	return -ENODEV;
 }
+
 static inline int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen)
 {
 	return -ENODEV;
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 7e7e7e7c250a..959d9edc113a 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -629,7 +629,7 @@ int ima_calc_buffer_hash(const void *buf, loff_t len,
 	return calc_buffer_shash(buf, len, hash);
 }
 
-static void __init ima_pcrread(int idx, u8 *pcr)
+static void __init ima_pcrread(u32 idx, u8 *pcr)
 {
 	if (!ima_tpm_chip)
 		return;
@@ -645,7 +645,8 @@ static int __init ima_calc_boot_aggregate_tfm(char *digest,
 					      struct crypto_shash *tfm)
 {
 	u8 pcr_i[TPM_DIGEST_SIZE];
-	int rc, i;
+	int rc;
+	u32 i;
 	SHASH_DESC_ON_STACK(shash, tfm);
 
 	shash->tfm = tfm;
-- 
2.14.4

