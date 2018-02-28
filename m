Return-Path: <jgg@ziepe.ca>
ARC-Seal: i=1; a=rsa-sha256; t=1519849545; cv=none;
        d=google.com; s=arc-20160816;
        b=LHWd2zfDxGXNoH+v19x3ZZseZCWaP4cneLt6FyipUAGE7YUsCsxzVJhUhBo8vWPL40
         uxIbpanoZpkSDCZCtjsH8wVwb29AmQ30LicO72fJqogYNoXTHa9sh96ejBMPgmsoWiWG
         4dU4hLd9XjpBbUP+RxnhFOaJV8vXxISlq044//KT1sJ2TGodLcnue4mAHyqO7NRIgvmF
         Jiziy6NBq9FWBpc28kSjSAm8pJJRdaOKLcW9GY2+FA5wTp6aZQ65GOzg9BjZF09Nd24r
         G8HVPqDlCDdN0OMsR9BOExYbMCszsO0EyAZDO3iAt+2GPJPEGR4FwsPbQBK7UugpNSA8
         UecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=0g7kdCglJU4kJ4MnbVD53WA/ExgplIHQjZfn+mh5lZU=;
        b=J9bexpcsduEhE9O57TzuFvht8g7e/TmoBAdiAO50COxGCXKO46gY4AimtEPZP2s3kR
         l02DQ7SVHQgPAmQZgJ3EM+7liqj5U4+omiFWbQUEHA8SJIHsM8EA5sHlWUZkafAbC+dz
         mbzX1SD7ov/kZfCieSgH6i9ud8I53PJDGm8ElyqC+lIf1UP1+KiPHsECBONUYBSVMdkT
         Y1Wqg4CXVOFaO2tkRRTWe1MoLqUOaFiGFRrwaMeQIk7om2tvGRlW+RbVK+OUNgrq3/73
         nrDzD2o2b4bMVAajZXQaI+dYI/9ssWqwyJGu430jKPjMrxDuRWOLEXe4pCZVaj+a1Egm
         zr0g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ziepe.ca header.s=google header.b=QHG1pdG0;
       spf=pass (google.com: domain of jgg@ziepe.ca designates 209.85.220.65 as permitted sender) smtp.mailfrom=jgg@ziepe.ca
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ziepe.ca header.s=google header.b=QHG1pdG0;
       spf=pass (google.com: domain of jgg@ziepe.ca designates 209.85.220.65 as permitted sender) smtp.mailfrom=jgg@ziepe.ca
X-Google-Smtp-Source: AH8x225LU+VWUXqtTQe09eEZb051H923p2pk0gWTAXXMCZZJHOQE4KqUX5sPapckE2oVmrfQ7v6/vw==
Date: Wed, 28 Feb 2018 13:25:40 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
	keyrings@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] tpm: migrate tpm2_shutdown() to use struct tpm_buf
Message-ID: <20180228202540.GA19007@ziepe.ca>
References: <20180228195819.22231-1-jarkko.sakkinen@linux.intel.com>
 <20180228195819.22231-3-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228195819.22231-3-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676060311547889?=
X-GMAIL-MSGID: =?utf-8?q?1593677757104430155?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 09:58:15PM +0200, Jarkko Sakkinen wrote:
> In order to make struct tpm_buf the first class object for constructing TPM
> commands, migrate tpm2_shutdown() to use it. In addition, removed the klog
> entry when tpm_transmit_cmd() fails because tpm_tansmit_cmd() already
> prints an error message.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>  drivers/char/tpm/tpm2-cmd.c | 41 +++++++++++++----------------------------
>  1 file changed, 13 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 6eeff3a60003..5f92141b1e16 100644
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -27,10 +27,6 @@ enum tpm2_session_attributes {
>  	TPM2_SA_CONTINUE_SESSION	= BIT(0),
>  };
>  
> -struct tpm2_startup_in {
> -	__be16	startup_type;
> -} __packed;
> -
>  struct tpm2_get_tpm_pt_in {
>  	__be32	cap_id;
>  	__be32	property_id;
> @@ -55,7 +51,6 @@ struct tpm2_get_random_out {
>  } __packed;
>  
>  union tpm2_cmd_params {
> -	struct	tpm2_startup_in		startup_in;
>  	struct	tpm2_get_tpm_pt_in	get_tpm_pt_in;
>  	struct	tpm2_get_tpm_pt_out	get_tpm_pt_out;
>  	struct	tpm2_get_random_in	getrandom_in;
> @@ -760,40 +755,30 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,  u32 *value,
>  }
>  EXPORT_SYMBOL_GPL(tpm2_get_tpm_pt);
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
>  /**
>   * tpm2_shutdown() - send shutdown command to the TPM chip
>   *
> + * In places where shutdown command is sent there's no much we can do except
> + * print the error code on a system failure.
> + *
>   * @chip:		TPM chip to use.
>   * @shutdown_type:	shutdown type. The value is either
>   *			TPM_SU_CLEAR or TPM_SU_STATE.
>   */
>  void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type)
>  {
> -	struct tpm2_cmd cmd;
> +	struct tpm_buf buf;
>  	int rc;
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
> +	if (rc) {
> +		dev_err(&chip->dev, "%s: out of memory", __func__);

Don't print for out of memory. The kernel already makes lots of
prints for you. Same comment everywhere.

Jason
