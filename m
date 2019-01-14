Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8955FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E2AE20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="EYToVw+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfANTzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:55:21 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39455 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbfANTzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:55:20 -0500
Received: by mail-qk1-f194.google.com with SMTP id c21so176129qkl.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 11:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o1vavm9o2DV9O64MLQtDGzlGNk+4Yzp+Ye5GIraM8u4=;
        b=EYToVw+iUrvwv53qbXyja40nKY/nlR7NUXUF4MsrYkdgtgpIViIg2yd9F6K5odUqo3
         p6xdEbe2tW3LLyxahVtZ7QJ8Coot3XeLBsTO2QC0OGnS7utMopDm0O284ktvM7KGU/YQ
         cN4yUHQr/ch2qnd1Tmv7KNtsNVzqZ2kOrreg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o1vavm9o2DV9O64MLQtDGzlGNk+4Yzp+Ye5GIraM8u4=;
        b=L6s336OagYGBqyqTiBWhw2+v83BKhZXrzyTvOhjgyeLF60MQ4XbXXMqCJ1YYAoUpZA
         4WM3/w4FUPYIMho1XUry83xaelNMdtQ14cQz35vE/WtlQ7zKkBvgr8XRrvhYqAOlTRr2
         yVSyeNwDGUtRJkV+dhqaZLNzYs9CBNud/VfKbEIhK0Jkqq7CsdKBH5MbIc73CYiQ2ZX1
         14HZNAowx8Xvcz3VO5b8RPYgWaJYhm0mCACXbW8qo8Ni1zZQFkiZtV4EaDP5EOfM6pBb
         t7WXGRsfwHIGH6IK07Qz0witQ8JcXGEo22wHfvhLOGUaU5eEQ7Gd+3mMl9s9aDSItX0Y
         gsmA==
X-Gm-Message-State: AJcUukeE6lmUFoU7rAewwd63QGcPzbIEgBvF0Vl2hycv4G+m9GdsrPIq
        ZLvMszm94QidBwTC40baXHSUPw==
X-Google-Smtp-Source: ALg8bN50ECzxcR6eqOE2ePBtlNMZkiWBrflifr5CEzZWbz62WSIy16rUOg9MJCWtdibNqd3iIMtWJQ==
X-Received: by 2002:a37:5e42:: with SMTP id s63mr117608qkb.220.1547495719044;
        Mon, 14 Jan 2019 11:55:19 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cfd0:d2ee:d54d:ab6d])
        by smtp.gmail.com with ESMTPSA id s46sm49980008qtc.63.2019.01.14.11.55.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 11:55:17 -0800 (PST)
Date:   Mon, 14 Jan 2019 14:55:16 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Todd Kjos <tkjos@google.com>
Cc:     Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v3] binder: create node flag to request sender's security
 context
Message-ID: <20190114195516.GA227294@google.com>
References: <20190114171021.86171-1-tkjos@google.com>
 <20190114183316.GA199154@google.com>
 <CAHRSSEx7BMMZ1CFoQiOxUzPfO1+MFuSEF4Xo=oN5h+gUZb=4JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHRSSEx7BMMZ1CFoQiOxUzPfO1+MFuSEF4Xo=oN5h+gUZb=4JQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 10:50:24AM -0800, Todd Kjos wrote:
> On Mon, Jan 14, 2019 at 10:33 AM Joel Fernandes <joelaf@google.com> wrote:
> >
> > On Mon, Jan 14, 2019 at 09:10:21AM -0800, Todd Kjos wrote:
> > > To allow servers to verify client identity, allow a node
> > > flag to be set that causes the sender's security context
> > > to be delivered with the transaction. The BR_TRANSACTION
> > > command is extended in BR_TRANSACTION_SEC_CTX to
> > > contain a pointer to the security context string.
> > >
> > > Signed-off-by: Todd Kjos <tkjos@google.com>
> > > ---
> > > v2: fix 32-bit build warning
> > > v3: fix smatch warning on unitialized struct element
> > >
> > >  drivers/android/binder.c            | 106 ++++++++++++++++++++++------
> > >  include/uapi/linux/android/binder.h |  19 +++++
> > >  2 files changed, 102 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > index cdfc87629efb8..5f6ef5e63b91e 100644
> > > --- a/drivers/android/binder.c
> > > +++ b/drivers/android/binder.c
> > > @@ -329,6 +329,8 @@ struct binder_error {
> > >   *                        (invariant after initialized)
> > >   * @min_priority:         minimum scheduling priority
> > >   *                        (invariant after initialized)
> > > + * @txn_security_ctx:     require sender's security context
> > > + *                        (invariant after initialized)
> > >   * @async_todo:           list of async work items
> > >   *                        (protected by @proc->inner_lock)
> > >   *
> > > @@ -365,6 +367,7 @@ struct binder_node {
> > >                * invariant after initialization
> > >                */
> > >               u8 accept_fds:1;
> > > +             u8 txn_security_ctx:1;
> > >               u8 min_priority;
> > >       };
> > >       bool has_async_transaction;
> > > @@ -615,6 +618,7 @@ struct binder_transaction {
> > >       long    saved_priority;
> > >       kuid_t  sender_euid;
> > >       struct list_head fd_fixups;
> > > +     binder_uintptr_t security_ctx;
> > >       /**
> > >        * @lock:  protects @from, @to_proc, and @to_thread
> > >        *
> > > @@ -1152,6 +1156,7 @@ static struct binder_node *binder_init_node_ilocked(
> > >       node->work.type = BINDER_WORK_NODE;
> > >       node->min_priority = flags & FLAT_BINDER_FLAG_PRIORITY_MASK;
> > >       node->accept_fds = !!(flags & FLAT_BINDER_FLAG_ACCEPTS_FDS);
> > > +     node->txn_security_ctx = !!(flags & FLAT_BINDER_FLAG_TXN_SECURITY_CTX);
> > >       spin_lock_init(&node->lock);
> > >       INIT_LIST_HEAD(&node->work.entry);
> > >       INIT_LIST_HEAD(&node->async_todo);
> > > @@ -2778,6 +2783,8 @@ static void binder_transaction(struct binder_proc *proc,
> > >       binder_size_t last_fixup_min_off = 0;
> > >       struct binder_context *context = proc->context;
> > >       int t_debug_id = atomic_inc_return(&binder_last_id);
> > > +     char *secctx = NULL;
> > > +     u32 secctx_sz = 0;
> > >
> > >       e = binder_transaction_log_add(&binder_transaction_log);
> > >       e->debug_id = t_debug_id;
> > > @@ -3020,6 +3027,20 @@ static void binder_transaction(struct binder_proc *proc,
> > >       t->flags = tr->flags;
> > >       t->priority = task_nice(current);
> > >
> > > +     if (target_node && target_node->txn_security_ctx) {
> > > +             u32 secid;
> > > +
> > > +             security_task_getsecid(proc->tsk, &secid);
> > > +             ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
> > > +             if (ret) {
> > > +                     return_error = BR_FAILED_REPLY;
> > > +                     return_error_param = ret;
> > > +                     return_error_line = __LINE__;
> > > +                     goto err_get_secctx_failed;
> > > +             }
> > > +             extra_buffers_size += ALIGN(secctx_sz, sizeof(u64));
> > > +     }
> > > +
> > >       trace_binder_transaction(reply, t, target_node);
> > >
> > >       t->buffer = binder_alloc_new_buf(&target_proc->alloc, tr->data_size,
> > > @@ -3036,6 +3057,19 @@ static void binder_transaction(struct binder_proc *proc,
> > >               t->buffer = NULL;
> > >               goto err_binder_alloc_buf_failed;
> > >       }
> > > +     if (secctx) {
> > > +             size_t buf_offset = ALIGN(tr->data_size, sizeof(void *)) +
> > > +                                 ALIGN(tr->offsets_size, sizeof(void *)) +
> > > +                                 ALIGN(extra_buffers_size, sizeof(void *)) -
> > > +                                 ALIGN(secctx_sz, sizeof(u64));
> > > +             char *kptr = t->buffer->data + buf_offset;
> > > +
> > > +             t->security_ctx = (uintptr_t)kptr +
> > > +                 binder_alloc_get_user_buffer_offset(&target_proc->alloc);
> > > +             memcpy(kptr, secctx, secctx_sz);
> >
> > Just for my clarification, instead of storing the string in the transaction
> > buffer, would it not be better to store the security context id in
> > t->security_ctx, and then do the conversion to string later, during
> > binder_thread_read? Then some space will also be saved in the transaction
> > buffer?
> 
> The string has to be somewhere in the address space of the target. We
> allocate the space in the binder buffer and copy it here. This is a
> convenient place to allocate the space since we know the size at the
> time of allocation. Presumably, in your proposal, we would copy it
> later into the output buffer...which is allocated by the userspace so
> we don't have complete control of it in the kernel. Doing that would
> make binder_thread_read() more complex since we'd need to make sure
> there is sizeof(tr) + secctx_sz always available in the output buffer
> (which is allocated by userspace). Saving a few bytes in the this
> buffer is of little value, but keeping the output buffer management
> simple is valuable.

Makes sense now, thanks. I agree its simpler this way.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

