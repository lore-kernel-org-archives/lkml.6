Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C56BC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C272220877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C272220877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbeIYUIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:08:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:56253 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728997AbeIYUIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:08:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 07:00:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,302,1534834800"; 
   d="scan'208";a="73569647"
Received: from thomasvo-mobl2.ger.corp.intel.com ([10.252.53.212])
  by fmsmga008.fm.intel.com with ESMTP; 25 Sep 2018 07:00:35 -0700
Message-ID: <5c2d41fc0434db4af4ebf66151ee022fba629ec8.camel@linux.intel.com>
Subject: Re: [PATCH v2, RESEND 3/3] tpm: retrieve digest size of unknown
 algorithms with PCR read
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 25 Sep 2018 17:00:32 +0300
In-Reply-To: <20180917093820.20500-4-roberto.sassu@huawei.com>
References: <20180917093820.20500-1-roberto.sassu@huawei.com>
         <20180917093820.20500-4-roberto.sassu@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-17 at 11:38 +0200, Roberto Sassu wrote:
> Currently, the TPM driver retrieves the digest size from a table mapping
> TPM algorithms identifiers to identifiers defined by the crypto subsystem.
> If the algorithm is not defined by the latter, the digest size can be
> retrieved from the output of the PCR read command.
> 
> The patch retrieves at TPM startup the digest sizes for each PCR bank and
> stores them in the new structure tpm_active_bank_info, member of tpm_chip,
> so that the information can be passed to other kernel subsystems.
> 
> tpm_active_bank_info contains: the TPM algorithm identifier, necessary to
> generate the event log as defined by Trusted Computing Group (TCG); the
> digest size, to pad/truncate a digest calculated with a different
> algorithm; the crypto subsystem identifier, to calculate the digest of
> event data.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  drivers/char/tpm/tpm-interface.c | 11 +++++++---
>  drivers/char/tpm/tpm.h           |  4 ++--
>  drivers/char/tpm/tpm2-cmd.c      | 47 ++++++++++++++++++++++++++++++---------
> -
>  include/linux/tpm.h              |  6 +++++
>  4 files changed, 51 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-
> interface.c
> index 81872880b5f1..02dcdcda5a3c 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -993,7 +993,7 @@ int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx, u32
> count,
>  	if (!chip)
>  		return -ENODEV;
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> -		rc = tpm2_pcr_read(chip, pcr_idx, count, digests);
> +		rc = tpm2_pcr_read(chip, pcr_idx, count, digests, NULL);
>  	else
>  		rc = tpm_pcr_read_dev(chip, pcr_idx, digests[0].digest);
>  	tpm_put_ops(chip);
> @@ -1056,8 +1056,8 @@ int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx,
> const u8 *hash)
>  		memset(digest_list, 0, sizeof(digest_list));
>  
>  		for (i = 0; i < ARRAY_SIZE(chip->active_banks) &&
> -			    chip->active_banks[i] != TPM_ALG_ERROR; i++) {
> -			digest_list[i].alg_id = chip->active_banks[i];
> +		     chip->active_banks[i].alg_id != TPM_ALG_ERROR; i++) {
> +			digest_list[i].alg_id = chip->active_banks[i].alg_id;
>  			memcpy(digest_list[i].digest, hash, TPM_DIGEST_SIZE);
>  			count++;
>  		}
> @@ -1158,6 +1158,11 @@ int tpm1_auto_startup(struct tpm_chip *chip)
>  		goto out;
>  	}
>  
> +	chip->active_banks[0].alg_id = TPM_ALG_SHA1;
> +	chip->active_banks[0].digest_size = hash_digest_size[HASH_ALGO_SHA1];
> +	chip->active_banks[0].crypto_id = HASH_ALGO_SHA1;
> +	chip->active_banks[1].alg_id = TPM_ALG_ERROR;
> +
>  	return rc;
>  out:
>  	if (rc > 0)
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 9479e1ae1b4c..385843b49c17 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -237,7 +237,7 @@ struct tpm_chip {
>  	const struct attribute_group *groups[3];
>  	unsigned int groups_cnt;
>  
> -	u16 active_banks[7];
> +	struct tpm_active_bank_info active_banks[7];
>  #ifdef CONFIG_ACPI
>  	acpi_handle acpi_dev_handle;
>  	char ppi_version[TPM_PPI_VERSION_LEN + 1];
> @@ -565,7 +565,7 @@ static inline u32 tpm2_rc_value(u32 rc)
>  }
>  
>  int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx, u32 count,
> -		  struct tpm_digest *digests);
> +		  struct tpm_digest *digests, u16 *sizes);
>  int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
>  		    struct tpm_digest *digests);
>  int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 601d67c76c1e..51d2454c5329 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -181,11 +181,12 @@ struct tpm2_pcr_read_out {
>   * @pcr_idx:	index of the PCR to read.
>   * @count:	number of digests passed.
>   * @digests:	list of pcr banks and buffers current PCR values are
> written to.
> + * @sizes:	list of digest sizes.
>   *
>   * Return: Same as with tpm_transmit_cmd.
>   */
>  int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx, u32 count,
> -		  struct tpm_digest *digests)
> +		  struct tpm_digest *digests, u16 *sizes)
>  {
>  	int rc;
>  	struct tpm_buf buf;
> @@ -215,6 +216,9 @@ int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx, u32
> count,
>  		out = (struct tpm2_pcr_read_out *)&buf.data[TPM_HEADER_SIZE];
>  		memcpy(digests[0].digest, out->digest,
>  		       be16_to_cpu(out->digest_size));
> +
> +		if (sizes)
> +			sizes[0] = be16_to_cpu(out->digest_size);
>  	}
>  
>  	tpm_buf_destroy(&buf);
> @@ -245,7 +249,6 @@ int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx,
> u32 count,
>  	struct tpm2_null_auth_area auth_area;
>  	int rc;
>  	int i;
> -	int j;
>  
>  	if (count > ARRAY_SIZE(chip->active_banks))
>  		return -EINVAL;
> @@ -267,14 +270,9 @@ int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx,
> u32 count,
>  	tpm_buf_append_u32(&buf, count);
>  
>  	for (i = 0; i < count; i++) {
> -		for (j = 0; j < ARRAY_SIZE(tpm2_hash_map); j++) {
> -			if (digests[i].alg_id != tpm2_hash_map[j].tpm_id)
> -				continue;
> -			tpm_buf_append_u16(&buf, digests[i].alg_id);
> -			tpm_buf_append(&buf, (const unsigned char
> -					      *)&digests[i].digest,
> -			       hash_digest_size[tpm2_hash_map[j].crypto_id]);
> -		}
> +		tpm_buf_append_u16(&buf, digests[i].alg_id);
> +		tpm_buf_append(&buf, (const unsigned char
> *)&digests[i].digest,
> +			       chip->active_banks[i].digest_size);
>  	}
>  
>  	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
> @@ -851,6 +849,26 @@ int tpm2_probe(struct tpm_chip *chip)
>  }
>  EXPORT_SYMBOL_GPL(tpm2_probe);
>  
> +static int tpm2_init_active_bank_info(struct tpm_chip *chip,
> +				      struct tpm_active_bank_info
> *active_bank)
> +{
> +	struct tpm_digest digest = {.alg_id = active_bank->alg_id};
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
> +		enum hash_algo crypto_algo = tpm2_hash_map[i].crypto_id;
> +
> +		if (active_bank->alg_id != tpm2_hash_map[i].tpm_id)
> +			continue;
> +
> +		active_bank->digest_size = hash_digest_size[crypto_algo];
> +		active_bank->crypto_id = crypto_algo;
> +		return 0;
> +	}
> +
> +	return tpm2_pcr_read(chip, 0, 1, &digest, &active_bank->digest_size);
> +}
> +
>  struct tpm2_pcr_selection {
>  	__be16  hash_alg;
>  	u8  size_of_select;
> @@ -905,7 +923,12 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip
> *chip)
>  		}
>  
>  		memcpy(&pcr_selection, marker, sizeof(pcr_selection));
> -		chip->active_banks[i] = be16_to_cpu(pcr_selection.hash_alg);
> +		chip->active_banks[i].alg_id =
> +			be16_to_cpu(pcr_selection.hash_alg);
> +		rc =  tpm2_init_active_bank_info(chip, &chip-
> >active_banks[i]);
> +		if (rc)
> +			break;
> +
>  		sizeof_pcr_selection = sizeof(pcr_selection.hash_alg) +
>  			sizeof(pcr_selection.size_of_select) +
>  			pcr_selection.size_of_select;
> @@ -914,7 +937,7 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip
> *chip)
>  
>  out:
>  	if (i < ARRAY_SIZE(chip->active_banks))
> -		chip->active_banks[i] = TPM_ALG_ERROR;
> +		chip->active_banks[i].alg_id = TPM_ALG_ERROR;
>  
>  	tpm_buf_destroy(&buf);
>  
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index ac9fc47f4494..c8372ff582c3 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -46,6 +46,12 @@ struct tpm_digest {
>  	u8 digest[SHA512_DIGEST_SIZE];
>  } __packed;
>  
> +struct tpm_active_bank_info {
> +	u16 alg_id;
> +	u16 digest_size;
> +	u16 crypto_id;
> +};
> +
>  enum TPM_OPS_FLAGS {
>  	TPM_OPS_AUTO_STARTUP = BIT(0),
>  };

Still think that we should use zero as marker for the end and not use
TPM_ALG_ERROR as zero is the defacto way to terminate an array. It
should be a separate commit. I can accept this and send such a patch
after this has been merged or alternatively you can include such patch
to a new version of the series.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
