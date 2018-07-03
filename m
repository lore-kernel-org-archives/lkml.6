Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0520CC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08D4205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08D4205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753497AbeGCPYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:24:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:8710 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752905AbeGCPYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:24:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 08:24:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,304,1526367600"; 
   d="scan'208";a="213108709"
Received: from cdikicix-mobl.ger.corp.intel.com ([10.249.254.69])
  by orsmga004.jf.intel.com with ESMTP; 03 Jul 2018 08:24:35 -0700
Message-ID: <edf4aeaab76713579016cb009a0e632d7417c5f8.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] KEYS: trusted: Find tpm_chip and use it until
 module shutdown
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        jejb@linux.vnet.ibm.com
Cc:     jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        keyrings@vger.kernel.org
Date:   Tue, 03 Jul 2018 18:24:34 +0300
In-Reply-To: <20180626193040.2509798-3-stefanb@linux.vnet.ibm.com>
References: <20180626193040.2509798-1-stefanb@linux.vnet.ibm.com>
         <20180626193040.2509798-3-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-26 at 15:30 -0400, Stefan Berger wrote:
> Use tpm_default_chip() to find the system's default TPM chip and
> use it as the tpm_chip parameter for all TPM operations. Release
> the tpm_chip when the module is shut down.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  security/keys/trusted.c | 41 ++++++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/security/keys/trusted.c b/security/keys/trusted.c
> index 423776682025..06d863caea43 100644
> --- a/security/keys/trusted.c
> +++ b/security/keys/trusted.c
> @@ -42,6 +42,7 @@ struct sdesc {
>  
>  static struct crypto_shash *hashalg;
>  static struct crypto_shash *hmacalg;
> +static struct tpm_chip *tpm_chip;
>  
>  static struct sdesc *init_sdesc(struct crypto_shash *alg)
>  {
> @@ -360,7 +361,7 @@ static int trusted_tpm_send(unsigned char *cmd, size_t
> buflen)
>  	int rc;
>  
>  	dump_tpm_buf(cmd);
> -	rc = tpm_send(NULL, cmd, buflen);
> +	rc = tpm_send(tpm_chip, cmd, buflen);
>  	dump_tpm_buf(cmd);
>  	if (rc > 0)
>  		/* Can't return positive return codes values to keyctl */
> @@ -381,10 +382,10 @@ static int pcrlock(const int pcrnum)
>  
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
> -	ret = tpm_get_random(NULL, hash, SHA1_DIGEST_SIZE);
> +	ret = tpm_get_random(tpm_chip, hash, SHA1_DIGEST_SIZE);
>  	if (ret != SHA1_DIGEST_SIZE)
>  		return ret;
> -	return tpm_pcr_extend(NULL, pcrnum, hash) ? -EINVAL : 0;
> +	return tpm_pcr_extend(tpm_chip, pcrnum, hash) ? -EINVAL : 0;
>  }
>  
>  /*
> @@ -397,7 +398,7 @@ static int osap(struct tpm_buf *tb, struct osapsess *s,
>  	unsigned char ononce[TPM_NONCE_SIZE];
>  	int ret;
>  
> -	ret = tpm_get_random(NULL, ononce, TPM_NONCE_SIZE);
> +	ret = tpm_get_random(tpm_chip, ononce, TPM_NONCE_SIZE);
>  	if (ret != TPM_NONCE_SIZE)
>  		return ret;
>  
> @@ -492,7 +493,7 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
>  	if (ret < 0)
>  		goto out;
>  
> -	ret = tpm_get_random(NULL, td->nonceodd, TPM_NONCE_SIZE);
> +	ret = tpm_get_random(tpm_chip, td->nonceodd, TPM_NONCE_SIZE);
>  	if (ret != TPM_NONCE_SIZE)
>  		goto out;
>  	ordinal = htonl(TPM_ORD_SEAL);
> @@ -602,7 +603,7 @@ static int tpm_unseal(struct tpm_buf *tb,
>  
>  	ordinal = htonl(TPM_ORD_UNSEAL);
>  	keyhndl = htonl(SRKHANDLE);
> -	ret = tpm_get_random(NULL, nonceodd, TPM_NONCE_SIZE);
> +	ret = tpm_get_random(tpm_chip, nonceodd, TPM_NONCE_SIZE);
>  	if (ret != TPM_NONCE_SIZE) {
>  		pr_info("trusted_key: tpm_get_random failed (%d)\n", ret);
>  		return ret;
> @@ -747,7 +748,7 @@ static int getoptions(char *c, struct trusted_key_payload
> *pay,
>  	int i;
>  	int tpm2;
>  
> -	tpm2 = tpm_is_tpm2(NULL);
> +	tpm2 = tpm_is_tpm2(tpm_chip);
>  	if (tpm2 < 0)
>  		return tpm2;
>  
> @@ -916,7 +917,7 @@ static struct trusted_key_options
> *trusted_options_alloc(void)
>  	struct trusted_key_options *options;
>  	int tpm2;
>  
> -	tpm2 = tpm_is_tpm2(NULL);
> +	tpm2 = tpm_is_tpm2(tpm_chip);
>  	if (tpm2 < 0)
>  		return NULL;
>  
> @@ -966,7 +967,7 @@ static int trusted_instantiate(struct key *key,
>  	size_t key_len;
>  	int tpm2;
>  
> -	tpm2 = tpm_is_tpm2(NULL);
> +	tpm2 = tpm_is_tpm2(tpm_chip);
>  	if (tpm2 < 0)
>  		return tpm2;
>  
> @@ -1007,7 +1008,7 @@ static int trusted_instantiate(struct key *key,
>  	switch (key_cmd) {
>  	case Opt_load:
>  		if (tpm2)
> -			ret = tpm_unseal_trusted(NULL, payload, options);
> +			ret = tpm_unseal_trusted(tpm_chip, payload, options);
>  		else
>  			ret = key_unseal(payload, options);
>  		dump_payload(payload);
> @@ -1017,13 +1018,13 @@ static int trusted_instantiate(struct key *key,
>  		break;
>  	case Opt_new:
>  		key_len = payload->key_len;
> -		ret = tpm_get_random(NULL, payload->key, key_len);
> +		ret = tpm_get_random(tpm_chip, payload->key, key_len);
>  		if (ret != key_len) {
>  			pr_info("trusted_key: key_create failed (%d)\n",
> ret);
>  			goto out;
>  		}
>  		if (tpm2)
> -			ret = tpm_seal_trusted(NULL, payload, options);
> +			ret = tpm_seal_trusted(tpm_chip, payload, options);
>  		else
>  			ret = key_seal(payload, options);
>  		if (ret < 0)
> @@ -1226,12 +1227,26 @@ static int __init init_trusted(void)
>  		return ret;
>  	ret = register_key_type(&key_type_trusted);
>  	if (ret < 0)
> -		trusted_shash_release();
> +		goto exit_shash_release;
> +	tpm_chip = tpm_default_chip();
> +	if (!tpm_chip) {
> +		ret = -ENODEV;
> +		goto exit_unregister;
> +	}
> +	return 0;
> +
> +exit_unregister:
> +	unregister_key_type(&key_type_trusted);
> +
> +exit_shash_release:
> +	trusted_shash_release();
>  	return ret;
>  }
>  
>  static void __exit cleanup_trusted(void)
>  {
> +	if (tpm_chip)
> +		tpm_put_chip(tpm_chip);
>  	trusted_shash_release();
>  	unregister_key_type(&key_type_trusted);
>  }

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Is James maintaining this now? Have not seen his feedback yet...

/Jarkko
