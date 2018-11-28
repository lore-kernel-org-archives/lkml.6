Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110BEC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D645C20873
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D645C20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbeK1Tli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 14:41:38 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32786 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727864AbeK1Tlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 14:41:37 -0500
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 56B341CABD4B0;
        Wed, 28 Nov 2018 08:40:45 +0000 (GMT)
Received: from [10.204.65.144] (10.204.65.144) by smtpsuk.huawei.com
 (10.201.108.35) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 28 Nov
 2018 08:40:38 +0000
Subject: Re: [PATCH v5 6/7] tpm: ensure that the output of PCR read contains
 the correct digest size
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     <zohar@linux.ibm.com>, <david.safford@ge.com>,
        <monty.wiseman@ge.com>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        <stable@vger.kernel.org>
References: <20181114153108.12907-1-roberto.sassu@huawei.com>
 <20181114153108.12907-7-roberto.sassu@huawei.com>
 <20181116134153.GD4163@linux.intel.com>
 <05c7c936-da58-f386-0a43-69e96d6e18a8@huawei.com>
 <20181118073207.GC5897@linux.intel.com>
 <a259a629-def7-b538-2a54-8ca6bfbe772a@huawei.com>
 <20181119143357.GG8755@linux.intel.com>
 <ed2d769b-2917-7d8b-ff9c-16220fa17833@huawei.com>
 <20181119160702.GE13298@linux.intel.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <d3102578-039e-519e-4ed1-f931f00b6846@huawei.com>
Date:   Wed, 28 Nov 2018 09:40:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181119160702.GE13298@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.144]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/2018 5:07 PM, Jarkko Sakkinen wrote:
> On Mon, Nov 19, 2018 at 04:09:34PM +0100, Roberto Sassu wrote:
>> On 11/19/2018 3:33 PM, Jarkko Sakkinen wrote:
>>> On Mon, Nov 19, 2018 at 09:14:00AM +0100, Roberto Sassu wrote:
>>>> On 11/18/2018 8:32 AM, Jarkko Sakkinen wrote:
>>>>> On Fri, Nov 16, 2018 at 05:06:48PM +0100, Roberto Sassu wrote:
>>>>>> On 11/16/2018 2:41 PM, Jarkko Sakkinen wrote:
>>>>>>> On Wed, Nov 14, 2018 at 04:31:07PM +0100, Roberto Sassu wrote:
>>>>>>>> This patch protects against data corruption that could happen in the bus,
>>>>>>>> by checking that that the digest size returned by the TPM during a PCR read
>>>>>>>> matches the size of the algorithm passed to tpm2_pcr_read().
>>>>>>>>
>>>>>>>> This check is performed after information about the PCR banks has been
>>>>>>>> retrieved.
>>>>>>>>
>>>>>>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>>>>>>>> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>>>>>>> Cc: stable@vger.kernel.org
>>>>>>>
>>>>>>> Missing fixes tag.
>>>>>>
>>>>>> Before this patch set, tpm2_pcr_extend() always copied 20 bytes from the
>>>>>> output sent by the TPM.
>>>>>>
>>>>>> Roberto
>>>>>
>>>>> Aah, right, of course. Well the patch set is ATM somewhat broken because
>>>>> this would require a fixes tag that points to a patch insdie the patch
>>>>> set.
>>>>>
>>>>> Probably good way to fix the issue is to just merge this with the
>>>>> earlier commit.
>>>>
>>>> Unfortunately, it is not possible. The exact digest size has been
>>>> introduced with patch 5/7.
>>>
>>> I put this in simple terms: if I merge 5/7 the driver will be broken.
>>> Any commit in the patch set should not leave the tree in broken state.
>>
>> Patch 6/7 does not fix patch 5/7. The check in patch 6/7 is not done for
>> the PCR read performed by patch 5/7, because the digest sizes are not
>> yet available.
> 
> Ah, right. Point taken :-)

Should I keep CC: stable@vger.kernel.org?

Roberto


> /Jarkko
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
