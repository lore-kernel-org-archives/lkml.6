Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751280AbeBINSl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 08:18:41 -0500
Received: from mga14.intel.com ([192.55.52.115]:1704 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750997AbeBINSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 08:18:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,483,1511856000";
   d="scan'208";a="29475600"
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tpm: migrate tpm2_do_selftest() to use struct tpm_buf
Date: Fri,  9 Feb 2018 15:18:20 +0200
Message-Id: <20180209131820.23718-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of an ongoing effort to encapsulate TPM commands to struct
tpm_buf instead of using clunky union of structs, migrated
tpm2_do_selft_test() to use struct tpm_buf.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
I wish this would be included as part of patch set that fixes the timing
issue.
 drivers/char/tpm/tpm2-cmd.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index c17e75348a99..a91a2c6f03a7 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -31,10 +31,6 @@ struct tpm2_startup_in {
 	__be16	startup_type;
 } __packed;
 
-struct tpm2_self_test_in {
-	u8	full_test;
-} __packed;
-
 struct tpm2_get_tpm_pt_in {
 	__be32	cap_id;
 	__be32	property_id;
@@ -60,7 +56,6 @@ struct tpm2_get_random_out {
 
 union tpm2_cmd_params {
 	struct	tpm2_startup_in		startup_in;
-	struct	tpm2_self_test_in	selftest_in;
 	struct	tpm2_get_tpm_pt_in	get_tpm_pt_in;
 	struct	tpm2_get_tpm_pt_out	get_tpm_pt_out;
 	struct	tpm2_get_random_in	getrandom_in;
@@ -823,16 +818,6 @@ unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 }
 EXPORT_SYMBOL_GPL(tpm2_calc_ordinal_duration);
 
-#define TPM2_SELF_TEST_IN_SIZE \
-	(sizeof(struct tpm_input_header) + \
-	 sizeof(struct tpm2_self_test_in))
-
-static const struct tpm_input_header tpm2_selftest_header = {
-	.tag = cpu_to_be16(TPM2_ST_NO_SESSIONS),
-	.length = cpu_to_be32(TPM2_SELF_TEST_IN_SIZE),
-	.ordinal = cpu_to_be32(TPM2_CC_SELF_TEST)
-};
-
 /**
  * tpm2_do_selftest() - ensure that all self tests have passed
  *
@@ -851,18 +836,21 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
 	int rc;
 	unsigned int delay_msec = 10;
 	long duration;
-	struct tpm2_cmd cmd;
+	struct tpm_buf buf;
 
 	duration = jiffies_to_msecs(
 		tpm2_calc_ordinal_duration(chip, TPM2_CC_SELF_TEST));
 
-	while (1) {
-		cmd.header.in = tpm2_selftest_header;
-		cmd.params.selftest_in.full_test = 0;
-
-		rc = tpm_transmit_cmd(chip, NULL, &cmd, TPM2_SELF_TEST_IN_SIZE,
-				      0, 0, "continue selftest");
+	for (;;) {
+		rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SELF_TEST);
+		if (rc)
+			return rc;
 
+		/* Perform tests in the background. */
+		tpm_buf_append_u8(&buf, 0);
+		rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
+				      "continue selftest");
+		tpm_buf_destroy(&buf);
 		if (rc != TPM2_RC_TESTING || delay_msec >= duration)
 			break;
 
-- 
2.14.1
