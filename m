Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DD4C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8A22081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RYvVHYaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8A22081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeJaGdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:33:52 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46189 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeJaGdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:33:52 -0400
Received: by mail-yw1-f66.google.com with SMTP id j202-v6so5573353ywa.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 14:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4QzChBZAs/cvKyicn0LsqabevfHPFQzxPHy0SLFIV6Y=;
        b=RYvVHYaXwfg81KOBsCJ2mxPUCbEE0sBdWUqlfJQpvQKH+Ty+nWCkvZN0s8Hs0EzTUp
         nNAJm1XFXEJj9lnMyiNqRbkOh1Azse1UxFntHGwUGpLPeuSeieFX1l/DejxbticRuPTj
         Z0b+KWevGRzZCBtbKgfrgIJs0iSxwuJfLgv3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4QzChBZAs/cvKyicn0LsqabevfHPFQzxPHy0SLFIV6Y=;
        b=EJWQHp3AW+qlsLw2Eg3ndYZAdEehVXfU7SZGpiM3EsXy3gk4FGUq9I47zgRg6qPj/V
         pBK0gCPkizDhou80LMXjYsq+V5BLxPgs9rXJANaFOYk3TCiy8i7agUHdbehXgAGtxezY
         stEUdqSWAu9tFzY3uRYMNi9Jxx7uS6DCmYyne7D9qe1av0U6cDEmy62ype/pRefxKWS5
         3ggVKCA+1CiWxYcUq5Qt4q3EkNJlBe6P6M1YeQQ3t0o77dNMtxqB3bxjBnGh7kabCVxk
         HB2YVrsTjhaE4pVsBS/luNitxbqvdjYgmSk7xTb+n9LNFCwACymtQ2TMmKtCN83M7ldN
         8eGQ==
X-Gm-Message-State: AGRZ1gJYSCSQorhb2L8viUmanHgmXDSzKJkYYeBGMrbLHppaS3PxfBEb
        ZA8coayVOupZj9BH9qKDM2seLTCQmds=
X-Google-Smtp-Source: AJdET5fsUcRKG9TLAref5L1TMRmzuFuL9NQHpjBq/zeo7c14JBGHMyNXxqED5AlEV+uK5a5Z61Xfdg==
X-Received: by 2002:a81:b87:: with SMTP id 129-v6mr462986ywl.335.1540935522388;
        Tue, 30 Oct 2018 14:38:42 -0700 (PDT)
Received: from mail-yw1-f50.google.com (mail-yw1-f50.google.com. [209.85.161.50])
        by smtp.gmail.com with ESMTPSA id n128-v6sm5921508ywc.71.2018.10.30.14.38.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 14:38:40 -0700 (PDT)
Received: by mail-yw1-f50.google.com with SMTP id j202-v6so5573312ywa.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 14:38:40 -0700 (PDT)
X-Received: by 2002:a81:2953:: with SMTP id p80-v6mr461899ywp.407.1540935520061;
 Tue, 30 Oct 2018 14:38:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 14:38:39
 -0700 (PDT)
In-Reply-To: <20181030155403.GC7343@cisco>
References: <20181029224031.29809-1-tycho@tycho.ws> <20181029224031.29809-2-tycho@tycho.ws>
 <20181030150254.GB3385@redhat.com> <20181030155403.GC7343@cisco>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 30 Oct 2018 14:38:39 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+S+vuMpTObEG+5b8kSJ-4uK9NS_1ZJ5ABZFox0dgD3MA@mail.gmail.com>
Message-ID: <CAGXu5j+S+vuMpTObEG+5b8kSJ-4uK9NS_1ZJ5ABZFox0dgD3MA@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] seccomp: add a return code to trap to userspace
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 8:54 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> On Tue, Oct 30, 2018 at 04:02:54PM +0100, Oleg Nesterov wrote:
>> On 10/29, Tycho Andersen wrote:
>> >
>> > +static long seccomp_notify_recv(struct seccomp_filter *filter,
>> > +                           void __user *buf)
>> > +{
>> > +   struct seccomp_knotif *knotif = NULL, *cur;
>> > +   struct seccomp_notif unotif;
>> > +   ssize_t ret;
>> > +
>> > +   memset(&unotif, 0, sizeof(unotif));
>> > +
>> > +   ret = down_interruptible(&filter->notif->request);
>> > +   if (ret < 0)
>> > +           return ret;
>> > +
>> > +   mutex_lock(&filter->notify_lock);
>> > +   list_for_each_entry(cur, &filter->notif->notifications, list) {
>> > +           if (cur->state == SECCOMP_NOTIFY_INIT) {
>> > +                   knotif = cur;
>> > +                   break;
>> > +           }
>> > +   }
>> > +
>> > +   /*
>> > +    * If we didn't find a notification, it could be that the task was
>> > +    * interrupted by a fatal signal between the time we were woken and
>> > +    * when we were able to acquire the rw lock.
>> > +    *
>> > +    * This is the place where we handle the extra high semaphore count
>> > +    * mentioned in seccomp_do_user_notification().
>> > +    */
>> > +   if (!knotif) {
>> > +           ret = -ENOENT;
>> > +           goto out;
>> > +   }
>> > +
>> > +   unotif.id = knotif->id;
>> > +   unotif.pid = task_pid_vnr(knotif->task);
>> > +   if (knotif->signaled)
>> > +           unotif.flags |= SECCOMP_NOTIF_FLAG_SIGNALED;
>> > +   unotif.data = *(knotif->data);
>>
>> Tycho, I forgot everything about seccomp, most probably I am wrong but let me
>> ask anyway.
>>
>> __seccomp_filter(SECCOMP_RET_TRACE) does
>>
>>               /*
>>                * Recheck the syscall, since it may have changed. This
>>                * intentionally uses a NULL struct seccomp_data to force
>>                * a reload of all registers. This does not goto skip since
>>                * a skip would have already been reported.
>>                */
>>               if (__seccomp_filter(this_syscall, NULL, true))
>>                       return -1;
>>
>> and the next seccomp_run_filters() can return SECCOMP_RET_USER_NOTIF, right?
>> seccomp_do_user_notification() doesn't check recheck_after_trace and it simply
>> does n.data = sd.
>>
>> Doesn't this mean that "unotif.data = *(knotif->data)" can hit NULL ?
>>
>> seccomp_run_filters() does populate_seccomp_data() in this case, but this
>> won't affect "seccomp_data *sd" passed to seccomp_do_user_notification().

Woo, yeah, good catch. :)

> Oof, yes, you're right. Seems like there are no other users of sd in
> __seccomp_filter(). Seems to me like we can just do the
> populate_seccomp_data() one level higher in __seccomp_filter()?

Agreed.

>
> Tycho
>
>
> From 9e0f75ea51a2c328567910df3122a236ebeccab0 Mon Sep 17 00:00:00 2001
> From: Tycho Andersen <tycho@tycho.ws>
> Date: Tue, 30 Oct 2018 09:51:14 -0600
> Subject: [PATCH] seccomp: hoist struct seccomp_data recalculation higher
>
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> ---
>  kernel/seccomp.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 4c5fb6ced4cd..1525cb753ad2 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -257,7 +257,6 @@ static int seccomp_check_filter(struct sock_filter *filter, unsigned int flen)
>  static u32 seccomp_run_filters(const struct seccomp_data *sd,
>                                struct seccomp_filter **match)
>  {
> -       struct seccomp_data sd_local;
>         u32 ret = SECCOMP_RET_ALLOW;
>         /* Make sure cross-thread synced filter points somewhere sane. */
>         struct seccomp_filter *f =
> @@ -267,11 +266,6 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
>         if (unlikely(WARN_ON(f == NULL)))
>                 return SECCOMP_RET_KILL_PROCESS;
>
> -       if (!sd) {
> -               populate_seccomp_data(&sd_local);
> -               sd = &sd_local;
> -       }
> -
>         /*
>          * All filters in the list are evaluated and the lowest BPF return
>          * value always takes priority (ignoring the DATA).
> @@ -821,6 +815,7 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
>         u32 filter_ret, action;
>         struct seccomp_filter *match = NULL;
>         int data;
> +       struct seccomp_data sd_local;
>
>         /*
>          * Make sure that any changes to mode from another thread have
> @@ -828,6 +823,11 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
>          */
>         rmb();
>
> +       if (!sd) {
> +               populate_seccomp_data(&sd_local);
> +               sd = &sd_local;
> +       }
> +
>         filter_ret = seccomp_run_filters(sd, &match);
>         data = filter_ret & SECCOMP_RET_DATA;
>         action = filter_ret & SECCOMP_RET_ACTION_FULL;
> --
> 2.17.1
>

Looks good to me, yes.

-- 
Kees Cook
