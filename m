Return-Path: <jarkko.sakkinen@intel.com>
X-Google-Smtp-Source: AH8x224hIaeys57A8mhDhkpMILMqBKvTOa4+Nb9KMWc4lzOC8MkYLRRIAw2dE2mm0sdiy5Ox+bJ3
ARC-Seal: i=1; a=rsa-sha256; t=1519847934; cv=none;
        d=google.com; s=arc-20160816;
        b=jtpvMla2hthAtfyYKqTEA6A6yAPmcka79O1VhWR1VJCzcEuUthL5Lql9Fhc8ejFEuV
         /evYhiT+penhrwR9s+s2Y2StFcfsNDIgkUQ6f0zJDSKKGlNIlhKRIEyMmvvkgkauq+Bv
         CsJQqwISFGpxG5b2N0BPnG5QoEN42CgyFwFs88NL5aN3tuyLbPmRW/pvDqkUMeIUq0W2
         k9IBq14wZpRCUQfZe5nbX3ESsnmcF5P1T7KLA5Rg+oq65h6FhCiRMEhMHBRU3UChSuvL
         xv/Zt1hfn1Z4s/1RizXogLFvQ3hmwSZkYg9oxTnsVsX8jasWXxNazoOLijIVJ/YJdwMU
         GldQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=ndpb/z81UVaNKVG4j6iD6Ky2WcQr9/0Nkl6PnAV7xlY=;
        b=m+lrmTXz6rxTwsvusSfZHvUL9BnawjFpVs0lNOzvnm+LyBw0JQcYz47kvt0I1YO49e
         naWAZNJMAbYCNaXQ/gjZbixi7lT1whg8j8v19hsWWYG0fujMIGFuBLE2ot4doroJRxa9
         tj56D35Md8hwlAwTUx2cLuMY46LJ9UNarL1hqhaR0n+9sr9mDDbCevF4MK0/0TcC7rbQ
         jxc7xiucu9BAR9mc75AVqmcY+UxmicWe90rsdxXIPnJoVDPo41PKtLn8W7ScmAXH9Kxh
         iA4QRNRZAn+/xA5wi5bWvGTRTglhc2Rb46cRkDmgdc56ZrQVMw7lVfS9uYavNDYZCUW5
         JzEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jarkko.sakkinen@intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jarkko.sakkinen@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jarkko.sakkinen@intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jarkko.sakkinen@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,406,1515484800";
   d="scan'208";a="20929734"
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
Subject: [PATCH 3/5] tpm: migrate tpm2_probe() to use struct tpm_buf
Date: Wed, 28 Feb 2018 21:58:16 +0200
Message-Id: <20180228195819.22231-4-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180228195819.22231-1-jarkko.sakkinen@linux.intel.com>
References: <20180228195819.22231-1-jarkko.sakkinen@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676067717266056?=
X-GMAIL-MSGID: =?utf-8?q?1593676067717266056?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In order to make struct tpm_buf the first class object for constructing TPM
commands, migrate tpm2_probe() to use it.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm2-cmd.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 5f92141b1e16..36f6b0ac412b 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -856,19 +856,22 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
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
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
+	if (rc)
+		return rc;
+	tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
+	tpm_buf_append_u32(&buf, TPM_PT_TOTAL_COMMANDS);
+	tpm_buf_append_u32(&buf, 1);
+	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0, NULL);
+	tpm_buf_destroy(&buf);
 	if (rc <  0)
 		return rc;
-
-	if (be16_to_cpu(cmd.header.out.tag) == TPM2_ST_NO_SESSIONS)
+	out = (struct tpm_output_header *)buf.data;
+	if (be16_to_cpu(out->tag) == TPM2_ST_NO_SESSIONS)
 		chip->flags |= TPM_CHIP_FLAG_TPM2;
 
 	return 0;
-- 
2.15.1
