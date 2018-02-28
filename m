Return-Path: <jarkko.sakkinen@intel.com>
X-Google-Smtp-Source: AG47ELukWOE0B5uPns7AboLAcqPi70XKq8Q8QTtTnED4irkro/pUOd5aAIpbv3sGKDyb56ajZcWc
ARC-Seal: i=1; a=rsa-sha256; t=1519847920; cv=none;
        d=google.com; s=arc-20160816;
        b=USY20qV5Yp/FICW+MzWNRqxekgrLTKzaGnOTZScQxKre+2aMHO9X1E3Ae+LDzt5fby
         tzueP/pOOiKpjBSUKbncKqa30QymcUaPIUq7vyu6BNMuPYG+r+thZPLpQSs+SbApsX9t
         +oRSzUvj28fZiqWAkHo22SRPjwvBWMZrWSTxW+B92xAkrT51hdQ5ig278wNDMfqyz9pH
         u2pCEpmmGdjpfNfaOS7FbbZ2jgNECEdlxKdFx+sJCMBIveXpIeB6EVMWMlVg4HvkReNu
         8niZqe1vcvCKiKpkKMji8rElK32RWpiLWjDEkmEafxMQLvkKqMgoNmhXw+NV1Ze7W9Zt
         mS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=7Uklir2OySBUOJP1VATQSC2tbJ5rDYKnr2O8gDCDH8k=;
        b=hy6Z8bitK4C2+t7J8uiYlCT+qgCb6BfkCw9zkYwXdHI3Q7X3FrV5oAjPzrP4X0C5VI
         BeBJQ7CZLYHMrw0ml6qqfMW2uj1CEt9IGVRuNQJfl3qeJrzzw3Oy1zuk1cg3rNKE7P4Q
         TaLtOkuAxCb1z6TCA0ew0EdNrD5l9xwAs4xO4hIVlSz6DR2GC134ZMECbFq7XxbUtOWe
         crYPB4vpVz/Wk/2xrooZ+esumliPDIwYiQvIBCWcGRAGNM00erdonH8aXj/xeEi1Nznv
         V+sCIQRzzonnGmlUxRHUMlbiouGf1px5+xb6ru+HRurXxD7oboe7/kQEMwbbXOxEkYvV
         dKLw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jarkko.sakkinen@intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=jarkko.sakkinen@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jarkko.sakkinen@intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=jarkko.sakkinen@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,406,1515484800";
   d="scan'208";a="20929683"
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
	keyrings@vger.kernel.org,
	Alexander Steffen <Alexander.Steffen@infineon.com>,
	stable@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/5] tpm: Trigger only missing TPM 2.0 self tests
Date: Wed, 28 Feb 2018 21:58:14 +0200
Message-Id: <20180228195819.22231-2-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180228195819.22231-1-jarkko.sakkinen@linux.intel.com>
References: <20180228195819.22231-1-jarkko.sakkinen@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676052985435467?=
X-GMAIL-MSGID: =?utf-8?q?1593676052985435467?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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

Fixes: 2482b1bba5122 ("tpm: Trigger only missing TPM 2.0 self tests")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>
---
 drivers/char/tpm/tpm-interface.c | 20 ++++++++++++---
 drivers/char/tpm/tpm.h           |  1 +
 drivers/char/tpm/tpm2-cmd.c      | 54 ++++++++++++----------------------------
 3 files changed, 33 insertions(+), 42 deletions(-)

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
index a700f8f9ead7..6eeff3a60003 100644
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
@@ -852,27 +837,24 @@ static const struct tpm_input_header tpm2_selftest_header = {
  */
 static int tpm2_do_selftest(struct tpm_chip *chip)
 {
+	struct tpm_buf buf;
+	int full;
 	int rc;
-	unsigned int delay_msec = 10;
-	long duration;
-	struct tpm2_cmd cmd;
 
-	duration = jiffies_to_msecs(
-		tpm2_calc_ordinal_duration(chip, TPM2_CC_SELF_TEST));
-
-	while (1) {
-		cmd.header.in = tpm2_selftest_header;
-		cmd.params.selftest_in.full_test = 0;
-
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
 
 	return rc;
@@ -1058,10 +1040,8 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 		goto out;
 
 	rc = tpm2_do_selftest(chip);
-	if (rc != 0 && rc != TPM2_RC_INITIALIZE) {
-		dev_err(&chip->dev, "TPM self test failed\n");
+	if (rc && rc != TPM2_RC_INITIALIZE)
 		goto out;
-	}
 
 	if (rc == TPM2_RC_INITIALIZE) {
 		rc = tpm_startup(chip);
@@ -1069,10 +1049,8 @@ int tpm2_auto_startup(struct tpm_chip *chip)
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
2.15.1
