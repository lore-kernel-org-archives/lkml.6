Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A3BECDE46
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DD520827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73DD520827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeKER3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 12:29:36 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32711 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725745AbeKER3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 12:29:36 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 59B834939E4A5;
        Mon,  5 Nov 2018 08:11:05 +0000 (GMT)
Received: from [10.204.65.142] (10.204.65.142) by smtpsuk.huawei.com
 (10.201.108.37) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 5 Nov
 2018 08:10:59 +0000
Subject: Re: [PATCH v3 1/5] tpm: change the end marker of the active_banks
 array to zero
To:     Mimi Zohar <zohar@linux.ibm.com>, <jarkko.sakkinen@linux.intel.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
References: <20181030154711.2782-1-roberto.sassu@huawei.com>
 <20181030154711.2782-2-roberto.sassu@huawei.com>
 <1540996980.11273.67.camel@linux.ibm.com>
 <1541083377.4035.13.camel@linux.ibm.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <b2622675-041b-c1af-4670-aecab2adf3ac@huawei.com>
Date:   Mon, 5 Nov 2018 09:10:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1541083377.4035.13.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.204.65.142]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/2018 3:42 PM, Mimi Zohar wrote:
> On Wed, 2018-10-31 at 10:43 -0400, Mimi Zohar wrote:
>> On Tue, 2018-10-30 at 16:47 +0100, Roberto Sassu wrote:
>>> This patch changes the end marker of the active_banks array from
>>> TPM2_ALG_ERROR to zero.
>>
>> The patch description is a bit off.
>>
>> TPM2_ALG_ERROR is defined as zero.  Since tpm_chip_alloc() calls
>> kzalloc to allocate the structure, there is no need to explicitly set
>> the active_banks end marker to TPM2_ALG_ERROR, nor is there a need to
>> explicitly test for the end marker.
>>
>> This patch removes explicitly setting the end marker and changes the
>> coding style.
>>
>>>
>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>>> ---
>>>   drivers/char/tpm/tpm-interface.c | 2 +-
>>>   drivers/char/tpm/tpm2-cmd.c      | 3 ---
>>>   2 files changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
>>> index 1a803b0cf980..f7fc4b5ee239 100644
>>> --- a/drivers/char/tpm/tpm-interface.c
>>> +++ b/drivers/char/tpm/tpm-interface.c
>>> @@ -1051,7 +1051,7 @@ int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)
>>>   		memset(digest_list, 0, sizeof(digest_list));
>>>   
>>>   		for (i = 0; i < ARRAY_SIZE(chip->active_banks) &&
>>> -			    chip->active_banks[i] != TPM2_ALG_ERROR; i++) {
>>> +			    chip->active_banks[i]; i++) {
>>>   			digest_list[i].alg_id = chip->active_banks[i];
>>>   			memcpy(digest_list[i].digest, hash, TPM_DIGEST_SIZE);
>>>   			count++;
> 
> The fourth patch further updates this code.  Please move those changes
> to this first patch.  No need to touch the same code in both places.

alg_id is introduced in patch 4/5. It cannot be moved here.

Roberto


>                  for (i = 0; i < ARRAY_SIZE(chip->active_banks) &&
> -                           chip->active_banks[i]; i++) {
> -                       digest_list[i].alg_id = chip->active_banks[i];
> +                           chip->active_banks[i].alg_id; i++) {
> +                       digest_list[i].alg_id = chip->active_banks[i].alg_id;
>                          memcpy(digest_list[i].digest, hash, TPM_DIGEST_SIZE);
>                          count++;
>                  }
> Mimi
> 
>>> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>>> index c31b490bd41d..046c9d8f3c1e 100644
>>> --- a/drivers/char/tpm/tpm2-cmd.c
>>> +++ b/drivers/char/tpm/tpm2-cmd.c
>>> @@ -908,9 +908,6 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
>>>   	}
>>>   
>>>   out:
>>> -	if (i < ARRAY_SIZE(chip->active_banks))
>>> -		chip->active_banks[i] = TPM2_ALG_ERROR;
>>> -
>>>   	tpm_buf_destroy(&buf);
>>>   
>>>   	return rc;
>>
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
