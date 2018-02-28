Return-Path: <jarkko.sakkinen@intel.com>
X-Google-Smtp-Source: AH8x225RLZUKTzJ3t+qqYUaNOxA8e8bW7hqLtqye9KQjfmQoR1BgBGlQ7Whgwr9OxoVwhllXzL89
ARC-Seal: i=1; a=rsa-sha256; t=1519847927; cv=none;
        d=google.com; s=arc-20160816;
        b=UMeaNqttwhFEhwITm7S+wsGUf6mUdcBWprmfPgzKWMOZrHvU1g/hlK1Ix/+yZ2RFdj
         jk3u1QMqJl9EdQlZlIlTd7CDo2kngbCHj23ger4S+n3eiQNMp3qGLSFyE+M9BEUMyALS
         H1CKWwtnGXmQqrrgicuPQ1qT/ptWjVvESpmWbB0Fnv8YrWO8ks+ZZS8GDmLeFMDOW3H3
         b4ZPborZc6NduKrneR8tZJ9aiVcLakA3dJG+SukG8tMAExK4F90eNxeRUUPf4v0wE2tH
         KTle5ZPJUZzYZF5WRHQ30bBjlT0YgSjK08WiPnpFob3ebeg/GezP9PgeyKybe+jNiyyS
         CsPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=kHoc2Fwc0vwAktv4O0Gs+cvfaNsJKB90zRcdQmgUDKQ=;
        b=PBIz0/IlZD+dNzGLOEduH0/nlxxWbkjVp4rXXJDTFxm0Zz7hMweR4Ob1UViJi4NEdt
         B9F4KiFCpd/3yQvHdvQTz3MoyIHu9dOzWnepfnIKUNt9huuV1WwHLT+Kts8OcWXallJg
         eOOmS75ylUrqSsS0migm1eKXhhXoJIZ0pRaM7c0ZtvsP0c//VajDk1eTRZqUkFgm018X
         D7mZKgYTA/gdyquw9scAYFpoLxsUlCBh5ciZPaiXCXrq6RM2tAe32kWRLS+v+CO9VRLr
         yvwM0+Ov47SercCN0iWMXmyv6xmmF1fKx1Q0MHrlKUWbcYym1+xm5IeQED/D8uip0YpQ
         lU+A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jarkko.sakkinen@intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jarkko.sakkinen@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jarkko.sakkinen@intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jarkko.sakkinen@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,406,1515484800";
   d="scan'208";a="20929720"
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
Subject: [PATCH 2/5] tpm: migrate tpm2_shutdown() to use struct tpm_buf
Date: Wed, 28 Feb 2018 21:58:15 +0200
Message-Id: <20180228195819.22231-3-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180228195819.22231-1-jarkko.sakkinen@linux.intel.com>
References: <20180228195819.22231-1-jarkko.sakkinen@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676060311547889?=
X-GMAIL-MSGID: =?utf-8?q?1593676060311547889?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In order to make struct tpm_buf the first class object for constructing TPM
commands, migrate tpm2_shutdown() to use it. In addition, removed the klog
entry when tpm_transmit_cmd() fails because tpm_tansmit_cmd() already
prints an error message.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm2-cmd.c | 41 +++++++++++++----------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 6eeff3a60003..5f92141b1e16 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -27,10 +27,6 @@ enum tpm2_session_attributes {
 	TPM2_SA_CONTINUE_SESSION	= BIT(0),
 };
 
-struct tpm2_startup_in {
-	__be16	startup_type;
-} __packed;
-
 struct tpm2_get_tpm_pt_in {
 	__be32	cap_id;
 	__be32	property_id;
@@ -55,7 +51,6 @@ struct tpm2_get_random_out {
 } __packed;
 
 union tpm2_cmd_params {
-	struct	tpm2_startup_in		startup_in;
 	struct	tpm2_get_tpm_pt_in	get_tpm_pt_in;
 	struct	tpm2_get_tpm_pt_out	get_tpm_pt_out;
 	struct	tpm2_get_random_in	getrandom_in;
@@ -760,40 +755,30 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,  u32 *value,
 }
 EXPORT_SYMBOL_GPL(tpm2_get_tpm_pt);
 
-#define TPM2_SHUTDOWN_IN_SIZE \
-	(sizeof(struct tpm_input_header) + \
-	 sizeof(struct tpm2_startup_in))
-
-static const struct tpm_input_header tpm2_shutdown_header = {
-	.tag = cpu_to_be16(TPM2_ST_NO_SESSIONS),
-	.length = cpu_to_be32(TPM2_SHUTDOWN_IN_SIZE),
-	.ordinal = cpu_to_be32(TPM2_CC_SHUTDOWN)
-};
-
 /**
  * tpm2_shutdown() - send shutdown command to the TPM chip
  *
+ * In places where shutdown command is sent there's no much we can do except
+ * print the error code on a system failure.
+ *
  * @chip:		TPM chip to use.
  * @shutdown_type:	shutdown type. The value is either
  *			TPM_SU_CLEAR or TPM_SU_STATE.
  */
 void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type)
 {
-	struct tpm2_cmd cmd;
+	struct tpm_buf buf;
 	int rc;
 
-	cmd.header.in = tpm2_shutdown_header;
-	cmd.params.startup_in.startup_type = cpu_to_be16(shutdown_type);
-
-	rc = tpm_transmit_cmd(chip, NULL, &cmd, sizeof(cmd), 0, 0,
-			      "stopping the TPM");
-
-	/* In places where shutdown command is sent there's no much we can do
-	 * except print the error code on a system failure.
-	 */
-	if (rc < 0 && rc != -EPIPE)
-		dev_warn(&chip->dev, "transmit returned %d while stopping the TPM",
-			 rc);
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SHUTDOWN);
+	if (rc) {
+		dev_err(&chip->dev, "%s: out of memory", __func__);
+		return;
+	}
+	tpm_buf_append_u16(&buf, shutdown_type);
+	tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
+			 "stopping the TPM");
+	tpm_buf_destroy(&buf);
 }
 
 /*
-- 
2.15.1
