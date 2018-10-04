Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E62C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42892082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42892082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbeJDVDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:03:39 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2096 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727369AbeJDVDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:03:39 -0400
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 8CC95D1BDADD8;
        Thu,  4 Oct 2018 15:10:06 +0100 (IST)
Received: from [10.204.65.138] (10.204.65.138) by smtpsuk.huawei.com
 (10.201.108.34) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 4 Oct
 2018 15:10:08 +0100
Subject: Re: [PATCH v5 12/21] tpm: move pcr extend code to tpm2-cmd.c
To:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180928223035.14471-1-tomas.winkler@intel.com>
 <20180928223035.14471-13-tomas.winkler@intel.com>
 <20181002005208.GH23753@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9DFAA5@hasmsx109.ger.corp.intel.com>
 <20181003120141.GA7969@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9E5343@hasmsx109.ger.corp.intel.com>
 <20181004113502.GA12498@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9E6D00@hasmsx109.ger.corp.intel.com>
 <19c26db0-cde9-da70-1b02-7e37ca188b45@huawei.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9E6E47@hasmsx109.ger.corp.intel.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <1851e1d3-edc8-613d-00c3-dd3847f3ecd2@huawei.com>
Date:   Thu, 4 Oct 2018 16:10:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D9E6E47@hasmsx109.ger.corp.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.138]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/2018 3:46 PM, Winkler, Tomas wrote:
>>
>> On 10/4/2018 1:45 PM, Winkler, Tomas wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Jarkko Sakkinen [mailto:jarkko.sakkinen@linux.intel.com]
>>>> Sent: Thursday, October 04, 2018 14:35
>>>> To: Winkler, Tomas <tomas.winkler@intel.com>
>>>> Cc: Jason Gunthorpe <jgg@ziepe.ca>; Nayna Jain
>>>> <nayna@linux.vnet.ibm.com>; Usyskin, Alexander
>>>> <alexander.usyskin@intel.com>; Struk, Tadeusz
>>>> <tadeusz.struk@intel.com>; linux-integrity@vger.kernel.org;
>>>> linux-security-module@vger.kernel.org;
>>>> linux-kernel@vger.kernel.org; roberto.sassu@huawei.com
>>>> Subject: Re: [PATCH v5 12/21] tpm: move pcr extend code to tpm2-cmd.c
>>>>
>>>> On Wed, Oct 03, 2018 at 10:24:09PM +0000, Winkler, Tomas wrote:
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Jarkko Sakkinen [mailto:jarkko.sakkinen@linux.intel.com]
>>>>>> Sent: Wednesday, October 03, 2018 15:02
>>>>>> To: Winkler, Tomas <tomas.winkler@intel.com>
>>>>>> Cc: Jason Gunthorpe <jgg@ziepe.ca>; Nayna Jain
>>>>>> <nayna@linux.vnet.ibm.com>; Usyskin, Alexander
>>>>>> <alexander.usyskin@intel.com>; Struk, Tadeusz
>>>>>> <tadeusz.struk@intel.com>; linux-integrity@vger.kernel.org;
>>>>>> linux-security-module@vger.kernel.org;
>>>>>> linux-kernel@vger.kernel.org; roberto.sassu@huawei.com
>>>>>> Subject: Re: [PATCH v5 12/21] tpm: move pcr extend code to
>>>>>> tpm2-cmd.c
>>>>>>
>>>>>> On Tue, Oct 02, 2018 at 04:58:25AM +0000, Winkler, Tomas wrote:
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> On Sat, Sep 29, 2018 at 01:30:26AM +0300, Tomas Winkler wrote:
>>>>>>>>> Add tpm2_pcr_extend() function to tpm2-cmd.c with signature
>>>>>>>>> required by tpm-interface.c. It wraps the original open code
>>>>>> implementation.
>>>>>>>>> The original original tpm2_pcr_extend() function is renamed to
>>>>>>>>> __tpm2_pcr_extend() and made static, it is called only from new
>>>>>>>>> tpm2_pcr_extend().
>>>>>>>>>
>>>>>>>>> Fix warnings in __tpm2_pcr_extend()
>>>>>>>>> tpm2-cmd.c:251:16: warning: comparison between signed and
>>>>>>>>> unsigned integer expressions [-Wsign-compare]
>>>>>>>>> tpm2-cmd.c:252:17: warning: comparison between signed and
>>>>>>>>> unsigned integer expressions [-Wsign-compare]
>>>>>>>>>
>>>>>>>>> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
>>>>>>>>
>>>>>>>> We do not want the signature change, especially because as we are
>>>>>>>> working on getting Roberto's changes in and also because it has
>>>>>>>> absolutely a zero gain. Who cares if those functions take
>>>>>>>> different
>>>>>> parameters? I don't.
>>>>>>>
>>>>>>> Yes, we do care this series tries to have a clean cut between 1.x
>>>>>>> and 2.x
>>>>>> specs. Please, let's finish one transformation and then move to
>> another.
>>>>>>> I understand that Roberto will have to rebase anyhow, if this
>>>>>>> series goes in
>>>>>> first, if this is hard I can do it myself, it's trivial.
>>>>>>>
>>>>>>> Tomas
>>>>>>
>>>>>> I'm happy to tune this minor stuff.
>>>>> What minor stuff?  This patch is just okay, let's change the API in
>>>>> next
>>>> round.
>>>>
>>>> The patch is not okay because it does a completely unnecessary API
>> change.
>>>
>>> There is no API change, in that sense.
>>> The exported API is in tpm-interface.c int tpm_pcr_extend(struct
>>> tpm_chip *chip, int pcr_idx, const u8 *hash) that is used is outside
>>> of the tpm reminds the same, only the open coded implementation of
>> tpm2_pcr_extned has moved to tpm2-cmd.c, This code is not called out of
>> tpm module.
>>> Please review the code again.
>>
>> Hi Tomas
>>
>> I will update tpm_pcr_extend() by replacing the array of u8 with an array of
>> tpm2_digest structures, so that the caller can provide multiple digests with
>> one call. The array of tpm2_digest structures will be passed to
>> tpm2_pcr_extend(). Please, don't modify the parameters of
>> tpm2_pcr_extend().
> 
> What about tpm1_pcr_extend/read()?

tpm_pcr_extend/read() would pass to them the array of u8 from the
tpm2_digest structure. Check this patch:

[PATCH v2 2/3] tpm: modify tpm_pcr_read() definition to pass TPM hash
algorithms

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
