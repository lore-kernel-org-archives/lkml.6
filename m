Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0692C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0E420854
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfAGKGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:06:48 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32818 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726453AbfAGKGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:06:47 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id EC413F9CFFC653B95D1C;
        Mon,  7 Jan 2019 10:06:45 +0000 (GMT)
Received: from [10.204.65.149] (10.204.65.149) by smtpsuk.huawei.com
 (10.201.108.34) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 7 Jan
 2019 10:06:38 +0000
Subject: Re: [PATCH v7 1/5] tpm: dynamically allocate the allocated_banks
 array
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     <zohar@linux.ibm.com>, <david.safford@ge.com>,
        <monty.wiseman@ge.com>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
References: <20181213102945.30946-1-roberto.sassu@huawei.com>
 <20181213102945.30946-2-roberto.sassu@huawei.com>
 <20181220145500.GA10652@linux.intel.com>
 <0900a894-e17b-edc8-fa30-db7d16665082@huawei.com>
 <20181222000321.GB8954@linux.intel.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <7cc91a22-b09b-8bdc-c225-adff68e1f69e@huawei.com>
Date:   Mon, 7 Jan 2019 11:06:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181222000321.GB8954@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.149]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/2018 1:03 AM, Jarkko Sakkinen wrote:
> On Fri, Dec 21, 2018 at 10:40:09AM +0100, Roberto Sassu wrote:
>> On 12/20/2018 3:55 PM, Jarkko Sakkinen wrote:
>>> On Thu, Dec 13, 2018 at 11:29:41AM +0100, Roberto Sassu wrote:
>>>> This patch renames active_banks (member of tpm_chip) to allocated_banks,
>>>> stores the number of allocated PCR banks in nr_allocated_banks (new member
>>>> of tpm_chip), and replaces the static array with a pointer to a dynamically
>>>> allocated array.
>>>>
>>>> tpm2_get_pcr_allocation() determines if a PCR bank is allocated by checking
>>>> the mask in the TPML_PCR_SELECTION structure returned by the TPM for
>>>> TPM2_Get_Capability(). If a bank is not allocated, the TPM returns that
>>>> bank in TPML_PCR_SELECTION, with all bits in the mask set to zero. In this
>>>> case, the bank is not included in chip->allocated_banks, to avoid that TPM
>>>> driver users unnecessarily calculate a digest for that bank.
>>>>
>>>> One PCR bank with algorithm set to SHA1 is always allocated for TPM 1.x.
>>>>
>>>> As a consequence of the introduction of nr_allocated_banks,
>>>> tpm_pcr_extend() does not check anymore if the algorithm stored in tpm_chip
>>>> is equal to zero.
>>>>
>>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>>>> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>>> ---
>>>>    drivers/char/tpm/tpm-chip.c      |  1 +
>>>>    drivers/char/tpm/tpm-interface.c | 18 +++++++++--------
>>>>    drivers/char/tpm/tpm.h           |  3 ++-
>>>>    drivers/char/tpm/tpm1-cmd.c      | 10 ++++++++++
>>>>    drivers/char/tpm/tpm2-cmd.c      | 34 ++++++++++++++++++++++----------
>>>>    5 files changed, 47 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>>>> index 32db84683c40..ce851c62bb68 100644
>>>> --- a/drivers/char/tpm/tpm-chip.c
>>>> +++ b/drivers/char/tpm/tpm-chip.c
>>>> @@ -160,6 +160,7 @@ static void tpm_dev_release(struct device *dev)
>>>>    	kfree(chip->log.bios_event_log);
>>>>    	kfree(chip->work_space.context_buf);
>>>>    	kfree(chip->work_space.session_buf);
>>>> +	kfree(chip->allocated_banks);
>>>>    	kfree(chip);
>>>>    }
>>>> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
>>>> index d9439f9abe78..7b80919228be 100644
>>>> --- a/drivers/char/tpm/tpm-interface.c
>>>> +++ b/drivers/char/tpm/tpm-interface.c
>>>> @@ -488,8 +488,7 @@ EXPORT_SYMBOL_GPL(tpm_pcr_read);
>>>>    int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash)
>>>>    {
>>>>    	int rc;
>>>> -	struct tpm2_digest digest_list[ARRAY_SIZE(chip->active_banks)];
>>>> -	u32 count = 0;
>>>> +	struct tpm2_digest *digest_list;
>>>>    	int i;
>>>>    	chip = tpm_find_get_ops(chip);
>>>> @@ -497,16 +496,19 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash)
>>>>    		return -ENODEV;
>>>>    	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
>>>> -		memset(digest_list, 0, sizeof(digest_list));
>>>> +		digest_list = kcalloc(chip->nr_allocated_banks,
>>>> +				      sizeof(*digest_list), GFP_KERNEL);
>>>> +		if (!digest_list)
>>>> +			return -ENOMEM;
>>>
>>> You could preallocate digest list and place it to struct tpm_chip
>>> instead of doing it everytime tpm_pcr_extend() called.
>>
>> This part will be removed with patch 5/5.
> 
> Even if it did, it does not make this patch unbroken.

Can two calls to tpm_pcr_extend() be executed at the same time?

If yes, the digest list should be protected by a mutex.

Roberto


> /Jarkko
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
