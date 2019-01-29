Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07AAC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46592147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfA2VCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:02:45 -0500
Received: from mga01.intel.com ([192.55.52.88]:52337 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbfA2VCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 16:02:44 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 13:02:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,538,1539673200"; 
   d="scan'208";a="118456834"
Received: from rkazants-mobl.ccr.corp.intel.com (HELO localhost) ([10.249.254.212])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jan 2019 13:02:38 -0800
Date:   Tue, 29 Jan 2019 23:02:45 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        matthewgarrett@google.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v8 7/7] tpm: pass an array of tpm_extend_digest
 structures to tpm_pcr_extend()
Message-ID: <20190129210245.GF11615@linux.intel.com>
References: <20190124154910.29948-1-roberto.sassu@huawei.com>
 <20190124154910.29948-8-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124154910.29948-8-roberto.sassu@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 04:49:10PM +0100, Roberto Sassu wrote:
> Currently, tpm_pcr_extend() accepts as an input only a SHA1 digest.
> 
> This patch replaces the hash parameter of tpm_pcr_extend() with an array of
> tpm_digest structures, so that the caller can provide a digest for each PCR
> bank currently allocated in the TPM.
> 
> tpm_pcr_extend() will not extend banks for which no digest was provided,
> as it happened before this patch, but instead it requires that callers
> provide the full set of digests. Since the number of digests will always be
> chip->nr_allocated_banks, the count parameter has been removed.
> 
> Due to the API change, ima_pcr_extend() and pcrlock() have been modified.
> Since the number of allocated banks is not known in advance, the memory for
> the digests must be dynamically allocated. To avoid performance degradation
> and to avoid that a PCR extend is not done due to lack of memory, the array
> of tpm_digest structures is allocated by the users of the TPM driver at
> initialization time.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  drivers/char/tpm/tpm-interface.c   | 30 ++++++++------------
>  drivers/char/tpm/tpm.h             |  2 +-
>  drivers/char/tpm/tpm2-cmd.c        | 10 ++-----
>  include/linux/tpm.h                |  5 ++--
>  security/integrity/ima/ima.h       |  1 +
>  security/integrity/ima/ima_init.c  | 22 +++++++++++++++
>  security/integrity/ima/ima_queue.c |  6 +++-
>  security/keys/trusted.c            | 44 ++++++++++++++++++++++++------
>  8 files changed, 82 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index eb7c79ca8a94..b52242a165e0 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -478,42 +478,34 @@ EXPORT_SYMBOL_GPL(tpm_pcr_read);
>   * tpm_pcr_extend - extend a PCR value in SHA1 bank.
>   * @chip:	a &struct tpm_chip instance, %NULL for the default chip
>   * @pcr_idx:	the PCR to be retrieved
> - * @hash:	the hash value used to extend the PCR value
> + * @digests:	array of tpm_digest structures used to extend PCRs
>   *
> - * Note: with TPM 2.0 extends also those banks for which no digest was
> - * specified in order to prevent malicious use of those PCR banks.
> + * Note: callers must pass a digest for every allocated PCR bank, in the same
> + * order of the banks in chip->allocated_banks.
>   *
>   * Return: same as with tpm_transmit_cmd()
>   */
> -int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash)
> +int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
> +		   struct tpm_digest *digests)
>  {
>  	int rc;
> -	struct tpm_digest *digest_list;
>  	int i;
>  
>  	chip = tpm_find_get_ops(chip);
>  	if (!chip)
>  		return -ENODEV;
>  
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> -		digest_list = kcalloc(chip->nr_allocated_banks,
> -				      sizeof(*digest_list), GFP_KERNEL);
> -		if (!digest_list)
> -			return -ENOMEM;
> -
> -		for (i = 0; i < chip->nr_allocated_banks; i++) {
> -			digest_list[i].alg_id = chip->allocated_banks[i].alg_id;
> -			memcpy(digest_list[i].digest, hash, TPM_DIGEST_SIZE);
> -		}
> +	for (i = 0; i < chip->nr_allocated_banks; i++)
> +		if (digests[i].alg_id != chip->allocated_banks[i].alg_id)
> +			return -EINVAL;
>  
> -		rc = tpm2_pcr_extend(chip, pcr_idx, chip->nr_allocated_banks,
> -				     digest_list);
> -		kfree(digest_list);
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +		rc = tpm2_pcr_extend(chip, pcr_idx, digests);
>  		tpm_put_ops(chip);
>  		return rc;
>  	}
>  
> -	rc = tpm1_pcr_extend(chip, pcr_idx, hash,
> +	rc = tpm1_pcr_extend(chip, pcr_idx, digests[0].digest,
>  			     "attempting extend a PCR value");
>  	tpm_put_ops(chip);
>  	return rc;
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index f5f15365b85b..5fb3f8bb279b 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -453,7 +453,7 @@ static inline u32 tpm2_rc_value(u32 rc)
>  int tpm2_get_timeouts(struct tpm_chip *chip);
>  int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
>  		  struct tpm_digest *digest, u16 *digest_size_ptr);
> -int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
> +int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>  		    struct tpm_digest *digests);
>  int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
>  void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 760893957f13..dc115096e280 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -247,12 +247,11 @@ struct tpm2_null_auth_area {
>   *
>   * @chip:	TPM chip to use.
>   * @pcr_idx:	index of the PCR.
> - * @count:	number of digests passed.
>   * @digests:	list of pcr banks and corresponding digest values to extend.
>   *
>   * Return: Same as with tpm_transmit_cmd.
>   */
> -int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
> +int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>  		    struct tpm_digest *digests)
>  {
>  	struct tpm_buf buf;
> @@ -260,9 +259,6 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
>  	int rc;
>  	int i;
>  
> -	if (count > chip->nr_allocated_banks)
> -		return -EINVAL;
> -
>  	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
>  	if (rc)
>  		return rc;
> @@ -277,9 +273,9 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
>  	tpm_buf_append_u32(&buf, sizeof(struct tpm2_null_auth_area));
>  	tpm_buf_append(&buf, (const unsigned char *)&auth_area,
>  		       sizeof(auth_area));
> -	tpm_buf_append_u32(&buf, count);
> +	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
>  
> -	for (i = 0; i < count; i++) {
> +	for (i = 0; i < chip->nr_allocated_banks; i++) {
>  		tpm_buf_append_u16(&buf, digests[i].alg_id);
>  		tpm_buf_append(&buf, (const unsigned char *)&digests[i].digest,
>  			       chip->allocated_banks[i].digest_size);
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 5ad0e58d5e09..08bf38e4c7aa 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -175,7 +175,8 @@ struct tpm_chip {
>  extern int tpm_is_tpm2(struct tpm_chip *chip);
>  extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
>  			struct tpm_digest *digest);
> -extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash);
> +extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
> +			  struct tpm_digest *digests);
>  extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
>  extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
>  extern int tpm_seal_trusted(struct tpm_chip *chip,
> @@ -198,7 +199,7 @@ static inline int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx,
>  }
>  
>  static inline int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
> -				 const u8 *hash)
> +				 struct tpm_digest *digests)
>  {
>  	return -ENODEV;
>  }
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index cc12f3449a72..e6b2dcb0846a 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -56,6 +56,7 @@ extern int ima_policy_flag;
>  extern int ima_hash_algo;
>  extern int ima_appraise;
>  extern struct tpm_chip *ima_tpm_chip;
> +extern struct tpm_digest *digests;
>  
>  /* IMA event related data */
>  struct ima_event_data {
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> index 6bb42a9c5e47..296a965b11ef 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -27,6 +27,7 @@
>  /* name for boot aggregate entry */
>  static const char boot_aggregate_name[] = "boot_aggregate";
>  struct tpm_chip *ima_tpm_chip;
> +struct tpm_digest *digests;
>  
>  /* Add the boot aggregate to the IMA measurement list and extend
>   * the PCR register.
> @@ -104,6 +105,24 @@ void __init ima_load_x509(void)
>  }
>  #endif
>  
> +int __init ima_init_digests(void)
> +{
> +	int i;
> +
> +	if (!ima_tpm_chip)
> +		return 0;
> +
> +	digests = kcalloc(ima_tpm_chip->nr_allocated_banks, sizeof(*digests),
> +			  GFP_NOFS);
> +	if (!digests)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++)
> +		digests[i].alg_id = ima_tpm_chip->allocated_banks[i].alg_id;
> +
> +	return 0;
> +}
> +
>  int __init ima_init(void)
>  {
>  	int rc;
> @@ -125,6 +144,9 @@ int __init ima_init(void)
>  
>  	ima_load_kexec_buffer();
>  
> +	rc = ima_init_digests();
> +	if (rc != 0)
> +		return rc;
>  	rc = ima_add_boot_aggregate();	/* boot aggregate must be first entry */
>  	if (rc != 0)
>  		return rc;
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> index 0e41dc1df1d4..719e88ca58f6 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -140,11 +140,15 @@ unsigned long ima_get_binary_runtime_size(void)
>  static int ima_pcr_extend(const u8 *hash, int pcr)
>  {
>  	int result = 0;
> +	int i;
>  
>  	if (!ima_tpm_chip)
>  		return result;
>  
> -	result = tpm_pcr_extend(ima_tpm_chip, pcr, hash);
> +	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++)
> +		memcpy(digests[i].digest, hash, TPM_DIGEST_SIZE);
> +
> +	result = tpm_pcr_extend(ima_tpm_chip, pcr, digests);
>  	if (result != 0)
>  		pr_err("Error Communicating to TPM chip, result: %d\n", result);
>  	return result;
> diff --git a/security/keys/trusted.c b/security/keys/trusted.c
> index 1a20a9692fef..baba0abc7850 100644
> --- a/security/keys/trusted.c
> +++ b/security/keys/trusted.c
> @@ -35,6 +35,7 @@
>  static const char hmac_alg[] = "hmac(sha1)";
>  static const char hash_alg[] = "sha1";
>  static struct tpm_chip *chip;
> +static struct tpm_digest *digests;
>  
>  struct sdesc {
>  	struct shash_desc shash;
> @@ -380,15 +381,10 @@ EXPORT_SYMBOL_GPL(trusted_tpm_send);
>   */
>  static int pcrlock(const int pcrnum)
>  {
> -	unsigned char hash[SHA1_DIGEST_SIZE];
> -	int ret;
> -
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
> -	ret = tpm_get_random(chip, hash, SHA1_DIGEST_SIZE);
> -	if (ret != SHA1_DIGEST_SIZE)
> -		return ret;
> -	return tpm_pcr_extend(chip, pcrnum, hash) ? -EINVAL : 0;
> +
> +	return tpm_pcr_extend(chip, pcrnum, digests) ? -EINVAL : 0;
>  }
>  
>  /*
> @@ -1222,6 +1218,32 @@ static int __init trusted_shash_alloc(void)
>  	return ret;
>  }
>  
> +static int __init init_digests(void)
> +{
> +	int ret;
> +	int i;
> +
> +	digests = kcalloc(chip->nr_allocated_banks, sizeof(*digests),
> +			  GFP_KERNEL);
> +	if (!digests)
> +		return -ENOMEM;
> +
> +	ret = tpm_get_random(chip, digests[0].digest,
> +			     sizeof(digests[0].digest));
> +	if (ret != sizeof(digests[0].digest))
> +		return 0;

You forgot to free digests i.e. you leak memory.

> +
> +	for (i = 0; i < chip->nr_allocated_banks; i++) {
> +		digests[i].alg_id = chip->allocated_banks[i].alg_id;
> +
> +		if (i)
> +			memcpy(digests[i].digest, digests[0].digest,
> +			       sizeof(digests[0].digest));

This just looks oddball.

What I would suggest is to change this definition a bit when you
move it to include/linux/tpm.h:

struct tpm2_digest {
	u16 alg_id;
	u8 digest[SHA512_DIGEST_SIZE];
} __packed;

Create a new constant for clarity:

#define TPM_MAX_DIGEST_SIZE SHA512_DIGEST_SIZE

And use redefine the struct as:

struct tpm_digest {
	u16 alg_id
	u8 digest[TPM_MAX_DIGEST_SIZE];
} __packed;

This should have been already done when that struct was defined in
the first place.

Then in that function create a temporary variable and grab the
random number there:

u8 digest[TPM_MAX_DIGEST_SIZE];

/* ... */

ret = tpm_get_random(chip, digest, TPM_MAX_DIGEST_SIZE);
if (ret < 0)
	return ret;
if (ret < TPM_MAX_DIGEST_SIZE)
	return -EFAULT;

After this you can allocate the array for digests.

/Jarkko
