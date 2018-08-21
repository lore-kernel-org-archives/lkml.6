Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA563C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175AE214D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="iXZT+KBP";
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="iXZT+KBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175AE214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeHURCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:02:43 -0400
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:36863 "EHLO
        forwardcorp1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726743AbeHURCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:02:42 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1o.cmail.yandex.net (Yandex) with ESMTP id C2A7720F1D;
        Tue, 21 Aug 2018 16:42:26 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id xO21xPTbTm-gQVO1cD1;
        Tue, 21 Aug 2018 16:42:26 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1534858946; bh=z9u6Z2yV8UqFQVMaogII26S+GJ3yIHMYurOJTXiGg6Y=;
        h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To;
        b=iXZT+KBPU1IisImEIX+2qTtGwWZtUflI1XHUdbAwGAdsYTIno2iwIsrL5pArA4Dg9
         Vc6bkVej0Rf7wpg5VNnIoKN21TuSxXGowr8KWlU3FLHFjoNR97Ljfy0jb6DhidpoH0
         xGrX8eV29cRvWy6CgHhOnhfiUQ6KXG0o7060hdXc=
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:ac1b:4357:f84c:a04a])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id yTzHtEPQUm-gQXSlmjr;
        Tue, 21 Aug 2018 16:42:26 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1534858946; bh=z9u6Z2yV8UqFQVMaogII26S+GJ3yIHMYurOJTXiGg6Y=;
        h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To;
        b=iXZT+KBPU1IisImEIX+2qTtGwWZtUflI1XHUdbAwGAdsYTIno2iwIsrL5pArA4Dg9
         Vc6bkVej0Rf7wpg5VNnIoKN21TuSxXGowr8KWlU3FLHFjoNR97Ljfy0jb6DhidpoH0
         xGrX8eV29cRvWy6CgHhOnhfiUQ6KXG0o7060hdXc=
Authentication-Results: smtpcorp1p.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: Re: [PATCH] fanotify: use killable wait for waiting response for
 permission events
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        linux-kernel@vger.kernel.org
References: <153474898224.6806.12518115530793064797.stgit@buzz>
 <20180820105327.GC13830@quack2.suse.cz>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <a7b4501c-ce1d-6590-3a48-a951740cf681@yandex-team.ru>
Date:   Tue, 21 Aug 2018 16:42:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180820105327.GC13830@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.08.2018 13:53, Jan Kara wrote:
> Hi!
> 
> On Mon 20-08-18 10:09:42, Konstantin Khlebnikov wrote:
>> Waiting in uninterruptible state for response from userspace
>> easily produces deadlocks and hordes of unkillable tasks.
>>
>> This patch makes this wait killable.
>>
>> At receiving fatal signal task will remove queued event and die.
>> If event is already handled then response will be received as usual.
>>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> 
> Thanks for the patch. I like the idea. Some comments inline.
> 
>> ---
>>   fs/notify/fanotify/fanotify.c |   22 +++++++++++++++++++++-
>>   1 file changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
>> index eb4e75175cfb..7a0c37790c89 100644
>> --- a/fs/notify/fanotify/fanotify.c
>> +++ b/fs/notify/fanotify/fanotify.c
>> @@ -64,7 +64,27 @@ static int fanotify_get_response(struct fsnotify_group *group,
>>   
>>   	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
>>   
>> -	wait_event(group->fanotify_data.access_waitq, event->response);
>> +	ret = wait_event_killable(group->fanotify_data.access_waitq,
>> +				  event->response);
>> +	if (ret) {
>> +		/* Try to remove pending event from the queue */
>> +		spin_lock(&group->notification_lock);
>> +		if (!list_empty(&event->fae.fse.list))
>> +			list_del_init(&event->fae.fse.list);
> 
> Here you forget to decrement group->q_len like
> fsnotify_remove_first_event() does.
> 

Yep

>> +		else
>> +			ret = 0;
>> +		spin_unlock(&group->notification_lock);
> 
> So the above check for list_empty can hit either when response is just
> being processed (and then we'll be woken up very soon) or when the event is
> just in the process of being copied from event queue to userspace (in which
> case we are in the same situation as in the old code). So it would be
> weird that in rare cases wait would not be really killable. I think we
> could detect this situation in fanotify_read() before adding event to
> access_list and just wakeup waiter in fanotify_get_response() again and
> avoid reporting the event to userspace. Hmm?

I've missed that move from list to list in fanotify_read().

So, fanotify_read needs event alive for a long time - copy_to_user might block forever.

We have to transfer ownership and destroy event in fanotify_read.
I'll try this approach.

> 
> 								Honza
> 
>> +
>> +		if (ret)
>> +			return ret;
>> +
>> +		/*
>> +		 * We cannot return, this will destroy event while
>> +		 * process_access_response() fills response.
>> +		 * Just wait for wakeup and continue normal flow.
>> +		 */
>> +		wait_event(group->fanotify_data.access_waitq, event->response);
>> +	}
>>   
>>   	/* userspace responded, convert to something usable */
>>   	switch (event->response & ~FAN_AUDIT) {
>>
