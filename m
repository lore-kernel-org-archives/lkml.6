Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3321AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47CF216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XF3HPeMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47CF216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeI1EUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:20:21 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41168 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbeI1EUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:20:21 -0400
Received: by mail-yw1-f65.google.com with SMTP id q129-v6so1761046ywg.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 14:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uKm4Kn+b+pUCf8ULPQsruKbGWiHJza1ikJkZfOlwobQ=;
        b=XF3HPeMVgP8PNaMXVJ8HixzH1ow8UT6HJfhdWKXHrtecCs2f8i+MtFBfekJZHmx59U
         v687oQvZb/YrcFQJWXz2yL7lpqRknPYjbkm6TpYdzp6cJ8Ijzyrbt8nAW7wu5/MohoHl
         amSgfzlOUt4C7kXCDr0+Dx0RkXY3mBbdYkPds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uKm4Kn+b+pUCf8ULPQsruKbGWiHJza1ikJkZfOlwobQ=;
        b=NRNj9TftAI7za9MyYujkFXbf7CubcGtbSjVvarBh4XbQZrFxQ5JEFUsF/Tr+QGtf6o
         qXMA/xrEgyH17wm5T0RlD5DE1nCxaxVePdW8CgtSPzYg5ZExLNd/Hww+JeNL0/3NKNOT
         K7aS6v2uZ+w6YIh9NeKqSvQoH0hXJ7YSykAJRq1PxEDdEmHHpUFrTqPV4lkjbx37FRSF
         nenidxGsHaraAkgaW8v/cBme+XhfusdgRH4QCqiAe35j6tKrnDn/EU2MX9I9yKbQJ2yb
         i6lHteiV4dmqagJkXckMdnMk4teTpv/L2ycavIVfcdASA9bUIBjokf9wNAcGE099pqI3
         htVA==
X-Gm-Message-State: ABuFfoiuLl1LrpP4tpwjerBJttEM28B6pOTvH2ZSR4jfBEd5kJmC7dOr
        nZ788ppogqnbyEK/M3L9uVNN0uf1Z2I=
X-Google-Smtp-Source: ACcGV62b0R66HWZ5HYmSYyL8d8zL0x49CCNuKqmagAL9g9WpPGl/9SniFnTNmAlAgPjnJGlU4fFCdQ==
X-Received: by 2002:a81:8302:: with SMTP id t2-v6mr6725518ywf.428.1538085596194;
        Thu, 27 Sep 2018 14:59:56 -0700 (PDT)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id u143-v6sm4091027ywc.28.2018.09.27.14.59.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 14:59:54 -0700 (PDT)
Received: by mail-yw1-f48.google.com with SMTP id j131-v6so1745026ywc.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 14:59:54 -0700 (PDT)
X-Received: by 2002:a81:98d7:: with SMTP id p206-v6mr6850445ywg.353.1538085594006;
 Thu, 27 Sep 2018 14:59:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 14:59:53
 -0700 (PDT)
In-Reply-To: <20180927151119.9989-5-tycho@tycho.ws>
References: <20180927151119.9989-1-tycho@tycho.ws> <20180927151119.9989-5-tycho@tycho.ws>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 27 Sep 2018 14:59:53 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLOe0izpGoB8c-hAeH2SzA51dF1BuMcXbk-d=QwqfjxxQ@mail.gmail.com>
Message-ID: <CAGXu5jLOe0izpGoB8c-hAeH2SzA51dF1BuMcXbk-d=QwqfjxxQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/6] files: add a replace_fd_files() function
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Jann Horn <jannh@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 8:11 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> Similar to fd_install/__fd_install, we want to be able to replace an fd of
> an arbitrary struct files_struct, not just current's. We'll use this in the
> next patch to implement the seccomp ioctl that allows inserting fds into a
> stopped process' context.
>
> v7: new in v7
>
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> CC: Alexander Viro <viro@zeniv.linux.org.uk>
> CC: Kees Cook <keescook@chromium.org>
> CC: Andy Lutomirski <luto@amacapital.net>
> CC: Oleg Nesterov <oleg@redhat.com>
> CC: Eric W. Biederman <ebiederm@xmission.com>
> CC: "Serge E. Hallyn" <serge@hallyn.com>
> CC: Christian Brauner <christian.brauner@ubuntu.com>
> CC: Tyler Hicks <tyhicks@canonical.com>
> CC: Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
> ---
>  fs/file.c            | 22 +++++++++++++++-------
>  include/linux/file.h |  8 ++++++++
>  2 files changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/fs/file.c b/fs/file.c
> index 7ffd6e9d103d..3b3c5aadaadb 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -850,24 +850,32 @@ __releases(&files->file_lock)
>  }
>
>  int replace_fd(unsigned fd, struct file *file, unsigned flags)
> +{
> +       return replace_fd_task(current, fd, file, flags);
> +}
> +
> +/*
> + * Same warning as __alloc_fd()/__fd_install() here.
> + */
> +int replace_fd_task(struct task_struct *task, unsigned fd,
> +                   struct file *file, unsigned flags)
>  {
>         int err;
> -       struct files_struct *files = current->files;

Same feedback as Jann: on a purely "smaller diff" note, this could
just be s/current/task/ here and all the other s/files/task->files/
would go away...

>
>         if (!file)
> -               return __close_fd(files, fd);
> +               return __close_fd(task->files, fd);
>
> -       if (fd >= rlimit(RLIMIT_NOFILE))
> +       if (fd >= task_rlimit(task, RLIMIT_NOFILE))
>                 return -EBADF;
>
> -       spin_lock(&files->file_lock);
> -       err = expand_files(files, fd);
> +       spin_lock(&task->files->file_lock);
> +       err = expand_files(task->files, fd);
>         if (unlikely(err < 0))
>                 goto out_unlock;
> -       return do_dup2(files, file, fd, flags);
> +       return do_dup2(task->files, file, fd, flags);
>
>  out_unlock:
> -       spin_unlock(&files->file_lock);
> +       spin_unlock(&task->files->file_lock);
>         return err;
>  }
>
> diff --git a/include/linux/file.h b/include/linux/file.h
> index 6b2fb032416c..f94277fee038 100644
> --- a/include/linux/file.h
> +++ b/include/linux/file.h
> @@ -11,6 +11,7 @@
>  #include <linux/posix_types.h>
>
>  struct file;
> +struct task_struct;
>
>  extern void fput(struct file *);
>
> @@ -79,6 +80,13 @@ static inline void fdput_pos(struct fd f)
>
>  extern int f_dupfd(unsigned int from, struct file *file, unsigned flags);
>  extern int replace_fd(unsigned fd, struct file *file, unsigned flags);
> +/*
> + * Warning! This is only safe if you know the owner of the files_struct is
> + * stopped outside syscall context. It's a very bad idea to use this unless you
> + * have similar guarantees in your code.
> + */
> +extern int replace_fd_task(struct task_struct *task, unsigned fd,
> +                          struct file *file, unsigned flags);

Perhaps call this __replace_fd() to indicate the "please don't use
this unless you're very sure"ness of it?

>  extern void set_close_on_exec(unsigned int fd, int flag);
>  extern bool get_close_on_exec(unsigned int fd);
>  extern int get_unused_fd_flags(unsigned flags);
> --
> 2.17.1
>

If I can get an Ack from Al, that would be very nice. :)

-Kees

-- 
Kees Cook
Pixel Security
