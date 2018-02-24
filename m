Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeBXHyi (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 02:54:38 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:37002 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751399AbeBXHyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 02:54:36 -0500
X-Google-Smtp-Source: AH8x226/xia+Hij1BUZP09wJ6Pv3oviWZj2ToK9vtF4NywUgMnsvHuS33EzZEgq1AjLCIEs53fqNXg==
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH BUGFIX V3] block, bfq: add requeue-request hook
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20180223161751.GA17466@ming.t460p>
Date: Sat, 24 Feb 2018 08:54:31 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "'Paolo Valente' via bfq-iosched"
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Alban Browaeys <alban.browaeys@gmail.com>,
        Ivan Kozik <ivan@ludios.org>,
        SERENA ZIVIANI <169364@studenti.unimore.it>,
        =?utf-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        efault@gmx.de, Serena Ziviani <ziviani.serena@gmail.com>
Message-Id: <A6215E5D-3AA0-4908-8F4F-AEBE5B7D8C85@linaro.org>
References: <20180207211920.6343-1-paolo.valente@linaro.org>
 <20180223150705.GB30079@ming.t460p>
 <8296094C-C3DB-434F-A83D-64CBDE927D09@linaro.org>
 <20180223161751.GA17466@ming.t460p>
To: Ming Lei <ming.lei@redhat.com>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1O7siRb020849



> Il giorno 23 feb 2018, alle ore 17:17, Ming Lei <ming.lei@redhat.com> ha scritto:
> 
> Hi Paolo,
> 
> On Fri, Feb 23, 2018 at 04:41:36PM +0100, Paolo Valente wrote:
>> 
>> 
>>> Il giorno 23 feb 2018, alle ore 16:07, Ming Lei <ming.lei@redhat.com> ha scritto:
>>> 
>>> Hi Paolo,
>>> 
>>> On Wed, Feb 07, 2018 at 10:19:20PM +0100, Paolo Valente wrote:
>>>> Commit 'a6a252e64914 ("blk-mq-sched: decide how to handle flush rq via
>>>> RQF_FLUSH_SEQ")' makes all non-flush re-prepared requests for a device
>>>> be re-inserted into the active I/O scheduler for that device. As a
>>> 
>>> No, this behaviour isn't related with commit a6a252e64914, and
>>> it has been there since blk_mq_requeue_request() is introduced.
>>> 
>> 
>> Hi Ming,
>> actually, we wrote the above statement after simply following the call
>> chain that led to the failure.  In this respect, the change in commit
>> a6a252e64914:
>> 
>> static bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx,
>> +                                      bool has_sched,
>>                                       struct request *rq)
>> {
>> -       if (rq->tag == -1) {
>> +       /* dispatch flush rq directly */
>> +       if (rq->rq_flags & RQF_FLUSH_SEQ) {
>> +               spin_lock(&hctx->lock);
>> +               list_add(&rq->queuelist, &hctx->dispatch);
>> +               spin_unlock(&hctx->lock);
>> +               return true;
>> +       }
>> +
>> +       if (has_sched) {
>>                rq->rq_flags |= RQF_SORTED;
>> -               return false;
>> +               WARN_ON(rq->tag != -1);
>>        }
>> 
>> -       /*
>> -        * If we already have a real request tag, send directly to
>> -        * the dispatch list.
>> -        */
>> -       spin_lock(&hctx->lock);
>> -       list_add(&rq->queuelist, &hctx->dispatch);
>> -       spin_unlock(&hctx->lock);
>> -       return true;
>> +       return false;
>> }
>> 
>> makes blk_mq_sched_bypass_insert return false for all non-flush
>> requests.  From that, the anomaly described in our commit follows, for
>> bfq any stateful scheduler that waits for the completion of requests
>> that passed through it.  I'm elaborating again a little bit on this in
>> my replies to your next points below.
> 
> Before a6a252e64914, follows blk_mq_sched_bypass_insert()
> 
>       if (rq->tag == -1) {
>               rq->rq_flags |= RQF_SORTED;
>               return false;
> 	   }
> 
>       /*
>        * If we already have a real request tag, send directly to
>        * the dispatch list.
>        */
>       spin_lock(&hctx->lock);
>       list_add(&rq->queuelist, &hctx->dispatch);
>       spin_unlock(&hctx->lock);
>       return true;
> 
> This function still returns false for all non-flush request, so nothing
> changes wrt. this kind of handling.
> 

Yep Ming.  I don't have the expertise to tell you why, but the failure
in the USB case was caused by an rq that is not flush, but for which
rq->tag != -1.  So, the previous version of blk_mq_sched_bypass_insert
returned true, and there was not failure, while after commit
a6a252e64914 the function returns true and the failure occurs if bfq
does not exploit the requeue hook.

You have actually shown it yourself, several months ago, through the
simple code instrumentation you made and used to show that bfq was
stuck.  And I guess it can still be reproduced very easily, unless
something else has changed in blk-mq.

BTW, if you can shed a light on this fact, that would be a great
occasion to learn for me.

>> 
>> I don't mean that this change is an error, it simply sends a stateful
>> scheduler in an inconsistent state, unless the scheduler properly
>> handles the requeue that precedes the re-insertion into the
>> scheduler.
>> 
>> If this clarifies the situation, but there is still some misleading
>> statement in the commit, just let me better understand, and I'll be
>> glad to rectify it, if possible somehow.
>> 
>> 
>>> And you can see blk_mq_requeue_request() is called by lots of drivers,
>>> especially it is often used in error handler, see SCSI's example.
>>> 
>>>> consequence, I/O schedulers may get the same request inserted again,
>>>> even several times, without a finish_request invoked on that request
>>>> before each re-insertion.
>>>> 
>> 
>> ...
>> 
>>>> @@ -5426,7 +5482,8 @@ static struct elevator_type iosched_bfq_mq = {
>>>> 	.ops.mq = {
>>>> 		.limit_depth		= bfq_limit_depth,
>>>> 		.prepare_request	= bfq_prepare_request,
>>>> -		.finish_request		= bfq_finish_request,
>>>> +		.requeue_request        = bfq_finish_requeue_request,
>>>> +		.finish_request		= bfq_finish_requeue_request,
>>>> 		.exit_icq		= bfq_exit_icq,
>>>> 		.insert_requests	= bfq_insert_requests,
>>>> 		.dispatch_request	= bfq_dispatch_request,
>>> 
>>> This way may not be correct since blk_mq_sched_requeue_request() can be
>>> called for one request which won't enter io scheduler.
>>> 
>> 
>> Exactly, there are two cases: requeues that lead to subsequent
>> re-insertions, and requeues that don't.  The function
>> bfq_finish_requeue_request handles both, and both need to be handled,
>> to inform bfq that it has not to wait for the completion of rq any
>> longer.
>> 
>> One special case is when bfq_finish_requeue_request gets invoked even
>> if rq has nothing to do with any scheduler.  In that case,
>> bfq_finish_requeue_request exists immediately.
>> 
>> 
>>> __blk_mq_requeue_request() is called for two cases:
>>> 
>>> 	- one is that the requeued request is added to hctx->dispatch, such
>>> 	as blk_mq_dispatch_rq_list()
>> 
>> yes
>> 
>>> 	- another case is that the request is requeued to io scheduler, such as
>>> 	blk_mq_requeue_request().
>>> 
>> 
>> yes
>> 
>>> For the 1st case, blk_mq_sched_requeue_request() shouldn't be called
>>> since it is nothing to do with scheduler,
>> 
>> No, if that rq has been inserted and then extracted from the scheduler
>> through a dispatch_request, then it has.  The scheduler is stateful,
>> and keeps state for rq, because it must do so, until a completion or a
>> requeue arrive.  In particular, bfq may decide that no other
> 
> This 'requeue' to hctx->dispatch is invisible to io scheduler, and from
> io scheduler view, seems no difference between STS_OK and STS_RESOURCE,
> since this request will be submitted to lld automatically by blk-mq
> core.
> 
> Also in legacy path, no such notification to io scheduler too.

ok, still, for reasons that at this point I don't know, in the last
9-10 years it has never been reported a failure caused by a request
that has been first dispatched by bfq and then re-inserted into bfq
without being completed.  This new event is the problem.


>> bfq_queues must be served before rq has been completed, because this
>> is necessary to preserve its target service guarantees.  If bfq is not
>> informed, either through its completion or its requeue hook, then it
>> will wait forever.
> 
> The .finish_request will be called after this request is completed for this
> case, either after this io is completed by device, or timeout.
> 
> Or .requeue_request will be called if the driver need to requeue it to
> io scheduler via blk_mq_requeue_request() explicitly.
> 
> So io scheduler will be made sure to get notified.
> 

So, you mean that the scheduler will get notified in a way or the
other, if it has a requeue hook defined, right?  Or, simply, the
request will be eventually completed, thus unblocking the scheduler?


>> 
>>> seems we only need to do that
>>> for 2nd case.
>>> 
>> 
>>> So looks we need the following patch:
>>> 
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 23de7fd8099a..a216f3c3c3ce 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -712,7 +714,6 @@ static void __blk_mq_requeue_request(struct request *rq)
>>> 
>>> 	trace_block_rq_requeue(q, rq);
>>> 	wbt_requeue(q->rq_wb, &rq->issue_stat);
>>> -	blk_mq_sched_requeue_request(rq);
>>> 
>> 
>> By doing so, if rq has 'passed' through bfq, then you block again bfq
>> forever.
> 
> Could you explain it a bit why bfq is blocked by this way?

It's a theoretical problem (unfortunately not just a contingency you
can work around).  If you want to guarantee that a process doing sync
I/O, and with a higher weight than other processes, gets a share of
the total throughput proportional to its weight, then you have to idle
the device during the service slot of that process.  Otherwise, the
pending requests of the other processes will simply slip through
*every time* the high-weight process has no pending request because it
is blocked by one of its sync request.  The final result will be loss
of control on the percentage of requests of the high-weight process
that get dispatched w.r.t. to the total number of requests
dispatched.  So, failure to provide the process with its due share of
the throughput.

I'm working on solutions to compensate for this nasty service
constraint, and its effects on throughput, but this is another story.

> 
>> 
>> Of course, I may be wrong, as I don't have a complete mental model of
>> all what blk-mq does around bfq.  But I thin that you can quickly
>> check whether a hang occurs again if you add this change.  In
>> particular, it should happen in the USB former failure case.
> 
> USB/BFQ runs well on my parted test with this change, and this test can
> trigger the IO hang issue easily on kyber or without your patch of 'block,
> bfq: add requeue-request hook'.
> 

Great!  According to the facts I reported at the beginning of
this email, I guess your patch works because it avoids the
nasty case for bfq, i.e., a request re-inserted into bfq without being
completed first, right?  And then, about the requeues without
re-insertions, everything works because the latter type of requests
eventually get a completion.  Is it correct?

Sorry for being pedantic, but because of our lack of expertise on
these requeueing mechanism, we worked really a lot on this commit, and
it would be frustrating if we bumped again into troubles, after
removing it.  Apart from that, if this commit is useless, it is
perfectly fine for me that it is reverted and replaced by a better
solution.  In the end, less code in bfq means less room for bugs ;)

Thanks,
Paolo

> Thanks,
> Ming
