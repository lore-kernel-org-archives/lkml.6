Return-Path: <jarkko.sakkinen@intel.com>
X-Google-Smtp-Source: AG47ELvbcXERGegDMOByHboXHi9HpKcVM/bhKwBeOJRzjxbbCWto7pBlwtuhgK40nkSZtcfi5Iqo
ARC-Seal: i=1; a=rsa-sha256; t=1520260773; cv=none;
        d=google.com; s=arc-20160816;
        b=ZeVy3NTkxFmhuj6VxOnC9mqCVIpeNpxBWthfZ6IgC2/+G4eJy4DdFMdf3/pKnARw2P
         j6qzSrZ1IwHNzv/OKweIBYn8E/SeEF6oNHebmg/u9lOs/5fOS5BJ1pwo4SYb+OOMqWxF
         MIAfadBd/S2Ym2SaCUdV0ERNtwyoX4BENDoDTjRhizIrU+gCpkeTmiH0ShnkqUepVXyh
         VGnZI4TcKwz6A1yvliOadxsE/wRRAi+A0riY1OsMn44+jVnzzNKFZQTxypQ6YVVcPenK
         scIOx1mrJbT+HIguQyenvBEhICdklPNdrfvkdT3etlNSZIWhP6NU6e204Zkp/958e5NW
         0kUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=+fB81EE9JxImM6dOXbEdZ2bOrn5Uo7mX3koYNB/YhOU=;
        b=M0aKReEp1IpJoQwZBjbMlcNU9YsLzkeqRIWnpiBLrhsaeCAoBfZk5H69eWb6wHzPHZ
         33ABUY6xvJXOqmG+8uU1VZKyRkeYu9KaLSPYlkQgH5mMBx5r6/r5JUY9HnKHaFfzuT72
         hN5p9JOCsrT2Qe6RKQ+t2RGhFG95MHtCkO4vQjvrnx0QiuPfW+Un49K1h2YoBvRacpoL
         Zo1QtZrDvzzFLqqQx9K5dQGAB5fHFyoJJUlIIT/fc1RAJiSvPtB3DmA02coCOR0qJ3mQ
         aMrDnruoAa4uhDRFBAolrQsGsoC2hfh3izpo00hAE5IjbA8gWFc1cDag3LB5b/2xDefg
         OSDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jarkko.sakkinen@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=jarkko.sakkinen@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jarkko.sakkinen@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=jarkko.sakkinen@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="39325827"
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
Subject: [PATCH v2 3/5] tpm: migrate tpm2_probe() to use struct tpm_buf
Date: Mon,  5 Mar 2018 16:39:01 +0200
Message-Id: <20180305143904.7477-4-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180305143904.7477-1-jarkko.sakkinen@linux.intel.com>
References: <20180305143904.7477-1-jarkko.sakkinen@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676067717266056?=
X-GMAIL-MSGID: =?utf-8?q?1594108960939561757?=
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
