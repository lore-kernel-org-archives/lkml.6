Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AAEC46465
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093772085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093772085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbeKGX4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:56:33 -0500
Received: from relay.sw.ru ([185.231.240.75]:59596 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbeKGX4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:56:32 -0500
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gKOmH-0002qM-06; Wed, 07 Nov 2018 17:25:53 +0300
Subject: Re: [PATCH 6/6] fuse: Verify userspace asks to requeue interrupt that
 we really sent
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <154149586524.17764.5252013294539109287.stgit@localhost.localdomain>
 <154149666097.17764.12092615786683141764.stgit@localhost.localdomain>
 <CAJfpeguDTsG7vEAhH=CHp43vJak70VzR8YH8K6=vZAUXCZZeEQ@mail.gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <6f27b5a5-0092-b23f-b28e-341ae093a241@virtuozzo.com>
Date:   Wed, 7 Nov 2018 17:25:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAJfpeguDTsG7vEAhH=CHp43vJak70VzR8YH8K6=vZAUXCZZeEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.11.2018 16:55, Miklos Szeredi wrote:
> On Tue, Nov 6, 2018 at 10:31 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>> When queue_interrupt() is called from fuse_dev_do_write(),
>> it came from userspace directly. Userspace may pass any
>> request id, even the request's we have not interrupted
>> (or even background's request). This patch adds sanity
>> check to make kernel safe against that.
> 
> Okay, I understand this far.
> 
>> The problem is real interrupt may be queued and requeued
>> by two tasks on two cpus. This case, the requeuer has not
>> guarantees it sees FR_INTERRUPTED bit on its cpu (since
>> we know nothing about the way userspace manages requests
>> between its threads and whether it uses smp barriers).
> 
> This sounds like BS. There's an explicit  smp_mb__after_atomic()
> after the set_bit(FR_INTERRUPTED,...).  Which means FR_INTERRUPTED is
> going to be visible on all CPU's after this, no need to fool around
> with setting FR_INTERRUPTED again, etc...

Hm, but how does it make the bit visible on all CPUS?

The problem is that smp_mb_xxx() barrier on a cpu has a sense
only in pair with the appropriate barrier on the second cpu.
There is no guarantee for visibility, if second cpu does not
have a barrier:

  CPU 1                  CPU2                        CPU3                       CPU4                        CPU5

  set FR_INTERRUPTED     set FR_SENT                                            
  <smp mb>               <smp mb>                          
  test FR_SENT (== 0)    test FR_INTERRUPTED (==1)
                         list_add[&req->intr_entry]  read[req by intr_entry]
                                                     <place to insert a barrier>
                                                     goto userspace
                                                     write in userspace buffer
                                                                                read from userspace buffer  
                                                                                write to userspace buffer
                                                                                                             read from userspace buffer
                                                                                                             enter kernel
                                                                                                             <place to insert a barrier>
                                                                                                             test FR_INTERRUPTED <- Not visible

The sequence:

set_bit(FR_INTERRUPTED, ...)
smp_mb__after_atomic();
test_bit(FR_SENT, &req->flags)

just guarantees the expected order on CPU2, which uses <smp mb>,
but CPU5 does not have any guarantees.


This 5 CPUs picture is a scheme, which illustrates the possible way userspace
may manage interrupts. Tags <place to insert a barrier> show places, where
we not have barriers yet, but where we may introduce them. But even in case
of we introduce them, there is no a way, that such the barriers help against CPU4.
So, this is the reason we have to set FR_INTERRUPTED bit again to make it visible
under the spinlock on CPU5.

Thanks,
Kirill

>>
>> To eliminate this problem, queuer writes FR_INTERRUPTED
>> bit again under fiq->waitq.lock, and this guarantees
>> requeuer will see the bit, when checks it.
>>
>> I try to introduce solution, which does not affect on
>> performance, and which does not force to take more
>> locks. This is the reason, the below solution is worse:
>>
>>    request_wait_answer()
>>    {
>>      ...
>>   +  spin_lock(&fiq->waitq.lock);
>>      set_bit(FR_INTERRUPTED, &req->flags);
>>   +  spin_unlock(&fiq->waitq.lock);
>>      ...
>>    }
>>
>> Also, it does not look a better idea to extend fuse_dev_do_read()
>> with the fix, since it's already a big function:
>>
>>    fuse_dev_do_read()
>>    {
>>      ...
>>      if (test_bit(FR_INTERRUPTED, &req->flags)) {
>>   +      /* Comment */
>>   +      barrier();
>>   +      set_bit(FR_INTERRUPTED, &req->flags);
>>          queue_interrupt(fiq, req);
>>      }
>>      ...
>>    }
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  fs/fuse/dev.c |   26 +++++++++++++++++++++-----
>>  1 file changed, 21 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 315d395d5c02..3bfc5ed61c9a 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -475,13 +475,27 @@ static void request_end(struct fuse_conn *fc, struct fuse_req *req)
>>         fuse_put_request(fc, req);
>>  }
>>
>> -static void queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
>> +static int queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
>>  {
>>         bool kill = false;
>>
>>         if (test_bit(FR_FINISHED, &req->flags))
>> -               return;
>> +               return 0;
>>         spin_lock(&fiq->waitq.lock);
>> +       /* Check for we've sent request to interrupt this req */
>> +       if (unlikely(!test_bit(FR_INTERRUPTED, &req->flags))) {
>> +               spin_unlock(&fiq->waitq.lock);
>> +               return -EINVAL;
>> +       }
>> +       /*
>> +        * Interrupt may be queued from fuse_dev_do_read(), and
>> +        * later requeued on other cpu by fuse_dev_do_write().
>> +        * To make FR_INTERRUPTED bit visible for the requeuer
>> +        * (under fiq->waitq.lock) we write it once again.
>> +        */
>> +       barrier();
>> +       __set_bit(FR_INTERRUPTED, &req->flags);
>> +
>>         if (list_empty(&req->intr_entry)) {
>>                 list_add_tail(&req->intr_entry, &fiq->interrupts);
>>                 /*
>> @@ -492,7 +506,7 @@ static void queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
>>                 if (test_bit(FR_FINISHED, &req->flags)) {
>>                         list_del_init(&req->intr_entry);
>>                         spin_unlock(&fiq->waitq.lock);
>> -                       return;
>> +                       return 0;
>>                 }
>>                 wake_up_locked(&fiq->waitq);
>>                 kill = true;
>> @@ -500,6 +514,7 @@ static void queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
>>         spin_unlock(&fiq->waitq.lock);
>>         if (kill)
>>                 kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
>> +       return (int)kill;
>>  }
>>
>>  static void request_wait_answer(struct fuse_conn *fc, struct fuse_req *req)
>> @@ -1959,8 +1974,9 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
>>                         nbytes = -EINVAL;
>>                 else if (oh.error == -ENOSYS)
>>                         fc->no_interrupt = 1;
>> -               else if (oh.error == -EAGAIN)
>> -                       queue_interrupt(&fc->iq, req);
>> +               else if (oh.error == -EAGAIN &&
>> +                        queue_interrupt(&fc->iq, req) < 0)
>> +                       nbytes = -EINVAL;
>>
>>                 fuse_put_request(fc, req);
>>                 fuse_copy_finish(cs);
>>
