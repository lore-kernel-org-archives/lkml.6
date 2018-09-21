Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBC3ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECBD2150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECBD2150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390065AbeIUQMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:12:35 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2085 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389313AbeIUQMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:12:34 -0400
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 5ADDA79223355;
        Fri, 21 Sep 2018 11:24:18 +0100 (IST)
Received: from [10.204.65.145] (10.204.65.145) by smtpsuk.huawei.com
 (10.201.108.36) with Microsoft SMTP Server (TLS) id 14.3.399.0; Fri, 21 Sep
 2018 11:24:16 +0100
Subject: Re: [PATCH v2, RESEND 2/3] tpm: modify tpm_pcr_read() definition to
 pass TPM hash algorithms
To:     <jarkko.sakkinen@linux.intel.com>, Mimi Zohar <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180917093820.20500-1-roberto.sassu@huawei.com>
 <20180917093820.20500-3-roberto.sassu@huawei.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <411432db-ea57-a537-05d3-0b53008bef27@huawei.com>
Date:   Fri, 21 Sep 2018 12:24:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917093820.20500-3-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.145]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/2018 11:38 AM, Roberto Sassu wrote:
> Currently the TPM driver allows other kernel subsystems to read only the
> SHA1 PCR bank. This patch modifies the parameters of tpm_pcr_read() and
> tpm2_pcr_read() to pass an array of tpm_digest structures, which contains
> the desired hash algorithms. Initially, the array size is limited to 1.

Jarkko, is this patch ok?

Mimi, I wait for your review of the IMA part.

Roberto


> Due to the API change, IMA functions have been modified.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   drivers/char/tpm/tpm-interface.c    | 13 +++++++++----
>   drivers/char/tpm/tpm.h              |  3 ++-
>   drivers/char/tpm/tpm2-cmd.c         | 17 +++++++++++------
>   include/linux/tpm.h                 |  6 ++++--
>   security/integrity/ima/ima_crypto.c | 10 +++++-----
>   5 files changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 645c9aa7677a..81872880b5f1 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -976,21 +976,26 @@ EXPORT_SYMBOL_GPL(tpm_is_tpm2);
>    * tpm_pcr_read - read a PCR value from SHA1 bank
>    * @chip:	a &struct tpm_chip instance, %NULL for the default chip
>    * @pcr_idx:	the PCR to be retrieved
> - * @res_buf:	the value of the PCR
> + * @count:	number of digests passed
> + * @digests:	list of pcr banks and buffers current PCR values are written to
>    *
>    * Return: same as with tpm_transmit_cmd()
>    */
> -int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
> +int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx, u32 count,
> +		 struct tpm_digest *digests)
>   {
>   	int rc;
>   
> +	if (count != 1)
> +		return -EINVAL;
> +
>   	chip = tpm_find_get_ops(chip);
>   	if (!chip)
>   		return -ENODEV;
>   	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> -		rc = tpm2_pcr_read(chip, pcr_idx, res_buf);
> +		rc = tpm2_pcr_read(chip, pcr_idx, count, digests);
>   	else
> -		rc = tpm_pcr_read_dev(chip, pcr_idx, res_buf);
> +		rc = tpm_pcr_read_dev(chip, pcr_idx, digests[0].digest);
>   	tpm_put_ops(chip);
>   	return rc;
>   }
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index b928ba44d864..9479e1ae1b4c 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -564,7 +564,8 @@ static inline u32 tpm2_rc_value(u32 rc)
>   	return (rc & BIT(7)) ? rc & 0xff : rc;
>   }
>   
> -int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf);
> +int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx, u32 count,
> +		  struct tpm_digest *digests);
>   int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
>   		    struct tpm_digest *digests);
>   int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 2d7397b8a0d1..601d67c76c1e 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -179,11 +179,13 @@ struct tpm2_pcr_read_out {
>    * tpm2_pcr_read() - read a PCR value
>    * @chip:	TPM chip to use.
>    * @pcr_idx:	index of the PCR to read.
> - * @res_buf:	buffer to store the resulting hash.
> + * @count:	number of digests passed.
> + * @digests:	list of pcr banks and buffers current PCR values are written to.
>    *
>    * Return: Same as with tpm_transmit_cmd.
>    */
> -int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
> +int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx, u32 count,
> +		  struct tpm_digest *digests)
>   {
>   	int rc;
>   	struct tpm_buf buf;
> @@ -192,6 +194,8 @@ int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
>   
>   	if (pcr_idx >= TPM2_PLATFORM_PCR)
>   		return -EINVAL;
> +	if (count > 1)
> +		return -EINVAL;
>   
>   	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_PCR_READ);
>   	if (rc)
> @@ -200,16 +204,17 @@ int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
>   	pcr_select[pcr_idx >> 3] = 1 << (pcr_idx & 0x7);
>   
>   	tpm_buf_append_u32(&buf, 1);
> -	tpm_buf_append_u16(&buf, TPM_ALG_SHA1);
> +	tpm_buf_append_u16(&buf, count ? digests[0].alg_id : TPM_ALG_SHA1);
>   	tpm_buf_append_u8(&buf, TPM2_PCR_SELECT_MIN);
>   	tpm_buf_append(&buf, (const unsigned char *)pcr_select,
>   		       sizeof(pcr_select));
>   
>   	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
> -			res_buf ? "attempting to read a pcr value" : NULL);
> -	if (rc == 0 && res_buf) {
> +			      count ? "attempting to read a pcr value" : NULL);
> +	if (rc == 0 && count) {
>   		out = (struct tpm2_pcr_read_out *)&buf.data[TPM_HEADER_SIZE];
> -		memcpy(res_buf, out->digest, SHA1_DIGEST_SIZE);
> +		memcpy(digests[0].digest, out->digest,
> +		       be16_to_cpu(out->digest_size));
>   	}
>   
>   	tpm_buf_destroy(&buf);
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 71d7bbf5f690..ac9fc47f4494 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -71,7 +71,8 @@ struct tpm_class_ops {
>   #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
>   
>   extern int tpm_is_tpm2(struct tpm_chip *chip);
> -extern int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf);
> +extern int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx, u32 count,
> +			struct tpm_digest *digests);
>   extern int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash);
>   extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
>   extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
> @@ -87,7 +88,8 @@ static inline int tpm_is_tpm2(struct tpm_chip *chip)
>   {
>   	return -ENODEV;
>   }
> -static inline int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
> +static inline int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx, u32 count,
> +			       struct tpm_digest *digests)
>   {
>   	return -ENODEV;
>   }
> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
> index 7e7e7e7c250a..4c94cf810d15 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -629,12 +629,12 @@ int ima_calc_buffer_hash(const void *buf, loff_t len,
>   	return calc_buffer_shash(buf, len, hash);
>   }
>   
> -static void __init ima_pcrread(int idx, u8 *pcr)
> +static void __init ima_pcrread(int idx, struct tpm_digest *d)
>   {
>   	if (!ima_tpm_chip)
>   		return;
>   
> -	if (tpm_pcr_read(ima_tpm_chip, idx, pcr) != 0)
> +	if (tpm_pcr_read(ima_tpm_chip, idx, 1, d) != 0)
>   		pr_err("Error Communicating to TPM chip\n");
>   }
>   
> @@ -644,7 +644,7 @@ static void __init ima_pcrread(int idx, u8 *pcr)
>   static int __init ima_calc_boot_aggregate_tfm(char *digest,
>   					      struct crypto_shash *tfm)
>   {
> -	u8 pcr_i[TPM_DIGEST_SIZE];
> +	struct tpm_digest d = {.alg_id = TPM_ALG_SHA1};
>   	int rc, i;
>   	SHASH_DESC_ON_STACK(shash, tfm);
>   
> @@ -657,9 +657,9 @@ static int __init ima_calc_boot_aggregate_tfm(char *digest,
>   
>   	/* cumulative sha1 over tpm registers 0-7 */
>   	for (i = TPM_PCR0; i < TPM_PCR8; i++) {
> -		ima_pcrread(i, pcr_i);
> +		ima_pcrread(i, &d);
>   		/* now accumulate with current aggregate */
> -		rc = crypto_shash_update(shash, pcr_i, TPM_DIGEST_SIZE);
> +		rc = crypto_shash_update(shash, d.digest, TPM_DIGEST_SIZE);
>   	}
>   	if (!rc)
>   		crypto_shash_final(shash, digest);
> 
