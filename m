Return-Path: <why2jjj.linux@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520545624; cv=none;
        d=google.com; s=arc-20160816;
        b=r8/Td2SMK0MToLYOm/OUNEW3bDGaZO3e5Eslt1JmNUatpMiadgOcvCENrlqLjlCPed
         98IlSAV93eWV1jATv5Fb4LWdptP7QRUxvxn8iYNMUJHCWbcGiJEnM9Uz5qLpmuEqfaND
         TkJpKyxZT2lxba1LSn4mckl6c/+cisKY8MbAs6J4BOT27dgVaI2pesC+mOXCiC7yoTEN
         6VtjGuy7p/7a58k6qAhUDNGLHvlaos/1Q6o9LiGBiURrR+p7XqUnegYFnsKFh5T5TJj4
         IKlAl3AoPEPfrO78sBr0rOv7emj7hth1hgWuvYassx3axSpKDpC9PqBAVqKXhcl2aSsM
         ADaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=Nml4PfKv9x7fKrN9PnwJcnSvg5DnBnPpLFJdnwj3Eto=;
        b=hd3PVkNIrHEQ9EY/RSbWi6N35PU6vYTvDZVZndBDXsLwnFtyLKoZ+r0/qGbV3aKDkC
         zqsFp72i1CZe/SkjFFcQyHWZVOHYMHS+GMY3yTRPUequijL0Bf++Fiumc358ZoXbVqSm
         TqK6L4WyXjPFJgeemCi7JaMiZAMAQ6Y+SkU9VcyTdJ3fY7l6PLJ8pea2sjT8ta/Nfa26
         9SfDFfOYfxv/0PiAH20MHHFi3FQyDe3iMRGInqwAarwUqOYkNyboMmn3iZtpD8W5wTLr
         yBWkMe1KTES4pbQGy4OUvmUKIxONoOGVNLM/xCWCAATrPXkivR1Cy+725RXPrPfWQhQV
         nwjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=h+mPhX/O;
       spf=pass (google.com: domain of why2jjj.linux@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=why2jjj.linux@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=h+mPhX/O;
       spf=pass (google.com: domain of why2jjj.linux@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=why2jjj.linux@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvLbZGMvkAZMQhQGX4Y4OvvcKmht1ZQsIgOH8mDtIQTvbMgMTGmDOiUmucc7PmhHXBxqDEj/Q==
Subject: Re: [PATCH v3 3/5] tpm: migrate tpm2_probe() to use struct tpm_buf
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
 Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
 <20180305165614.5469-4-jarkko.sakkinen@linux.intel.com>
From: J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <3f3f9059-06ae-cb78-0d02-2658b2edc234@gmail.com>
Date: Thu, 8 Mar 2018 13:47:00 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305165614.5469-4-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676067717266056?=
X-GMAIL-MSGID: =?utf-8?q?1594407648338691553?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/5/18 8:56 AM, Jarkko Sakkinen wrote:
> In order to make struct tpm_buf the first class object for constructing TPM
> commands, migrate tpm2_probe() to use it.
>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>   drivers/char/tpm/tpm2-cmd.c | 27 +++++++++++++++------------
>   1 file changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index abe6ef4a7a0b..890d83c5c78b 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -851,22 +851,25 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
>    */
>   int tpm2_probe(struct tpm_chip *chip)
>   {
> -	struct tpm2_cmd cmd;
> +	struct tpm_output_header *out;
> +	struct tpm_buf buf;
>   	int rc;
>   
> -	cmd.header.in = tpm2_get_tpm_pt_header;
> -	cmd.params.get_tpm_pt_in.cap_id = cpu_to_be32(TPM2_CAP_TPM_PROPERTIES);
> -	cmd.params.get_tpm_pt_in.property_id = cpu_to_be32(0x100);
> -	cmd.params.get_tpm_pt_in.property_cnt = cpu_to_be32(1);
> -
> -	rc = tpm_transmit_cmd(chip, NULL, &cmd, sizeof(cmd), 0, 0, NULL);
> -	if (rc <  0)
> +	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
> +	if (rc)
>   		return rc;
> -
> -	if (be16_to_cpu(cmd.header.out.tag) == TPM2_ST_NO_SESSIONS)
> +	tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
> +	tpm_buf_append_u32(&buf, TPM_PT_TOTAL_COMMANDS);
> +	tpm_buf_append_u32(&buf, 1);
> +	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0, NULL);
> +	if (rc <  0)
> +		goto out;
> +	out = (struct tpm_output_header *)buf.data;
> +	if (be16_to_cpu(out->tag) == TPM2_ST_NO_SESSIONS)
>   		chip->flags |= TPM_CHIP_FLAG_TPM2;
> -
> -	return 0;
> +out:
> +	tpm_buf_destroy(&buf);
> +	return rc;


Looks better :-).


Acked-by: Jay Freyensee <why2jjj.linux@gmail.com>


>   }
>   EXPORT_SYMBOL_GPL(tpm2_probe);
>   
