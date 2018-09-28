Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE19C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFC42170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MCal4byR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BFC42170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbeI1ImS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:42:18 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:45995 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbeI1ImR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:42:17 -0400
Received: by mail-yb1-f195.google.com with SMTP id d9-v6so1999159ybr.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 19:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GOKsD+KchkBKgT7nKYt8vN7PSnsq+jSh5jm3e7+wpnk=;
        b=MCal4byRTXIKai+bi5VIh3R1hnr287+fnSCdFsttGGiZwRkV7LHJAL9e091vAptRJK
         MzK1H7ObIIQPoKB0XZcb9F3EgAw+46NK3la1ibqO6tV08LtRClFoUe/MIK8/o+KQtuwD
         oJl1vHTXM2OFhHBLzmGolFW//G6V002dE7/tY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GOKsD+KchkBKgT7nKYt8vN7PSnsq+jSh5jm3e7+wpnk=;
        b=XxeaeVuvdrTvErsE64a9Sf77Ex5u5tKlE/B4LZyf2tnEUL+h1sg+6ymKrUIaE90Czb
         t4y1C+APylWssGgfwCGUkm6h6tYk9G9sYNyLfBvw4HaqNc3kNgqJdOg6wSfBKr1xy6bF
         YrNL+Wq7E3QirOdq+2ZBnMjTPQOqWGIRKsHXAqx+EZ++s7TJJNU8sTuewnXAVmzMsABo
         e8fWLtnOCNHmzaZkqHdak4uzSMVSB960j7kopHunMos1DNnV1kWEBZjb8NsqFug8wsNz
         VR1LHp65+j1ciOaRY0eONqY/AHCHARIi5Yck5YJXygjD4VpZueRN5YSswJcLNHxplJba
         muyQ==
X-Gm-Message-State: ABuFfoiLS786y5zp/71D8L0mENAJNFOZGY3a6wOx3cm1uzq3XoYF0kVy
        AL+NghHmNM+LSJI8PMAsmCJCNhSZXaQ=
X-Google-Smtp-Source: ACcGV60ARACp7zMzD7waaW0nSauoh9KklcXaVu8OU3lJOtKprTAwbOCe3UWqjAuROVoyZtrL8/sVgw==
X-Received: by 2002:a25:2d58:: with SMTP id s24-v6mr7497235ybe.347.1538101253800;
        Thu, 27 Sep 2018 19:20:53 -0700 (PDT)
Received: from mail-yw1-f46.google.com (mail-yw1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id b7-v6sm3147888ywe.1.2018.09.27.19.20.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 19:20:52 -0700 (PDT)
Received: by mail-yw1-f46.google.com with SMTP id y14-v6so1997225ywa.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 19:20:51 -0700 (PDT)
X-Received: by 2002:a0d:fec6:: with SMTP id o189-v6mr6906088ywf.237.1538101251463;
 Thu, 27 Sep 2018 19:20:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 19:20:50
 -0700 (PDT)
In-Reply-To: <CAGXu5jLOe0izpGoB8c-hAeH2SzA51dF1BuMcXbk-d=QwqfjxxQ@mail.gmail.com>
References: <20180927151119.9989-1-tycho@tycho.ws> <20180927151119.9989-5-tycho@tycho.ws>
 <CAGXu5jLOe0izpGoB8c-hAeH2SzA51dF1BuMcXbk-d=QwqfjxxQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 27 Sep 2018 19:20:50 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJvkkNNsGj=MK+=Dg0=nauANRkp=b1MrvOOzxkpb+DVkg@mail.gmail.com>
Message-ID: <CAGXu5jJvkkNNsGj=MK+=Dg0=nauANRkp=b1MrvOOzxkpb+DVkg@mail.gmail.com>
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

On Thu, Sep 27, 2018 at 2:59 PM, Kees Cook <keescook@chromium.org> wrote:
> On Thu, Sep 27, 2018 at 8:11 AM, Tycho Andersen <tycho@tycho.ws> wrote:
>> Similar to fd_install/__fd_install, we want to be able to replace an fd of
>> an arbitrary struct files_struct, not just current's. We'll use this in the
>> next patch to implement the seccomp ioctl that allows inserting fds into a
>> stopped process' context.
>>
>> v7: new in v7
>>
>> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
>> CC: Alexander Viro <viro@zeniv.linux.org.uk>
>> CC: Kees Cook <keescook@chromium.org>
>> CC: Andy Lutomirski <luto@amacapital.net>
>> CC: Oleg Nesterov <oleg@redhat.com>
>> CC: Eric W. Biederman <ebiederm@xmission.com>
>> CC: "Serge E. Hallyn" <serge@hallyn.com>
>> CC: Christian Brauner <christian.brauner@ubuntu.com>
>> CC: Tyler Hicks <tyhicks@canonical.com>
>> CC: Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
>> ---
>>  fs/file.c            | 22 +++++++++++++++-------
>>  include/linux/file.h |  8 ++++++++
>>  2 files changed, 23 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/file.c b/fs/file.c
>> index 7ffd6e9d103d..3b3c5aadaadb 100644
>> --- a/fs/file.c
>> +++ b/fs/file.c
>> @@ -850,24 +850,32 @@ __releases(&files->file_lock)
>>  }
>>
>>  int replace_fd(unsigned fd, struct file *file, unsigned flags)
>> +{
>> +       return replace_fd_task(current, fd, file, flags);
>> +}
>> +
>> +/*
>> + * Same warning as __alloc_fd()/__fd_install() here.
>> + */
>> +int replace_fd_task(struct task_struct *task, unsigned fd,
>> +                   struct file *file, unsigned flags)
>>  {
>>         int err;
>> -       struct files_struct *files = current->files;
>
> Same feedback as Jann: on a purely "smaller diff" note, this could
> just be s/current/task/ here and all the other s/files/task->files/
> would go away...
>
>>
>>         if (!file)
>> -               return __close_fd(files, fd);
>> +               return __close_fd(task->files, fd);
>>
>> -       if (fd >= rlimit(RLIMIT_NOFILE))
>> +       if (fd >= task_rlimit(task, RLIMIT_NOFILE))
>>                 return -EBADF;
>>
>> -       spin_lock(&files->file_lock);
>> -       err = expand_files(files, fd);
>> +       spin_lock(&task->files->file_lock);
>> +       err = expand_files(task->files, fd);
>>         if (unlikely(err < 0))
>>                 goto out_unlock;
>> -       return do_dup2(files, file, fd, flags);
>> +       return do_dup2(task->files, file, fd, flags);
>>
>>  out_unlock:
>> -       spin_unlock(&files->file_lock);
>> +       spin_unlock(&task->files->file_lock);
>>         return err;
>>  }
>>
>> diff --git a/include/linux/file.h b/include/linux/file.h
>> index 6b2fb032416c..f94277fee038 100644
>> --- a/include/linux/file.h
>> +++ b/include/linux/file.h
>> @@ -11,6 +11,7 @@
>>  #include <linux/posix_types.h>
>>
>>  struct file;
>> +struct task_struct;
>>
>>  extern void fput(struct file *);
>>
>> @@ -79,6 +80,13 @@ static inline void fdput_pos(struct fd f)
>>
>>  extern int f_dupfd(unsigned int from, struct file *file, unsigned flags);
>>  extern int replace_fd(unsigned fd, struct file *file, unsigned flags);
>> +/*
>> + * Warning! This is only safe if you know the owner of the files_struct is
>> + * stopped outside syscall context. It's a very bad idea to use this unless you
>> + * have similar guarantees in your code.
>> + */
>> +extern int replace_fd_task(struct task_struct *task, unsigned fd,
>> +                          struct file *file, unsigned flags);
>
> Perhaps call this __replace_fd() to indicate the "please don't use
> this unless you're very sure"ness of it?
>
>>  extern void set_close_on_exec(unsigned int fd, int flag);
>>  extern bool get_close_on_exec(unsigned int fd);
>>  extern int get_unused_fd_flags(unsigned flags);
>> --
>> 2.17.1
>>
>
> If I can get an Ack from Al, that would be very nice. :)

In out-of-band feedback from Al, he's pointed out a much cleaner
approach: do the work on the "current" side. i.e. current is stopped
in __seccomp_filter in the case SECCOMP_RET_USER_NOTIFY. Instead of
having the ioctl-handing process doing the work, have it done on the
other side. This may cause some additional complexity on the ioctl
return path, but it solves both this problem and the "ptrace attach"
issue: have the work delayed until "current" gets caught by seccomp.

-Kees

-- 
Kees Cook
Pixel Security
