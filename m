Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD95AC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B0127EF2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B0127EF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755474AbeF2Mbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 08:31:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:45633 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752301AbeF2Mbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 08:31:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 05:31:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,285,1526367600"; 
   d="scan'208";a="68776490"
Received: from tmuluk-mobl4.ger.corp.intel.com (HELO localhost) ([10.249.254.88])
  by orsmga001.jf.intel.com with ESMTP; 29 Jun 2018 05:31:43 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tpm: replace TPM_TRANSMIT_RAW with TPM_TRANSMIT_NESTED
Date:   Fri, 29 Jun 2018 15:31:37 +0300
Message-Id: <20180629123138.21918-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As TPM_TRANSMIT_RAW always requires also not to take locks for obvious
reasons (deadlock), this commit renames the flag as TPM_TRANSMIT_NESTED
and prevents taking tpm_mutex when the flag is given to tpm_transmit().

Suggested-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm-interface.c  | 13 ++++++-------
 drivers/char/tpm/tpm.h            | 14 +++++++-------
 drivers/char/tpm/tpm2-space.c     | 16 ++++++----------
 drivers/char/tpm/tpm_vtpm_proxy.c |  2 +-
 4 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index ad761e629a0f..1a803b0cf980 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -372,7 +372,7 @@ static int tpm_request_locality(struct tpm_chip *chip, unsigned int flags)
 {
 	int rc;
 
-	if (flags & TPM_TRANSMIT_RAW)
+	if (flags & TPM_TRANSMIT_NESTED)
 		return 0;
 
 	if (!chip->ops->request_locality)
@@ -391,7 +391,7 @@ static void tpm_relinquish_locality(struct tpm_chip *chip, unsigned int flags)
 {
 	int rc;
 
-	if (flags & TPM_TRANSMIT_RAW)
+	if (flags & TPM_TRANSMIT_NESTED)
 		return;
 
 	if (!chip->ops->relinquish_locality)
@@ -406,7 +406,7 @@ static void tpm_relinquish_locality(struct tpm_chip *chip, unsigned int flags)
 
 static int tpm_cmd_ready(struct tpm_chip *chip, unsigned int flags)
 {
-	if (flags & TPM_TRANSMIT_RAW)
+	if (flags & TPM_TRANSMIT_NESTED)
 		return 0;
 
 	if (!chip->ops->cmd_ready)
@@ -417,7 +417,7 @@ static int tpm_cmd_ready(struct tpm_chip *chip, unsigned int flags)
 
 static int tpm_go_idle(struct tpm_chip *chip, unsigned int flags)
 {
-	if (flags & TPM_TRANSMIT_RAW)
+	if (flags & TPM_TRANSMIT_NESTED)
 		return 0;
 
 	if (!chip->ops->go_idle)
@@ -466,10 +466,9 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 		return -E2BIG;
 	}
 
-	if (!(flags & TPM_TRANSMIT_UNLOCKED))
+	if (!(flags & TPM_TRANSMIT_UNLOCKED) && !(flags & TPM_TRANSMIT_NESTED))
 		mutex_lock(&chip->tpm_mutex);
 
-
 	if (chip->ops->clk_enable != NULL)
 		chip->ops->clk_enable(chip, true);
 
@@ -559,7 +558,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 	if (chip->ops->clk_enable != NULL)
 		chip->ops->clk_enable(chip, false);
 
-	if (!(flags & TPM_TRANSMIT_UNLOCKED))
+	if (!(flags & TPM_TRANSMIT_UNLOCKED) && !(flags & TPM_TRANSMIT_NESTED))
 		mutex_unlock(&chip->tpm_mutex);
 	return rc ? rc : len;
 }
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index ba01488cd029..f3501d05264f 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -513,16 +513,16 @@ extern const struct file_operations tpmrm_fops;
 extern struct idr dev_nums_idr;
 
 /**
- * enum tpm_transmit_flags
+ * enum tpm_transmit_flags - flags for tpm_transmit()
  *
- * @TPM_TRANSMIT_UNLOCKED: used to lock sequence of tpm_transmit calls.
- * @TPM_TRANSMIT_RAW: prevent recursive calls into setup steps
- *                    (go idle, locality,..). Always use with UNLOCKED
- *                    as it will fail on double locking.
+ * @TPM_TRANSMIT_UNLOCKED:	do not lock the chip
+ * @TPM_TRANSMIT_NESTED:	discard setup steps (power management,
+ *				locality) including locking (i.e. implicit
+ *				UNLOCKED)
  */
 enum tpm_transmit_flags {
-	TPM_TRANSMIT_UNLOCKED = BIT(0),
-	TPM_TRANSMIT_RAW      = BIT(1),
+	TPM_TRANSMIT_UNLOCKED	= BIT(0),
+	TPM_TRANSMIT_NESTED      = BIT(1),
 };
 
 ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 11c85ed8c113..d2e101b32482 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -39,8 +39,7 @@ static void tpm2_flush_sessions(struct tpm_chip *chip, struct tpm_space *space)
 	for (i = 0; i < ARRAY_SIZE(space->session_tbl); i++) {
 		if (space->session_tbl[i])
 			tpm2_flush_context_cmd(chip, space->session_tbl[i],
-					       TPM_TRANSMIT_UNLOCKED |
-					       TPM_TRANSMIT_RAW);
+					       TPM_TRANSMIT_NESTED);
 	}
 }
 
@@ -85,7 +84,7 @@ static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
 	tpm_buf_append(&tbuf, &buf[*offset], body_size);
 
 	rc = tpm_transmit_cmd(chip, NULL, tbuf.data, PAGE_SIZE, 4,
-			      TPM_TRANSMIT_UNLOCKED | TPM_TRANSMIT_RAW, NULL);
+			      TPM_TRANSMIT_NESTED, NULL);
 	if (rc < 0) {
 		dev_warn(&chip->dev, "%s: failed with a system error %d\n",
 			 __func__, rc);
@@ -134,7 +133,7 @@ static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
 	tpm_buf_append_u32(&tbuf, handle);
 
 	rc = tpm_transmit_cmd(chip, NULL, tbuf.data, PAGE_SIZE, 0,
-			      TPM_TRANSMIT_UNLOCKED | TPM_TRANSMIT_RAW, NULL);
+			      TPM_TRANSMIT_NESTED, NULL);
 	if (rc < 0) {
 		dev_warn(&chip->dev, "%s: failed with a system error %d\n",
 			 __func__, rc);
@@ -171,8 +170,7 @@ static void tpm2_flush_space(struct tpm_chip *chip)
 	for (i = 0; i < ARRAY_SIZE(space->context_tbl); i++)
 		if (space->context_tbl[i] && ~space->context_tbl[i])
 			tpm2_flush_context_cmd(chip, space->context_tbl[i],
-					       TPM_TRANSMIT_UNLOCKED |
-					       TPM_TRANSMIT_RAW);
+					       TPM_TRANSMIT_NESTED);
 
 	tpm2_flush_sessions(chip, space);
 }
@@ -379,8 +377,7 @@ static int tpm2_map_response_header(struct tpm_chip *chip, u32 cc, u8 *rsp,
 
 	return 0;
 out_no_slots:
-	tpm2_flush_context_cmd(chip, phandle,
-			       TPM_TRANSMIT_UNLOCKED | TPM_TRANSMIT_RAW);
+	tpm2_flush_context_cmd(chip, phandle, TPM_TRANSMIT_NESTED);
 	dev_warn(&chip->dev, "%s: out of slots for 0x%08X\n", __func__,
 		 phandle);
 	return -ENOMEM;
@@ -468,8 +465,7 @@ static int tpm2_save_space(struct tpm_chip *chip)
 			return rc;
 
 		tpm2_flush_context_cmd(chip, space->context_tbl[i],
-				       TPM_TRANSMIT_UNLOCKED |
-				       TPM_TRANSMIT_RAW);
+				       TPM_TRANSMIT_NESTED);
 		space->context_tbl[i] = ~0;
 	}
 
diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index e4f79f920450..87a0ce47f201 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -418,7 +418,7 @@ static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
 	proxy_dev->state |= STATE_DRIVER_COMMAND;
 
 	rc = tpm_transmit_cmd(chip, NULL, buf.data, tpm_buf_length(&buf), 0,
-			      TPM_TRANSMIT_UNLOCKED | TPM_TRANSMIT_RAW,
+			      TPM_TRANSMIT_NESTED,
 			      "attempting to set locality");
 
 	proxy_dev->state &= ~STATE_DRIVER_COMMAND;
-- 
2.17.0

