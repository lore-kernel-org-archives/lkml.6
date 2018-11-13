Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7706BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7422175B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7422175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731502AbeKNEgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:36:48 -0500
Received: from mga01.intel.com ([192.55.52.88]:62106 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbeKNEgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:36:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 10:37:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,229,1539673200"; 
   d="scan'208";a="107948876"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.77])
  by orsmga001.jf.intel.com with ESMTP; 13 Nov 2018 10:37:11 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip
        (AT91) SoC support)
Subject: [PATCH v7 05/17] tpm: declare struct tpm_header
Date:   Tue, 13 Nov 2018 20:36:04 +0200
Message-Id: <20181113183620.27447-6-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113183620.27447-1-jarkko.sakkinen@linux.intel.com>
References: <20181113183620.27447-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decleare struct tpm_header that replaces struct tpm_input_header and
struct tpm_output_header.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 drivers/char/tpm/tpm-interface.c  |  9 ++++-----
 drivers/char/tpm/tpm.h            | 27 ++++++++++++---------------
 drivers/char/tpm/tpm2-cmd.c       |  4 ++--
 drivers/char/tpm/tpm2-space.c     |  6 +++---
 drivers/char/tpm/tpm_i2c_atmel.c  |  5 ++---
 drivers/char/tpm/tpm_vtpm_proxy.c |  8 ++++----
 drivers/char/tpm/xen-tpmfront.c   |  2 +-
 7 files changed, 28 insertions(+), 33 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 7ac6ada8428c..cb0d44c158ae 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -67,7 +67,7 @@ static int tpm_validate_command(struct tpm_chip *chip,
 				 const u8 *cmd,
 				 size_t len)
 {
-	const struct tpm_input_header *header = (const void *)cmd;
+	const struct tpm_header *header = (const void *)cmd;
 	int i;
 	u32 cc;
 	u32 attrs;
@@ -166,7 +166,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 				u8 *buf, size_t bufsiz,
 				unsigned int flags)
 {
-	struct tpm_output_header *header = (void *)buf;
+	struct tpm_header *header = (void *)buf;
 	int rc;
 	ssize_t len = 0;
 	u32 count, ordinal;
@@ -316,7 +316,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 		     u8 *buf, size_t bufsiz, unsigned int flags)
 {
-	struct tpm_output_header *header = (struct tpm_output_header *)buf;
+	struct tpm_header *header = (struct tpm_header *)buf;
 	/* space for header and handles */
 	u8 save[TPM_HEADER_SIZE + 3*sizeof(u32)];
 	unsigned int delay_msec = TPM2_DURATION_SHORT;
@@ -381,8 +381,7 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
 			 struct tpm_buf *buf, size_t min_rsp_body_length,
 			 unsigned int flags, const char *desc)
 {
-	const struct tpm_output_header *header =
-		(struct tpm_output_header *)buf->data;
+	const struct tpm_header *header = (struct tpm_header *)buf->data;
 	int err;
 	ssize_t len;
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 49bca4d1e786..86fa8ac0ae20 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -273,16 +273,13 @@ struct tpm_chip {
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
 
-struct tpm_input_header {
-	__be16	tag;
-	__be32	length;
-	__be32	ordinal;
-} __packed;
-
-struct tpm_output_header {
-	__be16	tag;
-	__be32	length;
-	__be32	return_code;
+struct tpm_header {
+	__be16 tag;
+	__be32 length;
+	union {
+		__be32 ordinal;
+		__be32 return_code;
+	};
 } __packed;
 
 #define TPM_TAG_RQU_COMMAND 193
@@ -401,8 +398,8 @@ struct tpm_buf {
 
 static inline void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
 {
-	struct tpm_input_header *head;
-	head = (struct tpm_input_header *)buf->data;
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+
 	head->tag = cpu_to_be16(tag);
 	head->length = cpu_to_be32(sizeof(*head));
 	head->ordinal = cpu_to_be32(ordinal);
@@ -428,14 +425,14 @@ static inline void tpm_buf_destroy(struct tpm_buf *buf)
 
 static inline u32 tpm_buf_length(struct tpm_buf *buf)
 {
-	struct tpm_input_header *head = (struct tpm_input_header *) buf->data;
+	struct tpm_header *head = (struct tpm_header *) buf->data;
 
 	return be32_to_cpu(head->length);
 }
 
 static inline u16 tpm_buf_tag(struct tpm_buf *buf)
 {
-	struct tpm_input_header *head = (struct tpm_input_header *) buf->data;
+	struct tpm_header *head = (struct tpm_header *) buf->data;
 
 	return be16_to_cpu(head->tag);
 }
@@ -444,7 +441,7 @@ static inline void tpm_buf_append(struct tpm_buf *buf,
 				  const unsigned char *new_data,
 				  unsigned int new_len)
 {
-	struct tpm_input_header *head = (struct tpm_input_header *) buf->data;
+	struct tpm_header *head = (struct tpm_header *) buf->data;
 	u32 len = tpm_buf_length(buf);
 
 	/* Return silently if overflow has already happened. */
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 2bcf470c8e5d..ab03f8600f89 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -784,7 +784,7 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
  */
 int tpm2_probe(struct tpm_chip *chip)
 {
-	struct tpm_output_header *out;
+	struct tpm_header *out;
 	struct tpm_buf buf;
 	int rc;
 
@@ -797,7 +797,7 @@ int tpm2_probe(struct tpm_chip *chip)
 	rc = tpm_transmit_cmd(chip, NULL, &buf, 0, 0, NULL);
 	/* We ignore TPM return codes on purpose. */
 	if (rc >=  0) {
-		out = (struct tpm_output_header *)buf.data;
+		out = (struct tpm_header *)buf.data;
 		if (be16_to_cpu(out->tag) == TPM2_ST_NO_SESSIONS)
 			chip->flags |= TPM_CHIP_FLAG_TPM2;
 	}
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 5ecc73988f7c..862ee1ce1755 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -334,7 +334,7 @@ static int tpm2_map_response_header(struct tpm_chip *chip, u32 cc, u8 *rsp,
 				    size_t len)
 {
 	struct tpm_space *space = &chip->work_space;
-	struct tpm_output_header *header = (void *)rsp;
+	struct tpm_header *header = (void *)rsp;
 	u32 phandle;
 	u32 phandle_type;
 	u32 vhandle;
@@ -394,7 +394,7 @@ static int tpm2_map_response_body(struct tpm_chip *chip, u32 cc, u8 *rsp,
 				  size_t len)
 {
 	struct tpm_space *space = &chip->work_space;
-	struct tpm_output_header *header = (void *)rsp;
+	struct tpm_header *header = (void *)rsp;
 	struct tpm2_cap_handles *data;
 	u32 phandle;
 	u32 phandle_type;
@@ -492,7 +492,7 @@ static int tpm2_save_space(struct tpm_chip *chip)
 int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
 		      u32 cc, u8 *buf, size_t *bufsiz)
 {
-	struct tpm_output_header *header = (void *)buf;
+	struct tpm_header *header = (void *)buf;
 	int rc;
 
 	if (!space)
diff --git a/drivers/char/tpm/tpm_i2c_atmel.c b/drivers/char/tpm/tpm_i2c_atmel.c
index 95ce2e9ccdc6..4720b2442ffe 100644
--- a/drivers/char/tpm/tpm_i2c_atmel.c
+++ b/drivers/char/tpm/tpm_i2c_atmel.c
@@ -46,7 +46,7 @@ struct priv_data {
 	/* This is the amount we read on the first try. 25 was chosen to fit a
 	 * fair number of read responses in the buffer so a 2nd retry can be
 	 * avoided in small message cases. */
-	u8 buffer[sizeof(struct tpm_output_header) + 25];
+	u8 buffer[sizeof(struct tpm_header) + 25];
 };
 
 static int i2c_atmel_send(struct tpm_chip *chip, u8 *buf, size_t len)
@@ -72,8 +72,7 @@ static int i2c_atmel_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	struct priv_data *priv = dev_get_drvdata(&chip->dev);
 	struct i2c_client *client = to_i2c_client(chip->dev.parent);
-	struct tpm_output_header *hdr =
-		(struct tpm_output_header *)priv->buffer;
+	struct tpm_header *hdr = (struct tpm_header *)priv->buffer;
 	u32 expected_len;
 	int rc;
 
diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index 5f95fbfb7f6b..28eb5ab15b99 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -303,9 +303,9 @@ static int vtpm_proxy_tpm_op_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 static int vtpm_proxy_is_driver_command(struct tpm_chip *chip,
 					u8 *buf, size_t count)
 {
-	struct tpm_input_header *hdr = (struct tpm_input_header *)buf;
+	struct tpm_header *hdr = (struct tpm_header *)buf;
 
-	if (count < sizeof(struct tpm_input_header))
+	if (count < sizeof(struct tpm_header))
 		return 0;
 
 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
@@ -402,7 +402,7 @@ static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
 {
 	struct tpm_buf buf;
 	int rc;
-	const struct tpm_output_header *header;
+	const struct tpm_header *header;
 	struct proxy_dev *proxy_dev = dev_get_drvdata(&chip->dev);
 
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
@@ -427,7 +427,7 @@ static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
 		goto out;
 	}
 
-	header = (const struct tpm_output_header *)buf.data;
+	header = (const struct tpm_header *)buf.data;
 	rc = be32_to_cpu(header->return_code);
 	if (rc)
 		locality = -1;
diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
index b150f87f38f5..1259e935fd58 100644
--- a/drivers/char/tpm/xen-tpmfront.c
+++ b/drivers/char/tpm/xen-tpmfront.c
@@ -163,7 +163,7 @@ static int vtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
 	wmb();
 	notify_remote_via_evtchn(priv->evtchn);
 
-	ordinal = be32_to_cpu(((struct tpm_input_header*)buf)->ordinal);
+	ordinal = be32_to_cpu(((struct tpm_header *)buf)->ordinal);
 	duration = tpm_calc_ordinal_duration(chip, ordinal);
 
 	if (wait_for_tpm_stat(chip, VTPM_STATUS_IDLE, duration,
-- 
2.19.1

