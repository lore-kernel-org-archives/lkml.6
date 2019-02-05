Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660B2C282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DA02175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbfBEWtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:49:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:58206 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730379AbfBEWs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:48:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 14:48:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,337,1544515200"; 
   d="scan'208";a="113982263"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.171])
  by orsmga006.jf.intel.com with ESMTP; 05 Feb 2019 14:48:53 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v11 12/16] tpm: use tpm_try_get_ops() in tpm-sysfs.c.
Date:   Wed,  6 Feb 2019 00:47:19 +0200
Message-Id: <20190205224723.19671-13-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
References: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use tpm_try_get_ops() in tpm-sysfs.c so that we can consider moving
other decorations (locking, localities, power management for example)
inside it. This direction can be of course taken only after other call
sites for tpm_transmit() have been treated in the same way.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm-sysfs.c | 123 ++++++++++++++++++++++-------------
 1 file changed, 78 insertions(+), 45 deletions(-)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 03e704f99ed6..3733491671ca 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -39,7 +39,6 @@ static ssize_t pubek_show(struct device *dev, struct device_attribute *attr,
 {
 	struct tpm_buf tpm_buf;
 	struct tpm_readpubek_out *out;
-	ssize_t rc;
 	int i;
 	char *str = buf;
 	struct tpm_chip *chip = to_tpm_chip(dev);
@@ -47,17 +46,17 @@ static ssize_t pubek_show(struct device *dev, struct device_attribute *attr,
 
 	memset(&anti_replay, 0, sizeof(anti_replay));
 
-	if (tpm_buf_init(&tpm_buf, TPM_TAG_RQU_COMMAND, TPM_ORD_READPUBEK))
+	if (tpm_try_get_ops(chip))
 		return 0;
 
+	if (tpm_buf_init(&tpm_buf, TPM_TAG_RQU_COMMAND, TPM_ORD_READPUBEK))
+		goto out_ops;
+
 	tpm_buf_append(&tpm_buf, anti_replay, sizeof(anti_replay));
 
-	rc = tpm_transmit_cmd(chip, &tpm_buf, READ_PUBEK_RESULT_MIN_BODY_SIZE,
-			      0, "attempting to read the PUBEK");
-	if (rc) {
-		tpm_buf_destroy(&tpm_buf);
-		return 0;
-	}
+	if (tpm_transmit_cmd(chip, &tpm_buf, READ_PUBEK_RESULT_MIN_BODY_SIZE,
+			      0, "attempting to read the PUBEK"))
+		goto out_buf;
 
 	out = (struct tpm_readpubek_out *)&tpm_buf.data[10];
 	str +=
@@ -88,9 +87,11 @@ static ssize_t pubek_show(struct device *dev, struct device_attribute *attr,
 			str += sprintf(str, "\n");
 	}
 
-	rc = str - buf;
+out_buf:
 	tpm_buf_destroy(&tpm_buf);
-	return rc;
+out_ops:
+	tpm_put_ops(chip);
+	return str - buf;
 }
 static DEVICE_ATTR_RO(pubek);
 
@@ -103,10 +104,15 @@ static ssize_t pcrs_show(struct device *dev, struct device_attribute *attr,
 	char *str = buf;
 	struct tpm_chip *chip = to_tpm_chip(dev);
 
+	if (tpm_try_get_ops(chip))
+		return 0;
+
 	if (tpm1_getcap(chip, TPM_CAP_PROP_PCR, &cap,
 			"attempting to determine the number of PCRS",
-			sizeof(cap.num_pcrs)))
+			sizeof(cap.num_pcrs))) {
+		tpm_put_ops(chip);
 		return 0;
+	}
 
 	num_pcrs = be32_to_cpu(cap.num_pcrs);
 	for (i = 0; i < num_pcrs; i++) {
@@ -119,6 +125,7 @@ static ssize_t pcrs_show(struct device *dev, struct device_attribute *attr,
 			str += sprintf(str, "%02X ", digest[j]);
 		str += sprintf(str, "\n");
 	}
+	tpm_put_ops(chip);
 	return str - buf;
 }
 static DEVICE_ATTR_RO(pcrs);
@@ -126,16 +133,21 @@ static DEVICE_ATTR_RO(pcrs);
 static ssize_t enabled_show(struct device *dev, struct device_attribute *attr,
 		     char *buf)
 {
+	struct tpm_chip *chip = to_tpm_chip(dev);
+	ssize_t rc = 0;
 	cap_t cap;
-	ssize_t rc;
 
-	rc = tpm1_getcap(to_tpm_chip(dev), TPM_CAP_FLAG_PERM, &cap,
-			 "attempting to determine the permanent enabled state",
-			 sizeof(cap.perm_flags));
-	if (rc)
+	if (tpm_try_get_ops(chip))
 		return 0;
 
+	if (tpm1_getcap(chip, TPM_CAP_FLAG_PERM, &cap,
+			"attempting to determine the permanent enabled state",
+			sizeof(cap.perm_flags)))
+		goto out_ops;
+
 	rc = sprintf(buf, "%d\n", !cap.perm_flags.disable);
+out_ops:
+	tpm_put_ops(chip);
 	return rc;
 }
 static DEVICE_ATTR_RO(enabled);
@@ -143,16 +155,21 @@ static DEVICE_ATTR_RO(enabled);
 static ssize_t active_show(struct device *dev, struct device_attribute *attr,
 		    char *buf)
 {
+	struct tpm_chip *chip = to_tpm_chip(dev);
+	ssize_t rc = 0;
 	cap_t cap;
-	ssize_t rc;
 
-	rc = tpm1_getcap(to_tpm_chip(dev), TPM_CAP_FLAG_PERM, &cap,
-			 "attempting to determine the permanent active state",
-			 sizeof(cap.perm_flags));
-	if (rc)
+	if (tpm_try_get_ops(chip))
 		return 0;
 
+	if (tpm1_getcap(chip, TPM_CAP_FLAG_PERM, &cap,
+			"attempting to determine the permanent active state",
+			sizeof(cap.perm_flags)))
+		goto out_ops;
+
 	rc = sprintf(buf, "%d\n", !cap.perm_flags.deactivated);
+out_ops:
+	tpm_put_ops(chip);
 	return rc;
 }
 static DEVICE_ATTR_RO(active);
@@ -160,16 +177,21 @@ static DEVICE_ATTR_RO(active);
 static ssize_t owned_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
+	struct tpm_chip *chip = to_tpm_chip(dev);
+	ssize_t rc = 0;
 	cap_t cap;
-	ssize_t rc;
 
-	rc = tpm1_getcap(to_tpm_chip(dev), TPM_CAP_PROP_OWNER, &cap,
-			 "attempting to determine the owner state",
-			 sizeof(cap.owned));
-	if (rc)
+	if (tpm_try_get_ops(chip))
 		return 0;
 
+	if (tpm1_getcap(to_tpm_chip(dev), TPM_CAP_PROP_OWNER, &cap,
+			"attempting to determine the owner state",
+			sizeof(cap.owned)))
+		goto out_ops;
+
 	rc = sprintf(buf, "%d\n", cap.owned);
+out_ops:
+	tpm_put_ops(chip);
 	return rc;
 }
 static DEVICE_ATTR_RO(owned);
@@ -177,16 +199,21 @@ static DEVICE_ATTR_RO(owned);
 static ssize_t temp_deactivated_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
+	struct tpm_chip *chip = to_tpm_chip(dev);
+	ssize_t rc = 0;
 	cap_t cap;
-	ssize_t rc;
 
-	rc = tpm1_getcap(to_tpm_chip(dev), TPM_CAP_FLAG_VOL, &cap,
-			 "attempting to determine the temporary state",
-			 sizeof(cap.stclear_flags));
-	if (rc)
+	if (tpm_try_get_ops(chip))
 		return 0;
 
+	if (tpm1_getcap(to_tpm_chip(dev), TPM_CAP_FLAG_VOL, &cap,
+			"attempting to determine the temporary state",
+			sizeof(cap.stclear_flags)))
+		goto out_ops;
+
 	rc = sprintf(buf, "%d\n", cap.stclear_flags.deactivated);
+out_ops:
+	tpm_put_ops(chip);
 	return rc;
 }
 static DEVICE_ATTR_RO(temp_deactivated);
@@ -195,15 +222,18 @@ static ssize_t caps_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct tpm_chip *chip = to_tpm_chip(dev);
-	cap_t cap;
-	ssize_t rc;
+	ssize_t rc = 0;
 	char *str = buf;
+	cap_t cap;
 
-	rc = tpm1_getcap(chip, TPM_CAP_PROP_MANUFACTURER, &cap,
-			 "attempting to determine the manufacturer",
-			 sizeof(cap.manufacturer_id));
-	if (rc)
+	if (tpm_try_get_ops(chip))
 		return 0;
+
+	if (tpm1_getcap(chip, TPM_CAP_PROP_MANUFACTURER, &cap,
+			"attempting to determine the manufacturer",
+			sizeof(cap.manufacturer_id)))
+		goto out_ops;
+
 	str += sprintf(str, "Manufacturer: 0x%x\n",
 		       be32_to_cpu(cap.manufacturer_id));
 
@@ -220,11 +250,10 @@ static ssize_t caps_show(struct device *dev, struct device_attribute *attr,
 			       cap.tpm_version_1_2.revMinor);
 	} else {
 		/* Otherwise just use TPM_STRUCT_VER */
-		rc = tpm1_getcap(chip, TPM_CAP_VERSION_1_1, &cap,
-				 "attempting to determine the 1.1 version",
-				 sizeof(cap.tpm_version));
-		if (rc)
-			return 0;
+		if (tpm1_getcap(chip, TPM_CAP_VERSION_1_1, &cap,
+				"attempting to determine the 1.1 version",
+				sizeof(cap.tpm_version)))
+			goto out_ops;
 		str += sprintf(str,
 			       "TCG version: %d.%d\nFirmware version: %d.%d\n",
 			       cap.tpm_version.Major,
@@ -232,8 +261,10 @@ static ssize_t caps_show(struct device *dev, struct device_attribute *attr,
 			       cap.tpm_version.revMajor,
 			       cap.tpm_version.revMinor);
 	}
-
-	return str - buf;
+	rc = str - buf;
+out_ops:
+	tpm_put_ops(chip);
+	return rc;
 }
 static DEVICE_ATTR_RO(caps);
 
@@ -241,10 +272,12 @@ static ssize_t cancel_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
 	struct tpm_chip *chip = to_tpm_chip(dev);
-	if (chip == NULL)
+
+	if (tpm_try_get_ops(chip))
 		return 0;
 
 	chip->ops->cancel(chip);
+	tpm_put_ops(chip);
 	return count;
 }
 static DEVICE_ATTR_WO(cancel);
-- 
2.19.1

