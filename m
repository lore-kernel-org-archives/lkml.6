Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E978FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A402086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="lu/abGNY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A402086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeKGWPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 17:15:42 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:39875 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbeKGWPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 17:15:41 -0500
Received: by mail-it1-f196.google.com with SMTP id m15so22463418itl.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 04:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nwes3/5X+l7FBPnP8N7guJ9b8/Oh2apJCRFWHwwsQN8=;
        b=lu/abGNYMDGkHubbzrEbumyAlZZxpPro7GtVVOpMBkNk5aYKwCRi5gfRE4sLoN6zWA
         XfEQ6SZs2Zc5Hamu4I7qYYzVg9lD0cXd+H+H6VWZLq0kglSiqJLNFhj/U8FRnKvhMkrn
         7ZS+6lRrOAGIu8FOQKckT0QP71dSjXcsu5X34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nwes3/5X+l7FBPnP8N7guJ9b8/Oh2apJCRFWHwwsQN8=;
        b=t4WlpS+TEXiBJ8OxokTjcrxyz9/q8YOhxb8UeWu3HEpC9MZ6rE7coyfUC8n+aWs8Um
         fJTK+AEvxUUO8dlePkheDfJpjcdrCCeGxwqnhWxVE9Ij/ajgeyZzONus2SBLep0qbbi2
         75b2B/+DSMXVe6NX9AyVW+7tjqzGOiOk29bWO+u482ndri9DO5uJG9GIqLqZgSJSEZAT
         AyWNQle2IfRyYY9sayjzz32MOOsMi2fUyCjBDW0qUbSyzKliDm8mpwhvS4oiFJBhZARI
         nMOIzEyPP0of1MhRrXvtO4fC3TT3zAp3yZftCOyby4hEzoINu4b4ykupGzqPQrywa4fz
         NrrQ==
X-Gm-Message-State: AGRZ1gIy5dh7xJ6K4U6D2on0aWLFMuDRWrS5HlsjgDOYBXRlLWGmwu2S
        YFTR6VEIldIu67pfEw9qSOwJ1RlYucRU6pTBRR91ag==
X-Google-Smtp-Source: AJdET5ddhvaN2fN8vRUz/ILxgyZKnvxy6LTgeB/hWCD17ir4OEL6T4AZYGclQmizoa5Mz/PpqxWntfJwb0LIKHG+Dpg=
X-Received: by 2002:a24:fe88:: with SMTP id w130-v6mr41880ith.69.1541594727008;
 Wed, 07 Nov 2018 04:45:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:ac42:0:0:0:0:0 with HTTP; Wed, 7 Nov 2018 04:45:26 -0800 (PST)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <154149663324.17764.5859568987168525822.stgit@localhost.localdomain>
References: <154149586524.17764.5252013294539109287.stgit@localhost.localdomain>
 <154149663324.17764.5859568987168525822.stgit@localhost.localdomain>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 7 Nov 2018 13:45:26 +0100
Message-ID: <CAJfpegtCYsA3zn121AZr+kF+GSNCCz=AjhJrZZMvydT9=w_SUA@mail.gmail.com>
Subject: Re: [PATCH 1/6] fuse: Kill fasync only if interrupt is queued in queue_interrupt()
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 10:30 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> We should sent signal only in case of interrupt is really queued.
> Not a real problem, but this makes the code clearer and intuitive.
>
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  fs/fuse/dev.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index fb2530ed84b3..7705f75c77a3 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -468,6 +468,8 @@ static void request_end(struct fuse_conn *fc, struct fuse_req *req)
>
>  static void queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
>  {
> +       bool kill = false;
> +
>         spin_lock(&fiq->waitq.lock);
>         if (test_bit(FR_FINISHED, &req->flags)) {
>                 spin_unlock(&fiq->waitq.lock);
> @@ -476,9 +478,11 @@ static void queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
>         if (list_empty(&req->intr_entry)) {
>                 list_add_tail(&req->intr_entry, &fiq->interrupts);
>                 wake_up_locked(&fiq->waitq);
> +               kill = true;
>         }
>         spin_unlock(&fiq->waitq.lock);
> -       kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
> +       if (kill)
> +               kill_fasync(&fiq->fasync, SIGIO, POLL_IN);

All other cases just do the kill_fasync() inside the fiq->waitq.lock
locked region.  That seems the simpler and more readable solution to
this.

Thanks,
Miklos
