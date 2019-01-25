Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69482C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3806C21919
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfAYISq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:18:46 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:47097 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfAYISq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 03:18:46 -0500
Received: by mail-oi1-f195.google.com with SMTP id x202so7060445oif.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 00:18:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Zlmdjy5XkZ2rL0/5E9GQ1qmVMGgIWthiVHeC78Ds0g=;
        b=bKffSKYHcQou9AclqB9FCooFUANmXR9d9j1hZXvI7to2fx27T4ab7BoSuE6d0nePMR
         K9fEaW6xhiBsS8GjW6YkHKqRBAARGWyVDTuW7Fs88BtS7UMSXnKT20nQIQYT6NpL/RZ2
         vJECKjhlTHiCQNAZvL8QwWlmaadvB3/wF/zqdV7ybM3ghRL93U4qPQjwdUAleH9aOxJ1
         3v63pIpS9MBl40iq1cXt46bT/EpaJce45jG0/7v4MbrLz6bKnUu3bWvIbt09Fojm8AWh
         h40y/ErpZO7VX+6qrZz1Y0c5e9dVpxM/PRaeWO415oyThECvq3y/6yR6hF2VcggzAVGB
         0VJQ==
X-Gm-Message-State: AJcUukflaXNTpDGcqYmlaJKqfb2NEDQ1Dox+1XRMqAp9REgQ3dsYoE4W
        e+IhpCzVjcyJpCwcfOMD/eBP9JsXg7Ad0cTgDMHToxYz
X-Google-Smtp-Source: ALg8bN5MaFWphtY67cfDOwct31BT0oPWap2a4HrrlQJEINrPUtPQMjbK/4Xo4Vn6OyBmqgNFeo78RarmYvFIDyvwQTs=
X-Received: by 2002:a05:6808:13:: with SMTP id u19mr718410oic.57.1548403124836;
 Thu, 24 Jan 2019 23:58:44 -0800 (PST)
MIME-Version: 1.0
References: <20190118193200.32691-1-malat@debian.org> <CAH7mPvi2TN0b=j-6fqDpjGPkZVSEQnDiT2nj9NWmoBOhUiwKEg@mail.gmail.com>
In-Reply-To: <CAH7mPvi2TN0b=j-6fqDpjGPkZVSEQnDiT2nj9NWmoBOhUiwKEg@mail.gmail.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Fri, 25 Jan 2019 08:58:32 +0100
Message-ID: <CA+7wUsz6Rm58VOOTRA1+URKvONzsGcUT+A8F_sctyqMEOfs=yw@mail.gmail.com>
Subject: Re: [PATCH] writeback: tracing: Copy only up to 31 characters in
 strncpy() calls
To:     Nick Desaulniers <nick.desaulniers@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 5:26 AM Nick Desaulniers
<nick.desaulniers@gmail.com> wrote:
>
> On Fri, Jan 18, 2019 at 11:32 AM Mathieu Malaterre <malat@debian.org> wrote:
> >
> > In the past an attempt was made to remove a set of warnings triggered by
> > gcc 8.x and W=1 by changing calls to strncpy() into strlcpy(). This was
> > rejected as one of the desired behavior is to keep initializing the rest
> > of the destination string whenever the source string is less than the
> > size.
> >
> > However the code makes it clear that this is not a desired behavior to
> > copy the entire 32 characters into the destination buffer, since it is
> > expected that the string is NUL terminated. So change the maximum number
> > of characters to be copied to be the size of the destination buffer
> > minus 1.
> >
> > Break long lines and make this patch go through `checkpatch --strict` with
> > no errors.
> >
> > This commit removes the following warnings:
> >
> >   include/trace/events/writeback.h:69:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> >   include/trace/events/writeback.h:99:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> >   include/trace/events/writeback.h:179:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> >   include/trace/events/writeback.h:223:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> >   include/trace/events/writeback.h:277:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> >   include/trace/events/writeback.h:299:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> >   include/trace/events/writeback.h:324:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> >   include/trace/events/writeback.h:375:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> >   include/trace/events/writeback.h:586:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> >   include/trace/events/writeback.h:660:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> >
> > Cc: Nick Desaulniers <nick.desaulniers@gmail.com>
> > Link: https://lore.kernel.org/patchwork/patch/910830/
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
> > ---
> >  include/trace/events/writeback.h | 30 ++++++++++++++++++++----------
> >  1 file changed, 20 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> > index 32db72c7c055..7bc58980f84f 100644
> > --- a/include/trace/events/writeback.h
> > +++ b/include/trace/events/writeback.h
> > @@ -67,7 +67,8 @@ TRACE_EVENT(writeback_dirty_page,
> >
> >         TP_fast_assign(
> >                 strncpy(__entry->name,
> > -                       mapping ? dev_name(inode_to_bdi(mapping->host)->dev) : "(unknown)", 32);
> > +                       mapping ? dev_name(inode_to_bdi(mapping->host)->dev) :
> > +                       "(unknown)", sizeof(__entry->name) - 1);
>
> Does strncpy guarantee that destination will be NULL terminated if
> (sizeof(src) > sizeof(dst)) || (32 > sizeof(dst))?

No, that's the point here:

https://www.kernel.org/doc/htmldocs/kernel-api/API-strncpy.html

...
The result is not NUL-terminated if the source exceeds count bytes.

In the case where the length of src is less than that of count, the
remainder of dest will be padded with NUL.
...

One should use strlcpy for the use case you describe:

https://www.kernel.org/doc/htmldocs/kernel-api/API-strlcpy.html

> >                 __entry->ino = mapping ? mapping->host->i_ino : 0;
> >                 __entry->index = page->index;
> >         ),
> > @@ -97,7 +98,8 @@ DECLARE_EVENT_CLASS(writeback_dirty_inode_template,
> >
> >                 /* may be called for files on pseudo FSes w/ unregistered bdi */
> >                 strncpy(__entry->name,
> > -                       bdi->dev ? dev_name(bdi->dev) : "(unknown)", 32);
> > +                       bdi->dev ? dev_name(bdi->dev) : "(unknown)",
> > +                       sizeof(__entry->name) - 1);
> >                 __entry->ino            = inode->i_ino;
> >                 __entry->state          = inode->i_state;
> >                 __entry->flags          = flags;
> > @@ -177,7 +179,8 @@ DECLARE_EVENT_CLASS(writeback_write_inode_template,
> >
> >         TP_fast_assign(
> >                 strncpy(__entry->name,
> > -                       dev_name(inode_to_bdi(inode)->dev), 32);
> > +                       dev_name(inode_to_bdi(inode)->dev),
> > +                       sizeof(__entry->name) - 1);
> >                 __entry->ino            = inode->i_ino;
> >                 __entry->sync_mode      = wbc->sync_mode;
> >                 __entry->cgroup_ino     = __trace_wbc_assign_cgroup(wbc);
> > @@ -221,7 +224,8 @@ DECLARE_EVENT_CLASS(writeback_work_class,
> >         ),
> >         TP_fast_assign(
> >                 strncpy(__entry->name,
> > -                       wb->bdi->dev ? dev_name(wb->bdi->dev) : "(unknown)", 32);
> > +                       wb->bdi->dev ? dev_name(wb->bdi->dev) : "(unknown)",
> > +                       sizeof(__entry->name) - 1);
> >                 __entry->nr_pages = work->nr_pages;
> >                 __entry->sb_dev = work->sb ? work->sb->s_dev : 0;
> >                 __entry->sync_mode = work->sync_mode;
> > @@ -274,7 +278,8 @@ DECLARE_EVENT_CLASS(writeback_class,
> >                 __field(unsigned int, cgroup_ino)
> >         ),
> >         TP_fast_assign(
> > -               strncpy(__entry->name, dev_name(wb->bdi->dev), 32);
> > +               strncpy(__entry->name, dev_name(wb->bdi->dev),
> > +                       sizeof(__entry->name) - 1);
> >                 __entry->cgroup_ino = __trace_wb_assign_cgroup(wb);
> >         ),
> >         TP_printk("bdi %s: cgroup_ino=%u",
> > @@ -296,7 +301,8 @@ TRACE_EVENT(writeback_bdi_register,
> >                 __array(char, name, 32)
> >         ),
> >         TP_fast_assign(
> > -               strncpy(__entry->name, dev_name(bdi->dev), 32);
> > +               strncpy(__entry->name, dev_name(bdi->dev),
> > +                       sizeof(__entry->name) - 1);
> >         ),
> >         TP_printk("bdi %s",
> >                 __entry->name
> > @@ -321,7 +327,8 @@ DECLARE_EVENT_CLASS(wbc_class,
> >         ),
> >
> >         TP_fast_assign(
> > -               strncpy(__entry->name, dev_name(bdi->dev), 32);
> > +               strncpy(__entry->name, dev_name(bdi->dev),
> > +                       sizeof(__entry->name) - 1);
> >                 __entry->nr_to_write    = wbc->nr_to_write;
> >                 __entry->pages_skipped  = wbc->pages_skipped;
> >                 __entry->sync_mode      = wbc->sync_mode;
> > @@ -372,7 +379,8 @@ TRACE_EVENT(writeback_queue_io,
> >         ),
> >         TP_fast_assign(
> >                 unsigned long *older_than_this = work->older_than_this;
> > -               strncpy(__entry->name, dev_name(wb->bdi->dev), 32);
> > +               strncpy(__entry->name, dev_name(wb->bdi->dev),
> > +                       sizeof(__entry->name) - 1);
> >                 __entry->older  = older_than_this ?  *older_than_this : 0;
> >                 __entry->age    = older_than_this ?
> >                                   (jiffies - *older_than_this) * 1000 / HZ : -1;
> > @@ -584,7 +592,8 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
> >
> >         TP_fast_assign(
> >                 strncpy(__entry->name,
> > -                       dev_name(inode_to_bdi(inode)->dev), 32);
> > +                       dev_name(inode_to_bdi(inode)->dev),
> > +                       sizeof(__entry->name) - 1);
> >                 __entry->ino            = inode->i_ino;
> >                 __entry->state          = inode->i_state;
> >                 __entry->dirtied_when   = inode->dirtied_when;
> > @@ -658,7 +667,8 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
> >
> >         TP_fast_assign(
> >                 strncpy(__entry->name,
> > -                       dev_name(inode_to_bdi(inode)->dev), 32);
> > +                       dev_name(inode_to_bdi(inode)->dev),
> > +                       sizeof(__entry->name) - 1);
> >                 __entry->ino            = inode->i_ino;
> >                 __entry->state          = inode->i_state;
> >                 __entry->dirtied_when   = inode->dirtied_when;
> > --
> > 2.19.2
> >
