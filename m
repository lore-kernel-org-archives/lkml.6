Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A651DC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8DC2151D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8DC2151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeHUSDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:03:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:41322 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726590AbeHUSDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:03:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7445FAF60;
        Tue, 21 Aug 2018 14:43:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 00DF11E0EFE; Tue, 21 Aug 2018 16:43:15 +0200 (CEST)
Date:   Tue, 21 Aug 2018 16:43:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fanotify: use killable wait for waiting response for
 permission events
Message-ID: <20180821144315.GC11261@quack2.suse.cz>
References: <153474898224.6806.12518115530793064797.stgit@buzz>
 <20180820105327.GC13830@quack2.suse.cz>
 <a7b4501c-ce1d-6590-3a48-a951740cf681@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7b4501c-ce1d-6590-3a48-a951740cf681@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-08-18 16:42:26, Konstantin Khlebnikov wrote:
> On 20.08.2018 13:53, Jan Kara wrote:
> > > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> > > index eb4e75175cfb..7a0c37790c89 100644
> > > --- a/fs/notify/fanotify/fanotify.c
> > > +++ b/fs/notify/fanotify/fanotify.c
> > > @@ -64,7 +64,27 @@ static int fanotify_get_response(struct fsnotify_group *group,
> > >   	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
> > > -	wait_event(group->fanotify_data.access_waitq, event->response);
> > > +	ret = wait_event_killable(group->fanotify_data.access_waitq,
> > > +				  event->response);
> > > +	if (ret) {
> > > +		/* Try to remove pending event from the queue */
> > > +		spin_lock(&group->notification_lock);
> > > +		if (!list_empty(&event->fae.fse.list))
> > > +			list_del_init(&event->fae.fse.list);
> > 
> > Here you forget to decrement group->q_len like
> > fsnotify_remove_first_event() does.
> > 
> 
> Yep

Actually only if this was the list of events to report to userspace. If the
event was on a list of events already reported but not responded to,
group->q_len should not be touched.

> > > +		else
> > > +			ret = 0;
> > > +		spin_unlock(&group->notification_lock);
> > 
> > So the above check for list_empty can hit either when response is just
> > being processed (and then we'll be woken up very soon) or when the event is
> > just in the process of being copied from event queue to userspace (in which
> > case we are in the same situation as in the old code). So it would be
> > weird that in rare cases wait would not be really killable. I think we
> > could detect this situation in fanotify_read() before adding event to
> > access_list and just wakeup waiter in fanotify_get_response() again and
> > avoid reporting the event to userspace. Hmm?
> 
> I've missed that move from list to list in fanotify_read().
> 
> So, fanotify_read needs event alive for a long time - copy_to_user might
> block forever.

It might block for a long time due to page fault. That is correct.

> We have to transfer ownership and destroy event in fanotify_read.
> I'll try this approach.

I'm open to that if you come up with something reasonably simple. But you
need to somehow communicate back the response and that used to be a mess
and that's why we ended up with permission events being completely handled
by the process generating them...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
