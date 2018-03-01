Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965293AbeCAARq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 19:17:46 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:43455 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965144AbeCAARp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 19:17:45 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Syh0pSi_1519863454;
Subject: Re: [RFC PATCH 0/4 v2] Define killable version for access_remote_vm()
 and use it in fs/proc
To: David Rientjes <rientjes@google.com>
Cc: akpm@linux-foundation.org, mingo@kernel.org, adobriyan@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1519691151-101999-1-git-send-email-yang.shi@linux.alibaba.com>
 <alpine.DEB.2.20.1802261656490.16999@chino.kir.corp.google.com>
 <4ec32e5b-af63-f412-2213-e52bdbcc9585@linux.alibaba.com>
 <alpine.DEB.2.20.1802261742400.24072@chino.kir.corp.google.com>
From: Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <6ee55dbd-5b06-5ae8-f16d-c58448500df1@linux.alibaba.com>
Date: Wed, 28 Feb 2018 16:17:33 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1802261742400.24072@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/26/18 5:47 PM, David Rientjes wrote:
> On Mon, 26 Feb 2018, Yang Shi wrote:
>
>>> Rather than killable, we have patches that introduce down_read_unfair()
>>> variants for the files you've modified (cmdline and environ) as well as
>>> others (maps, numa_maps, smaps).
>> You mean you have such functionality used by google internally?
>>
> Yup, see https://lwn.net/Articles/387720.
>
>>> When another thread is holding down_read() and there are queued
>>> down_write()'s, down_read_unfair() allows for grabbing the rwsem without
>>> queueing for it.  Additionally, when another thread is holding
>>> down_write(), down_read_unfair() allows for queueing in front of other
>>> threads trying to grab it for write as well.
>> It sounds the __unfair variant make the caller have chance to jump the gun to
>> grab the semaphore before other waiters, right? But when a process holds the
>> semaphore, i.e. mmap_sem, for a long time, it still has to sleep in
>> uninterruptible state, right?
>>
> Right, it's solving two separate things which I think may be able to be
> merged together.  Killable is solving an issue where the rwsem is blocking
> for a long period of time in uninterruptible sleep, and unfair is solving
> an issue where reading the procfs files gets stalled for a long period of
> time.  We haven't run into an issue (yet) where killable would have solved
> it; we just have the unfair variants to grab the rwsem asap and then, if
> killable, gracefully return.
>
>>> Ingo would know more about whether a variant like that in upstream Linux
>>> would be acceptable.
>>>
>>> Would you be interested in unfair variants instead of only addressing
>>> killable?
>> Yes, I'm although it still looks overkilling to me for reading /proc.
>>
> We make certain inferences on the readablility of procfs files for other
> threads to determine how much its mm's mmap_sem is contended.

I see your points here for reading /proc for system monitor. However, 
I'm concerned that the _unfair APIs get the processes which read /proc 
priority elevation (not real priority change, just look like). It might 
be abused by some applications, for example:

A high priority process and a low priority process are waiting for the 
same rwsem, if the low priority process is trying to read /proc 
maliciously on purpose, it can get elevated to grap the rwsem before any 
other processes which are waiting for the same rwsem.

Yang
