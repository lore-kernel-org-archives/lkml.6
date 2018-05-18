Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbeERWjv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 18:39:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47470 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751747AbeERWjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 18:39:47 -0400
Date: Fri, 18 May 2018 15:39:47 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] tpm: migrate tpm2_get_tpm_pt() to use struct
 tpm_buf
Message-ID: <20180518223947.s3x2lkexyjemcnfa@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
 <20180326121406.14548-4-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180326121406.14548-4-jarkko.sakkinen@linux.intel.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Mar 26 18, Jarkko Sakkinen wrote:
>In order to make struct tpm_buf the first class object for constructing TPM
>commands, migrate tpm2_get_tpm_pt() to use it.
>
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

>---
> drivers/char/tpm/tpm2-cmd.c | 63 +++++++++++++++++----------------------------
> 1 file changed, 23 insertions(+), 40 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>index 7bffd0fd1dca..b3b52f9eb65f 100644
>--- a/drivers/char/tpm/tpm2-cmd.c
>+++ b/drivers/char/tpm/tpm2-cmd.c
>@@ -27,20 +27,6 @@ enum tpm2_session_attributes {
> 	TPM2_SA_CONTINUE_SESSION	= BIT(0),
> };
>
>-struct tpm2_get_tpm_pt_in {
>-	__be32	cap_id;
>-	__be32	property_id;
>-	__be32	property_cnt;
>-} __packed;
>-
>-struct tpm2_get_tpm_pt_out {
>-	u8	more_data;
>-	__be32	subcap_id;
>-	__be32	property_cnt;
>-	__be32	property_id;
>-	__be32	value;
>-} __packed;
>-
> struct tpm2_get_random_in {
> 	__be16	size;
> } __packed;
>@@ -51,8 +37,6 @@ struct tpm2_get_random_out {
> } __packed;
>
> union tpm2_cmd_params {
>-	struct	tpm2_get_tpm_pt_in	get_tpm_pt_in;
>-	struct	tpm2_get_tpm_pt_out	get_tpm_pt_out;
> 	struct	tpm2_get_random_in	getrandom_in;
> 	struct	tpm2_get_random_out	getrandom_out;
> };
>@@ -379,19 +363,6 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *out, size_t max)
> 	return total ? total : -EIO;
> }
>
>-#define TPM2_GET_TPM_PT_IN_SIZE \
>-	(sizeof(struct tpm_input_header) + \
>-	 sizeof(struct tpm2_get_tpm_pt_in))
>-
>-#define TPM2_GET_TPM_PT_OUT_BODY_SIZE \
>-	 sizeof(struct tpm2_get_tpm_pt_out)
>-
>-static const struct tpm_input_header tpm2_get_tpm_pt_header = {
>-	.tag = cpu_to_be16(TPM2_ST_NO_SESSIONS),
>-	.length = cpu_to_be32(TPM2_GET_TPM_PT_IN_SIZE),
>-	.ordinal = cpu_to_be32(TPM2_CC_GET_CAPABILITY)
>-};
>-
> /**
>  * tpm2_flush_context_cmd() - execute a TPM2_FlushContext command
>  * @chip: TPM chip to use
>@@ -725,6 +696,14 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
> 	return rc;
> }
>
>+struct tpm2_get_cap_out {
>+	u8 more_data;
>+	__be32 subcap_id;
>+	__be32 property_cnt;
>+	__be32 property_id;
>+	__be32 value;
>+} __packed;
>+
> /**
>  * tpm2_get_tpm_pt() - get value of a TPM_CAP_TPM_PROPERTIES type property
>  * @chip:		TPM chip to use.
>@@ -737,19 +716,23 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
> ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,  u32 *value,
> 			const char *desc)
> {
>-	struct tpm2_cmd cmd;
>+	struct tpm2_get_cap_out *out;
>+	struct tpm_buf buf;
> 	int rc;
>
>-	cmd.header.in = tpm2_get_tpm_pt_header;
>-	cmd.params.get_tpm_pt_in.cap_id = cpu_to_be32(TPM2_CAP_TPM_PROPERTIES);
>-	cmd.params.get_tpm_pt_in.property_id = cpu_to_be32(property_id);
>-	cmd.params.get_tpm_pt_in.property_cnt = cpu_to_be32(1);
>-
>-	rc = tpm_transmit_cmd(chip, NULL, &cmd, sizeof(cmd),
>-			      TPM2_GET_TPM_PT_OUT_BODY_SIZE, 0, desc);
>-	if (!rc)
>-		*value = be32_to_cpu(cmd.params.get_tpm_pt_out.value);
>-
>+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
>+	if (rc)
>+		return rc;
>+	tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
>+	tpm_buf_append_u32(&buf, property_id);
>+	tpm_buf_append_u32(&buf, 1);
>+	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0, NULL);
>+	if (!rc) {
>+		out = (struct tpm2_get_cap_out *)
>+			&buf.data[TPM_HEADER_SIZE];
>+		*value = be32_to_cpu(out->value);
>+	}
>+	tpm_buf_destroy(&buf);
> 	return rc;
> }
> EXPORT_SYMBOL_GPL(tpm2_get_tpm_pt);
>-- 
>2.15.1
>
