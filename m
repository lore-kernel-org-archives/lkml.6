Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3771BC0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCB5223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCB5223AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387549AbeKMXc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:32:59 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32755 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733229AbeKMXc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:32:58 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 2CD036B5544DA;
        Tue, 13 Nov 2018 13:34:46 +0000 (GMT)
Received: from [10.204.65.144] (10.204.65.144) by smtpsuk.huawei.com
 (10.201.108.37) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 13 Nov
 2018 13:34:40 +0000
Subject: Re: [PATCH v4 1/6] tpm: dynamically allocate active_banks array
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     <zohar@linux.ibm.com>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
References: <20181106150159.1136-1-roberto.sassu@huawei.com>
 <20181106150159.1136-2-roberto.sassu@huawei.com>
 <20181108134651.GA8922@linux.intel.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <38bdee38-503b-0bac-efba-99f285018934@huawei.com>
Date:   Tue, 13 Nov 2018 14:34:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181108134651.GA8922@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.144]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/2018 2:46 PM, Jarkko Sakkinen wrote:
> Orrayn Tue, Nov 06, 2018 at 04:01:54PM +0100, Roberto Sassu wrote:
>> This patch removes the hard-coded limit of the active_banks array size.
>> It stores in the tpm_chip structure the number of active PCR banks,
>> determined in tpm2_get_pcr_allocation(), and replaces the static array
>> with a pointer to a dynamically allocated array.
>>
>> As a consequence of the introduction of nr_active_banks, tpm_pcr_extend()
>> does not check anymore if the algorithm stored in tpm_chip is equal to
>> zero. The active_banks array always contains valid algorithms.
>>
>> Fixes: 1db15344f874 ("tpm: implement TPM 2.0 capability to get active
>> PCR banks")
>>
>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>> ---
>>   drivers/char/tpm/tpm-chip.c      |  1 +
>>   drivers/char/tpm/tpm-interface.c | 19 ++++++++++++-------
>>   drivers/char/tpm/tpm.h           |  3 ++-
>>   drivers/char/tpm/tpm2-cmd.c      | 17 ++++++++---------
>>   4 files changed, 23 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>> index 46caadca916a..2a9e8b744436 100644
>> --- a/drivers/char/tpm/tpm-chip.c
>> +++ b/drivers/char/tpm/tpm-chip.c
>> @@ -160,6 +160,7 @@ static void tpm_dev_release(struct device *dev)
>>   	kfree(chip->log.bios_event_log);
>>   	kfree(chip->work_space.context_buf);
>>   	kfree(chip->work_space.session_buf);
>> +	kfree(chip->active_banks);
>>   	kfree(chip);
>>   }
>>   
>> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
>> index 1a803b0cf980..ba7ca6b3e664 100644
>> --- a/drivers/char/tpm/tpm-interface.c
>> +++ b/drivers/char/tpm/tpm-interface.c
>> @@ -1039,8 +1039,7 @@ static int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
>>   int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)
>>   {
>>   	int rc;
>> -	struct tpm2_digest digest_list[ARRAY_SIZE(chip->active_banks)];
>> -	u32 count = 0;
>> +	struct tpm2_digest *digest_list;
>>   	int i;
>>   
>>   	chip = tpm_find_get_ops(chip);
>> @@ -1048,16 +1047,22 @@ int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)
>>   		return -ENODEV;
> 
> Should take digest_list as input. Probably callers could re-use the
> same digest_list array multiple times?
> 
> Move struct tpm_chip to include/linux/tpm.h so that the caller can query
> nr_active_banks and active_banks and can create the digest array by
> itself. Lets do this right at once now that this is being restructured.

I have to move also other structures and #define. Wouldn't be better to
introduce a new function to pass to the caller active_banks and
nr_active_banks?

Roberto


>>   
>>   	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
>> -		memset(digest_list, 0, sizeof(digest_list));
>> +		digest_list = kmalloc_array(chip->nr_active_banks,
>> +					    sizeof(*digest_list), GFP_KERNEL);
>> +		if (!digest_list)
>> +			return -ENOMEM;
>>   
>> -		for (i = 0; i < ARRAY_SIZE(chip->active_banks) &&
>> -			    chip->active_banks[i] != TPM2_ALG_ERROR; i++) {
>> +		memset(digest_list, 0,
>> +		       chip->nr_active_banks * sizeof(*digest_list));
> 
> You should use kcalloc() to allocate digest_list.
> 
>> +
>> +		for (i = 0; i < chip->nr_active_banks; i++) {
>>   			digest_list[i].alg_id = chip->active_banks[i];
>>   			memcpy(digest_list[i].digest, hash, TPM_DIGEST_SIZE);
>> -			count++;
>>   		}
>>   
>> -		rc = tpm2_pcr_extend(chip, pcr_idx, count, digest_list);
>> +		rc = tpm2_pcr_extend(chip, pcr_idx, chip->nr_active_banks,
>> +				     digest_list);
>> +		kfree(digest_list);
>>   		tpm_put_ops(chip);
>>   		return rc;
>>   	}
>> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>> index f3501d05264f..98368c3a6ff7 100644
>> --- a/drivers/char/tpm/tpm.h
>> +++ b/drivers/char/tpm/tpm.h
>> @@ -248,7 +248,8 @@ struct tpm_chip {
>>   	const struct attribute_group *groups[3];
>>   	unsigned int groups_cnt;
>>   
>> -	u16 active_banks[7];
>> +	u32 nr_active_banks;
>> +	u16 *active_banks;
>>   #ifdef CONFIG_ACPI
>>   	acpi_handle acpi_dev_handle;
>>   	char ppi_version[TPM_PPI_VERSION_LEN + 1];
>> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>> index c31b490bd41d..533089cede07 100644
>> --- a/drivers/char/tpm/tpm2-cmd.c
>> +++ b/drivers/char/tpm/tpm2-cmd.c
>> @@ -242,7 +242,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
>>   	int i;
>>   	int j;
>>   
>> -	if (count > ARRAY_SIZE(chip->active_banks))
>> +	if (count > chip->nr_active_banks)
>>   		return -EINVAL;
>>   
>>   	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
>> @@ -859,7 +859,6 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
>>   	void *marker;
>>   	void *end;
>>   	void *pcr_select_offset;
>> -	unsigned int count;
>>   	u32 sizeof_pcr_selection;
>>   	u32 rsp_len;
>>   	int rc;
>> @@ -878,11 +877,14 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
>>   	if (rc)
>>   		goto out;
>>   
>> -	count = be32_to_cpup(
>> +	chip->nr_active_banks = be32_to_cpup(
>>   		(__be32 *)&buf.data[TPM_HEADER_SIZE + 5]);
>>   
>> -	if (count > ARRAY_SIZE(chip->active_banks)) {
>> -		rc = -ENODEV;
>> +	chip->active_banks = kmalloc_array(chip->nr_active_banks,
>> +					   sizeof(*chip->active_banks),
>> +					   GFP_KERNEL);
>> +	if (!chip->active_banks) {
>> +		rc = -ENOMEM;
>>   		goto out;
>>   	}
>>   
>> @@ -891,7 +893,7 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
>>   	rsp_len = be32_to_cpup((__be32 *)&buf.data[2]);
>>   	end = &buf.data[rsp_len];
>>   
>> -	for (i = 0; i < count; i++) {
>> +	for (i = 0; i < chip->nr_active_banks; i++) {
>>   		pcr_select_offset = marker +
>>   			offsetof(struct tpm2_pcr_selection, size_of_select);
>>   		if (pcr_select_offset >= end) {
>> @@ -908,9 +910,6 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
>>   	}
>>   
>>   out:
>> -	if (i < ARRAY_SIZE(chip->active_banks))
>> -		chip->active_banks[i] = TPM2_ALG_ERROR;
>> -
>>   	tpm_buf_destroy(&buf);
>>   
>>   	return rc;
>> -- 
>> 2.17.1
>>
> 
> /Jarkko
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
