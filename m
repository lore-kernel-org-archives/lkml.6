Return-Path: <jarkko.sakkinen@intel.com>
X-Google-Smtp-Source: AG47ELubaG9xZXwKH6jCMTB2Hja6k9hh9ey3rMDlCQU1W5m0W/ZkuX7/BK2KDA5434cnX0pr7e/f
ARC-Seal: i=1; a=rsa-sha256; t=1520260785; cv=none;
        d=google.com; s=arc-20160816;
        b=pie9n/x2Qyo5d0uVCCHcTd3WPrKl4/j1QyFnQFRBEhLE3qRicJGgcQQi/2ReptOTB+
         4Q4Grw49rPm+L70gxqmqGwIdGRkdEXwtDawFCW2IzhhU1rk9GbSRg/zvBVLDUY9hKRrw
         pbyPaMnT1M2jewRCIKuo/2RwVxeuy330WvlmAKNtKo+QcWjmbnzgGw6XJZNIYs9V+7GC
         +MtrhzATtENXRt+28DAyzxcMJGrGOUxU0LSEpY+e7ZvTiQeMjyPyk4IiHGetV110agso
         ybC1BE0v2oRK9uwsXXQGtuMVb6aD+NOw7fx8N8qjEn5Hw+NXgyYQZh0xyBEeYZ7qJQyZ
         E5qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=vd/hZHdZmtGE7BD9Pf8NzmWdcvYMUNmY9HRT8/goVn4=;
        b=qStqHpyfnGLYpxJ0jw6lRTe5a8QPkek8qAm2jtP1lWIQf6Y7aUrv313bCB5BcjGHRB
         Yh068c3C2Yr5t05HlX04uDDQNstjHVVO/9SsRw0OgQG5oV6lWsyaErEoDY39BpDvz3Gd
         Zyu3BWEzx0SgGQiCwFhf5ifo29eD15JNu3PrwpZhmUqiK1gNC0qh0hHcPgsYmQc7tXJE
         fNHhGuIgR2wlzHUVrgn2fLS69AqLy6LTDRYmYiJPPSfg2EdS7V5BrQ53sV3+qgRnG9Sx
         ml3CWHvN1S1sEP6mFBsocoEYxYtqNBFDvI7wPricRyNIGFw3aXCul6Pz8sKD0Q24paJS
         t9Jg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jarkko.sakkinen@intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=jarkko.sakkinen@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jarkko.sakkinen@intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=jarkko.sakkinen@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="39325864"
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
Subject: [PATCH v2 4/5] tpm: migrate tpm2_get_tpm_pt() to use struct tpm_buf
Date: Mon,  5 Mar 2018 16:39:02 +0200
Message-Id: <20180305143904.7477-5-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180305143904.7477-1-jarkko.sakkinen@linux.intel.com>
References: <20180305143904.7477-1-jarkko.sakkinen@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108972817157025?=
X-GMAIL-MSGID: =?utf-8?q?1594108972817157025?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In order to make struct tpm_buf the first class object for constructing TPM
commands, migrate tpm2_get_tpm_pt() to use it.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm2-cmd.c | 63 +++++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 40 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 890d83c5c78b..e02f7d46e9ac 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -27,20 +27,6 @@ enum tpm2_session_attributes {
 	TPM2_SA_CONTINUE_SESSION	= BIT(0),
 };
 
-struct tpm2_get_tpm_pt_in {
-	__be32	cap_id;
-	__be32	property_id;
-	__be32	property_cnt;
-} __packed;
-
-struct tpm2_get_tpm_pt_out {
-	u8	more_data;
-	__be32	subcap_id;
-	__be32	property_cnt;
-	__be32	property_id;
-	__be32	value;
-} __packed;
-
 struct tpm2_get_random_in {
 	__be16	size;
 } __packed;
@@ -51,8 +37,6 @@ struct tpm2_get_random_out {
 } __packed;
 
 union tpm2_cmd_params {
-	struct	tpm2_get_tpm_pt_in	get_tpm_pt_in;
-	struct	tpm2_get_tpm_pt_out	get_tpm_pt_out;
 	struct	tpm2_get_random_in	getrandom_in;
 	struct	tpm2_get_random_out	getrandom_out;
 };
@@ -377,19 +361,6 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 	return total ? total : -EIO;
 }
 
-#define TPM2_GET_TPM_PT_IN_SIZE \
-	(sizeof(struct tpm_input_header) + \
-	 sizeof(struct tpm2_get_tpm_pt_in))
-
-#define TPM2_GET_TPM_PT_OUT_BODY_SIZE \
-	 sizeof(struct tpm2_get_tpm_pt_out)
-
-static const struct tpm_input_header tpm2_get_tpm_pt_header = {
-	.tag = cpu_to_be16(TPM2_ST_NO_SESSIONS),
-	.length = cpu_to_be32(TPM2_GET_TPM_PT_IN_SIZE),
-	.ordinal = cpu_to_be32(TPM2_CC_GET_CAPABILITY)
-};
-
 /**
  * tpm2_flush_context_cmd() - execute a TPM2_FlushContext command
  * @chip: TPM chip to use
@@ -723,6 +694,14 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
 	return rc;
 }
 
+struct tpm2_get_cap_out {
+	u8 more_data;
+	__be32 subcap_id;
+	__be32 property_cnt;
+	__be32 property_id;
+	__be32 value;
+} __packed;
+
 /**
  * tpm2_get_tpm_pt() - get value of a TPM_CAP_TPM_PROPERTIES type property
  * @chip:		TPM chip to use.
@@ -735,19 +714,23 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
 ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,  u32 *value,
 			const char *desc)
 {
-	struct tpm2_cmd cmd;
+	struct tpm2_get_cap_out *out;
+	struct tpm_buf buf;
 	int rc;
 
-	cmd.header.in = tpm2_get_tpm_pt_header;
-	cmd.params.get_tpm_pt_in.cap_id = cpu_to_be32(TPM2_CAP_TPM_PROPERTIES);
-	cmd.params.get_tpm_pt_in.property_id = cpu_to_be32(property_id);
-	cmd.params.get_tpm_pt_in.property_cnt = cpu_to_be32(1);
-
-	rc = tpm_transmit_cmd(chip, NULL, &cmd, sizeof(cmd),
-			      TPM2_GET_TPM_PT_OUT_BODY_SIZE, 0, desc);
-	if (!rc)
-		*value = be32_to_cpu(cmd.params.get_tpm_pt_out.value);
-
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
+	if (rc)
+		return rc;
+	tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
+	tpm_buf_append_u32(&buf, property_id);
+	tpm_buf_append_u32(&buf, 1);
+	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0, NULL);
+	if (!rc) {
+		out = (struct tpm2_get_cap_out *)
+			&buf.data[TPM_HEADER_SIZE];
+		*value = be32_to_cpu(out->value);
+	}
+	tpm_buf_destroy(&buf);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(tpm2_get_tpm_pt);
-- 
2.15.1
