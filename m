Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF53C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21BF2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XkcW+YmP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfALSgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 13:36:48 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38834 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfALSgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 13:36:47 -0500
Received: by mail-ua1-f67.google.com with SMTP id p9so5795815uaa.5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 10:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N+2nUVDOHGycsD0liXCBjsCmBJu5kZfTKeMx8kQh4n8=;
        b=XkcW+YmPwFllIyGDzl3EXryZNOJnaEA2eECEYjp7fcUXkFWOhEGjrGF/cll/FVbf8q
         3GJ56BNl6j708KbWwc9bvvvdRduFxMiL8bNKXP6yYWpbBZGPjynHTFVWcVPjMZLRj6PI
         SZRvXNTWkEARPsyNilt5bHPk1haoMTxSjMDnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N+2nUVDOHGycsD0liXCBjsCmBJu5kZfTKeMx8kQh4n8=;
        b=B+2Sipq5y/CvwLmzguKMUZyemjtMfYZdul/7o3GKebxdea6shEDY1Ja/DXmeVEWZXK
         FgZUiINvzG6JNYpPHRVx7L5BQKc/UM/EDooVAAvaIkIkkLRRZZQZD4Bpb//JqqmHpTxV
         k5AYfQjCYvzeqVrqRcyyi7DLkx7/pPJvbS4ZW/miQnD2aI73S1ZCPoVhQYKKH8O6AbY0
         B3+VMIyvhkevBqHeJpOtL3phc3znNZyuxFxH4SNTlsUErjo2nGqDk2Xgh0pxzTNrRGkc
         qjpA19uZkARSHJelIbGAEgIR/4QqumYixVKKuPiORkUvnpb+E4RxZDjwYI5L+Yfjqrn5
         knsg==
X-Gm-Message-State: AJcUukduNLI1cztTO9mv52sZ1SrQ/VoCcGL2K7IQFcFI3a+AyPOgx0fz
        KJcFFg+QXorkNFXKm7+7HznBBECbml0=
X-Google-Smtp-Source: ALg8bN5VWwevPhga5lhwms5z/lh4eSc2sfyvxEIkVWsX1lTKDcZnAFmftjG1dYmp0rfqEc0YNZqF/Q==
X-Received: by 2002:ab0:30b7:: with SMTP id b23mr7147896uam.109.1547318206779;
        Sat, 12 Jan 2019 10:36:46 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id e67sm43594943vsd.32.2019.01.12.10.36.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 10:36:45 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id v24so5788424uap.13
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 10:36:45 -0800 (PST)
X-Received: by 2002:ab0:645:: with SMTP id f63mr2040025uaf.106.1547318205051;
 Sat, 12 Jan 2019 10:36:45 -0800 (PST)
MIME-Version: 1.0
References: <CAGXu5j+9ETYcavj2x3Up0FhvkopZohbJcS4CMvrrCWOwDurSFw@mail.gmail.com>
 <20190112182420.4669-1-tycho@tycho.ws>
In-Reply-To: <20190112182420.4669-1-tycho@tycho.ws>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 12 Jan 2019 10:36:33 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJKeO_-Vy5sffQugBKy4z1W7KGwUAySz=MN9ZvMsYqKFw@mail.gmail.com>
Message-ID: <CAGXu5jJKeO_-Vy5sffQugBKy4z1W7KGwUAySz=MN9ZvMsYqKFw@mail.gmail.com>
Subject: Re: [PATCH] seccomp: fix UAF in user-trap code
To:     Tycho Andersen <tycho@tycho.ws>, James Morris <jmorris@namei.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+981c26489b2d1c6316ba@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 10:24 AM Tycho Andersen <tycho@tycho.ws> wrote:
>
> On the failure path, we do an fput() of the listener fd if the filter fails
> to install (e.g. because of a TSYNC race that's lost, or if the thread is
> killed, etc.). fput() doesn't actually release the fd, it just ads it to a
> work queue. Then the thread proceeds to free the filter, even though the
> listener struct file has a reference to it.
>
> To fix this, on the failure path let's set the private data to null, so we
> know in ->release() to ignore the filter.
>
> Reported-by: syzbot+981c26489b2d1c6316ba@syzkaller.appspotmail.com
> Fixes: 6a21cc50f0c7 ("seccomp: add a return code to trap to userspace")
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> ---
> This is a little ugly, but I can't really think of a better way (other than
> force freeing, but the fput function that does the actual work is declared
> static with four underscores :).

This makes sense to me. Thanks for fixing it!

Acked-by: Kees Cook <keescook@chromium.org>

James, can you add this to your fixes tree for sending to Linus?

-Kees

> ---
>  kernel/seccomp.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index d7f538847b84..e815781ed751 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -976,6 +976,9 @@ static int seccomp_notify_release(struct inode *inode, struct file *file)
>         struct seccomp_filter *filter = file->private_data;
>         struct seccomp_knotif *knotif;
>
> +       if (!filter)
> +               return 0;
> +
>         mutex_lock(&filter->notify_lock);
>
>         /*
> @@ -1300,6 +1303,7 @@ static long seccomp_set_mode_filter(unsigned int flags,
>  out_put_fd:
>         if (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER) {
>                 if (ret < 0) {
> +                       listener_f->private_data = NULL;
>                         fput(listener_f);
>                         put_unused_fd(listener);
>                 } else {
> --
> 2.19.1
>


-- 
Kees Cook
