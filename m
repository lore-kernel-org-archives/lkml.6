Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44748C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135042173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="OmSoiSJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfAJLAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 06:00:20 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39021 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfAJLAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 06:00:20 -0500
Received: by mail-it1-f194.google.com with SMTP id a6so15633820itl.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 03:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c8MJ5O5qoeQdBHpA0MpiU5uHvPirlHn/6WvD3Ps9Juc=;
        b=OmSoiSJFwOW5puPGa3naqJljxufvfyg2nHkX/IDEm+vGPiGEKFGnrOrVV4v3QyDZUO
         kO61S6fuj4U7clU92vRLQMnm21Psk0AmUi+raDSqLwBoTWSjSHMM2WdbNXJu3ne7xU0a
         EqFfPj+E4gEyJFGBRanCE6SmoWVI10nZr2eF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c8MJ5O5qoeQdBHpA0MpiU5uHvPirlHn/6WvD3Ps9Juc=;
        b=DGn/gVzyVVHhHtArdIarDRywXDSTUwPug/0rIUfsP8Cigl2FXeltyqTqnS3ajmgKBN
         t4E6PL8uXscfSV2re4f+Yh6Tqg4CrHBOP2rBbjgiPOI+FNatCB5ezrZU5yK26cKdf53h
         Zf2hsKpgue4H8Tptxs4T2XjM2oyPkwz707Yj1lxicn1sPNr7X77kvy/pvUx+7Mp8xnxm
         +jDn50xGAzaSpGarwfW9vZfAsb9SxuNEEIPGzuLsVzthGjUZcg7koJJD4TzFhLfb0ee3
         2VXF6Fv01ticompqQ+MTHMQsRH0E/k98+J0E+B3RWRxBCOcJtvAeYFesWWNmKMEg9MZg
         /TIA==
X-Gm-Message-State: AJcUukdxcQvTj1NfyRnf308jwpEgsrgOour9DEGKa9bXLUgffC4sP4UT
        maZ0wVBuBelEqFKd5p+DBq7XsrrwzETvgQfRb5h9ag==
X-Google-Smtp-Source: ALg8bN4tQRQlPfEaED8rfItCDzu7nUttn7BNwDwBsDN2FbcE9RM/haZyLf6Z5iFt8SoT3nbHRvagByTDoXJ7lHN8O4A=
X-Received: by 2002:a02:40c9:: with SMTP id n192mr3954493jaa.78.1547118019463;
 Thu, 10 Jan 2019 03:00:19 -0800 (PST)
MIME-Version: 1.0
References: <154322517208.18737.3297786654135648324.stgit@localhost.localdomain>
 <00b1782a-5c5c-5bc8-7ea9-4f8450679fa1@virtuozzo.com>
In-Reply-To: <00b1782a-5c5c-5bc8-7ea9-4f8450679fa1@virtuozzo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 10 Jan 2019 12:00:08 +0100
Message-ID: <CAJfpeguokUoCPEnK7Q_Rp9cmyBCMfm51=7TmbbS-QiEy2BxxAQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: Fix race in fuse_writepage_in_flight()
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 11:48 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> Hi, Miklos,
>
> any comments about this?

Is there a reproducer?  ISTR that fsx-linux with mmaps enabled was
good for stressing the writeback_cache code.

Thanks,
Miklos

>
> On 26.11.2018 12:46, Kirill Tkhai wrote:
> > Checking for FR_PENDING in fuse_writepage_in_flight() is racy.
> > It does not guarantee the first request in misc.write.next list
> > is not in userspace, since there we take fc->lock, while
> > fuse_dev_do_read() takes fiq->waitq.lock:
> >
> > fuse_dev_read()                           fuse_writepage_in_flight()
> >                                             test_bit(FR_PENDING)
> >   clear_bit(FR_PENDING)
> > handle old_req->pages[0] in userspace
> >                                             copy_highpage(old_req->pages[0], page)
> >                                             ^^^^^
> >                                             userspace never sees this pages
> >
> > The only reliable way to determ, whether we are able to replace
> > old_req's page, is to completely skip the first request in the list.
> > This patch makes the function to do that.
> >
> > Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> > ---
> >  fs/fuse/file.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index b52f9baaa3e7..c6650c68b31a 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -1740,6 +1740,7 @@ static bool fuse_writepage_in_flight(struct fuse_req *new_req,
> >  {
> >       struct fuse_conn *fc = get_fuse_conn(new_req->inode);
> >       struct fuse_inode *fi = get_fuse_inode(new_req->inode);
> > +     struct fuse_req *first_req;
> >       struct fuse_req *tmp;
> >       struct fuse_req *old_req;
> >       bool found = false;
> > @@ -1764,6 +1765,7 @@ static bool fuse_writepage_in_flight(struct fuse_req *new_req,
> >       }
> >
> >       new_req->num_pages = 1;
> > +     first_req = old_req;
> >       for (tmp = old_req; tmp != NULL; tmp = tmp->misc.write.next) {
> >               BUG_ON(tmp->inode != new_req->inode);
> >               curr_index = tmp->misc.write.in.offset >> PAGE_SHIFT;
> > @@ -1773,7 +1775,7 @@ static bool fuse_writepage_in_flight(struct fuse_req *new_req,
> >               }
> >       }
> >
> > -     if (old_req->num_pages == 1 && test_bit(FR_PENDING, &old_req->flags)) {
> > +     if (old_req->num_pages == 1 && old_req != first_req) {
> >               struct backing_dev_info *bdi = inode_to_bdi(page->mapping->host);
> >
> >               copy_highpage(old_req->pages[0], page);
> >
