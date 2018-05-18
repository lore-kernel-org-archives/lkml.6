Return-Path: <nayna@linux.vnet.ibm.com>
X-Google-Smtp-Source: AB8JxZrARZdLAHn6CMXvgPsjzCGJYQCeU2CJMrpVr6THZmpn293GBzg42payOEZOo1HoujHFH8yT
ARC-Seal: i=1; a=rsa-sha256; t=1526625063; cv=none;
        d=google.com; s=arc-20160816;
        b=UfjSvKknH6KkWBdwXda8r7i3YBeOJ3gzaM0Vxlo/6A1IFreSpBkqRgukpZ5btUDoxW
         y1cCsYEcICN6kcOmpvUgZf+MWe1i5SuBB8mW2AKp2Rrd0YuwTJJDaRdlc/XAgmf6Ye9U
         /qc+8/Olhj8G0J2PJMjmqh9iRudhtZWxJJFnzb7DSn+LN3UcTd8h+vSUGkbK+/BkaEg7
         5fuWB0F8JV1zd7Tkx3N8oPDIBecksDLZdspNMYxFhXvmQ85pShg5UHvLgcb/mYOaedJ0
         XnvI3XmhlBG6nO2PzEy49HKU2RNGqruJqKXS164vFOmdGRwUBt9g9ZahBxSr4vCoxme0
         fUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-language:content-transfer-encoding:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=4Zxtni2/aC0w2aV1DzUpV4XYz+3vAB4+5bE79cmDD48=;
        b=U/8XRUYjKy7oryUOWNIuXVZMHw9H/dlLg3Er54l8hqoCiJ2iBobjwus0J26ipy+qKj
         iZ8Amtr6retm9e313spA9zTpAazeWBQeKZ6xsVOxdQyot2bQDLkVVq2OskQX5wx5xaA6
         DfjaQ3Q958yb8W5rh4ypfARqBMChGzqK5ujnUg3aDyS6H7DqFxTdxgqyPLjmgkLDNeeQ
         fb0ZaApZnUD6smPy76HdWMC5aMyUX3O4GcpDS4ceKGKVAh41RvrHvbaseyXTum6/pX6a
         efSf3CigUFxLh2t5gfbW+z9lTFtBmZfcq8Vx/hbyxfKLRjH1zfbOTofqqDcZbosANR3f
         RNCA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of nayna@linux.vnet.ibm.com) smtp.mailfrom=nayna@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of nayna@linux.vnet.ibm.com) smtp.mailfrom=nayna@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v4 1/4] tpm: migrate tpm2_shutdown() to use struct tpm_buf
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
 <20180326121406.14548-2-jarkko.sakkinen@linux.intel.com>
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Fri, 18 May 2018 11:59:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180326121406.14548-2-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18051806-8235-0000-0000-00000D85CB05
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009044; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01033962; UDB=6.00528730; IPR=6.00813091;
 MB=3.00021176; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-18 06:30:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051806-8236-0000-0000-0000410472CA
Message-Id: <ec8f1102-e096-e39e-b6a7-4d335401c088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-18_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=9 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805180072
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596002370872973909?=
X-GMAIL-MSGID: =?utf-8?q?1600782402059321571?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/26/2018 05:44 PM, Jarkko Sakkinen wrote:
> In order to make struct tpm_buf the first class object for constructing TPM
> commands, migrate tpm2_shutdown() to use it. In addition, removed the klog
> entry when tpm_transmit_cmd() fails because tpm_tansmit_cmd() already
> prints an error message.
>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Reviewed-by: Nayna Jain<nayna@linux.vnet.ibm.com>
Tested-by: Nayna Jain<nayna@linux.vnet.ibm.com>

> ---
>   drivers/char/tpm/tpm2-cmd.c | 44 ++++++++++++--------------------------------
>   1 file changed, 12 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 96c77c8e7f40..7665661d9230 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -27,10 +27,6 @@ enum tpm2_session_attributes {
>   	TPM2_SA_CONTINUE_SESSION	= BIT(0),
>   };
>
> -struct tpm2_startup_in {
> -	__be16	startup_type;
> -} __packed;
> -
>   struct tpm2_get_tpm_pt_in {
>   	__be32	cap_id;
>   	__be32	property_id;
> @@ -55,7 +51,6 @@ struct tpm2_get_random_out {
>   } __packed;
>
>   union tpm2_cmd_params {
> -	struct	tpm2_startup_in		startup_in;
>   	struct	tpm2_get_tpm_pt_in	get_tpm_pt_in;
>   	struct	tpm2_get_tpm_pt_out	get_tpm_pt_out;
>   	struct	tpm2_get_random_in	getrandom_in;
> @@ -412,11 +407,8 @@ void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
>   	int rc;
>
>   	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_FLUSH_CONTEXT);
> -	if (rc) {
> -		dev_warn(&chip->dev, "0x%08x was not flushed, out of memory\n",
> -			 handle);
> +	if (rc)
>   		return;
> -	}
>
>   	tpm_buf_append_u32(&buf, handle);
>
> @@ -762,40 +754,28 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,  u32 *value,
>   }
>   EXPORT_SYMBOL_GPL(tpm2_get_tpm_pt);
>
> -#define TPM2_SHUTDOWN_IN_SIZE \
> -	(sizeof(struct tpm_input_header) + \
> -	 sizeof(struct tpm2_startup_in))
> -
> -static const struct tpm_input_header tpm2_shutdown_header = {
> -	.tag = cpu_to_be16(TPM2_ST_NO_SESSIONS),
> -	.length = cpu_to_be32(TPM2_SHUTDOWN_IN_SIZE),
> -	.ordinal = cpu_to_be32(TPM2_CC_SHUTDOWN)
> -};
> -
>   /**
>    * tpm2_shutdown() - send shutdown command to the TPM chip
>    *
> + * In places where shutdown command is sent there's no much we can do except
> + * print the error code on a system failure.
> + *
>    * @chip:		TPM chip to use.
>    * @shutdown_type:	shutdown type. The value is either
>    *			TPM_SU_CLEAR or TPM_SU_STATE.
>    */
>   void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type)
>   {
> -	struct tpm2_cmd cmd;
> +	struct tpm_buf buf;
>   	int rc;
>
> -	cmd.header.in = tpm2_shutdown_header;
> -	cmd.params.startup_in.startup_type = cpu_to_be16(shutdown_type);
> -
> -	rc = tpm_transmit_cmd(chip, NULL, &cmd, sizeof(cmd), 0, 0,
> -			      "stopping the TPM");
> -
> -	/* In places where shutdown command is sent there's no much we can do
> -	 * except print the error code on a system failure.
> -	 */
> -	if (rc < 0 && rc != -EPIPE)
> -		dev_warn(&chip->dev, "transmit returned %d while stopping the TPM",
> -			 rc);
> +	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SHUTDOWN);
> +	if (rc)
> +		return;
> +	tpm_buf_append_u16(&buf, shutdown_type);
> +	tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
> +			 "stopping the TPM");
> +	tpm_buf_destroy(&buf);
>   }
>
>   /*
