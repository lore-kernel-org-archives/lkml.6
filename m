Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53C1C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B75C24FA9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B75C24FA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753091AbeGBSKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:10:42 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:53029 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752150AbeGBSKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:10:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0T3r74G1_1530555025;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T3r74G1_1530555025)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 Jul 2018 02:10:33 +0800
Subject: Re: [RFC v3 PATCH 5/5] x86: check VM_DEAD flag in page fault
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Laurent Dufour <ldufour@linux.vnet.ibm.com>, willy@infradead.org,
        akpm@linux-foundation.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-mm@kvack.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <1530311985-31251-1-git-send-email-yang.shi@linux.alibaba.com>
 <1530311985-31251-6-git-send-email-yang.shi@linux.alibaba.com>
 <84eba553-2e0b-1a90-d543-6b22c1b3c5f8@linux.vnet.ibm.com>
 <20180702121528.GM19043@dhcp22.suse.cz>
 <80406cbd-67f4-ca4c-cd54-aeb305579a72@linux.vnet.ibm.com>
 <20180702124558.GP19043@dhcp22.suse.cz>
 <e6f8d0e2-48c1-f610-c00b-d05d4bd0d9eb@linux.vnet.ibm.com>
 <20180702133733.GU19043@dhcp22.suse.cz>
 <6fd4eb3d-ef66-7a37-4adb-05c22ac51d95@linux.alibaba.com>
 <20180702175749.GG19043@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <a5b4888c-6518-df47-bc0d-d4173984daa9@linux.alibaba.com>
Date:   Mon, 2 Jul 2018 11:10:23 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180702175749.GG19043@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/2/18 10:57 AM, Michal Hocko wrote:
> On Mon 02-07-18 10:24:27, Yang Shi wrote:
>>
>> On 7/2/18 6:37 AM, Michal Hocko wrote:
>>> On Mon 02-07-18 15:33:11, Laurent Dufour wrote:
>>>> On 02/07/2018 14:45, Michal Hocko wrote:
>>>>> On Mon 02-07-18 14:26:09, Laurent Dufour wrote:
>>>>>> On 02/07/2018 14:15, Michal Hocko wrote:
>>> [...]
>>>>>>> We already do have a model for that. Have a look at MMF_UNSTABLE.
>>>>>> MMF_UNSTABLE is a mm's flag, here this is a VMA's flag which is checked.
>>>>> Yeah, and we have the VMA ready for all places where we do check the
>>>>> flag. check_stable_address_space can be made to get vma rather than mm.
>>>> Yeah, this would have been more efficient to check that flag at the beginning
>>>> of the page fault handler rather than the end, but this way it will be easier
>>>> to handle the speculative page fault too ;)
>>> The thing is that it doesn't really need to be called earlier. You are
>>> not risking data corruption on file backed mappings.
>> OK, I just think it could save a few cycles to check the flag earlier.
> This should be an extremely rare case. Just think about it. It should
> only ever happen when an access races with munmap which itself is
> questionable if not an outright bug.
>
>> If nobody think it is necessary, we definitely could re-use
>> check_stable_address_space(),
> If we really need this whole VM_DEAD thing then it should be better
> handled at the same place rather than some ad-hoc places.
>
>> just return VM_FAULT_SIGSEGV for VM_DEAD vma,
>> and check for both shared and non-shared.
> Why would you even care about shared mappings?

Just thought about we are dealing with VM_DEAD, which means the vma will 
be tore down soon regardless it is shared or non-shared.

MMF_UNSTABLE doesn't care about !shared case.


