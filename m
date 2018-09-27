Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BDEC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD31206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NgIK4+NG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD31206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeI1FFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:05:52 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35464 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbeI1FFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:05:52 -0400
Received: by mail-yb1-f194.google.com with SMTP id o63-v6so1852134yba.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 15:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=j5x/kbi6IdF3I7YOIe2yLXkP6GMZMrWA6raHG+m2Svk=;
        b=NgIK4+NGNz1sgQRRsVtMywCkAVsqYySCJNIp2BMdZDPwntOLHsmM6V8gsnRm281mFr
         eXzssmy/rmmc5w8zAUzP5aw7rFuVwygkp0Uw5HWEdk0cHz+HrNuuAFOeXBDloH9y66yr
         fKplF8tGbRcMtuRU9dqboRF6c8HwVqOHMtu1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=j5x/kbi6IdF3I7YOIe2yLXkP6GMZMrWA6raHG+m2Svk=;
        b=J/ouPDv14IiczmTPTITnZ0ZDLlWsJadZQavvec+ZnJewv2Y0EnBaXLyiDDdOoQiVBT
         fOPGLG4jCU1l1YodlAlwjCnswneqHnbaSEOtS+Gr58QL0u/ZGLCnycPTq0zKm7RClCsT
         vIvWDNUP3Vjkvbgn/e7caEw5TOUhdyrY8T4gLeC+VjiZAWDB7eIJxXR7pC1Gz7CRMt/6
         qLPbGzwNEgv0bDoYi9OZymUN6PPmd6vq6DYC5APeZjIzY/4/gABskReCmrvp6IvDm6ft
         TEkTBu8UBZ02RWcFbxHQNQ8sTtS4mYGcfny2Kv5+iqXV/ryyKLjZSTkd0TFV7gusq3Ke
         jbRw==
X-Gm-Message-State: ABuFfojIroj9seACnDNH4o7i7nIFhvSU/46CJygkS6QhOCPCngzaCzLR
        r69uPeOTt1RSB/+t1JR2G8zTGs6/35I=
X-Google-Smtp-Source: ACcGV61Iy74rRBXLwq3MUDXrgx2zjH80E5KiosjMkMuzrLEnlV0pZeugDY5iLg8MDgqVrJiatghXLw==
X-Received: by 2002:a25:c64d:: with SMTP id k74-v6mr6937260ybf.62.1538088315173;
        Thu, 27 Sep 2018 15:45:15 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id 124-v6sm1298881yws.25.2018.09.27.15.45.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 15:45:13 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id o8-v6so1818701ybk.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 15:45:13 -0700 (PDT)
X-Received: by 2002:a25:19c3:: with SMTP id 186-v6mr7114777ybz.410.1538088312667;
 Thu, 27 Sep 2018 15:45:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 15:45:11
 -0700 (PDT)
In-Reply-To: <CAG48ez05LyQOb4pw5H74VhHdQFDEOPLoLuhDPMEqFG7W1hwA_Q@mail.gmail.com>
References: <20180927151119.9989-1-tycho@tycho.ws> <20180927151119.9989-2-tycho@tycho.ws>
 <CAG48ez05LyQOb4pw5H74VhHdQFDEOPLoLuhDPMEqFG7W1hwA_Q@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 27 Sep 2018 15:45:11 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+uqgCkxaEPoOa_+XSTJBe==bNATCewsqqzwiyKhbLGVQ@mail.gmail.com>
Message-ID: <CAGXu5j+uqgCkxaEPoOa_+XSTJBe==bNATCewsqqzwiyKhbLGVQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] seccomp: add a return code to trap to userspace
To:     Jann Horn <jannh@google.com>
Cc:     Tycho Andersen <tycho@tycho.ws>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 2:51 PM, Jann Horn <jannh@google.com> wrote:
> On Thu, Sep 27, 2018 at 5:11 PM Tycho Andersen <tycho@tycho.ws> wrote:
>> However, care should be taken to avoid the TOCTOU
>> +mentioned above in this document: all arguments being read from the tracee's
>> +memory should be read into the tracer's memory before any policy decisions are
>> +made. This allows for an atomic decision on syscall arguments.
>
> Again, I don't really see how you could get this wrong.

Doesn't hurt to mention it, IMO.

>> +static long seccomp_notify_send(struct seccomp_filter *filter,
>> +                               unsigned long arg)
>> +{
>> +       struct seccomp_notif_resp resp = {};
>> +       struct seccomp_knotif *knotif = NULL;
>> +       long ret;
>> +       u16 size;
>> +       void __user *buf = (void __user *)arg;
>> +
>> +       if (copy_from_user(&size, buf, sizeof(size)))
>> +               return -EFAULT;
>> +       size = min_t(size_t, size, sizeof(resp));
>> +       if (copy_from_user(&resp, buf, size))
>> +               return -EFAULT;
>> +
>> +       ret = mutex_lock_interruptible(&filter->notify_lock);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       list_for_each_entry(knotif, &filter->notif->notifications, list) {
>> +               if (knotif->id == resp.id)
>> +                       break;
>> +       }
>> +
>> +       if (!knotif || knotif->id != resp.id) {
>
> Uuuh, this looks unsafe and wrong. I don't think `knotif` can ever be
> NULL here. If `filter->notif->notifications` is empty, I think
> `knotif` will be `container_of(&filter->notif->notifications, struct
> seccom_knotif, list)` - in other words, you'll have a type confusion,
> and `knotif` probably points into some random memory in front of
> `filter->notif`.
>
> Am I missing something?

Oh, good catch. This just needs to be fixed like it's done in
seccomp_notif_recv (separate cur and knotif).

>> +static struct file *init_listener(struct task_struct *task,
>> +                                 struct seccomp_filter *filter)
>> +{
>
> Why does this function take a `task` pointer instead of always
> accessing `current`? If `task` actually wasn't `current`, I would have
> concurrency concerns. A comment in seccomp.h even explains:
>
>  *          @filter must only be accessed from the context of current as there
>  *          is no read locking.
>
> Unless there's a good reason for it, I would prefer it if this
> function didn't take a `task` pointer.

This is to support PTRACE_SECCOMP_NEW_LISTENER.

But you make an excellent point. Even TSYNC expects to operate only on
the current thread group. Hmm.

While the process is stopped by ptrace, we could, in theory, update
task->seccomp.filter via something like TSYNC.

So perhaps use:

mutex_lock_killable(&task->signal->cred_guard_mutex);

before walking the notify_locks?

>
>> +       struct file *ret = ERR_PTR(-EBUSY);
>> +       struct seccomp_filter *cur, *last_locked = NULL;
>> +       int filter_nesting = 0;
>> +
>> +       for (cur = task->seccomp.filter; cur; cur = cur->prev) {
>> +               mutex_lock_nested(&cur->notify_lock, filter_nesting);
>> +               filter_nesting++;
>> +               last_locked = cur;
>> +               if (cur->notif)
>> +                       goto out;
>> +       }
>> +
>> +       ret = ERR_PTR(-ENOMEM);
>> +       filter->notif = kzalloc(sizeof(*(filter->notif)), GFP_KERNEL);
>
> sizeof(struct notification) instead, to make the code clearer?

I prefer what Tycho has: I want to allocate an instances of whatever
filter->notif is.

Though, let's do the kzalloc outside of the locking, instead?

>> +       ret = anon_inode_getfile("seccomp notify", &seccomp_notify_ops,
>> +                                filter, O_RDWR);
>> +       if (IS_ERR(ret))
>> +               goto out;
>> +
>> +
>> +       /* The file has a reference to it now */
>> +       __get_seccomp_filter(filter);
>
> __get_seccomp_filter() has a comment in it that claims "/* Reference
> count is bounded by the number of total processes. */". I think this
> change invalidates that comment. I think it should be fine to just
> remove the comment.

Update it to "bounded by total processes and notification listeners"?

>> +out:
>> +       for (cur = task->seccomp.filter; cur; cur = cur->prev) {
>
> s/; cur;/; 1;/, or use a while loop instead? If the NULL check fires
> here, something went very wrong.

Hm? This is correct. This is how seccomp_run_filters() walks the list too:

        struct seccomp_filter *f =
                        READ_ONCE(current->seccomp.filter);
        ...
        for (; f; f = f->prev) {

Especially if we'll be holding the cred_guard_mutex.

-Kees

-- 
Kees Cook
Pixel Security
