Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE12CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526A82098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qWrAVZc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526A82098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbeHWT7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 15:59:36 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:34641 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbeHWT7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 15:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1535041747; x=1566577747;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=4wA+Y7jP2pMXJ7EpVVo7g6nhybbohD33sk/lau+D/ok=;
  b=qWrAVZc2TAg9gHvVvUTjn3vFNGipX1VzEjqRvP2TcatGwDz1kcxOebDD
   49zyUIPJQknv+35n4KtdIZ0z2HW8aju8m/yoxDIE7RN7T3vVLBBB0X0Fv
   ASiYycsBRtS/oDgt0zNk6Fk2zSomwgK58iTAHmUtXKZTObcgVkmlENcnM
   A=;
X-IronPort-AV: E=Sophos;i="5.53,278,1531785600"; 
   d="scan'208";a="627902175"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 23 Aug 2018 16:26:07 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w7NGO3vZ085497
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 23 Aug 2018 16:24:03 GMT
Received: from EX13D07UWB004.ant.amazon.com (10.43.161.196) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 23 Aug 2018 16:24:01 +0000
Received: from EX13D13UWB002.ant.amazon.com (10.43.161.21) by
 EX13D07UWB004.ant.amazon.com (10.43.161.196) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 23 Aug 2018 16:24:01 +0000
Received: from EX13D13UWB002.ant.amazon.com ([10.43.161.21]) by
 EX13D13UWB002.ant.amazon.com ([10.43.161.21]) with mapi id 15.00.1367.000;
 Thu, 23 Aug 2018 16:24:01 +0000
From:   "van der Linden, Frank" <fllinden@amazon.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Agarwal, Anchal" <anchalag@amazon.com>
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
Thread-Topic: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
Thread-Index: AQHUOvcv6Trip5kavUmHReG3ezAEAw==
Date:   Thu, 23 Aug 2018 16:24:00 +0000
Message-ID: <da9458c632cb4c4695660664bf7c3fb3@EX13D13UWB002.ant.amazon.com>
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <bd84ff08-b75a-0a2f-6b37-07a104452bff@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.19]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/18 8:37 AM, Jens Axboe wrote:=0A=
> On 8/23/18 7:08 AM, Jianchao Wang wrote:=0A=
>> 2887e41 (blk-wbt: Avoid lock contention and thundering herd=0A=
>> issue in wbt_wait) introduces two cases that could miss wakeup:=0A=
>>  - __wbt_done only wakes up one waiter one time. There could be=0A=
>>    multiple waiters and (limit - inflight) > 1 at the moment.=0A=
>>=0A=
>>  - When the waiter is waked up, it is still on wait queue and set=0A=
>>    to TASK_UNINTERRUPTIBLE immediately, so this waiter could be=0A=
>>    waked up one more time. If a __wbt_done comes and wakes up=0A=
>>    again, the prevous waiter may waste a wakeup.=0A=
>>=0A=
>> To fix them and avoid to introduce too much lock contention, we=0A=
>> introduce our own wake up func wbt_wake_function in __wbt_wait and=0A=
>> use wake_up_all in __wbt_done. wbt_wake_function will try to get=0A=
>> wbt budget firstly, if sucesses, wake up the process, otherwise,=0A=
>> return -1 to interrupt the wake up loop.=0A=
> I really like this approach, since it'll naturally wake up as many=0A=
> as we can instead of either being single wakeups, or wake all.=0A=
>=0A=
> BTW, you added Anchal and Frank to the CC in the patch, but they =0A=
> are not actually CC'ed. Doing that now - can you guys give this=0A=
> a whirl? Should still solve the thundering herd issue, but be=0A=
> closer to the original logic in terms of wakeup. Actually better,=0A=
> since we remain on list and remain ordered.=0A=
>=0A=
> Leaving the patch below for you guys.=0A=
>=0A=
>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>=0A=
>> Fixes: 2887e41 (blk-wbt: Avoid lock contention and thundering herd issue=
 in wbt_wait)=0A=
>> Cc: Anchal Agarwal <anchalag@amazon.com>=0A=
>> Cc: Frank van der Linden <fllinden@amazon.com>=0A=
>> ---=0A=
>>  block/blk-wbt.c | 78 +++++++++++++++++++++++++++++++++++++++-----------=
-------=0A=
>>  1 file changed, 54 insertions(+), 24 deletions(-)=0A=
>>=0A=
>> diff --git a/block/blk-wbt.c b/block/blk-wbt.c=0A=
>> index c9358f1..2667590 100644=0A=
>> --- a/block/blk-wbt.c=0A=
>> +++ b/block/blk-wbt.c=0A=
>> @@ -166,7 +166,7 @@ static void __wbt_done(struct rq_qos *rqos, enum wbt=
_flags wb_acct)=0A=
>>  		int diff =3D limit - inflight;=0A=
>>  =0A=
>>  		if (!inflight || diff >=3D rwb->wb_background / 2)=0A=
>> -			wake_up(&rqw->wait);=0A=
>> +			wake_up_all(&rqw->wait);=0A=
>>  	}=0A=
>>  }=0A=
>>  =0A=
>> @@ -481,6 +481,40 @@ static inline unsigned int get_limit(struct rq_wb *=
rwb, unsigned long rw)=0A=
>>  	return limit;=0A=
>>  }=0A=
>>  =0A=
>> +struct wbt_wait_data {=0A=
>> +	struct task_struct *curr;=0A=
>> +	struct rq_wb *rwb;=0A=
>> +	struct rq_wait *rqw;=0A=
>> +	unsigned long rw;=0A=
>> +};=0A=
>> +=0A=
>> +static int wbt_wake_function(wait_queue_entry_t *curr, unsigned int mod=
e,=0A=
>> +		int wake_flags, void *key)=0A=
>> +{=0A=
>> +	struct wbt_wait_data *data =3D curr->private;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * If fail to get budget, return -1 to interrupt the wake up=0A=
>> +	 * loop in __wake_up_common.=0A=
>> +	 */=0A=
>> +	if (!rq_wait_inc_below(data->rqw, get_limit(data->rwb, data->rw)))=0A=
>> +		return -1;=0A=
>> +=0A=
>> +	wake_up_process(data->curr);=0A=
>> +=0A=
>> +	list_del_init(&curr->entry);=0A=
>> +	return 1;=0A=
>> +}=0A=
>> +=0A=
>> +static inline void wbt_init_wait(struct wait_queue_entry *wait,=0A=
>> +		struct wbt_wait_data *data)=0A=
>> +{=0A=
>> +	INIT_LIST_HEAD(&wait->entry);=0A=
>> +	wait->flags =3D 0;=0A=
>> +	wait->func =3D wbt_wake_function;=0A=
>> +	wait->private =3D data;=0A=
>> +}=0A=
>> +=0A=
>>  /*=0A=
>>   * Block if we will exceed our limit, or if we are currently waiting fo=
r=0A=
>>   * the timer to kick off queuing again.=0A=
>> @@ -491,31 +525,27 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt=
_flags wb_acct,=0A=
>>  	__acquires(lock)=0A=
>>  {=0A=
>>  	struct rq_wait *rqw =3D get_rq_wait(rwb, wb_acct);=0A=
>> -	DECLARE_WAITQUEUE(wait, current);=0A=
>> -	bool has_sleeper;=0A=
>> -=0A=
>> -	has_sleeper =3D wq_has_sleeper(&rqw->wait);=0A=
>> -	if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))=0A=
>> +	struct wait_queue_entry wait;=0A=
>> +	struct wbt_wait_data data =3D {=0A=
>> +		.curr =3D current,=0A=
>> +		.rwb =3D rwb,=0A=
>> +		.rqw =3D rqw,=0A=
>> +		.rw =3D rw,=0A=
>> +	};=0A=
>> +=0A=
>> +	if (!wq_has_sleeper(&rqw->wait) &&=0A=
>> +			rq_wait_inc_below(rqw, get_limit(rwb, rw)))=0A=
>>  		return;=0A=
>>  =0A=
>> -	add_wait_queue_exclusive(&rqw->wait, &wait);=0A=
>> -	do {=0A=
>> -		set_current_state(TASK_UNINTERRUPTIBLE);=0A=
>> -=0A=
>> -		if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))=0A=
>> -			break;=0A=
>> -=0A=
>> -		if (lock) {=0A=
>> -			spin_unlock_irq(lock);=0A=
>> -			io_schedule();=0A=
>> -			spin_lock_irq(lock);=0A=
>> -		} else=0A=
>> -			io_schedule();=0A=
>> -		has_sleeper =3D false;=0A=
>> -	} while (1);=0A=
>> -=0A=
>> -	__set_current_state(TASK_RUNNING);=0A=
>> -	remove_wait_queue(&rqw->wait, &wait);=0A=
>> +	wbt_init_wait(&wait, &data);=0A=
>> +	prepare_to_wait_exclusive(&rqw->wait, &wait,=0A=
>> +			TASK_UNINTERRUPTIBLE);=0A=
>> +	if (lock) {=0A=
>> +		spin_unlock_irq(lock);=0A=
>> +		io_schedule();=0A=
>> +		spin_lock_irq(lock);=0A=
>> +	} else=0A=
>> +		io_schedule();=0A=
>>  }=0A=
>>  =0A=
>>  static inline bool wbt_should_throttle(struct rq_wb *rwb, struct bio *b=
io)=0A=
>>=0A=
>=0A=
I like it, this combines some of the ideas outlined in our previous=0A=
thread in to a good solution.=0A=
=0A=
One comment, though: I think we need to set the task state back to=0A=
TASK_RUNNING after being woken up, right?=0A=
=0A=
Frank=0A=
=0A=
