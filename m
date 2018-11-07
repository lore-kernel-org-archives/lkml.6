Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6261C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796AA20989
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="HOrTghbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796AA20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeKGX0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:26:05 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51419 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbeKGX0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:26:05 -0500
Received: by mail-it1-f196.google.com with SMTP id m34-v6so1739826iti.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 05:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FGh01L7cooZqcnHrnmambmA0GV3gC0p/DtcaHT2//s4=;
        b=HOrTghbscRey9eM5er7N8naaqFu1Hl8dtSgB8b1SxggRlpD2EmkiudI259fqLk4l1h
         nil6pQg466iWrOdq+DQ7yLRy+6HDKTpHWML2tZLFzpafX7/k2I3L4xjZ1KRlZDZd/Ni2
         T/o3EuD7yxf91TGpO8U3ryEdh2Y7spR9D8BhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FGh01L7cooZqcnHrnmambmA0GV3gC0p/DtcaHT2//s4=;
        b=m5X/Yw+ULun1qCZinKjrFElbBzV3AorJhSX6ECfdMrAn5o+fYnoh65BhGiKNn6V8D5
         NlAGY4gptt0kA6eloBjBdrhAdkjBP1dZmW4Dz36mq/zPuS46Rrhb8iC0UQJ0+91Szg2a
         uqt4YNlez8KewG8GLbcH99FvTDqGySsStErrlI3zHTgNz1DrbL1ReA03hFoxqcbVmzxh
         BtRWviH0MEbcnjnbBa/qLh3lnTd48cG6f3lGACKDp6wW+zOLKpK/OFUAUW761eEvSdw5
         AYVtyHRdpL0T8srDij/ATxzfuwl5y/7I9AFDCnZdU/zYp/kxvDYVC3hHRhYw4qG9iFO+
         nCEQ==
X-Gm-Message-State: AGRZ1gIWMvG+UTHcwVXsvuLk//qduo1ZaqC0+S3mc7kYpw2WRVKGX5fy
        ztA7TOlj5j8/hZhn/rfXdkac8CEtmP5MF0HOg74gNg==
X-Google-Smtp-Source: AJdET5f4MnAvJ7IhU5YnFcTDV2tsqXW1f4msZKr3kBnkEnbkIyiQ7Fqj4+MTruCYIVbORSBpA9AqRdfjz8l9CQ28yKc=
X-Received: by 2002:a24:750f:: with SMTP id y15-v6mr264857itc.1.1541598935418;
 Wed, 07 Nov 2018 05:55:35 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:ac42:0:0:0:0:0 with HTTP; Wed, 7 Nov 2018 05:55:34 -0800 (PST)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <154149666097.17764.12092615786683141764.stgit@localhost.localdomain>
References: <154149586524.17764.5252013294539109287.stgit@localhost.localdomain>
 <154149666097.17764.12092615786683141764.stgit@localhost.localdomain>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 7 Nov 2018 14:55:34 +0100
Message-ID: <CAJfpeguDTsG7vEAhH=CHp43vJak70VzR8YH8K6=vZAUXCZZeEQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] fuse: Verify userspace asks to requeue interrupt that
 we really sent
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 10:31 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> When queue_interrupt() is called from fuse_dev_do_write(),
> it came from userspace directly. Userspace may pass any
> request id, even the request's we have not interrupted
> (or even background's request). This patch adds sanity
> check to make kernel safe against that.

Okay, I understand this far.

> The problem is real interrupt may be queued and requeued
> by two tasks on two cpus. This case, the requeuer has not
> guarantees it sees FR_INTERRUPTED bit on its cpu (since
> we know nothing about the way userspace manages requests
> between its threads and whether it uses smp barriers).

This sounds like BS.   There's an explicit  smp_mb__after_atomic()
after the set_bit(FR_INTERRUPTED,...).  Which means FR_INTERRUPTED is
going to be visible on all CPU's after this, no need to fool around
with setting FR_INTERRUPTED again, etc...



>
> To eliminate this problem, queuer writes FR_INTERRUPTED
> bit again under fiq->waitq.lock, and this guarantees
> requeuer will see the bit, when checks it.
>
> I try to introduce solution, which does not affect on
> performance, and which does not force to take more
> locks. This is the reason, the below solution is worse:
>
>    request_wait_answer()
>    {
>      ...
>   +  spin_lock(&fiq->waitq.lock);
>      set_bit(FR_INTERRUPTED, &req->flags);
>   +  spin_unlock(&fiq->waitq.lock);
>      ...
>    }
>
> Also, it does not look a better idea to extend fuse_dev_do_read()
> with the fix, since it's already a big function:
>
>    fuse_dev_do_read()
>    {
>      ...
>      if (test_bit(FR_INTERRUPTED, &req->flags)) {
>   +      /* Comment */
>   +      barrier();
>   +      set_bit(FR_INTERRUPTED, &req->flags);
>          queue_interrupt(fiq, req);
>      }
>      ...
>    }
>
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  fs/fuse/dev.c |   26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 315d395d5c02..3bfc5ed61c9a 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -475,13 +475,27 @@ static void request_end(struct fuse_conn *fc, struct fuse_req *req)
>         fuse_put_request(fc, req);
>  }
>
> -static void queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
> +static int queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
>  {
>         bool kill = false;
>
>         if (test_bit(FR_FINISHED, &req->flags))
> -               return;
> +               return 0;
>         spin_lock(&fiq->waitq.lock);
> +       /* Check for we've sent request to interrupt this req */
> +       if (unlikely(!test_bit(FR_INTERRUPTED, &req->flags))) {
> +               spin_unlock(&fiq->waitq.lock);
> +               return -EINVAL;
> +       }
> +       /*
> +        * Interrupt may be queued from fuse_dev_do_read(), and
> +        * later requeued on other cpu by fuse_dev_do_write().
> +        * To make FR_INTERRUPTED bit visible for the requeuer
> +        * (under fiq->waitq.lock) we write it once again.
> +        */
> +       barrier();
> +       __set_bit(FR_INTERRUPTED, &req->flags);
> +
>         if (list_empty(&req->intr_entry)) {
>                 list_add_tail(&req->intr_entry, &fiq->interrupts);
>                 /*
> @@ -492,7 +506,7 @@ static void queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
>                 if (test_bit(FR_FINISHED, &req->flags)) {
>                         list_del_init(&req->intr_entry);
>                         spin_unlock(&fiq->waitq.lock);
> -                       return;
> +                       return 0;
>                 }
>                 wake_up_locked(&fiq->waitq);
>                 kill = true;
> @@ -500,6 +514,7 @@ static void queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
>         spin_unlock(&fiq->waitq.lock);
>         if (kill)
>                 kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
> +       return (int)kill;
>  }
>
>  static void request_wait_answer(struct fuse_conn *fc, struct fuse_req *req)
> @@ -1959,8 +1974,9 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
>                         nbytes = -EINVAL;
>                 else if (oh.error == -ENOSYS)
>                         fc->no_interrupt = 1;
> -               else if (oh.error == -EAGAIN)
> -                       queue_interrupt(&fc->iq, req);
> +               else if (oh.error == -EAGAIN &&
> +                        queue_interrupt(&fc->iq, req) < 0)
> +                       nbytes = -EINVAL;
>
>                 fuse_put_request(fc, req);
>                 fuse_copy_finish(cs);
>
