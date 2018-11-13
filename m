Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D25C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0D92243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0D92243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387440AbeKMXGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:06:55 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32753 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732728AbeKMXGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:06:55 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 851EF55C6FEAD;
        Tue, 13 Nov 2018 13:08:48 +0000 (GMT)
Received: from [10.204.65.144] (10.204.65.144) by smtpsuk.huawei.com
 (10.201.108.37) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 13 Nov
 2018 13:08:40 +0000
Subject: Re: [PATCH v4 6/6] tpm: ensure that the output of PCR read contains
 the correct digest size
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     <zohar@linux.ibm.com>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
References: <20181106150159.1136-1-roberto.sassu@huawei.com>
 <20181106150159.1136-7-roberto.sassu@huawei.com>
 <20181108140814.GF8922@linux.intel.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <bb9af477-61b0-7d11-4509-15cc2b2c0024@huawei.com>
Date:   Tue, 13 Nov 2018 14:08:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181108140814.GF8922@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.144]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/2018 3:08 PM, Jarkko Sakkinen wrote:
> On Tue, Nov 06, 2018 at 04:01:59PM +0100, Roberto Sassu wrote:
>> This patch protects against data corruption that could happen in the bus,
>> by checking that that the digest size returned by the TPM during a PCR read
>> matches the size of the algorithm passed as argument to tpm2_pcr_read().
>>
>> This check is performed after information about the PCR banks has been
>> retrieved.
>>
>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>> ---
>>   drivers/char/tpm/tpm2-cmd.c | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>> index e2d5b84286a7..3b0b5b032901 100644
>> --- a/drivers/char/tpm/tpm2-cmd.c
>> +++ b/drivers/char/tpm/tpm2-cmd.c
>> @@ -187,15 +187,28 @@ struct tpm2_pcr_read_out {
>>   int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx,
>>   		  struct tpm_digest *digest_struct, u16 *digest_size_ptr)
>>   {
>> +	int i;
>>   	int rc;
>>   	struct tpm_buf buf;
>>   	struct tpm2_pcr_read_out *out;
>>   	u8 pcr_select[TPM2_PCR_SELECT_MIN] = {0};
>>   	u16 digest_size;
>> +	u16 expected_digest_size = 0;
>>   
>>   	if (pcr_idx >= TPM2_PLATFORM_PCR)
>>   		return -EINVAL;
>>   
>> +	if (!digest_size_ptr) {
>> +		for (i = 0; i < chip->nr_active_banks &&
>> +		     chip->active_banks[i].alg_id != digest_struct->alg_id; i++)
>> +			;
> 
> Not sure if the semicolon should be in its own line.
> `
>> +
>> +		if (i == chip->nr_active_banks)
>> +			return -EINVAL;
>> +
>> +		expected_digest_size = chip->active_banks[i].digest_size;
>> +	}
>> +
>>   	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_PCR_READ);
>>   	if (rc)
>>   		return rc;
>> @@ -215,7 +228,8 @@ int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx,
>>   
>>   	out = (struct tpm2_pcr_read_out *)&buf.data[TPM_HEADER_SIZE];
>>   	digest_size = be16_to_cpu(out->digest_size);
>> -	if (digest_size > sizeof(digest_struct->digest)) {
>> +	if (digest_size > sizeof(digest_struct->digest) ||
>> +	    (!digest_size_ptr && digest_size != expected_digest_size)) {
>>   		rc = -EINVAL;
>>   		goto out;
>>   	}
>> -- 
>> 2.17.1
>>
> 
> Please add
> 
> Cc: stable@vger.kernel.org.

Should I do the same for the previous patches? This patch cannot be
applied alone.

Roberto


> /Jarkko
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
