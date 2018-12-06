Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E3DC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C3120850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C3120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbeLFSHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:07:43 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32802 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725898AbeLFSHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:07:43 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id A609DD4B967B3;
        Thu,  6 Dec 2018 18:07:39 +0000 (GMT)
Received: from [10.204.65.144] (10.204.65.144) by smtpsuk.huawei.com
 (10.201.108.34) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 6 Dec
 2018 18:07:35 +0000
Subject: Re: [PATCH v6 6/7] tpm: ensure that the output of PCR read contains
 the correct digest size
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     <zohar@linux.ibm.com>, <david.safford@ge.com>,
        <monty.wiseman@ge.com>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
References: <20181204082138.24600-1-roberto.sassu@huawei.com>
 <20181204082138.24600-7-roberto.sassu@huawei.com>
 <20181205000910.GE1233@linux.intel.com>
 <20181205004643.GA26578@linux.intel.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <af5a430f-c6ef-3989-0d93-7f972c26737d@huawei.com>
Date:   Thu, 6 Dec 2018 19:07:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181205004643.GA26578@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.144]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/2018 1:46 AM, Jarkko Sakkinen wrote:
> On Tue, Dec 04, 2018 at 04:09:10PM -0800, Jarkko Sakkinen wrote:
>> On Tue, Dec 04, 2018 at 09:21:37AM +0100, Roberto Sassu wrote:
>>>   	out = (struct tpm2_pcr_read_out *)&buf.data[TPM_HEADER_SIZE];
>>>   	digest_size = be16_to_cpu(out->digest_size);
>>> -	if (digest_size > sizeof(digest->digest)) {
>>> +	if (digest_size > sizeof(digest->digest) ||
>>> +	    (!digest_size_ptr && digest_size != expected_digest_size)) {
>>>   		rc = -EINVAL;
>>>   		goto out;
>>>   	}
>>
>> Just noticed this but you must squash 4-6 because applying only
>> previous commits will result a broken tree. It will be much bigger
>> commit but won't be broken.
>>
>> I think you should also feed min_rsp_body_length as you should be
>> able to precalculate.
>>
>> Last time I was asking why this isn't a bug fix. It is even for
>> the existing code. The existing code should have a bug fix that
>> checks that the received digest size so that it is the expected
>> SHA1 size before we can apply this commit.
> 
> My bad. This is not the same deal as the code because in the old code we
> always copy a constant block. Here we use the variable as parameter for
> memcpy() so it is better to check the size. You can ignore the last
> paragraph completely. Sorry, had to double check this one.
> 
> There is no need to do any type of bug fix for the current tree.
> 
> Still 4-6 need to be squashed in order to not put purposely the tree
> into broken state.

Ok. I keep the description of 5, and add few details from 4 and 6.

Roberto


> /Jarko
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
