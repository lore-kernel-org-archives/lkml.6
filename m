Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459AEC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC908216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CxFnisGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC908216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbeI0XIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:08:37 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44821 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbeI0XIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:08:37 -0400
Received: by mail-ot1-f66.google.com with SMTP id 36-v6so3195806oth.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 09:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d9X4YzW9YoeyCfTShjmLmkNpl6sPgnkTvAOSusxYv14=;
        b=CxFnisGjUiy/gYTFqiv/1wOMr+5ES6qdetcxLuglSowVrw+elhEf4AwAgymb0URLRD
         W0p05a3fco4ykS4mShLSadMYvcX37L46PIokFRuNSwbDp6Qr58X8Dxi5HypfLUTmPgMc
         XH7YzLAmafizNWh9qv3MVexEmKMBir7R8ogarH7Z1QFnYmAySD/MBQMbW0Un06Luirlf
         9Qi8zpNPCFMjAFMYrr7eMvUXp0rGSQVcdVRQ/uponVJW7ar5SIx8TNXuXj6Fpy7r4Yua
         WGtC+hiUtXVGMYGQtSO8q5HoiW7vhxGvRwpGmRgcyJP8L3xYVoBhLgIvJAgzLjGmyHzZ
         behA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d9X4YzW9YoeyCfTShjmLmkNpl6sPgnkTvAOSusxYv14=;
        b=X3MffiWl97FqPeI0r6lqU9Dcy8890nUGEEx/d8mVif2Tn4cbhk8miZ/Au32Z9Bz3oD
         dfSw953kQ6lu3EWGYHAP0F1Tz1+PlW2I81ZzXck4ju7hTLtoEft0g68Gw20/eA8IVHDW
         x51crctKnbhdf0y+iRjnpGp3CvJAvA4Ytew/FynGz0/MRU1AOq8hPbhWWpWDO91x8eEq
         mBwgLpCnQhAQRi3bDNJByVfD9CHKF1B4Suzxs+0AS45iXNsZJem46kx/oZZhpswvPLhB
         waemVpaVg67UY4IuEWeknUDcS7/llgdw4o7cpbcWv1tKFSLS5xAkwSeKLenvwlIFmkHb
         xlWg==
X-Gm-Message-State: ABuFfoieMVvH8ZTLDepV0DIyjJ90GaR9mJ5ua617k24GqR7DiVZW5zQ7
        TOct+Q2BzOlQjoKY85CBf1XxjGu/wctB3+YK04J3cg==
X-Google-Smtp-Source: ACcGV60Oz2VylcMNkEghcHrBqQ+2YZMKHWXn9il/eimzg3/DtjPJZ0dL4UrRDUiiVVBxQudLmpD5Gjh7PpB5H1CbxA4=
X-Received: by 2002:a9d:4e94:: with SMTP id v20-v6mr7631084otk.255.1538066968797;
 Thu, 27 Sep 2018 09:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180927151119.9989-1-tycho@tycho.ws> <20180927151119.9989-5-tycho@tycho.ws>
In-Reply-To: <20180927151119.9989-5-tycho@tycho.ws>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 27 Sep 2018 18:49:02 +0200
Message-ID: <CAG48ez1eU_j_Ti0nRh05Qv6hv7-7hv5i+8gnJS5e30mTti2Jhg@mail.gmail.com>
Subject: Re: [PATCH v7 4/6] files: add a replace_fd_files() function
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        suda.akihiro@lab.ntt.co.jp, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 5:11 PM Tycho Andersen <tycho@tycho.ws> wrote:
> Similar to fd_install/__fd_install, we want to be able to replace an fd of
> an arbitrary struct files_struct, not just current's. We'll use this in the
> next patch to implement the seccomp ioctl that allows inserting fds into a
> stopped process' context.
[...]
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

Why did you remove this? You could just do s/current/task/ instead, right?

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

I think Linux kernel coding style is normally to have comments on the
implementations of functions, not in the headers? Maybe replace the
warning above the implemenation of replace_fd_task() with this
comment.
