Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7047FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D45E217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbfBEWt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:49:27 -0500
Received: from mga11.intel.com ([192.55.52.93]:36335 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730329AbfBEWtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:49:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 14:49:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,337,1544515200"; 
   d="scan'208";a="113982317"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.171])
  by orsmga006.jf.intel.com with ESMTP; 05 Feb 2019 14:49:13 -0800
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
Subject: [PATCH v11 15/16] tpm: take TPM chip power gating out of tpm_transmit()
Date:   Wed,  6 Feb 2019 00:47:22 +0200
Message-Id: <20190205224723.19671-16-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
References: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call tpm_chip_start() and tpm_chip_stop() in

* tpm_try_get_ops() and tpm_put_ops()
* tpm_chip_register()
* tpm2_del_space()

And remove these calls from tpm_transmit(). The core reason for this
change is that in tpm_vtpm_proxy a locality change requires a virtual
TPM command (a command made up just for that driver).

The consequence of this is that this commit removes the remaining nested
calls.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm-chip.c       | 25 ++++++++++++-------------
 drivers/char/tpm/tpm-interface.c  |  6 ------
 drivers/char/tpm/tpm.h            |  9 ---------
 drivers/char/tpm/tpm2-space.c     |  5 ++++-
 drivers/char/tpm/tpm_vtpm_proxy.c |  3 +--
 5 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 65f1561eba81..7ad4d9045e4c 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -41,9 +41,6 @@ static int tpm_request_locality(struct tpm_chip *chip, unsigned int flags)
 {
 	int rc;
 
-	if (flags & TPM_TRANSMIT_NESTED)
-		return 0;
-
 	if (!chip->ops->request_locality)
 		return 0;
 
@@ -59,9 +56,6 @@ static void tpm_relinquish_locality(struct tpm_chip *chip, unsigned int flags)
 {
 	int rc;
 
-	if (flags & TPM_TRANSMIT_NESTED)
-		return;
-
 	if (!chip->ops->relinquish_locality)
 		return;
 
@@ -74,9 +68,6 @@ static void tpm_relinquish_locality(struct tpm_chip *chip, unsigned int flags)
 
 static int tpm_cmd_ready(struct tpm_chip *chip, unsigned int flags)
 {
-	if (flags & TPM_TRANSMIT_NESTED)
-		return 0;
-
 	if (!chip->ops->cmd_ready)
 		return 0;
 
@@ -85,9 +76,6 @@ static int tpm_cmd_ready(struct tpm_chip *chip, unsigned int flags)
 
 static int tpm_go_idle(struct tpm_chip *chip, unsigned int flags)
 {
-	if (flags & TPM_TRANSMIT_NESTED)
-		return 0;
-
 	if (!chip->ops->go_idle)
 		return 0;
 
@@ -166,11 +154,17 @@ int tpm_try_get_ops(struct tpm_chip *chip)
 
 	down_read(&chip->ops_sem);
 	if (!chip->ops)
-		goto out_lock;
+		goto out_ops;
 
 	mutex_lock(&chip->tpm_mutex);
+	rc = tpm_chip_start(chip, 0);
+	if (rc)
+		goto out_lock;
+
 	return 0;
 out_lock:
+	mutex_unlock(&chip->tpm_mutex);
+out_ops:
 	up_read(&chip->ops_sem);
 	put_device(&chip->dev);
 	return rc;
@@ -186,6 +180,7 @@ EXPORT_SYMBOL_GPL(tpm_try_get_ops);
  */
 void tpm_put_ops(struct tpm_chip *chip)
 {
+	tpm_chip_stop(chip, 0);
 	mutex_unlock(&chip->tpm_mutex);
 	up_read(&chip->ops_sem);
 	put_device(&chip->dev);
@@ -563,7 +558,11 @@ int tpm_chip_register(struct tpm_chip *chip)
 {
 	int rc;
 
+	rc = tpm_chip_start(chip, 0);
+	if (rc)
+		return rc;
 	rc = tpm_auto_startup(chip);
+	tpm_chip_stop(chip, 0);
 	if (rc)
 		return rc;
 
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index f7b7e4e75fcf..f20c78055731 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -168,13 +168,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
 	memcpy(save, buf, save_size);
 
 	for (;;) {
-		ret = tpm_chip_start(chip, flags);
-		if (ret)
-			return ret;
-
 		ret = tpm_try_transmit(chip, buf, bufsiz, flags);
-
-		tpm_chip_stop(chip, flags);
 		if (ret < 0)
 			break;
 		rc = be32_to_cpu(header->return_code);
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 2d6d934f1c8b..53e4208759ee 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -485,15 +485,6 @@ extern const struct file_operations tpm_fops;
 extern const struct file_operations tpmrm_fops;
 extern struct idr dev_nums_idr;
 
-/**
- * enum tpm_transmit_flags - flags for tpm_transmit()
- *
- * %TPM_TRANSMIT_NESTED:	discard setup steps (power management, locality)
- */
-enum tpm_transmit_flags {
-	TPM_TRANSMIT_NESTED      = BIT(0),
-};
-
 ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
 		     unsigned int flags);
 ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 9c9ccf2c0681..6c6ad2d4d31b 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -60,7 +60,10 @@ int tpm2_init_space(struct tpm_space *space)
 void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
 {
 	mutex_lock(&chip->tpm_mutex);
-	tpm2_flush_sessions(chip, space);
+	if (!tpm_chip_start(chip, 0)) {
+		tpm2_flush_sessions(chip, space);
+		tpm_chip_stop(chip, 0);
+	}
 	mutex_unlock(&chip->tpm_mutex);
 	kfree(space->context_buf);
 	kfree(space->session_buf);
diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index e8a1da2810a9..a4bb60e163cc 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -417,8 +417,7 @@ static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
 
 	proxy_dev->state |= STATE_DRIVER_COMMAND;
 
-	rc = tpm_transmit_cmd(chip, &buf, 0, TPM_TRANSMIT_NESTED,
-			      "attempting to set locality");
+	rc = tpm_transmit_cmd(chip, &buf, 0, 0, "attempting to set locality");
 
 	proxy_dev->state &= ~STATE_DRIVER_COMMAND;
 
-- 
2.19.1

