Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63722C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B3F2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B3F2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeKSSjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:39:47 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32776 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726687AbeKSSjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 13:39:46 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 42754A2F000E7;
        Mon, 19 Nov 2018 08:16:50 +0000 (GMT)
Received: from [10.204.65.144] (10.204.65.144) by smtpsuk.huawei.com
 (10.201.108.34) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 19 Nov
 2018 08:16:46 +0000
Subject: Re: [PATCH v5 7/7] tpm: pass an array of tpm_bank_list structures to
 tpm_pcr_extend()
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     <david.safford@ge.com>, <monty.wiseman@ge.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
References: <20181114153108.12907-1-roberto.sassu@huawei.com>
 <20181114153108.12907-8-roberto.sassu@huawei.com>
 <20181116150352.GA3612@linux.intel.com>
 <9c534ed1-7832-7a3b-3e69-5fcc25c565cc@huawei.com>
 <20181118072745.GA5897@linux.intel.com>
 <1542603470.4914.55.camel@linux.ibm.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <26519f33-b5d6-c2c6-5179-c43f197f2cbd@huawei.com>
Date:   Mon, 19 Nov 2018 09:16:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1542603470.4914.55.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.204.65.144]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/2018 5:57 AM, Mimi Zohar wrote:
> On Sun, 2018-11-18 at 09:27 +0200, Jarkko Sakkinen wrote:
>> On Fri, Nov 16, 2018 at 04:55:36PM +0100, Roberto Sassu wrote:
>>> On 11/16/2018 4:03 PM, Jarkko Sakkinen wrote:
>>>> On Wed, Nov 14, 2018 at 04:31:08PM +0100, Roberto Sassu wrote:
>>>>> Currently, tpm_pcr_extend() accepts as an input only a SHA1 digest.
>>>>>
>>>>> This patch modifies the definition of tpm_pcr_extend() to allow other
>>>>> kernel subsystems to pass a digest for each algorithm supported by the TPM.
>>>>> All digests are processed by the TPM in one operation.
>>>>>
>>>>> If a tpm_pcr_extend() caller provides a subset of the supported algorithms,
>>>>> the TPM driver extends the remaining PCR banks with the first digest
>>>>> passed as an argument to the function.
>>>>
>>>> What is the legit use case for this?
>>>
>>> A subset could be chosen for better performance, or when a TPM algorithm
>>> is not supported by the crypto subsystem.
>>
>> Doesn't extending a subset a security concern?
> 
> Right, so instead of extending a subset of the allocated banks, all of
> the allocated banks need to be extended, even for those banks that a
> digest was not included.  This is no different than what is being done
> today.  IMA is currently only calculating the SHA1 hash, padding the
> digest with 0's, and extending the padded value(s) into all of the
> allocated banks.

The caller of tpm_pcr_extend() could pass a subset of the allocated
banks, but the TPM driver extends all banks as before.

Roberto


> If there is a vulnerability with the hash algorithm, then any bank
> extended with the padded/truncated digest would be susceptible.
> 
> IMA will need to become TPM 2.0 aware, calculating and extending
> multiple banks and define a new measurement list format containing the
> multiple digests.
> 
> Mimi
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
