Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E366C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194A12086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194A12086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbeKHCMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:12:03 -0500
Received: from relay.sw.ru ([185.231.240.75]:36008 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727312AbeKHCMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:12:03 -0500
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gKQsu-0003W5-6r; Wed, 07 Nov 2018 19:40:52 +0300
Subject: Re: [PATCH 6/6] fuse: Verify userspace asks to requeue interrupt that
 we really sent
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <154149586524.17764.5252013294539109287.stgit@localhost.localdomain>
 <154149666097.17764.12092615786683141764.stgit@localhost.localdomain>
 <CAJfpeguDTsG7vEAhH=CHp43vJak70VzR8YH8K6=vZAUXCZZeEQ@mail.gmail.com>
 <6f27b5a5-0092-b23f-b28e-341ae093a241@virtuozzo.com>
 <CAJfpegtbwfioa0gv4j1SoRu3X8vX3kZUQC=QJo=dcfOD2OjKzw@mail.gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <e255327f-f6da-4075-f7ce-0956e1a4cc91@virtuozzo.com>
Date:   Wed, 7 Nov 2018 19:40:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegtbwfioa0gv4j1SoRu3X8vX3kZUQC=QJo=dcfOD2OjKzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.11.2018 17:45, Miklos Szeredi wrote:
> On Wed, Nov 7, 2018 at 3:25 PM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>> On 07.11.2018 16:55, Miklos Szeredi wrote:
>>> On Tue, Nov 6, 2018 at 10:31 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>>> When queue_interrupt() is called from fuse_dev_do_write(),
>>>> it came from userspace directly. Userspace may pass any
>>>> request id, even the request's we have not interrupted
>>>> (or even background's request). This patch adds sanity
>>>> check to make kernel safe against that.
>>>
>>> Okay, I understand this far.
>>>
>>>> The problem is real interrupt may be queued and requeued
>>>> by two tasks on two cpus. This case, the requeuer has not
>>>> guarantees it sees FR_INTERRUPTED bit on its cpu (since
>>>> we know nothing about the way userspace manages requests
>>>> between its threads and whether it uses smp barriers).
>>>
>>> This sounds like BS. There's an explicit  smp_mb__after_atomic()
>>> after the set_bit(FR_INTERRUPTED,...).  Which means FR_INTERRUPTED is
>>> going to be visible on all CPU's after this, no need to fool around
>>> with setting FR_INTERRUPTED again, etc...
>>
>> Hm, but how does it make the bit visible on all CPUS?
>>
>> The problem is that smp_mb_xxx() barrier on a cpu has a sense
>> only in pair with the appropriate barrier on the second cpu.
>> There is no guarantee for visibility, if second cpu does not
>> have a barrier:
>>
>>   CPU 1                  CPU2                        CPU3                       CPU4                        CPU5
>>
>>   set FR_INTERRUPTED     set FR_SENT
>>   <smp mb>               <smp mb>
>>   test FR_SENT (== 0)    test FR_INTERRUPTED (==1)
>>                          list_add[&req->intr_entry]  read[req by intr_entry]
>>                                                      <place to insert a barrier>
>>                                                      goto userspace
>>                                                      write in userspace buffer
>>                                                                                 read from userspace buffer
>>                                                                                 write to userspace buffer
>>                                                                                                              read from userspace buffer
>>                                                                                                              enter kernel
>>                                                                                                              <place to insert a barrier>
>>                                                                                                              test FR_INTERRUPTED <- Not visible
>>
>> The sequence:
>>
>> set_bit(FR_INTERRUPTED, ...)
>> smp_mb__after_atomic();
>> test_bit(FR_SENT, &req->flags)
>>
>> just guarantees the expected order on CPU2, which uses <smp mb>,
>> but CPU5 does not have any guarantees.
> 
> What you are missing is that there are other things that synchronize
> memory access besides the memory barrier.  In your example the
> ordering will be guaranteed by the fiq->waitq.lock in
> queue_interrupt() on CPU2: the set_bit() cannot move past the one-way
> barrier provided by the spin_unlock().

I thought, RELEASE is related to memory operations, which is made on the same cpu.
Strange thing, but the below memory-model test says, it's not true. Ok, I'll change
the patch, thanks for pointing this.


===== tools/memory-model/litmus-tests/test.litmus =====
C SB+test

{}

P0(atomic_t *flags)
{
	int r0;

	atomic_add(1, flags);
	smp_mb__after_atomic();
	r0 = (atomic_read(flags) & 2);
}

P1(atomic_t *flags, int *linked)
{
	int r0;

	atomic_add(2, flags);
	smp_mb__after_atomic();
	r0 = (atomic_read(flags) & 1);

	if (r0) {
		spin_lock(mylock);
		*linked = 1;
		spin_unlock(mylock);
	}
}

P2(atomic_t *flags, int *linked)
{
	int r0;

	spin_lock(mylock);
	if (*linked) {
		r0 = atomic_read(flags);
	} else
		r0 = 0;
	spin_unlock(mylock);
}

exists (0:r0=0 /\ 1:r0=1 /\ 2:r0=2)

===================================

kirill@pro:~/linux-next/tools/memory-model$ ~/.opam/system/bin/herd7 -conf linux-kernel.cfg litmus-tests/test.litmus 
Test SB+test Allowed
States 5
0:r0=0; 1:r0=1; 2:r0=0;
0:r0=0; 1:r0=1; 2:r0=3;
0:r0=2; 1:r0=0; 2:r0=0;
0:r0=2; 1:r0=1; 2:r0=0;
0:r0=2; 1:r0=1; 2:r0=3;
No
Witnesses
Positive: 0 Negative: 7
Condition exists (0:r0=0 /\ 1:r0=1 /\ 2:r0=2)
Observation SB+test Never 0 7
Time SB+test 0.09
Hash=0213fd54f80c511af2326e1bd120a96b
