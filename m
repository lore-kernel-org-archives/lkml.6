Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1533FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0052086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0052086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeIZUw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:52:27 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2086 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726937AbeIZUw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:52:26 -0400
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 95ED9D2A8DA5;
        Wed, 26 Sep 2018 15:39:06 +0100 (IST)
Received: from [10.204.65.145] (10.204.65.145) by smtpsuk.huawei.com
 (10.201.108.37) with Microsoft SMTP Server (TLS) id 14.3.399.0; Wed, 26 Sep
 2018 15:39:04 +0100
Subject: Re: EXTERNAL: [PATCH v2 2/3] tpm: modify tpm_pcr_read() definition to
 pass TPM hash algorithms
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Jeremy Boone <Jeremy.Boone@nccgroup.trust>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180905114202.7757-1-roberto.sassu@huawei.com>
 <20180905114202.7757-3-roberto.sassu@huawei.com>
 <F275EFAF-C940-4E44-8164-2819503DB334@nccgroup.trust>
 <e1d77563-81fd-36f0-648f-3325969b05af@huawei.com>
 <1537970986.4124.3.camel@linux.ibm.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <9fdc397b-4eba-760c-38d4-fcab9f262698@huawei.com>
Date:   Wed, 26 Sep 2018 16:39:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537970986.4124.3.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.204.65.145]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/2018 4:09 PM, Mimi Zohar wrote:
> On Wed, 2018-09-05 at 17:03 +0200, Roberto Sassu wrote:
>> On 9/5/2018 3:43 PM, Jeremy Boone wrote:
>>> Some comments on tpm2_pcr_read below.
>>>
>>> The tpm2_pcr_read function uses TPM2_ST_NO_SESSIONS. This means
>> that the response payload is not integrity protected with an HMAC.
>> If there is a man-in-the-middle sitting on the serial bus that
>> connects the TPM peripheral to the processor, they can tamper with
>> the response parameters.
>>>   
>>> In your changes to tpm2_pcr_read, the memcpy is now become a
>> variable-length operation, instead of just copying a fixed number of
>> bytes. If the MITM modifies the response field out->digest_size
>> before it is received by the driver, they can make it a very large
>> value, forcing a buffer overflow of the out->digest array.
>>>   
>>> Adding a session to the PCR Read command seems like overkill in
>> this case. I wouldn’t recommend that as a solution here.  So to fix
>> this I would suggest simply checking the digest size before the
>> memcpy.
>>
>> Hi Jeremy
>>
>> ok, thanks.
> 
> The hash digest size checking should be based on the size stored in
> the active_bank_info, either in 3/3 or as a separate patch.

This can be done after the PCR read requested by
tpm2_init_active_bank_info() to initialize the digest sizes.

Roberto
