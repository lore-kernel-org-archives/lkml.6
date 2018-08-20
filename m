Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D792C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4D521534
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4D521534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeHTOIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 10:08:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:38474 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbeHTOIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 10:08:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 61BF1ADE7;
        Mon, 20 Aug 2018 10:53:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E3A481E3D70; Mon, 20 Aug 2018 12:53:27 +0200 (CEST)
Date:   Mon, 20 Aug 2018 12:53:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fanotify: use killable wait for waiting response for
 permission events
Message-ID: <20180820105327.GC13830@quack2.suse.cz>
References: <153474898224.6806.12518115530793064797.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153474898224.6806.12518115530793064797.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Mon 20-08-18 10:09:42, Konstantin Khlebnikov wrote:
> Waiting in uninterruptible state for response from userspace
> easily produces deadlocks and hordes of unkillable tasks.
> 
> This patch makes this wait killable.
> 
> At receiving fatal signal task will remove queued event and die.
> If event is already handled then response will be received as usual.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Thanks for the patch. I like the idea. Some comments inline.

> ---
>  fs/notify/fanotify/fanotify.c |   22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index eb4e75175cfb..7a0c37790c89 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -64,7 +64,27 @@ static int fanotify_get_response(struct fsnotify_group *group,
>  
>  	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
>  
> -	wait_event(group->fanotify_data.access_waitq, event->response);
> +	ret = wait_event_killable(group->fanotify_data.access_waitq,
> +				  event->response);
> +	if (ret) {
> +		/* Try to remove pending event from the queue */
> +		spin_lock(&group->notification_lock);
> +		if (!list_empty(&event->fae.fse.list))
> +			list_del_init(&event->fae.fse.list);

Here you forget to decrement group->q_len like
fsnotify_remove_first_event() does.

> +		else
> +			ret = 0;
> +		spin_unlock(&group->notification_lock);

So the above check for list_empty can hit either when response is just
being processed (and then we'll be woken up very soon) or when the event is
just in the process of being copied from event queue to userspace (in which
case we are in the same situation as in the old code). So it would be
weird that in rare cases wait would not be really killable. I think we
could detect this situation in fanotify_read() before adding event to
access_list and just wakeup waiter in fanotify_get_response() again and
avoid reporting the event to userspace. Hmm?

								Honza

> +
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * We cannot return, this will destroy event while
> +		 * process_access_response() fills response.
> +		 * Just wait for wakeup and continue normal flow.
> +		 */
> +		wait_event(group->fanotify_data.access_waitq, event->response);
> +	}
>  
>  	/* userspace responded, convert to something usable */
>  	switch (event->response & ~FAN_AUDIT) {
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
