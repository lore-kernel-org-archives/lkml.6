Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4429C43610
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BE72089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80BE72089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390009AbeKQCIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:08:45 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32773 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728124AbeKQCIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 21:08:45 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id BBE50C3F0CB3F;
        Fri, 16 Nov 2018 15:55:46 +0000 (GMT)
Received: from [10.204.65.144] (10.204.65.144) by smtpsuk.huawei.com
 (10.201.108.34) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 16 Nov
 2018 15:55:41 +0000
Subject: Re: [PATCH v5 7/7] tpm: pass an array of tpm_bank_list structures to
 tpm_pcr_extend()
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     <zohar@linux.ibm.com>, <david.safford@ge.com>,
        <monty.wiseman@ge.com>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
References: <20181114153108.12907-1-roberto.sassu@huawei.com>
 <20181114153108.12907-8-roberto.sassu@huawei.com>
 <20181116150352.GA3612@linux.intel.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <9c534ed1-7832-7a3b-3e69-5fcc25c565cc@huawei.com>
Date:   Fri, 16 Nov 2018 16:55:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181116150352.GA3612@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.144]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/2018 4:03 PM, Jarkko Sakkinen wrote:
> On Wed, Nov 14, 2018 at 04:31:08PM +0100, Roberto Sassu wrote:
>> Currently, tpm_pcr_extend() accepts as an input only a SHA1 digest.
>>
>> This patch modifies the definition of tpm_pcr_extend() to allow other
>> kernel subsystems to pass a digest for each algorithm supported by the TPM.
>> All digests are processed by the TPM in one operation.
>>
>> If a tpm_pcr_extend() caller provides a subset of the supported algorithms,
>> the TPM driver extends the remaining PCR banks with the first digest
>> passed as an argument to the function.
> 
> What is the legit use case for this?

A subset could be chosen for better performance, or when a TPM algorithm
is not supported by the crypto subsystem.


>> The new tpm_bank_list structure has been preferred to the tpm_digest
>> structure, to let the caller specify the size of the digest (which may be
>> unknown to the TPM driver).
>>
>> Due to the API change, ima_pcr_extend() and pcrlock() have been modified.
>>
>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Should be dropped from the patch set as it is not taken advatange of
> but I can still try to give some feedback.

I understood from a previous email that you want to include all API
changes for crypto agility in the same patch set.

Roberto


>> ---
>>   drivers/char/tpm/tpm-interface.c   | 24 +++++---------------
>>   drivers/char/tpm/tpm.h             |  6 ++---
>>   drivers/char/tpm/tpm1-cmd.c        | 14 ++++++++----
>>   drivers/char/tpm/tpm2-cmd.c        | 36 +++++++++++++++++++++---------
>>   include/linux/tpm.h                | 13 ++++++++---
>>   security/integrity/ima/ima_queue.c |  5 ++++-
>>   security/keys/trusted.c            |  5 ++++-
>>   7 files changed, 63 insertions(+), 40 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
>> index f0e1456440d7..5495223d3f7b 100644
>> --- a/drivers/char/tpm/tpm-interface.c
>> +++ b/drivers/char/tpm/tpm-interface.c
>> @@ -478,42 +478,30 @@ EXPORT_SYMBOL_GPL(tpm_pcr_read);
>>    * tpm_pcr_extend - extend a PCR value in SHA1 bank.
>>    * @chip:	a &struct tpm_chip instance, %NULL for the default chip
>>    * @pcr_idx:	the PCR to be retrieved
>> - * @hash:	the hash value used to extend the PCR value
>> + * @count:	number of tpm_bank_list structures
>> + * @bank_list:	array of tpm_bank_list structures used to extend the PCR value
>>    *
>>    * Note: with TPM 2.0 extends also those banks for which no digest was
>>    * specified in order to prevent malicious use of those PCR banks.
>>    *
>>    * Return: same as with tpm_transmit_cmd()
>>    */
>> -int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash)
>> +int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
>> +		   const struct tpm_bank_list *bank_list)
>>   {
>>   	int rc;
>> -	struct tpm_digest *digest_list;
>> -	int i;
>>   
>>   	chip = tpm_find_get_ops(chip);
>>   	if (!chip)
>>   		return -ENODEV;
>>   
>>   	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
>> -		digest_list = kcalloc(chip->nr_allocated_banks,
>> -				      sizeof(*digest_list), GFP_KERNEL);
>> -		if (!digest_list)
>> -			return -ENOMEM;
>> -
>> -		for (i = 0; i < chip->nr_allocated_banks; i++) {
>> -			digest_list[i].alg_id = chip->allocated_banks[i].alg_id;
>> -			memcpy(digest_list[i].digest, hash, TPM_DIGEST_SIZE);
>> -		}
>> -
>> -		rc = tpm2_pcr_extend(chip, pcr_idx, chip->nr_allocated_banks,
>> -				     digest_list);
>> -		kfree(digest_list);
>> +		rc = tpm2_pcr_extend(chip, pcr_idx, count, bank_list);
>>   		tpm_put_ops(chip);
>>   		return rc;
>>   	}
>>   
>> -	rc = tpm1_pcr_extend(chip, pcr_idx, hash,
>> +	rc = tpm1_pcr_extend(chip, pcr_idx, count, bank_list,
>>   			     "attempting extend a PCR value");
>>   	tpm_put_ops(chip);
>>   	return rc;
>> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>> index 023ddf42038b..4296c720ebb4 100644
>> --- a/drivers/char/tpm/tpm.h
>> +++ b/drivers/char/tpm/tpm.h
>> @@ -504,8 +504,8 @@ int tpm1_auto_startup(struct tpm_chip *chip);
>>   int tpm1_do_selftest(struct tpm_chip *chip);
>>   int tpm1_get_timeouts(struct tpm_chip *chip);
>>   unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
>> -int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
>> -		    const char *log_msg);
>> +int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
>> +		    const struct tpm_bank_list *bank_list, const char *log_msg);
>>   int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
>>   ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
>>   		    const char *desc, size_t min_cap_length);
>> @@ -551,7 +551,7 @@ int tpm2_get_timeouts(struct tpm_chip *chip);
>>   int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
>>   		  struct tpm_digest *digest_struct, u16 *digest_size_ptr);
>>   int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
>> -		    struct tpm_digest *digests);
>> +		    const struct tpm_bank_list *bank_list);
>>   int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
>>   void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
>>   			    unsigned int flags);
>> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
>> index 8b70a7f884a7..439ac749517c 100644
>> --- a/drivers/char/tpm/tpm1-cmd.c
>> +++ b/drivers/char/tpm/tpm1-cmd.c
>> @@ -449,12 +449,19 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
>>   }
>>   
>>   #define TPM_ORD_PCR_EXTEND 20
>> -int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
>> -		    const char *log_msg)
>> +int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
>> +		    const struct tpm_bank_list *bank_list, const char *log_msg)
>>   {
>>   	struct tpm_buf buf;
>> +	u8 dummy_hash[TPM_DIGEST_SIZE] = { 0 };
>> +	const u8 *hash;
>>   	int rc;
>>   
>> +	hash = dummy_hash;
>> +	if (count)
>> +		memcpy(dummy_hash, bank_list[0].extend_array,
>> +		       min(bank_list[0].digest_size, (u16)sizeof(dummy_hash)));
>> +
>>   	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_EXTEND);
> 
> This is probably mistake? I mean dummy_hash is not used.
> 
>>   	if (rc)
>>   		return rc;
>> @@ -743,7 +750,6 @@ int tpm1_auto_startup(struct tpm_chip *chip)
>>    */
>>   int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
>>   {
>> -	u8 dummy_hash[TPM_DIGEST_SIZE] = { 0 };
>>   	struct tpm_buf buf;
>>   	unsigned int try;
>>   	int rc;
>> @@ -751,7 +757,7 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
>>   
>>   	/* for buggy tpm, flush pcrs with extend to selected dummy */
>>   	if (tpm_suspend_pcr)
>> -		rc = tpm1_pcr_extend(chip, tpm_suspend_pcr, dummy_hash,
>> +		rc = tpm1_pcr_extend(chip, tpm_suspend_pcr, 0, NULL,
>>   				     "extending dummy pcr before suspend");
>>   
>>   	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_SAVESTATE);
>> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>> index 974465f04b78..40eb1a044451 100644
>> --- a/drivers/char/tpm/tpm2-cmd.c
>> +++ b/drivers/char/tpm/tpm2-cmd.c
>> @@ -248,21 +248,22 @@ struct tpm2_null_auth_area {
>>    *
>>    * @chip:	TPM chip to use.
>>    * @pcr_idx:	index of the PCR.
>> - * @count:	number of digests passed.
>> - * @digests:	list of pcr banks and corresponding digest values to extend.
>> + * @count:	number of tpm_bank_list passed.
>> + * @bank_list:	array of tpm_bank_list with digest values to extend.
>>    *
>>    * Return: Same as with tpm_transmit_cmd.
>>    */
>>   int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
>> -		    struct tpm_digest *digests)
>> +		    const struct tpm_bank_list *bank_list)
>>   {
>>   	struct tpm_buf buf;
>>   	struct tpm2_null_auth_area auth_area;
>> +	const struct tpm_bank_list *item;
>> +	u8 dummy_hash[SHA512_DIGEST_SIZE] = { 0 };
>> +	const u8 *hash;
>>   	int rc;
>>   	int i;
>> -
>> -	if (count > chip->nr_allocated_banks)
>> -		return -EINVAL;
>> +	int j;
>>   
>>   	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
>>   	if (rc)
>> @@ -278,11 +279,26 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
>>   	tpm_buf_append_u32(&buf, sizeof(struct tpm2_null_auth_area));
>>   	tpm_buf_append(&buf, (const unsigned char *)&auth_area,
>>   		       sizeof(auth_area));
>> -	tpm_buf_append_u32(&buf, count);
>> +	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
>> +
>> +	if (count)
>> +		memcpy(dummy_hash, bank_list[0].extend_array,
>> +		       bank_list[0].digest_size);
>> +
>> +	for (i = 0; i < chip->nr_allocated_banks; i++) {
>> +		tpm_buf_append_u16(&buf, chip->allocated_banks[i].alg_id);
>> +
>> +		hash = dummy_hash;
>> +		for (j = 0; j < count; j++) {
>> +			item = bank_list + j;
>> +
>> +			if (item->alg_id == chip->allocated_banks[i].alg_id) {
>> +				hash = item->extend_array;
>> +				break;
>> +			}
>> +		}
>>   
>> -	for (i = 0; i < count; i++) {
>> -		tpm_buf_append_u16(&buf, digests[i].alg_id);
>> -		tpm_buf_append(&buf, (const unsigned char *)&digests[i].digest,
>> +		tpm_buf_append(&buf, hash,
>>   			       chip->allocated_banks[i].digest_size);
>>   	}
>>   
>> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>> index fcdd33ae9969..16e5ff1f0294 100644
>> --- a/include/linux/tpm.h
>> +++ b/include/linux/tpm.h
>> @@ -52,6 +52,12 @@ struct tpm_bank_info {
>>   	u16 crypto_id;
>>   };
>>   
>> +struct tpm_bank_list {
>> +	u8 alg_id;
>> +	u16 digest_size;
>> +	const u8 *extend_array;
>> +};
> 
> You should document this structure.
> 
>> +
>>   enum TPM_OPS_FLAGS {
>>   	TPM_OPS_AUTO_STARTUP = BIT(0),
>>   };
>> @@ -79,7 +85,8 @@ struct tpm_class_ops {
>>   extern int tpm_is_tpm2(struct tpm_chip *chip);
>>   extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
>>   			struct tpm_digest *digest_struct);
>> -extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash);
>> +extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
>> +			  const struct tpm_bank_list *bank_list);
>>   extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
>>   extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
>>   extern int tpm_seal_trusted(struct tpm_chip *chip,
>> @@ -101,8 +108,8 @@ static inline int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx,
>>   	return -ENODEV;
>>   }
>>   
>> -static inline int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>> -				 const u8 *hash)
>> +static inline int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
>> +				 const struct tpm_bank_list *bank_list)
>>   {
>>   	return -ENODEV;
>>   }
>> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
>> index b186819bd5aa..24024edef316 100644
>> --- a/security/integrity/ima/ima_queue.c
>> +++ b/security/integrity/ima/ima_queue.c
>> @@ -140,12 +140,15 @@ unsigned long ima_get_binary_runtime_size(void)
>>   
>>   static int ima_pcr_extend(const u8 *hash, int pcr)
>>   {
>> +	struct tpm_bank_list bank_item = { .alg_id = TPM_ALG_SHA1,
>> +					   .digest_size = TPM_DIGEST_SIZE,
>> +					   .extend_array = hash };
> 
> Item is a list?
> 
>>   	int result = 0;
>>   
>>   	if (!ima_tpm_chip)
>>   		return result;
>>   
>> -	result = tpm_pcr_extend(ima_tpm_chip, pcr, hash);
>> +	result = tpm_pcr_extend(ima_tpm_chip, pcr, 1, &bank_item);
>>   	if (result != 0)
>>   		pr_err("Error Communicating to TPM chip, result: %d\n", result);
>>   	return result;
>> diff --git a/security/keys/trusted.c b/security/keys/trusted.c
>> index ff6789365a12..d2a3129a95f9 100644
>> --- a/security/keys/trusted.c
>> +++ b/security/keys/trusted.c
>> @@ -380,6 +380,9 @@ EXPORT_SYMBOL_GPL(trusted_tpm_send);
>>   static int pcrlock(const int pcrnum)
>>   {
>>   	unsigned char hash[SHA1_DIGEST_SIZE];
>> +	struct tpm_bank_list bank_item = { .alg_id = TPM_ALG_SHA1,
>> +					   .digest_size = sizeof(hash),
>> +					   .extend_array = hash }
>>   	int ret;
>>   
>>   	if (!capable(CAP_SYS_ADMIN))
>> @@ -387,7 +390,7 @@ static int pcrlock(const int pcrnum)
>>   	ret = tpm_get_random(NULL, hash, SHA1_DIGEST_SIZE);
>>   	if (ret != SHA1_DIGEST_SIZE)
>>   		return ret;
>> -	return tpm_pcr_extend(NULL, pcrnum, hash) ? -EINVAL : 0;
>> +	return tpm_pcr_extend(NULL, pcrnum, 1, &bank_item) ? -EINVAL : 0;
>>   }
>>   
>>   /*
>> -- 
>> 2.17.1
>>
> 
> /Jarkko
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
