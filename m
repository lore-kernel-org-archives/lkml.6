Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10A5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824E3214F1
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824E3214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbeKNEiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:38:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:32878 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbeKNEiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:38:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 10:38:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,229,1539673200"; 
   d="scan'208";a="107949158"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.77])
  by orsmga001.jf.intel.com with ESMTP; 13 Nov 2018 10:38:45 -0800
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
Subject: [PATCH v7 16/17] tpm: take TPM chip power gating out of tpm_transmit()
Date:   Tue, 13 Nov 2018 20:36:15 +0200
Message-Id: <20181113183620.27447-17-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113183620.27447-1-jarkko.sakkinen@linux.intel.com>
References: <20181113183620.27447-1-jarkko.sakkinen@linux.intel.com>
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
---
 drivers/char/tpm/tpm-chip.c       | 19 ++++++-------------
 drivers/char/tpm/tpm-interface.c  |  4 ----
 drivers/char/tpm/tpm.h            |  9 ---------
 drivers/char/tpm/tpm2-space.c     |  5 ++++-
 drivers/char/tpm/tpm_vtpm_proxy.c |  3 +--
 5 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 65f1561eba81..87570182f75e 100644
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
 
@@ -169,7 +157,7 @@ int tpm_try_get_ops(struct tpm_chip *chip)
 		goto out_lock;
 
 	mutex_lock(&chip->tpm_mutex);
-	return 0;
+	return tpm_chip_start(chip, 0);
 out_lock:
 	up_read(&chip->ops_sem);
 	put_device(&chip->dev);
@@ -186,6 +174,7 @@ EXPORT_SYMBOL_GPL(tpm_try_get_ops);
  */
 void tpm_put_ops(struct tpm_chip *chip)
 {
+	tpm_chip_stop(chip, 0);
 	mutex_unlock(&chip->tpm_mutex);
 	up_read(&chip->ops_sem);
 	put_device(&chip->dev);
@@ -563,7 +552,11 @@ int tpm_chip_register(struct tpm_chip *chip)
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
index 888c9923fca1..5c04c0d9aaba 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -168,11 +168,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
 	memcpy(save, buf, save_size);
 
 	for (;;) {
-		ret = tpm_chip_start(chip, flags);
-		if (ret)
-			return ret;
 		ret = tpm_try_transmit(chip, buf, bufsiz, flags);
-		tpm_chip_stop(chip, flags);
 
 		rc = be32_to_cpu(header->return_code);
 		if (rc != TPM2_RC_RETRY && rc != TPM2_RC_TESTING)
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index c42a75710b70..f9d56dfd0d20 100644
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
index ced1dc91ba6f..d913715d30aa 100644
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

