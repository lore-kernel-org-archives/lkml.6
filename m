Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbeBUXMe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 18:12:34 -0500
Received: from mail-ua0-f195.google.com ([209.85.217.195]:46095 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbeBUXMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 18:12:32 -0500
X-Google-Smtp-Source: AH8x225lDcsUngw1ZuUad7FOu2ts1qU6vrY9/jvvYe4DrVDd+67lvw/JvLuI+9imZ/9naGrBlxAifQ3ARrRDMQ65yus=
MIME-Version: 1.0
In-Reply-To: <20180221215605.GK6778@dastard>
References: <20180221204128.5846-1-garrmcnu@gmail.com> <20180221215605.GK6778@dastard>
From: Garry McNulty <garrmcnu@gmail.com>
Date: Wed, 21 Feb 2018 23:12:31 +0000
Message-ID: <CANysgeGy2WkmH=Tv9x5sPc7JXf0rSH2Ash_YmfyfmHvzLEHz-A@mail.gmail.com>
Subject: Re: [PATCH] fs/iomap: fix memory leak on error condition
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, hch@lst.de,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 February 2018 at 21:56, Dave Chinner <david@fromorbit.com> wrote:
>
> On Wed, Feb 21, 2018 at 08:41:28PM +0000, Garry McNulty wrote:
> > If the call to is_sync_kiocb() fails an error is returned without
> > freeing dio. Set the return code and jump to out_free_dio.
> >
> > Detected by CoverityScan, CID 1429424 ("Resource leak")
>
> Coverity is wrong.
>
> > Signed-off-by: Garry McNulty <garrmcnu@gmail.com>
> > ---
> >  fs/iomap.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/iomap.c b/fs/iomap.c
> > index afd163586aa0..65c5db38c15a 100644
> > --- a/fs/iomap.c
> > +++ b/fs/iomap.c
> > @@ -1063,8 +1063,10 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> >               iomap_dio_set_error(dio, ret);
> >
> >       if (!atomic_dec_and_test(&dio->ref)) {
> > -             if (!is_sync_kiocb(iocb))
> > -                     return -EIOCBQUEUED;
> > +             if (!is_sync_kiocb(iocb)) {
> > +                     ret = -EIOCBQUEUED;
> > +                     goto out_free_dio;
> > +             }
>
> This is where we return after AIO submission. The struct dio has
> already been attached to the bio we have submitted, and will be
> freed on IO completion.  We are simply not waiting for IO completion
> here, instead leaving it to the completion code to free the struct
> dio and pass the completion status to the AIO code appropriately.
>
ah OK, thanks for reviewing and for the explanation.

Cheers

Garry
