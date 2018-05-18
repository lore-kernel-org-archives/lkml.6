Return-Path: <nayna@linux.vnet.ibm.com>
X-Google-Smtp-Source: AB8JxZrjyiQUe6BaPsQRfUzdMOF2dujY8Nd7KA6QLpvIvsRbONnbgTXZdPN4AlEP+y28z0gWBi1M
ARC-Seal: i=1; a=rsa-sha256; t=1526625225; cv=none;
        d=google.com; s=arc-20160816;
        b=O8067+EgKQAAVIRTu+4B4WVzvHUT8hJJ3kMrsTpkJwA1BWQc8n9DcZ1h+JjPuiDy0p
         iXCHzGECJHI5tE0mkD/LNRlSyiqX4gAMhdV0/DiNFPqWEihaSQ1vdwT1UCOpbe8/HzKj
         tb/kJuJN2M1/UYSQ8tU+u2zGrfTijC0SXWP3MwxltVRS4KIvFmdlU3GilGu5/8lYvL4s
         LVphPA9KMKo91XFe/Mldk237aWLN+PSAKaeRhayI9gzkNYkqjOu/07wiGMqz5J8rdakO
         pFwWZTHN3FQwC/KjUPazmchp1brCseEvnTxIyiyNt+qltyOifsvj+7rvGEJ74rF3ftCT
         Z8IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-language:content-transfer-encoding:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=YGUDlSx4tGGWUgM01FrXNS0ixQ7lRf+nH3Csy/OFiqo=;
        b=BudeKKvTut82bC34+twqtjoujDhmXFud/U+G2GKXa77+Y5fcXLZIfcrJPCm/8H1lKQ
         FALGybOLseQzBddtRJ11zkgz7JX0fjQ6P3hYlKxCyOBe0V7p1I6+MnO3r3cpjDoBvXUQ
         sHET4km7IoFelHo2mmFWFiWuEiNXLVFQVDZFUmZXhw4ViXLTjp/Nw20RYitnV1juFkLl
         rQ47jdmXe6e09rGHVgvk4ZClcqKmwDG9JzG6IKZjK+6PCGJM+7NVNlo4pShDB+FLbupc
         UGPDtzSDDXNiwnZvf5dyflvkbnkIEwVOOOyJZ2fMF+S4GGL6pQuGVTC+57cWwd/tDoht
         PeEA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of nayna@linux.vnet.ibm.com) smtp.mailfrom=nayna@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of nayna@linux.vnet.ibm.com) smtp.mailfrom=nayna@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v4 3/4] tpm: migrate tpm2_get_tpm_pt() to use struct
 tpm_buf
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
 <20180326121406.14548-4-jarkko.sakkinen@linux.intel.com>
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Fri, 18 May 2018 12:01:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180326121406.14548-4-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18051806-0024-0000-0000-0000186F067C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009044; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01033963; UDB=6.00528730; IPR=6.00813092;
 MB=3.00021176; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-18 06:33:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051806-0025-0000-0000-000050098C24
Message-Id: <95828353-43e1-0a02-ea54-544b709584b9@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-18_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=9 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805180072
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596002384835671162?=
X-GMAIL-MSGID: =?utf-8?q?1600782572060560309?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/26/2018 05:44 PM, Jarkko Sakkinen wrote:
> In order to make struct tpm_buf the first class object for constructing TPM
> commands, migrate tpm2_get_tpm_pt() to use it.
>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Nayna Jain<nayna@linux.vnet.ibm.com>
Tested-by: Nayna Jain<nayna@linux.vnet.ibm.com>


Thanks & Regards,
    - Nayna

> ---
>   drivers/char/tpm/tpm2-cmd.c | 63 +++++++++++++++++----------------------------
>   1 file changed, 23 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 7bffd0fd1dca..b3b52f9eb65f 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -27,20 +27,6 @@ enum tpm2_session_attributes {
>   	TPM2_SA_CONTINUE_SESSION	= BIT(0),
>   };
>
> -struct tpm2_get_tpm_pt_in {
> -	__be32	cap_id;
> -	__be32	property_id;
> -	__be32	property_cnt;
> -} __packed;
> -
> -struct tpm2_get_tpm_pt_out {
> -	u8	more_data;
> -	__be32	subcap_id;
> -	__be32	property_cnt;
> -	__be32	property_id;
> -	__be32	value;
> -} __packed;
> -
>   struct tpm2_get_random_in {
>   	__be16	size;
>   } __packed;
> @@ -51,8 +37,6 @@ struct tpm2_get_random_out {
>   } __packed;
>
>   union tpm2_cmd_params {
> -	struct	tpm2_get_tpm_pt_in	get_tpm_pt_in;
> -	struct	tpm2_get_tpm_pt_out	get_tpm_pt_out;
>   	struct	tpm2_get_random_in	getrandom_in;
>   	struct	tpm2_get_random_out	getrandom_out;
>   };
> @@ -379,19 +363,6 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *out, size_t max)
>   	return total ? total : -EIO;
>   }
>
> -#define TPM2_GET_TPM_PT_IN_SIZE \
> -	(sizeof(struct tpm_input_header) + \
> -	 sizeof(struct tpm2_get_tpm_pt_in))
> -
> -#define TPM2_GET_TPM_PT_OUT_BODY_SIZE \
> -	 sizeof(struct tpm2_get_tpm_pt_out)
> -
> -static const struct tpm_input_header tpm2_get_tpm_pt_header = {
> -	.tag = cpu_to_be16(TPM2_ST_NO_SESSIONS),
> -	.length = cpu_to_be32(TPM2_GET_TPM_PT_IN_SIZE),
> -	.ordinal = cpu_to_be32(TPM2_CC_GET_CAPABILITY)
> -};
> -
>   /**
>    * tpm2_flush_context_cmd() - execute a TPM2_FlushContext command
>    * @chip: TPM chip to use
> @@ -725,6 +696,14 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
>   	return rc;
>   }
>
> +struct tpm2_get_cap_out {
> +	u8 more_data;
> +	__be32 subcap_id;
> +	__be32 property_cnt;
> +	__be32 property_id;
> +	__be32 value;
> +} __packed;
> +
>   /**
>    * tpm2_get_tpm_pt() - get value of a TPM_CAP_TPM_PROPERTIES type property
>    * @chip:		TPM chip to use.
> @@ -737,19 +716,23 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
>   ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,  u32 *value,
>   			const char *desc)
>   {
> -	struct tpm2_cmd cmd;
> +	struct tpm2_get_cap_out *out;
> +	struct tpm_buf buf;
>   	int rc;
>
> -	cmd.header.in = tpm2_get_tpm_pt_header;
> -	cmd.params.get_tpm_pt_in.cap_id = cpu_to_be32(TPM2_CAP_TPM_PROPERTIES);
> -	cmd.params.get_tpm_pt_in.property_id = cpu_to_be32(property_id);
> -	cmd.params.get_tpm_pt_in.property_cnt = cpu_to_be32(1);
> -
> -	rc = tpm_transmit_cmd(chip, NULL, &cmd, sizeof(cmd),
> -			      TPM2_GET_TPM_PT_OUT_BODY_SIZE, 0, desc);
> -	if (!rc)
> -		*value = be32_to_cpu(cmd.params.get_tpm_pt_out.value);
> -
> +	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
> +	if (rc)
> +		return rc;
> +	tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
> +	tpm_buf_append_u32(&buf, property_id);
> +	tpm_buf_append_u32(&buf, 1);
> +	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0, NULL);
> +	if (!rc) {
> +		out = (struct tpm2_get_cap_out *)
> +			&buf.data[TPM_HEADER_SIZE];
> +		*value = be32_to_cpu(out->value);
> +	}
> +	tpm_buf_destroy(&buf);
>   	return rc;
>   }
>   EXPORT_SYMBOL_GPL(tpm2_get_tpm_pt);
