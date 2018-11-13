Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D68C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0426223CB
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0426223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387570AbeKMXgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:36:54 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14654 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732728AbeKMXgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:36:53 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 327A73E8DF5F2;
        Tue, 13 Nov 2018 21:38:38 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Tue, 13 Nov 2018
 21:38:29 +0800
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] scsi: libsas: Remove pcidev reference
To:     Joe Perches <joe@perches.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>
References: <1542043689-214071-1-git-send-email-john.garry@huawei.com>
 <584e7b4fcd6f95fe0c581f6f9472852685c754d1.camel@perches.com>
 <310504a2-f33c-183b-d00a-fa067b273dfd@huawei.com>
 <3b62b0ad-53ba-37c2-817c-591d94eed838@huawei.com>
 <31d224e8c4b9bcebc3657c17fa50302f7da90e64.camel@perches.com>
 <dd39734e-4113-f9fd-6890-a83e80093c7e@huawei.com>
 <3470156e35390d1810a6a5e4a554a77493c0d44f.camel@perches.com>
 <39f56211-cf15-8ca5-a48f-3e4cc347cdb0@huawei.com>
 <dda6fafd2096845ef503921703652f511d4f0daa.camel@perches.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Message-ID: <b63b6d3c-3b18-fcfa-1869-78b1f7637fd1@huawei.com>
Date:   Tue, 13 Nov 2018 13:38:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <dda6fafd2096845ef503921703652f511d4f0daa.camel@perches.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2018 19:52, Joe Perches wrote:
> On Mon, 2018-11-12 at 19:31 +0000, John Garry wrote:
>> On 12/11/2018 18:58, Joe Perches wrote:
>>>>> +#define pr_fmt(fmt) "sas: " fmt
>>>>>
>>>>> Some other subsystem may try to include this header, and gets its
>>>>> message prefix overwritten. Just a consequence for doing something bad,
>>>>> right?
>>> Right.
>>>
>>> And as this file is internal to drivers/scsi/libsas
>>> that seems very unlikely to occur.
>>>
>>> It also might useful to use the common debugging
>>> mechanisms and convert SAS_DPRINTK to pr_debug
>>> which would use the same #define pr_fmt.
>>>
>>

We have almost 100 references to SAS_DPRINTK. So when we replace with 
pr_debug, we will frequently have to realign the indentation. I'm 
beginning to think it's not worth the churn to remove SAS_DPRINTK.

However, with regards to using pr_debug(), there are loops to jump 
through to ensure any output at all:
- ensure DEBUG is defined or DYNAMIC DEBUG enabled
- ensure current loglevel is high enough

Having said that, there are actually lots of logs in libsas where debug 
level is too low (at pr_debug), and these could be upgraded.

So I think I will just go through the code and revise these levels.

>> OK, I will try to put this all together as a marginally wider scope tidy-up.
>
> Thanks.
>
> Another thing that could be done is to change
> the #define pr_fmt(fmt) to KBUILD_MODNAME as
> that would prefix "libsas" instead of just "sas".
>

I think "sas" makes more sense, as this is the technology, as opposed to 
"libsas", which is just the software framework name.

> I think that would be better but I didn't do that
> as it should be in a separate patch.
>

Cheers,
John



