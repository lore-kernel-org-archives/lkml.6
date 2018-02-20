Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbeBTWyF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 17:54:05 -0500
Received: from mga03.intel.com ([134.134.136.65]:5788 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751053AbeBTWyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 17:54:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,541,1511856000";
   d="scan'208";a="32882854"
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4] tpm: Trigger only missing TPM 2.0 self tests
Date: Wed, 21 Feb 2018 00:53:47 +0200
Message-Id: <20180220225347.25448-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Steffen <Alexander.Steffen@infineon.com>

My Nuvoton 6xx in a Dell XPS-13 has been intermittently failing to work
(necessitating a reboot). The problem seems to be that the TPM gets into a
state where the partial self-test doesn't return TPM_RC_SUCCESS (meaning
all tests have run to completion), but instead returns TPM_RC_TESTING
(meaning some tests are still running in the background).  There are
various theories that resending the self-test command actually causes the
tests to restart and thus triggers more TPM_RC_TESTING returns until the
timeout is exceeded.

There are several issues here: firstly being we shouldn't slow down the
boot sequence waiting for the self test to complete once the TPM
backgrounds them.  It will actually make available all functions that have
passed and if it gets a failure return TPM_RC_FAILURE to every subsequent
command.  So the fix is to kick off self tests once and if they return
TPM_RC_TESTING log that as a backgrounded self test and continue on.  In
order to prevent other tpm users from seeing any TPM_RC_TESTING returns
(which it might if they send a command that needs a TPM subsystem which is
still under test), we loop in tpm_transmit_cmd until either a timeout or we
don't get a TPM_RC_TESTING return.

Finally, there have been observations of strange returns from a partial
test. One Nuvoton is occasionally returning TPM_RC_COMMAND_CODE, so treat
any unexpected return from a partial self test as an indication we need to
run a full self test.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>
Fixes: 2482b1bba5122b1d5516c909832bdd282015b8e9
---
v4: Some updatees from jarkko.sakkinen@linux.intel.com:
    - squashed tpm_buf migration
    - cleaned up a bunch of clutter from the original patch
v3: - must pass through TPM2_RC_INTIALIZE
v2: - review feedback: encapsulate transmission and rename NOWAIT constant
    - Rewrite selftest routine to run full test on any unexpected
      (meaning not TPM2_RC_TESTING, TPM2_RC_SUCCESS or
      TPM2_RC_FAILURE) from the partial selftest.
 drivers/char/tpm/tpm-interface.c | 20 ++++++++++++---
 drivers/char/tpm/tpm.h           |  1 +
 drivers/char/tpm/tpm2-cmd.c      | 55 +++++++++++++---------------------------
 3 files changed, 34 insertions(+), 42 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 9e80a953d693..1adb976a2e37 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -537,14 +537,26 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
 			 const char *desc)
 {
 	const struct tpm_output_header *header = buf;
+	unsigned int delay_msec = TPM2_DURATION_SHORT;
 	int err;
 	ssize_t len;
 
-	len = tpm_transmit(chip, space, (u8 *)buf, bufsiz, flags);
-	if (len <  0)
-		return len;
+	for (;;) {
+		len = tpm_transmit(chip, space, (u8 *)buf, bufsiz, flags);
+		if (len <  0)
+			return len;
+		err = be32_to_cpu(header->return_code);
+		if (err != TPM2_RC_TESTING)
+			break;
+
+		delay_msec *= 2;
+		if (delay_msec > TPM2_DURATION_LONG) {
+			dev_err(&chip->dev, "the self test is still running\n");
+			break;
+		}
+		tpm_msleep(delay_msec);
+	}
 
-	err = be32_to_cpu(header->return_code);
 	if (err != 0 && desc)
 		dev_err(&chip->dev, "A TPM error (%d) occurred %s\n", err,
 			desc);
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index f895fba4e20d..cccd5994a0e1 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -104,6 +104,7 @@ enum tpm2_return_codes {
 	TPM2_RC_HASH		= 0x0083, /* RC_FMT1 */
 	TPM2_RC_HANDLE		= 0x008B,
 	TPM2_RC_INITIALIZE	= 0x0100, /* RC_VER1 */
+	TPM2_RC_FAILURE		= 0x0101,
 	TPM2_RC_DISABLED	= 0x0120,
 	TPM2_RC_COMMAND_CODE    = 0x0143,
 	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index a700f8f9ead7..3b24311918d5 100644
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
@@ -827,16 +822,6 @@ unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
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
@@ -853,28 +838,26 @@ static const struct tpm_input_header tpm2_selftest_header = {
 static int tpm2_do_selftest(struct tpm_chip *chip)
 {
 	int rc;
-	unsigned int delay_msec = 10;
-	long duration;
-	struct tpm2_cmd cmd;
-
-	duration = jiffies_to_msecs(
-		tpm2_calc_ordinal_duration(chip, TPM2_CC_SELF_TEST));
-
-	while (1) {
-		cmd.header.in = tpm2_selftest_header;
-		cmd.params.selftest_in.full_test = 0;
+	struct tpm_buf buf;
+	int full;
 
-		rc = tpm_transmit_cmd(chip, NULL, &cmd, TPM2_SELF_TEST_IN_SIZE,
-				      0, 0, "continue selftest");
+	for (full = 0; full < 2; full++) {
+		rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SELF_TEST);
+		if (rc)
+			return rc;
 
-		if (rc != TPM2_RC_TESTING || delay_msec >= duration)
-			break;
+		tpm_buf_append_u8(&buf, full);
+		rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
+				      "attempting the self test\n");
+		tpm_buf_destroy(&buf);
 
-		/* wait longer than before */
-		delay_msec *= 2;
-		tpm_msleep(delay_msec);
+		if (rc == TPM2_RC_TESTING)
+			rc = TPM2_RC_SUCCESS;
+		if (rc == TPM2_RC_INITIALIZE || rc == TPM2_RC_SUCCESS)
+			return rc;
 	}
 
+	dev_err(&chip->dev, "the self test failed, fullTest=%d\n", full);
 	return rc;
 }
 
@@ -1058,10 +1041,8 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 		goto out;
 
 	rc = tpm2_do_selftest(chip);
-	if (rc != 0 && rc != TPM2_RC_INITIALIZE) {
-		dev_err(&chip->dev, "TPM self test failed\n");
+	if (rc && rc != TPM2_RC_INITIALIZE)
 		goto out;
-	}
 
 	if (rc == TPM2_RC_INITIALIZE) {
 		rc = tpm_startup(chip);
@@ -1069,10 +1050,8 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 			goto out;
 
 		rc = tpm2_do_selftest(chip);
-		if (rc) {
-			dev_err(&chip->dev, "TPM self test failed\n");
+		if (rc)
 			goto out;
-		}
 	}
 
 	rc = tpm2_get_pcr_allocation(chip);
-- 
2.14.1
