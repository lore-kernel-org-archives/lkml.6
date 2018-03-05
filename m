Return-Path: <jarkko.sakkinen@intel.com>
X-Google-Smtp-Source: AG47ELtwQ1qaxhKAaErTmdlLRcLzrqpnvQfcbZBcctNf2biQ3hRU8CfkDj1QB0mWWRqA86RTlRyV
ARC-Seal: i=1; a=rsa-sha256; t=1520260795; cv=none;
        d=google.com; s=arc-20160816;
        b=P0zRI6Go/LmmQBUNNUA/kbuUuRr8pTutggia0HPFCdZ+WYw4oyQQwY+GrcT8p+c5Vg
         gcu6GxXJIge+a0LeaAoqbIwAUt0B+6xwyaWnTbYya+M742qybecTalnIc+0PkYWHdhdX
         xkpSJWPTgvUlalw9+JgQLcEifQd6fuCV/QUttpcEVSuWdziKxNTjv4PbsPIPWrExim1j
         GbDrDEHqq823E/vfJwU98inVC6bHqqjk7c8UWdyQw3kLIKDfrfX8+SsjUoc3f0g6Kygg
         q1rXCydJuqKYk5SkOdjjZwpmG0aBb8qQQFeDJtYTsbbjoaA8jiow0jHnsZYD7F8JQ+KG
         xuPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=z16D63x15RkWv4P2V8ijR+rWsg6t3rMrEd9iYg6IYYc=;
        b=KtSwn22aW3e/YIocqol43nZpYb3/+0Lef/oGSBsSb02PVMjpEWkNo8cZFhah/6HTFb
         7ftrUZnkjYymzM6tuxKf2hXw2UYVyq9OzheGkUGT5bGX2Y6g6X601TAOV6JyzEad+bcO
         IQz5a2waj7DpnYJvdKpEszxSHlaFvzAduQ6OREjeKTenzJlRwbm0HDeqlDjNy/ojwX7r
         vZ8lWOtPoudFMq6h962tNyeGMAGOgvqSohgN/jCkiO8ZYnRNXY1pXpduAGFkRrAFXHJi
         yV+uwFfIwXJkg3b6m7d76uijvqRc2Zo11YDBthnuIwArPoKEN+a4Qng513YvrjyS9jfJ
         xepQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jarkko.sakkinen@intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=jarkko.sakkinen@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jarkko.sakkinen@intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=jarkko.sakkinen@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="39325894"
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
Subject: [PATCH v2 5/5] tpm: migrate tpm2_get_random() to use struct tpm_buf
Date: Mon,  5 Mar 2018 16:39:03 +0200
Message-Id: <20180305143904.7477-6-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180305143904.7477-1-jarkko.sakkinen@linux.intel.com>
References: <20180305143904.7477-1-jarkko.sakkinen@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108984269814405?=
X-GMAIL-MSGID: =?utf-8?q?1594108984269814405?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In order to make struct tpm_buf the first class object for constructing
TPM commands, migrate tpm2_get_random() to use it. In addition, removed
remaining references to struct tpm2_cmd. All of them use it to acquire
the length of the response, which can be achieved by using
tpm_buf_length().

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm.h      | 19 ++++-----
 drivers/char/tpm/tpm2-cmd.c | 93 +++++++++++++++++----------------------------
 2 files changed, 45 insertions(+), 67 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index cccd5994a0e1..29c0717437bc 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -412,23 +412,24 @@ struct tpm_buf {
 	u8 *data;
 };
 
-static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
+static inline void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
 {
 	struct tpm_input_header *head;
+	head = (struct tpm_input_header *)buf->data;
+	head->tag = cpu_to_be16(tag);
+	head->length = cpu_to_be32(sizeof(*head));
+	head->ordinal = cpu_to_be32(ordinal);
+}
 
+static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
+{
 	buf->data_page = alloc_page(GFP_HIGHUSER);
 	if (!buf->data_page)
 		return -ENOMEM;
 
 	buf->flags = 0;
 	buf->data = kmap(buf->data_page);
-
-	head = (struct tpm_input_header *) buf->data;
-
-	head->tag = cpu_to_be16(tag);
-	head->length = cpu_to_be32(sizeof(*head));
-	head->ordinal = cpu_to_be32(ordinal);
-
+	tpm_buf_reset(buf, tag, ordinal);
 	return 0;
 }
 
@@ -557,7 +558,7 @@ static inline u32 tpm2_rc_value(u32 rc)
 int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf);
 int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
 		    struct tpm2_digest *digests);
-int tpm2_get_random(struct tpm_chip *chip, u8 *out, size_t max);
+int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
 void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
 			    unsigned int flags);
 int tpm2_seal_trusted(struct tpm_chip *chip,
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index e02f7d46e9ac..36a58af6f5c7 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -27,25 +27,6 @@ enum tpm2_session_attributes {
 	TPM2_SA_CONTINUE_SESSION	= BIT(0),
 };
 
-struct tpm2_get_random_in {
-	__be16	size;
-} __packed;
-
-struct tpm2_get_random_out {
-	__be16	size;
-	u8	buffer[TPM_MAX_RNG_DATA];
-} __packed;
-
-union tpm2_cmd_params {
-	struct	tpm2_get_random_in	getrandom_in;
-	struct	tpm2_get_random_out	getrandom_out;
-};
-
-struct tpm2_cmd {
-	tpm_cmd_header		header;
-	union tpm2_cmd_params	params;
-} __packed;
-
 struct tpm2_hash {
 	unsigned int crypto_id;
 	unsigned int tpm_id;
@@ -298,66 +279,66 @@ int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
 }
 
 
-#define TPM2_GETRANDOM_IN_SIZE \
-	(sizeof(struct tpm_input_header) + \
-	 sizeof(struct tpm2_get_random_in))
-
-static const struct tpm_input_header tpm2_getrandom_header = {
-	.tag = cpu_to_be16(TPM2_ST_NO_SESSIONS),
-	.length = cpu_to_be32(TPM2_GETRANDOM_IN_SIZE),
-	.ordinal = cpu_to_be32(TPM2_CC_GET_RANDOM)
-};
+struct tpm2_get_random_out {
+	__be16 size;
+	u8 buffer[TPM_MAX_RNG_DATA];
+} __packed;
 
 /**
  * tpm2_get_random() - get random bytes from the TPM RNG
  *
  * @chip: TPM chip to use
- * @out: destination buffer for the random bytes
+ * @dest: destination buffer for the random bytes
  * @max: the max number of bytes to write to @out
  *
  * Return:
- *    Size of the output buffer, or -EIO on error.
+ * size of the output buffer when the operation is successful.
+ * A negative number for system errors (errno).
  */
-int tpm2_get_random(struct tpm_chip *chip, u8 *out, size_t max)
+int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 {
-	struct tpm2_cmd cmd;
-	u32 recd, rlength;
-	u32 num_bytes;
+	struct tpm2_get_random_out *out;
+	struct tpm_buf buf;
+	u32 recd;
+	u32 num_bytes = max;
 	int err;
 	int total = 0;
 	int retries = 5;
-	u8 *dest = out;
+	u8 *dest_ptr = dest;
 
-	num_bytes = min_t(u32, max, sizeof(cmd.params.getrandom_out.buffer));
-
-	if (!out || !num_bytes ||
-	    max > sizeof(cmd.params.getrandom_out.buffer))
+	if (!num_bytes || max > TPM_MAX_RNG_DATA)
 		return -EINVAL;
 
-	do {
-		cmd.header.in = tpm2_getrandom_header;
-		cmd.params.getrandom_in.size = cpu_to_be16(num_bytes);
+	err = tpm_buf_init(&buf, 0, 0);
+	if (err)
+		return err;
 
-		err = tpm_transmit_cmd(chip, NULL, &cmd, sizeof(cmd),
+	do {
+		tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_RANDOM);
+		tpm_buf_append_u16(&buf, num_bytes);
+		err = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE,
 				       offsetof(struct tpm2_get_random_out,
 						buffer),
 				       0, "attempting get random");
 		if (err)
 			break;
 
-		recd = min_t(u32, be16_to_cpu(cmd.params.getrandom_out.size),
-			     num_bytes);
-		rlength = be32_to_cpu(cmd.header.out.length);
-		if (rlength < offsetof(struct tpm2_get_random_out, buffer) +
-			      recd)
-			return -EFAULT;
-		memcpy(dest, cmd.params.getrandom_out.buffer, recd);
+		out = (struct tpm2_get_random_out *)
+			&buf.data[TPM_HEADER_SIZE];
+		recd = min_t(u32, be16_to_cpu(out->size), num_bytes);
+		if (tpm_buf_length(&buf) <
+		    offsetof(struct tpm2_get_random_out, buffer) + recd) {
+			err = -EFAULT;
+			break;
+		}
+		memcpy(dest_ptr, out->buffer, recd);
 
-		dest += recd;
+		dest_ptr += recd;
 		total += recd;
 		num_bytes -= recd;
 	} while (retries-- && total < max);
 
+	tpm_buf_destroy(&buf);
 	return total ? total : -EIO;
 }
 
@@ -432,7 +413,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 {
 	unsigned int blob_len;
 	struct tpm_buf buf;
-	u32 hash, rlength;
+	u32 hash;
 	int i;
 	int rc;
 
@@ -507,8 +488,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		rc = -E2BIG;
 		goto out;
 	}
-	rlength = be32_to_cpu(((struct tpm2_cmd *)&buf)->header.out.length);
-	if (rlength < TPM_HEADER_SIZE + 4 + blob_len) {
+	if (tpm_buf_length(&buf) < TPM_HEADER_SIZE + 4 + blob_len) {
 		rc = -EFAULT;
 		goto out;
 	}
@@ -618,7 +598,6 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 	u16 data_len;
 	u8 *data;
 	int rc;
-	u32 rlength;
 
 	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_UNSEAL);
 	if (rc)
@@ -646,9 +625,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 			goto out;
 		}
 
-		rlength = be32_to_cpu(((struct tpm2_cmd *)&buf)
-					->header.out.length);
-		if (rlength < TPM_HEADER_SIZE + 6 + data_len) {
+		if (tpm_buf_length(&buf) < TPM_HEADER_SIZE + 6 + data_len) {
 			rc = -EFAULT;
 			goto out;
 		}
-- 
2.15.1
