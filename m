Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFE2ECDE4D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9B82086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9B82086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeKIAQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:16:17 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32724 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbeKIAQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:16:16 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 5036C2F49990E;
        Thu,  8 Nov 2018 14:40:25 +0000 (GMT)
Received: from [10.204.65.142] (10.204.65.142) by smtpsuk.huawei.com
 (10.201.108.37) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 8 Nov
 2018 14:40:18 +0000
Subject: Re: [PATCH v4 1/6] tpm: dynamically allocate active_banks array
To:     Nayna Jain <nayna@linux.ibm.com>,
        <jarkko.sakkinen@linux.intel.com>, <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Ken Goldman <kgold@linux.vnet.ibm.com>,
        Kenneth Goldman <kgoldman@us.ibm.com>
References: <20181106150159.1136-1-roberto.sassu@huawei.com>
 <20181106150159.1136-2-roberto.sassu@huawei.com>
 <98482eee-6e91-1666-1ce2-cfa94a33efc2@linux.ibm.com>
 <da2ef557-3041-a1ca-47cb-fd7ab92876aa@huawei.com>
 <086944ab-dd56-5522-af26-e9bb545556fd@linux.ibm.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <3528fa4f-b6fc-3af2-65f7-56b5d41e0932@huawei.com>
Date:   Thu, 8 Nov 2018 15:40:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <086944ab-dd56-5522-af26-e9bb545556fd@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.204.65.142]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/2018 2:50 PM, Nayna Jain wrote:
> 
> 
> On 11/07/2018 03:11 PM, Roberto Sassu wrote:
>> On 11/7/2018 7:14 AM, Nayna Jain wrote:
>>>
>>>
>>> On 11/06/2018 08:31 PM, Roberto Sassu wrote:
>>>> This patch removes the hard-coded limit of the active_banks array size.
>>>
>>>
>>> The hard-coded limit in static array active_banks[] represents the 
>>> maximum possible banks.
>>> A TPM might have three banks, but only one bank may be active.
>>>
>>> To confirm my understanding, is the idea for this patch is to 
>>> dynamically identify the number of possible banks or the number of 
>>> active banks ?
>>
>> The idea is to dynamically identify the number of active banks.
>>
>> In the TPM Commands specification (section 30.2.1), I found:
>>
>> TPM_CAP_PCRS – Returns the current allocation of PCR in a
>> TPML_PCR_SELECTION.
>>
>> You mentioned:
>>
>> #TPM_RC_SIZE response code when count is greater
>> than the possible number of banks
>>
>> but TPML_PCR_SELECTION is provided by the TPM.
> 
> Based on a discussion with Ken, the count in the TPML_PCR_SELECTION 
> returns the number of possible algorithms supported. In the example 
> below, two possible algorithms - SHA1 and SHA256 - are returned.
> 
> # /usr/local/bin/tssgetcapability -cap 5
> 2 PCR selections
>      hash TPM_ALG_SHA1
>      TPMS_PCR_SELECTION length 3
>      ff ff ff
>      hash TPM_ALG_SHA256
>      TPMS_PCR_SELECTION length 3
>      00 00 00
> 
> The pcr_select fields - "ff ff ff" and "00 00 00" - are bit masks for 
> the enabled PCRs. The SHA1 bank is enabled for all PCRs (0-23), while 
> the SHA256 bank is not enabled.
> 
> The current code works, but it unnecessarily extends some banks. Instead 
> of basing the number of active banks on the number of algorithms 
> returned, it should be based on the pcr_select field.

Thanks. I will add a bank if at least one bit is set in the pcr_select
mask.

Roberto


>     - Mimi & Nayna
> 
> 
>>
>> Roberto
>>
>>
>>>> It stores in the tpm_chip structure the number of active PCR banks,
>>>> determined in tpm2_get_pcr_allocation(), and replaces the static array
>>>> with a pointer to a dynamically allocated array.
>>>>
>>>> As a consequence of the introduction of nr_active_banks, 
>>>> tpm_pcr_extend()
>>>> does not check anymore if the algorithm stored in tpm_chip is equal to
>>>> zero. The active_banks array always contains valid algorithms.
>>>>
>>>> Fixes: 1db15344f874 ("tpm: implement TPM 2.0 capability to get active
>>>> PCR banks")
>>>>
>>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>>>> ---
>>>>   drivers/char/tpm/tpm-chip.c      |  1 +
>>>>   drivers/char/tpm/tpm-interface.c | 19 ++++++++++++-------
>>>>   drivers/char/tpm/tpm.h           |  3 ++-
>>>>   drivers/char/tpm/tpm2-cmd.c      | 17 ++++++++---------
>>>>   4 files changed, 23 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>>>> index 46caadca916a..2a9e8b744436 100644
>>>> --- a/drivers/char/tpm/tpm-chip.c
>>>> +++ b/drivers/char/tpm/tpm-chip.c
>>>> @@ -160,6 +160,7 @@ static void tpm_dev_release(struct device *dev)
>>>>       kfree(chip->log.bios_event_log);
>>>>       kfree(chip->work_space.context_buf);
>>>>       kfree(chip->work_space.session_buf);
>>>> +    kfree(chip->active_banks);
>>>>       kfree(chip);
>>>>   }
>>>>
>>>> diff --git a/drivers/char/tpm/tpm-interface.c 
>>>> b/drivers/char/tpm/tpm-interface.c
>>>> index 1a803b0cf980..ba7ca6b3e664 100644
>>>> --- a/drivers/char/tpm/tpm-interface.c
>>>> +++ b/drivers/char/tpm/tpm-interface.c
>>>> @@ -1039,8 +1039,7 @@ static int tpm1_pcr_extend(struct tpm_chip 
>>>> *chip, int pcr_idx, const u8 *hash,
>>>>   int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 
>>>> *hash)
>>>>   {
>>>>       int rc;
>>>> -    struct tpm2_digest digest_list[ARRAY_SIZE(chip->active_banks)];
>>>> -    u32 count = 0;
>>>> +    struct tpm2_digest *digest_list;
>>>>       int i;
>>>>
>>>>       chip = tpm_find_get_ops(chip);
>>>> @@ -1048,16 +1047,22 @@ int tpm_pcr_extend(struct tpm_chip *chip, 
>>>> int pcr_idx, const u8 *hash)
>>>>           return -ENODEV;
>>>>
>>>>       if (chip->flags & TPM_CHIP_FLAG_TPM2) {
>>>> -        memset(digest_list, 0, sizeof(digest_list));
>>>> +        digest_list = kmalloc_array(chip->nr_active_banks,
>>>> +                        sizeof(*digest_list), GFP_KERNEL);
>>>> +        if (!digest_list)
>>>> +            return -ENOMEM;
>>>>
>>>> -        for (i = 0; i < ARRAY_SIZE(chip->active_banks) &&
>>>> -                chip->active_banks[i] != TPM2_ALG_ERROR; i++) {
>>>> +        memset(digest_list, 0,
>>>> +               chip->nr_active_banks * sizeof(*digest_list));
>>>> +
>>>> +        for (i = 0; i < chip->nr_active_banks; i++) {
>>>>               digest_list[i].alg_id = chip->active_banks[i];
>>>>               memcpy(digest_list[i].digest, hash, TPM_DIGEST_SIZE);
>>>> -            count++;
>>>>           }
>>>>
>>>> -        rc = tpm2_pcr_extend(chip, pcr_idx, count, digest_list);
>>>> +        rc = tpm2_pcr_extend(chip, pcr_idx, chip->nr_active_banks,
>>>> +                     digest_list);
>>>> +        kfree(digest_list);
>>>>           tpm_put_ops(chip);
>>>>           return rc;
>>>>       }
>>>> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>>>> index f3501d05264f..98368c3a6ff7 100644
>>>> --- a/drivers/char/tpm/tpm.h
>>>> +++ b/drivers/char/tpm/tpm.h
>>>> @@ -248,7 +248,8 @@ struct tpm_chip {
>>>>       const struct attribute_group *groups[3];
>>>>       unsigned int groups_cnt;
>>>>
>>>> -    u16 active_banks[7];
>>>> +    u32 nr_active_banks;
>>>> +    u16 *active_banks;
>>>>   #ifdef CONFIG_ACPI
>>>>       acpi_handle acpi_dev_handle;
>>>>       char ppi_version[TPM_PPI_VERSION_LEN + 1];
>>>> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>>>> index c31b490bd41d..533089cede07 100644
>>>> --- a/drivers/char/tpm/tpm2-cmd.c
>>>> +++ b/drivers/char/tpm/tpm2-cmd.c
>>>> @@ -242,7 +242,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, int 
>>>> pcr_idx, u32 count,
>>>>       int i;
>>>>       int j;
>>>>
>>>> -    if (count > ARRAY_SIZE(chip->active_banks))
>>>> +    if (count > chip->nr_active_banks)
>>>>           return -EINVAL;
>>>>
>>>>       rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
>>>> @@ -859,7 +859,6 @@ static ssize_t tpm2_get_pcr_allocation(struct 
>>>> tpm_chip *chip)
>>>>       void *marker;
>>>>       void *end;
>>>>       void *pcr_select_offset;
>>>> -    unsigned int count;
>>>>       u32 sizeof_pcr_selection;
>>>>       u32 rsp_len;
>>>>       int rc;
>>>> @@ -878,11 +877,14 @@ static ssize_t tpm2_get_pcr_allocation(struct 
>>>> tpm_chip *chip)
>>>>       if (rc)
>>>>           goto out;
>>>>
>>>> -    count = be32_to_cpup(
>>>> +    chip->nr_active_banks = be32_to_cpup(
>>>>           (__be32 *)&buf.data[TPM_HEADER_SIZE + 5]);
>>>
>>>
>>> As per my understanding, the count in the TPML_PCR_SELECTION 
>>> represent the number of possible banks and not the number of active 
>>> banks.
>>> TCG Structures Spec for TPM 2.0 - Table 102 mentions this as 
>>> explanation of #TPM_RC_SIZE.
>>>
>>> Thanks & Regards,
>>>      - Nayna
>>>
>>>
>>>>
>>>> -    if (count > ARRAY_SIZE(chip->active_banks)) {
>>>> -        rc = -ENODEV;
>>>> +    chip->active_banks = kmalloc_array(chip->nr_active_banks,
>>>> +                       sizeof(*chip->active_banks),
>>>> +                       GFP_KERNEL);
>>>> +    if (!chip->active_banks) {
>>>> +        rc = -ENOMEM;
>>>>           goto out;
>>>>       }
>>>>
>>>> @@ -891,7 +893,7 @@ static ssize_t tpm2_get_pcr_allocation(struct 
>>>> tpm_chip *chip)
>>>>       rsp_len = be32_to_cpup((__be32 *)&buf.data[2]);
>>>>       end = &buf.data[rsp_len];
>>>>
>>>> -    for (i = 0; i < count; i++) {
>>>> +    for (i = 0; i < chip->nr_active_banks; i++) {
>>>>           pcr_select_offset = marker +
>>>>               offsetof(struct tpm2_pcr_selection, size_of_select);
>>>>           if (pcr_select_offset >= end) {
>>>> @@ -908,9 +910,6 @@ static ssize_t tpm2_get_pcr_allocation(struct 
>>>> tpm_chip *chip)
>>>>       }
>>>>
>>>>   out:
>>>> -    if (i < ARRAY_SIZE(chip->active_banks))
>>>> -        chip->active_banks[i] = TPM2_ALG_ERROR;
>>>> -
>>>>       tpm_buf_destroy(&buf);
>>>>
>>>>       return rc;
>>>
>>
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
