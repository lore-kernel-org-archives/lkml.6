Return-Path: <jarkko.sakkinen@intel.com>
X-Google-Smtp-Source: AG47ELuapCZ7qE2CLyJ3XZUAZpa7FiSq3aJneYpLiixPNnC5DuD9az5eIxFgH8G2vhQEVKce1p1Y
ARC-Seal: i=1; a=rsa-sha256; t=1520268997; cv=none;
        d=google.com; s=arc-20160816;
        b=h0FJ0RfIGAD7/9/D9gVctbiQE5QRWzksporAyEKhFGpET4brQq0T+lWheRp0mOFxxU
         eAqage2TfeJluH725r+ofkNJZipNpzdxmSCgfZkALcz3WJq+GcrOk881rUoioDJm6nbg
         1JOgQwkBcjDrF3poaxNoqY/Flz7mdq9G5w1Ruv1TiiEImEYMBL1TWDGZoYhWp9va2UQt
         lUGNVC8qMGsQPCI1i7eY/3UBpwcj3PpL5rDeLVN/ijG6LSQ5w7SUGA4gUHtjbuEhd6rD
         PyQaRqEAXDLZWoY0wTRc8fqLXSAeyQ6L/N1q40Rd7E1qkKstiFRnl3D/teUjWQv643Sr
         IoqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=+fB81EE9JxImM6dOXbEdZ2bOrn5Uo7mX3koYNB/YhOU=;
        b=KfaiVHYZn4sXuPFMujX3j/w4NvyUW5kvRAJA+ZvcXwObzwgSUfKLQHGTaHZ+Mzh0KZ
         RoofZEY3HQ3VqlMNRdJDbzUgSZzdI1xmkq+tl5bJtGKf2v02GQlW5CVbP6FAtxvK3yw6
         4uhbugvHyP6IevA+/+dEGq6icze9gH3ga5fQPlQQAS2A7n0se4HcQPv33Kgq3viNcyzY
         zZLZJx+eyrUCFqmZ3XHcDLGi4z/n4U6l5SjguMtu2+Tscdwy6O5VRKDx8g21Tm9Lpkzk
         N4jVywm40ZTrNJ90viHkB1W6lo8CGkefB4PmwRYNlGvnHO5vY2aS6lsVRkmnSGw2zet7
         DqJg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jarkko.sakkinen@intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=jarkko.sakkinen@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jarkko.sakkinen@intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=jarkko.sakkinen@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="35627937"
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
	keyrings@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 3/5] tpm: migrate tpm2_probe() to use struct tpm_buf
Date: Mon,  5 Mar 2018 18:56:12 +0200
Message-Id: <20180305165614.5469-4-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
References: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676067717266056?=
X-GMAIL-MSGID: =?utf-8?q?1594117584823197042?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In order to make struct tpm_buf the first class object for constructing TPM
commands, migrate tpm2_probe() to use it.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm2-cmd.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index abe6ef4a7a0b..890d83c5c78b 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -851,22 +851,25 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
  */
 int tpm2_probe(struct tpm_chip *chip)
 {
-	struct tpm2_cmd cmd;
+	struct tpm_output_header *out;
+	struct tpm_buf buf;
 	int rc;
 
-	cmd.header.in = tpm2_get_tpm_pt_header;
-	cmd.params.get_tpm_pt_in.cap_id = cpu_to_be32(TPM2_CAP_TPM_PROPERTIES);
-	cmd.params.get_tpm_pt_in.property_id = cpu_to_be32(0x100);
-	cmd.params.get_tpm_pt_in.property_cnt = cpu_to_be32(1);
-
-	rc = tpm_transmit_cmd(chip, NULL, &cmd, sizeof(cmd), 0, 0, NULL);
-	if (rc <  0)
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
+	if (rc)
 		return rc;
-
-	if (be16_to_cpu(cmd.header.out.tag) == TPM2_ST_NO_SESSIONS)
+	tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
+	tpm_buf_append_u32(&buf, TPM_PT_TOTAL_COMMANDS);
+	tpm_buf_append_u32(&buf, 1);
+	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0, NULL);
+	if (rc <  0)
+		goto out;
+	out = (struct tpm_output_header *)buf.data;
+	if (be16_to_cpu(out->tag) == TPM2_ST_NO_SESSIONS)
 		chip->flags |= TPM_CHIP_FLAG_TPM2;
-
-	return 0;
+out:
+	tpm_buf_destroy(&buf);
+	return rc;
 }
 EXPORT_SYMBOL_GPL(tpm2_probe);
 
-- 
2.15.1
