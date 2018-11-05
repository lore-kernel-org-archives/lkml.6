Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FBFECDE46
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFEC62089F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFEC62089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbeKETGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:06:23 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726086AbeKETGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:06:23 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 2D75DED5F41F6;
        Mon,  5 Nov 2018 09:47:28 +0000 (GMT)
Received: from [10.204.65.142] (10.204.65.142) by smtpsuk.huawei.com
 (10.201.108.37) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 5 Nov
 2018 09:47:19 +0000
Subject: Re: [PATCH v3 4/5] tpm: retrieve digest size of unknown algorithms
 with PCR read
To:     Mimi Zohar <zohar@linux.ibm.com>, <jarkko.sakkinen@linux.intel.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
References: <20181030154711.2782-1-roberto.sassu@huawei.com>
 <20181030154711.2782-5-roberto.sassu@huawei.com>
 <1541088173.4035.26.camel@linux.ibm.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <3034c896-788b-50f9-23cb-f4b2cd6363e6@huawei.com>
Date:   Mon, 5 Nov 2018 10:47:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1541088173.4035.26.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.204.65.142]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/2018 5:02 PM, Mimi Zohar wrote:
> On Tue, 2018-10-30 at 16:47 +0100, Roberto Sassu wrote:

[...]

>> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>> index 633e16f42107..8662e8587dce 100644
>> --- a/drivers/char/tpm/tpm.h
>> +++ b/drivers/char/tpm/tpm.h
>> @@ -237,7 +237,7 @@ struct tpm_chip {
>>   	const struct attribute_group *groups[3];
>>   	unsigned int groups_cnt;
>>   
>> -	u16 active_banks[7];
>> +	struct tpm_bank_info active_banks[7];
> 
> Commit 1db15344f874 ("tpm: implement TPM 2.0 capability to get active
> PCR banks") defined active_banks[7].  Subsequently, commit
> 4d23cc323cdb ("tpm: add securityfs support for TPM 2.0 firmware event
> log") defined TPM2_PCR_ACTIVE_BANKS as 3.  I'm not sure which is the
> correct value, but the number of active_banks should not be hard coded
> here.

Jarkko, should I change the value of TPM2_PCR_ACTIVE_BANKS, or set the
size of the active_banks array to TPM2_PCR_ACTIVE_BANKS?


>>   #ifdef CONFIG_ACPI
>>   	acpi_handle acpi_dev_handle;
>>   	char ppi_version[TPM_PPI_VERSION_LEN + 1];
>> @@ -565,7 +565,7 @@ static inline u32 tpm2_rc_value(u32 rc)
>>   }
>>   
>>   int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx,
>> -		  struct tpm_digest *digest_struct);
>> +		  struct tpm_digest *digest_struct, u16 *digest_size_ptr);
>>   int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
>>   		    struct tpm_digest *digests);
>>   int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
>> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>> index 8babd826ad27..8e821e7b4674 100644
>> --- a/drivers/char/tpm/tpm2-cmd.c
>> +++ b/drivers/char/tpm/tpm2-cmd.c
>> @@ -180,11 +180,12 @@ struct tpm2_pcr_read_out {
>>    * @chip:	TPM chip to use.
>>    * @pcr_idx:	index of the PCR to read.
>>    * @digest_struct:	pcr bank and buffer current PCR value is written to.
>> + * @digest_size_ptr:	pointer to variable that stores the digest size.
>>    *
>>    * Return: Same as with tpm_transmit_cmd.
>>    */
>>   int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx,
>> -		  struct tpm_digest *digest_struct)
>> +		  struct tpm_digest *digest_struct, u16 *digest_size_ptr)
>>   {
>>   	int rc;
>>   	struct tpm_buf buf;
>> @@ -219,6 +220,9 @@ int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx,
>>   		goto out;
>>   	}
>>   
>> +	if (digest_size_ptr)
>> +		*digest_size_ptr = digest_size;
>> +
>>   	memcpy(digest_struct->digest, out->digest, digest_size);
>>   out:
>>   	tpm_buf_destroy(&buf);
>> @@ -249,7 +253,6 @@ int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
>>   	struct tpm2_null_auth_area auth_area;
>>   	int rc;
>>   	int i;
>> -	int j;
>>   
>>   	if (count > ARRAY_SIZE(chip->active_banks))
>>   		return -EINVAL;
>> @@ -271,14 +274,9 @@ int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
>>   	tpm_buf_append_u32(&buf, count);
>>   
>>   	for (i = 0; i < count; i++) {
>> -		for (j = 0; j < ARRAY_SIZE(tpm2_hash_map); j++) {
>> -			if (digests[i].alg_id != tpm2_hash_map[j].tpm_id)
>> -				continue;
>> -			tpm_buf_append_u16(&buf, digests[i].alg_id);
>> -			tpm_buf_append(&buf, (const unsigned char
>> -					      *)&digests[i].digest,
>> -			       hash_digest_size[tpm2_hash_map[j].crypto_id]);
>> -		}
>> +		tpm_buf_append_u16(&buf, digests[i].alg_id);
>> +		tpm_buf_append(&buf, (const unsigned char *)&digests[i].digest,
>> +			       chip->active_banks[i].digest_size);
>>   	}
>>   
> 
> These tpm2_pcr_extend changes don't belong here in this patch.  Please
> move them to 1/5.

Also in this case, alg_id and digest_size are defined in patch 4/5.


>>   	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
>> @@ -855,6 +853,26 @@ int tpm2_probe(struct tpm_chip *chip)
>>   }
>>   EXPORT_SYMBOL_GPL(tpm2_probe);
>>   
>> +static int tpm2_init_bank_info(struct tpm_chip *chip,
>> +			       struct tpm_bank_info *bank)
>> +{
>> +	struct tpm_digest digest = {.alg_id = bank->alg_id};
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
>> +		enum hash_algo crypto_algo = tpm2_hash_map[i].crypto_id;
>> +
>> +		if (bank->alg_id != tpm2_hash_map[i].tpm_id)
>> +			continue;
>> +
>> +		bank->digest_size = hash_digest_size[crypto_algo];
>> +		bank->crypto_id = crypto_algo;
>> +		return 0;
>> +	}
>> +
>> +	return tpm2_pcr_read(chip, 0, &digest, &bank->digest_size);
>> +}
>> +
>>   struct tpm2_pcr_selection {
>>   	__be16  hash_alg;
>>   	u8  size_of_select;
>> @@ -909,7 +927,12 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
>>   		}
>>   
>>   		memcpy(&pcr_selection, marker, sizeof(pcr_selection));
>> -		chip->active_banks[i] = be16_to_cpu(pcr_selection.hash_alg);
>> +		chip->active_banks[i].alg_id =
>> +			be16_to_cpu(pcr_selection.hash_alg);
>> +		rc =  tpm2_init_bank_info(chip, &chip->active_banks[i]);
> 
> Please fix the formatting in the above 2 lines.
> 
> There's been discussion in the past on removing scripts/Lindent from
> the coding-style documentation, but that hasn't happened quite yet. I
> do think section 3 "New drivers" in Documentation/hwmon/submitting-
> patches has a good balance.
> 
> * Running your patch or driver file(s) through checkpatch does not mean its
>    formatting is clean. If unsure about formatting in your new driver, run it
>    through Lindent. Lindent is not perfect, and you may have to do some minor
>    cleanup, but it is a good start.

Ok.

Thanks

Roberto


> thanks!
> 
> Mimi
> 
>> +		if (rc)
>> +			break;
>> +
>>   		sizeof_pcr_selection = sizeof(pcr_selection.hash_alg) +
>>   			sizeof(pcr_selection.size_of_select) +
>>   			pcr_selection.size_of_select;
>> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>> index 4f00daf44dd2..3f91124837cf 100644
>> --- a/include/linux/tpm.h
>> +++ b/include/linux/tpm.h
>> @@ -46,6 +46,12 @@ struct tpm_digest {
>>   	u8 digest[SHA512_DIGEST_SIZE];
>>   } __packed;
>>   
>> +struct tpm_bank_info {
>> +	u16 alg_id;
>> +	u16 digest_size;
>> +	u16 crypto_id;
>> +};
>> +
>>   enum TPM_OPS_FLAGS {
>>   	TPM_OPS_AUTO_STARTUP = BIT(0),
>>   };
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
