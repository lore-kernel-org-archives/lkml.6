Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57E6C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9E1208B6
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9E1208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeH0Aq1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 20:46:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726793AbeH0Aq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 20:46:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB8C440216ED;
        Sun, 26 Aug 2018 21:02:44 +0000 (UTC)
Received: from llong.remote.csb (ovpn-121-41.rdu2.redhat.com [10.10.121.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 54B0C63F59;
        Sun, 26 Aug 2018 21:02:44 +0000 (UTC)
Subject: Re: [PATCH 2/2] xfs: Use wake_q for waking up log space waiters
From:   Waiman Long <longman@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>
References: <1535041570-24102-1-git-send-email-longman@redhat.com>
 <1535041570-24102-3-git-send-email-longman@redhat.com>
 <20180824003017.GZ2234@dastard>
 <bbdaf330-ce6b-bc53-eb97-93b34359bd3d@redhat.com>
Organization: Red Hat
Message-ID: <36d1f3f5-9a4a-2511-4dce-c3ae30022d4a@redhat.com>
Date:   Sun, 26 Aug 2018 17:02:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <bbdaf330-ce6b-bc53-eb97-93b34359bd3d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Sun, 26 Aug 2018 21:02:44 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Sun, 26 Aug 2018 21:02:44 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/24/2018 05:54 PM, Waiman Long wrote:
> On 08/23/2018 08:30 PM, Dave Chinner wrote:
>>
>> That's racy. You can't drop the spin lock between
>> xlog_grant_head_wake() and xlog_grant_head_wait(), because
>> free_bytes is only valid while while the spinlock is held.  Same for
>> the "wake_all" variable you added. i..e. while waking up the
>> waiters, we could have run out of space again and had more tasks
>> queued, or had the AIL tail move and now have space available.
>> Either way, we can do the wrong thing because we dropped the lock
>> and free_bytes and wake_all are now stale and potentially incorrect.
>>
>>> @@ -1068,6 +1088,7 @@
>>>  {
>>>  	struct xlog		*log = mp->m_log;
>>>  	int			free_bytes;
>>> +	DEFINE_WAKE_Q(wakeq);
>>>  
>>>  	if (XLOG_FORCED_SHUTDOWN(log))
>>>  		return;
>>> @@ -1077,8 +1098,11 @@
>>>  
>>>  		spin_lock(&log->l_write_head.lock);
>>>  		free_bytes = xlog_space_left(log, &log->l_write_head.grant);
>>> -		xlog_grant_head_wake(log, &log->l_write_head, &free_bytes);
>>> +		xlog_grant_head_wake(log, &log->l_write_head, &free_bytes,
>>> +				     &wakeq);
>>>  		spin_unlock(&log->l_write_head.lock);
>>> +		wake_up_q(&wakeq);
>>> +		wake_q_init(&wakeq);
>> That's another landmine. Just define the wakeq in the context where
>> it is used rather than use a function wide variable that requires
>> reinitialisation.
>>
>>>  	}
>>>  
>>>  	if (!list_empty_careful(&log->l_reserve_head.waiters)) {
>>> @@ -1086,8 +1110,10 @@
>>>  
>>>  		spin_lock(&log->l_reserve_head.lock);
>>>  		free_bytes = xlog_space_left(log, &log->l_reserve_head.grant);
>>> -		xlog_grant_head_wake(log, &log->l_reserve_head, &free_bytes);
>>> +		xlog_grant_head_wake(log, &log->l_reserve_head, &free_bytes,
>>> +				     &wakeq);
>>>  		spin_unlock(&log->l_reserve_head.lock);
>>> +		wake_up_q(&wakeq);
>>>  	}
>>>  }
>> Ok, what about xlog_grant_head_wake_all()? You didn't convert that
>> to use wake queues, and so that won't remove tickets for the grant
>> head waiter list, and so those tasks will never get out of the new
>> inner loop you added to xlog_grant_head_wait(). That means
>> filesystem shutdowns will just hang the filesystem and leave it
>> unmountable. Did you run this through fstests?
>>
>> Cheers,
>>
>> Dave
> OK, I need more time to think about some of the questions that you
> raise.  Thanks for reviewing the patch.
>
> Cheers,
> Longman

Thanks for your detailed review of the patch. I now have a better
understanding of what should and shouldn't be done. I have sent out a
more conservative v2 patchset which, hopefully, can address the concerns
that you raised.

Cheers,
Longman

