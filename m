Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6D4C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAF720C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AAF720C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeIYQEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:04:45 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:61206 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeIYQEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:04:45 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w8P9vwan052357;
        Tue, 25 Sep 2018 18:57:58 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Tue, 25 Sep 2018 18:57:57 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w8P9vvEv052348
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 25 Sep 2018 18:57:57 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v4] block/loop: Serialize ioctl operations.
To:     Jan Kara <jack@suse.cz>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        syzbot 
        <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>,
        syzbot <syzbot+bf89c128e05dd6c62523@syzkaller.appspotmail.com>
References: <1537009136-4839-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1af79300-cb04-36e3-a650-168a5942161f@i-love.sakura.ne.jp>
 <20180923220300.GA12589@ming.t460p>
 <ba535251-c206-6242-3e6d-a4ed825c8114@i-love.sakura.ne.jp>
 <20180924184734.GH28775@quack2.suse.cz>
 <70de0609-c9f5-1747-93dc-fc4d693f1c27@i-love.sakura.ne.jp>
 <20180925080622.GA6567@quack2.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <200e4b00-7182-275b-edb8-3c2948750e3c@i-love.sakura.ne.jp>
Date:   Tue, 25 Sep 2018 18:57:57 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180925080622.GA6567@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Redirecting from "Re: [PATCH v2] block/loop: Use global lock for ioctl() operation."

On 2018/09/25 17:41, Jan Kara wrote:
> On Tue 25-09-18 13:21:01, Tetsuo Handa wrote:
>> syzbot is reporting NULL pointer dereference [1] which is caused by
>> race condition between ioctl(loop_fd, LOOP_CLR_FD, 0) versus
>> ioctl(other_loop_fd, LOOP_SET_FD, loop_fd) due to traversing other
>> loop devices at loop_validate_file() without holding corresponding
>> lo->lo_ctl_mutex locks.
>>
>> Since ioctl() request on loop devices is not frequent operation, we don't
>> need fine grained locking. Let's use global lock in order to allow safe
>> traversal at loop_validate_file().
>>
>> Note that syzbot is also reporting circular locking dependency between
>> bdev->bd_mutex and lo->lo_ctl_mutex [2] which is caused by calling
>> blkdev_reread_part() with lock held. This patch does not address it.
>>
>> [1] https://syzkaller.appspot.com/bug?id=f3cfe26e785d85f9ee259f385515291d21bd80a3
>> [2] https://syzkaller.appspot.com/bug?id=bf154052f0eea4bc7712499e4569505907d15889
>>
>> v2: Don't call mutex_init() upon loop_add() request.
>>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Reported-by: syzbot <syzbot+bf89c128e05dd6c62523@syzkaller.appspotmail.com>
> 
> Yeah, this is really simple! Thank you for the patch. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> As a separate cleanup patch, you could drop loop_index_mutex and use
> loop_ctl_mutex instead as there's now no reason to have two of them. But it
> would not be completely trivial AFAICS.
> 

Yes. I know that and I did that in "[PATCH v4] block/loop: Serialize ioctl operations.".



Redirecting from "[PATCH] block/loop: Don't hold lock while rereading partition."

On 2018/09/25 17:47, Jan Kara wrote:
> On Tue 25-09-18 14:10:03, Tetsuo Handa wrote:
>> syzbot is reporting circular locking dependency between bdev->bd_mutex and
>> lo->lo_ctl_mutex [1] which is caused by calling blkdev_reread_part() with
>> lock held. Don't hold loop_ctl_mutex while calling blkdev_reread_part().
>> Also, bring bdgrab() at loop_set_fd() to before loop_reread_partitions()
>> in case loop_clr_fd() is called while blkdev_reread_part() from
>> loop_set_fd() is in progress.
>>
>> [1] https://syzkaller.appspot.com/bug?id=bf154052f0eea4bc7712499e4569505907d15889
>>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Reported-by: syzbot <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>
> 
> Thank you for splitting out this patch. Some comments below.
> 
>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>> index 920cbb1..877cca8 100644
>> --- a/drivers/block/loop.c
>> +++ b/drivers/block/loop.c
>> @@ -632,7 +632,12 @@ static void loop_reread_partitions(struct loop_device *lo,
>>  				   struct block_device *bdev)
>>  {
>>  	int rc;
>> +	char filename[LO_NAME_SIZE];
>> +	const int num = lo->lo_number;
>> +	const int count = atomic_read(&lo->lo_refcnt);
>>  
>> +	memcpy(filename, lo->lo_file_name, sizeof(filename));
>> +	mutex_unlock(&loop_ctl_mutex);
>>  	/*
>>  	 * bd_mutex has been held already in release path, so don't
>>  	 * acquire it if this function is called in such case.
>> @@ -641,13 +646,14 @@ static void loop_reread_partitions(struct loop_device *lo,
>>  	 * must be at least one and it can only become zero when the
>>  	 * current holder is released.
>>  	 */
>> -	if (!atomic_read(&lo->lo_refcnt))
>> +	if (!count)
>>  		rc = __blkdev_reread_part(bdev);
>>  	else
>>  		rc = blkdev_reread_part(bdev);
>> +	mutex_lock(&loop_ctl_mutex);
>>  	if (rc)
>>  		pr_warn("%s: partition scan of loop%d (%s) failed (rc=%d)\n",
>> -			__func__, lo->lo_number, lo->lo_file_name, rc);
>> +			__func__, num, filename, rc);
>>  }
> 
> I still don't quite like this. It is non-trivial to argue that the
> temporary dropping of loop_ctl_mutex in loop_reread_partitions() is OK for
> all it's callers. I'm really strongly in favor of unlocking the mutex in
> the callers of loop_reread_partitions() and reorganizing the code there so
> that loop_reread_partitions() is called as late as possible so that it is
> clear that dropping the mutex is fine (and usually we don't even have to
> reacquire it). Plus your patch does not seem to take care of the possible
> races of loop_clr_fd() with LOOP_CTL_REMOVE? See my other mail for
> details...

Yes. That's why lock_loop()/unlock_loop() is used. They comobined
loop_index_mutex and loop_ctl_mutex into one loop_mutex. And since
there are paths which may take both locks, holding loop_mutex when
loop_index_mutex or loop_ctl_mutex is taken, and releasing loop_mutex
when loop_index_mutex or loop_ctl_mutex is released. And this implies
that current thread has to call lock_loop() before accessing "struct
loop_device", and current thread must not access "struct loop_device"
after unlock_loop() is called. And lock_loop()/unlock_loop() made your

 "unlocking the mutex in the callers of loop_reread_partitions() and
  reorganizing the code there so that loop_reread_partitions() is called
  as late as possible so that it is clear that dropping the mutex is fine
  (and usually we don't even have to reacquire it)."

possible, with the aid of inverting loop_reread_partitions() and
loop_unprepare_queue() in loop_clr_fd().



On 2018/09/25 17:06, Jan Kara wrote:
> On Tue 25-09-18 06:06:56, Tetsuo Handa wrote:
>> On 2018/09/25 3:47, Jan Kara wrote:
>>>> +/*
>>>> + * unlock_loop - Unlock loop_mutex as needed.
>>>> + *
>>>> + * Explicitly call this function before calling fput() or blkdev_reread_part()
>>>> + * in order to avoid circular lock dependency. After this function is called,
>>>> + * current thread is no longer allowed to access "struct loop_device" memory,
>>>> + * for another thread would access that memory as soon as loop_mutex is held.
>>>> + */
>>>> +static void unlock_loop(void)
>>>> +{
>>>> +	if (loop_mutex_owner == current) {
>>>
>>> Urgh, why this check? Conditional locking / unlocking is evil so it has to
>>> have *very* good reasons and there is not any explanation here. So far I
>>> don't see a reason why this is needed at all.
>>
>> Yeah, this is why Jens hates this patch. But any alternative?
> 
> So can you explain why this conditional locking is really necessary?

I explained above.

> 
>>>> @@ -630,7 +669,12 @@ static void loop_reread_partitions(struct loop_device *lo,
>>>> +	unlock_loop();
>>>
>>> Unlocking in loop_reread_partitions() makes the locking rules ugly. And
>>> unnecessarily AFAICT. Can't we just use lo_refcnt to protect us against
>>> loop_clr_fd() and freeing of 'lo' structure itself?
>>
>> Really? I think that just elevating lo->lo_refcnt will cause another lockdep
>> warning because __blkdev_reread_part() requires bdev->bd_mutex being held.
>> Don't we need to drop the lock in order to solve original lockdep warning at [2] ?
> 
> Yes, you have to drop the lo_ctl_mutex before calling
> loop_reread_partitions().

OK.

>                           But AFAICS all places calling loop_reread_part()
> are called from ioctl where we are sure the device is open and thus
> lo_refcnt is > 0. So in these places calling loop_reread_partitions()
> without lo_ctl_mutex should be fine. The only exception is lo_clr_fd() that
> can get called from __lo_release()

But

>                                    - and I think we can protect that case
> against LOOP_CTL_REMOVE (it cannot really race with anything else) by
> keeping lo_state at Lo_rundown until after loop_reread_partitions() has
> finished.

how can we guarantee that lo_state is kept at Lo_rundown when we release
lo_ctl_lock before calling blkdev_reread_part() ? That's why I used
lock_loop()/unlock_loop() approach.

This patch became convoluted because this patch has to handle your

  "It is non-trivial to argue that the temporary dropping of loop_ctl_mutex
   in loop_reread_partitions() is OK for all it's callers."

concern.

