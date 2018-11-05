Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7251ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 01:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B49C2082A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 01:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B49C2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbeKELEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 06:04:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:9979 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729024AbeKELEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 06:04:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 17:47:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,466,1534834800"; 
   d="scan'208";a="271354319"
Received: from unknown (HELO localhost) ([10.249.254.144])
  by orsmga005.jf.intel.com with ESMTP; 04 Nov 2018 17:47:36 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 12/16] tpm: use tpm_try_get_ops() in tpm-sysfs.c.
Date:   Mon,  5 Nov 2018 03:45:45 +0200
Message-Id: <20181105014552.20262-13-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181105014552.20262-1-jarkko.sakkinen@linux.intel.com>
References: <20181105014552.20262-1-jarkko.sakkinen@linux.intel.com>
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
---
 drivers/char/tpm/tpm-sysfs.c | 135 +++++++++++++++++++++--------------
 1 file changed, 82 insertions(+), 53 deletions(-)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 7126b0b04ee6..02521c4d631b 100644
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
 
@@ -99,29 +100,31 @@ static ssize_t pcrs_show(struct device *dev, struct device_attribute *attr,
 {
 	cap_t cap;
 	u8 digest[TPM_DIGEST_SIZE];
-	ssize_t rc;
 	u32 i, j, num_pcrs;
 	char *str = buf;
+	ssize_t rc = 0;
 	struct tpm_chip *chip = to_tpm_chip(dev);
 
-	rc = tpm1_getcap(chip, TPM_CAP_PROP_PCR, &cap,
-			 "attempting to determine the number of PCRS",
-			 sizeof(cap.num_pcrs));
-	if (rc)
+	if (tpm_try_get_ops(chip))
 		return 0;
 
+	if (tpm1_getcap(chip, TPM_CAP_PROP_PCR, &cap,
+			"attempting to determine the number of PCRS",
+			sizeof(cap.num_pcrs)))
+		goto out_ops;
+
 	num_pcrs = be32_to_cpu(cap.num_pcrs);
 	for (i = 0; i < num_pcrs; i++) {
-		rc = tpm1_pcr_read(chip, i, digest);
-		if (rc)
-			goto out;
+		if (tpm1_pcr_read(chip, i, digest))
+			goto out_ops;
 		str += sprintf(str, "PCR-%02d: ", i);
 		for (j = 0; j < TPM_DIGEST_SIZE; j++)
 			str += sprintf(str, "%02X ", digest[j]);
 		str += sprintf(str, "\n");
 	}
 	rc = str - buf;
-out:
+out_ops:
+	tpm_put_ops(chip);
 	return rc;
 }
 static DEVICE_ATTR_RO(pcrs);
@@ -129,16 +132,21 @@ static DEVICE_ATTR_RO(pcrs);
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
@@ -146,16 +154,21 @@ static DEVICE_ATTR_RO(enabled);
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
@@ -163,16 +176,21 @@ static DEVICE_ATTR_RO(active);
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
@@ -180,16 +198,21 @@ static DEVICE_ATTR_RO(owned);
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
@@ -198,15 +221,18 @@ static ssize_t caps_show(struct device *dev, struct device_attribute *attr,
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
 
@@ -223,11 +249,10 @@ static ssize_t caps_show(struct device *dev, struct device_attribute *attr,
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
@@ -235,8 +260,10 @@ static ssize_t caps_show(struct device *dev, struct device_attribute *attr,
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
 
@@ -244,10 +271,12 @@ static ssize_t cancel_store(struct device *dev, struct device_attribute *attr,
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

