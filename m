Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED2BC282D8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DB1206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfBDJOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:14:51 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32861 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726987AbfBDJOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:14:51 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 53BCC73C55901C077B4B;
        Mon,  4 Feb 2019 09:14:49 +0000 (GMT)
Received: from [10.204.65.155] (10.204.65.155) by smtpsuk.huawei.com
 (10.201.108.37) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 4 Feb
 2019 09:14:43 +0000
Subject: Re: [PATCH v9 6/6] tpm: pass an array of tpm_extend_digest structures
 to tpm_pcr_extend()
To:     Mimi Zohar <zohar@linux.ibm.com>,
        <jarkko.sakkinen@linux.intel.com>, <david.safford@ge.com>,
        <monty.wiseman@ge.com>, <matthewgarrett@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>
References: <20190201100641.26936-1-roberto.sassu@huawei.com>
 <20190201100641.26936-7-roberto.sassu@huawei.com>
 <1549048506.6993.73.camel@linux.ibm.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <9f8a64d6-d566-1497-1d2b-465440cdfa80@huawei.com>
Date:   Mon, 4 Feb 2019 10:14:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1549048506.6993.73.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.204.65.155]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/2019 8:15 PM, Mimi Zohar wrote:
> Hi Roberto,
> 
> Sorry for the delayed review.  A few comments inline below, minor
> suggestions.
> 
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index cc12f3449a72..e6b2dcb0846a 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -56,6 +56,7 @@ extern int ima_policy_flag;
>>   extern int ima_hash_algo;
>>   extern int ima_appraise;
>>   extern struct tpm_chip *ima_tpm_chip;
>> +extern struct tpm_digest *digests;
>>   
>>   /* IMA event related data */
>>   struct ima_event_data {
>> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
>> index 6bb42a9c5e47..296a965b11ef 100644
>> --- a/security/integrity/ima/ima_init.c
>> +++ b/security/integrity/ima/ima_init.c
>> @@ -27,6 +27,7 @@
>>   /* name for boot aggregate entry */
>>   static const char boot_aggregate_name[] = "boot_aggregate";
>>   struct tpm_chip *ima_tpm_chip;
>> +struct tpm_digest *digests;
> 
> "digests" is used in the new ima_init_digests() and in
> ima_pcr_extend().  It's nice that the initialization routines are
> grouped together here in ima_init.c, but wouldn't it better to define
> "digests" in ima_queued.c, where it is currently being used?
>   "digests" could then be defined as static.

'digests' and ima_init_digests() can be moved to ima_queue.c, but I have
to add the definition of ima_init_digests() to ima.h. Should I do it?


>>   /* Add the boot aggregate to the IMA measurement list and extend
>>    * the PCR register.
>> @@ -104,6 +105,24 @@ void __init ima_load_x509(void)
>>   }
>>   #endif
>>   
>> +int __init ima_init_digests(void)
>> +{
>> +	int i;
>> +
>> +	if (!ima_tpm_chip)
>> +		return 0;
>> +
>> +	digests = kcalloc(ima_tpm_chip->nr_allocated_banks, sizeof(*digests),
>> +			  GFP_NOFS);
>> +	if (!digests)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++)
>> +		digests[i].alg_id = ima_tpm_chip->allocated_banks[i].alg_id;
>> +
>> +	return 0;
>> +}
>> +
>>   int __init ima_init(void)
>>   {
>>   	int rc;
>> @@ -125,6 +144,9 @@ int __init ima_init(void)
>>   
>>   	ima_load_kexec_buffer();
>>   
>> +	rc = ima_init_digests();
> 
> Ok. Getting the tpm chip is at the beginning of this function.
>   Deferring allocating "digests" to here, avoids having to free memory
> on failure.
> 
> ima_load_kexec_buffer() restores prior measurements, but doesn't
> extend the TPM.  For anyone reading the code, a short comment above
> ima_load_kexec_buffer() would make sense.

Ok. Should I resend the last patch again with the fixes you suggested?

Thanks

Roberto


> Mimi
>     
>> +	if (rc != 0)
>> +		return rc;
>>   	rc = ima_add_boot_aggregate();	/* boot aggregate must be first entry */
>>   	if (rc != 0)
>>   		return rc;
>> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
>> index 0e41dc1df1d4..719e88ca58f6 100644
>> --- a/security/integrity/ima/ima_queue.c
>> +++ b/security/integrity/ima/ima_queue.c
>> @@ -140,11 +140,15 @@ unsigned long ima_get_binary_runtime_size(void)
>>   static int ima_pcr_extend(const u8 *hash, int pcr)
>>   {
>>   	int result = 0;
>> +	int i;
>>   
>>   	if (!ima_tpm_chip)
>>   		return result;
>>   
>> -	result = tpm_pcr_extend(ima_tpm_chip, pcr, hash);
>> +	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++)
>> +		memcpy(digests[i].digest, hash, TPM_DIGEST_SIZE);
>> +
>> +	result = tpm_pcr_extend(ima_tpm_chip, pcr, digests);
>>   	if (result != 0)
>>   		pr_err("Error Communicating to TPM chip, result: %d\n", result);
>>   	return result;
>>
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
