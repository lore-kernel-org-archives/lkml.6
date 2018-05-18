Return-Path: <jarkko.sakkinen@linux.intel.com>
X-Google-Smtp-Source: AB8JxZo2wNQIDvEaW95/u9NHAhd4JFifD9lwSy5/g2gVMZ4eOyu9aueGPfuTK4H9t6GT9c8qfgjR
ARC-Seal: i=1; a=rsa-sha256; t=1526630621; cv=none;
        d=google.com; s=arc-20160816;
        b=gwa534SSqzkZ91JPyYXlA6R4ZT5vMdU3bkHFnXyfrm3LZizLtcnyhCGntXx77vpAhh
         ibudWPRlqDZJJcuIW2YLBX9BL6abav6pF6StL/ocQgO33ZtIMRF+HwITEExzXZ4iMmbB
         WJbBLlV1eIZ7GXJE9xatXd2/c07hTGKD2HQZHmeGCGXiSWhujTV94raFYAQrE1TCiKX9
         Dve0dwKRoU0KV79omVAWWcMoFSdbZBVavDEuiekOr4h/g89km6n+kGe3QQsY+jGbfCLI
         UDnfvGZ3gEIbk4VUjK5Iu1dmilacfuWu9vKZvix7MwWiY/GRxfnYhqsgG9BXF+vjqcug
         oiAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:organization:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=4mGqqIlAEx3SC5e9u7jcuDKzl5Bb7UwbvyqfDUbsUIQ=;
        b=p2O5CiLPnmvZIt6mLLtZZjcT/hlQ7+OVqIxZ+TCBm6p05WcF7iqhem4sojC+W5NJTM
         pGpi535OOkrYpR3jICYehYyDP8gXG0bSd419N98A4c8ny3CQ+2tCIzfhCE7KeGbcI3dz
         xmC4OcSbHtNvtHpMtWfqNUM802KZzp2H8b1XZUDuaHvZaIwrbL1gCpgJMbcQMmLT0UZg
         XPQp93OazKzhWBbezKPKhTBgknDkJHge7CGIBerQEpAFczbxjxmLcd1CPsacGZmhrIHl
         DKCSOKFZUYNVVQqQn4PPTc6O7zbvs2wJdZNzoxpBRPAi4yRH8asn+sWN9r6immDChOLn
         zG0w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jarkko.sakkinen@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=jarkko.sakkinen@linux.intel.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jarkko.sakkinen@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=jarkko.sakkinen@linux.intel.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,413,1520924400";
   d="scan'208";a="225277338"
Date: Fri, 18 May 2018 11:03:37 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] tpm: migrate tpm2_get_random() to use struct
 tpm_buf
Message-ID: <20180518080337.GA14777@linux.intel.com>
References: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
 <20180326121406.14548-5-jarkko.sakkinen@linux.intel.com>
 <ad7a4070-6fff-38e3-0284-45f1d7e6722f@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad7a4070-6fff-38e3-0284-45f1d7e6722f@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596002391978242985?=
X-GMAIL-MSGID: =?utf-8?q?1600788231170329376?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 11:39:16AM +0530, Nayna Jain wrote:
> 
> 
> On 03/26/2018 05:44 PM, Jarkko Sakkinen wrote:
> > In order to make struct tpm_buf the first class object for constructing
> > TPM commands, migrate tpm2_get_random() to use it. In addition, removed
> > remaining references to struct tpm2_cmd. All of them use it to acquire
> > the length of the response, which can be achieved by using
> > tpm_buf_length().
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >   drivers/char/tpm/tpm.h      | 19 ++++-----
> >   drivers/char/tpm/tpm2-cmd.c | 98 ++++++++++++++++++---------------------------
> >   2 files changed, 49 insertions(+), 68 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > index 7f2d0f489e9c..aa849a1b2641 100644
> > --- a/drivers/char/tpm/tpm.h
> > +++ b/drivers/char/tpm/tpm.h
> > @@ -421,23 +421,24 @@ struct tpm_buf {
> >   	u8 *data;
> >   };
> > 
> > -static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
> > +static inline void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
> >   {
> >   	struct tpm_input_header *head;
> > +	head = (struct tpm_input_header *)buf->data;
> > +	head->tag = cpu_to_be16(tag);
> > +	head->length = cpu_to_be32(sizeof(*head));
> > +	head->ordinal = cpu_to_be32(ordinal);
> > +}
> > 
> > +static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
> > +{
> >   	buf->data_page = alloc_page(GFP_HIGHUSER);
> >   	if (!buf->data_page)
> >   		return -ENOMEM;
> > 
> >   	buf->flags = 0;
> >   	buf->data = kmap(buf->data_page);
> > -
> > -	head = (struct tpm_input_header *) buf->data;
> > -
> > -	head->tag = cpu_to_be16(tag);
> > -	head->length = cpu_to_be32(sizeof(*head));
> > -	head->ordinal = cpu_to_be32(ordinal);
> > -
> > +	tpm_buf_reset(buf, tag, ordinal);
> >   	return 0;
> >   }
> > 
> > @@ -566,7 +567,7 @@ static inline u32 tpm2_rc_value(u32 rc)
> >   int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf);
> >   int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
> >   		    struct tpm2_digest *digests);
> > -int tpm2_get_random(struct tpm_chip *chip, u8 *out, size_t max);
> > +int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
> >   void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
> >   			    unsigned int flags);
> >   int tpm2_seal_trusted(struct tpm_chip *chip,
> > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> > index b3b52f9eb65f..d5c222f98515 100644
> > --- a/drivers/char/tpm/tpm2-cmd.c
> > +++ b/drivers/char/tpm/tpm2-cmd.c
> > @@ -27,25 +27,6 @@ enum tpm2_session_attributes {
> >   	TPM2_SA_CONTINUE_SESSION	= BIT(0),
> >   };
> > 
> > -struct tpm2_get_random_in {
> > -	__be16	size;
> > -} __packed;
> > -
> > -struct tpm2_get_random_out {
> > -	__be16	size;
> > -	u8	buffer[TPM_MAX_RNG_DATA];
> > -} __packed;
> > -
> > -union tpm2_cmd_params {
> > -	struct	tpm2_get_random_in	getrandom_in;
> > -	struct	tpm2_get_random_out	getrandom_out;
> > -};
> > -
> > -struct tpm2_cmd {
> > -	tpm_cmd_header		header;
> > -	union tpm2_cmd_params	params;
> > -} __packed;
> > -
> >   struct tpm2_hash {
> >   	unsigned int crypto_id;
> >   	unsigned int tpm_id;
> > @@ -300,67 +281,70 @@ int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
> >   }
> > 
> > 
> > -#define TPM2_GETRANDOM_IN_SIZE \
> > -	(sizeof(struct tpm_input_header) + \
> > -	 sizeof(struct tpm2_get_random_in))
> > -
> > -static const struct tpm_input_header tpm2_getrandom_header = {
> > -	.tag = cpu_to_be16(TPM2_ST_NO_SESSIONS),
> > -	.length = cpu_to_be32(TPM2_GETRANDOM_IN_SIZE),
> > -	.ordinal = cpu_to_be32(TPM2_CC_GET_RANDOM)
> > -};
> > +struct tpm2_get_random_out {
> > +	__be16 size;
> > +	u8 buffer[TPM_MAX_RNG_DATA];
> > +} __packed;
> > 
> >   /**
> >    * tpm2_get_random() - get random bytes from the TPM RNG
> >    *
> >    * @chip: TPM chip to use
> > - * @out: destination buffer for the random bytes
> > + * @dest: destination buffer for the random bytes
> >    * @max: the max number of bytes to write to @out
> >    *
> >    * Return:
> > - *    Size of the output buffer, or -EIO on error.
> > + * size of the output buffer when the operation is successful.
> > + * A negative number for system errors (errno).
> >    */
> > -int tpm2_get_random(struct tpm_chip *chip, u8 *out, size_t max)
> > +int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
> >   {
> > -	struct tpm2_cmd cmd;
> > -	u32 recd, rlength;
> > -	u32 num_bytes;
> > +	struct tpm2_get_random_out *out;
> > +	struct tpm_buf buf;
> > +	u32 recd;
> > +	u32 num_bytes = max;
> >   	int err;
> >   	int total = 0;
> >   	int retries = 5;
> > -	u8 *dest = out;
> > -
> > -	num_bytes = min_t(u32, max, sizeof(cmd.params.getrandom_out.buffer));
> > +	u8 *dest_ptr = dest;
> > 
> > -	if (!out || !num_bytes ||
> > -	    max > sizeof(cmd.params.getrandom_out.buffer))
> > +	if (!num_bytes || max > TPM_MAX_RNG_DATA)
> >   		return -EINVAL;
> > 
> > -	do {
> > -		cmd.header.in = tpm2_getrandom_header;
> > -		cmd.params.getrandom_in.size = cpu_to_be16(num_bytes);
> > +	err = tpm_buf_init(&buf, 0, 0);
> > +	if (err)
> > +		return err;
> > 
> > -		err = tpm_transmit_cmd(chip, NULL, &cmd, sizeof(cmd),
> > +	do {
> > +		tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_RANDOM);
> > +		tpm_buf_append_u16(&buf, num_bytes);
> > +		err = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE,
> >   				       offsetof(struct tpm2_get_random_out,
> >   						buffer),
> >   				       0, "attempting get random");
> >   		if (err)
> > -			break;
> > +			goto out;
> > 
> > -		recd = min_t(u32, be16_to_cpu(cmd.params.getrandom_out.size),
> > -			     num_bytes);
> > -		rlength = be32_to_cpu(cmd.header.out.length);
> > -		if (rlength < offsetof(struct tpm2_get_random_out, buffer) +
> > -			      recd)
> > -			return -EFAULT;
> > -		memcpy(dest, cmd.params.getrandom_out.buffer, recd);
> > +		out = (struct tpm2_get_random_out *)
> > +			&buf.data[TPM_HEADER_SIZE];
> > +		recd = min_t(u32, be16_to_cpu(out->size), num_bytes);
> > +		if (tpm_buf_length(&buf) <
> > +		    offsetof(struct tpm2_get_random_out, buffer) + recd) {
> > +			err = -EFAULT;
> > +			goto out;
> > +		}
> > +		memcpy(dest_ptr, out->buffer, recd);
> > 
> > -		dest += recd;
> > +		dest_ptr += recd;
> >   		total += recd;
> >   		num_bytes -= recd;
> >   	} while (retries-- && total < max);
> > 
> > +	tpm_buf_destroy(&buf);
> >   	return total ? total : -EIO;
> > +out:
> > +	tpm_buf_destroy(&buf);
> > +	return err;
> >   }
> 
> How about having it as :
> 
>     if (!total)
>         err = -EIO;
> out:
>     tpm_buf_destroy(&buf);
>     return total?:err;

I think the former is actually more readable in this case albeit there
is one 

> 
> >   /**
> > @@ -434,7 +418,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> >   {
> >   	unsigned int blob_len;
> >   	struct tpm_buf buf;
> > -	u32 hash, rlength;
> > +	u32 hash;
> >   	int i;
> >   	int rc;
> > 
> > @@ -509,8 +493,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> >   		rc = -E2BIG;
> >   		goto out;
> >   	}
> > -	rlength = be32_to_cpu(((struct tpm2_cmd *)&buf)->header.out.length);
> > -	if (rlength < TPM_HEADER_SIZE + 4 + blob_len) {
> > +	if (tpm_buf_length(&buf) < TPM_HEADER_SIZE + 4 + blob_len) {
> >   		rc = -EFAULT;
> >   		goto out;
> >   	}
> > @@ -620,7 +603,6 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
> >   	u16 data_len;
> >   	u8 *data;
> >   	int rc;
> > -	u32 rlength;
> > 
> >   	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_UNSEAL);
> >   	if (rc)
> > @@ -648,9 +630,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
> >   			goto out;
> >   		}
> > 
> > -		rlength = be32_to_cpu(((struct tpm2_cmd *)&buf)
> > -					->header.out.length);
> > -		if (rlength < TPM_HEADER_SIZE + 6 + data_len) {
> > +		if (tpm_buf_length(&buf) < TPM_HEADER_SIZE + 6 + data_len) {
> >   			rc = -EFAULT;
> >   			goto out;
> >   		}
> Probably, all the changes related to the use of tpm_buf_length() could be a
> separate patch in itself ?

I think so but have to recheck with time.

I'll drop these now  from master (really not something that needs to be
rushed) and also update the comments according to standard that I
described to you in my own review comments (since they are not in that
standard).

> Otherwise,
> 
> Tested-by: Nayna Jain<nayna@linux.vnet.ibm.com>

Thank you.

/Jarkko
