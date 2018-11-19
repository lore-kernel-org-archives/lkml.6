Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24427C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB8420823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="SBkrYYnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB8420823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbeKTEx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:53:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40860 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730237AbeKTEx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:53:59 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so1970287pfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 10:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6xsBeI9rXl5TQOqbrywUTjH2xgkQnbLNdlLtaEhG5uc=;
        b=SBkrYYnLJxj+pmxV3z1ZSqHXfDC61hJr90HO0FTkVpu1mt7/E6zZzjesgjT3UZD7E/
         9CdrUwzXwA/81G5+6Y5Ku2x0ovcGF8ICHyPdjGy56AwxWLVm+YftKtLbziC0uNhwspUd
         e9DXXwD/oDvw+a4/fxEgH48m/5kIWnB2Gi1D8BE3KDCsH3ilhUsXG2zguqo3s562+YND
         5k13h+GDOIps1BzL33a1AgUZRXojLLwLmjjhGTuOxfaLOj+MZaAmDWkCjzvJlRRQJ8yG
         k80gJVoW7yARJw94aFMBebtFTg3SwiUXZAmeN9qd016ZbaaCA++1Dk2SbRJ/R8/A5Zfg
         3+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6xsBeI9rXl5TQOqbrywUTjH2xgkQnbLNdlLtaEhG5uc=;
        b=Td0MtHu2fy+gdz3FHTSNSp8NEXq2Ex5myucsyN6/xGwiCl5zxTOrhTQ73FLOKqz7p1
         6eT1oR0pBNJN9nfcVyiliwS9qGSLc/ktyZDBVdltSm4ZfInM/kEXoS7H7bt34i6ZNMgP
         6TX7SfY60U27WQgjxoG+uSVgT2dlBfd4zojmm5qSaV+8TIS1NsnwjLu+DTs6wOVRtIix
         3QdhOV9i9n+mBCzcl57kOZ41uZM21njcD7X1RkD2zK75Gmj0m91quLI+2GBfyKYnveFg
         ZKRTDuBx6L5nnD2ITx9HAR7LzWdNPKbEJe86/84+HgXt9pVm7ur4SGQqKT9CdIGHezaZ
         YWLQ==
X-Gm-Message-State: AGRZ1gLnC0X+NZQRd/wFa7ioU3Ck7Pxhl7UmcjL37KaeK1qaMx3ji6o4
        cqFp6n49k7YRS/c6fZ8gCHCfRQ==
X-Google-Smtp-Source: AJdET5dnTaq6kfzxKx4J7OoavCTvMK/ntOHKs3cbYjicpMtWzH+9/MSiBIICB6/FoTvbWgodN/0CyQ==
X-Received: by 2002:a62:1f5a:: with SMTP id f87-v6mr23298299pff.92.1542652154180;
        Mon, 19 Nov 2018 10:29:14 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:9d11:de0b:446c:8485])
        by smtp.gmail.com with ESMTPSA id i4sm38686191pfj.82.2018.11.19.10.29.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 10:29:13 -0800 (PST)
Date:   Mon, 19 Nov 2018 19:29:05 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Daniel Colascione <dancol@google.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
Message-ID: <20181119182902.fadw6qiu3eepndm3@brauner.io>
References: <20181119103241.5229-1-christian@brauner.io>
 <20181119103241.5229-3-christian@brauner.io>
 <CAKOZueshQ2DAwUYp+dLpmfYG6FtvCqeRQxH41SjNS+WqY3e0Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKOZueshQ2DAwUYp+dLpmfYG6FtvCqeRQxH41SjNS+WqY3e0Fw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 07:59:24AM -0800, Daniel Colascione wrote:
> On Mon, Nov 19, 2018 at 2:32 AM, Christian Brauner <christian@brauner.io> wrote:
> > The kill() syscall operates on process identifiers. After a process has
> > exited its pid can be reused by another process. If a caller sends a signal
> > to a reused pid it will end up signaling the wrong process. This issue has
> > often surfaced and there has been a push [1] to address this problem.
> >
> > A prior patch has introduced the ability to get a file descriptor
> > referencing struct pid by opening /proc/<pid>. This guarantees a stable
> > handle on a process which can be used to send signals to the referenced
> > process. Discussion has shown that a dedicated syscall is preferable over
> > ioctl()s. Thus, the  new syscall procfd_signal() is introduced to solve
> > this problem. It operates on a process file descriptor.
> > The syscall takes an additional siginfo_t and flags argument. If siginfo_t
> > is NULL then procfd_signal() behaves like kill() if it is not NULL it
> > behaves like rt_sigqueueinfo.
> > The flags argument is added to allow for future extensions of this syscall.
> > It currently needs to be passed as 0.
> >
> > With this patch a process can be killed via:
> >
> >  #define _GNU_SOURCE
> >  #include <errno.h>
> >  #include <fcntl.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <string.h>
> >  #include <signal.h>
> >  #include <sys/stat.h>
> >  #include <sys/syscall.h>
> >  #include <sys/types.h>
> >  #include <unistd.h>
> >
> >  int main(int argc, char *argv[])
> >  {
> >          int ret;
> >          char buf[1000];
> >
> >          if (argc < 2)
> >                  exit(EXIT_FAILURE);
> >
> >          ret = snprintf(buf, sizeof(buf), "/proc/%s", argv[1]);
> >          if (ret < 0)
> >                  exit(EXIT_FAILURE);
> >
> >          int fd = open(buf, O_DIRECTORY | O_CLOEXEC);
> >          if (fd < 0) {
> >                  printf("%s - Failed to open \"%s\"\n", strerror(errno), buf);
> >                  exit(EXIT_FAILURE);
> >          }
> >
> >          ret = syscall(__NR_procfd_signal, fd, SIGKILL, NULL, 0);
> >          if (ret < 0) {
> >                  printf("Failed to send SIGKILL \"%s\"\n", strerror(errno));
> >                  close(fd);
> >                  exit(EXIT_FAILURE);
> >          }
> >
> >          close(fd);
> >
> >          exit(EXIT_SUCCESS);
> >  }
> >
> > [1]: https://lkml.org/lkml/2018/11/18/130
> >
> > Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> > Cc: Serge Hallyn <serge@hallyn.com>
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Andy Lutomirsky <luto@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: Aleksa Sarai <cyphar@cyphar.com>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Christian Brauner <christian@brauner.io>
> > ---
> > Changelog:
> > v1:
> > - patch introduced
> > ---
> >  arch/x86/entry/syscalls/syscall_32.tbl |  1 +
> >  arch/x86/entry/syscalls/syscall_64.tbl |  1 +
> >  fs/proc/base.c                         |  6 ++
> >  include/linux/proc_fs.h                |  1 +
> >  include/linux/syscalls.h               |  2 +
> >  kernel/signal.c                        | 76 ++++++++++++++++++++++++--
> >  6 files changed, 81 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> > index 3cf7b533b3d1..e637eab883e9 100644
> > --- a/arch/x86/entry/syscalls/syscall_32.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> > @@ -398,3 +398,4 @@
> >  384    i386    arch_prctl              sys_arch_prctl                  __ia32_compat_sys_arch_prctl
> >  385    i386    io_pgetevents           sys_io_pgetevents               __ia32_compat_sys_io_pgetevents
> >  386    i386    rseq                    sys_rseq                        __ia32_sys_rseq
> > +387    i386    procfd_signal           sys_procfd_signal               __ia32_sys_procfd_signal
> > diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> > index f0b1709a5ffb..e95f6741ab42 100644
> > --- a/arch/x86/entry/syscalls/syscall_64.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> > @@ -343,6 +343,7 @@
> >  332    common  statx                   __x64_sys_statx
> >  333    common  io_pgetevents           __x64_sys_io_pgetevents
> >  334    common  rseq                    __x64_sys_rseq
> > +335    common  procfd_signal           __x64_sys_procfd_signal
> >
> >  #
> >  # x32-specific system call numbers start at 512 to avoid cache impact
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index 6365a4fea314..a12c9de92bd0 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -3055,6 +3055,12 @@ static const struct file_operations proc_tgid_base_operations = {
> >         .release        = proc_tgid_release,
> >  };
> >
> > +bool proc_is_procfd(const struct file *file)
> > +{
> > +       return d_is_dir(file->f_path.dentry) &&
> > +              (file->f_op == &proc_tgid_base_operations);
> > +}
> > +
> >  static struct dentry *proc_tgid_base_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
> >  {
> >         return proc_pident_lookup(dir, dentry,
> > diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
> > index d0e1f1522a78..2d53a47fba34 100644
> > --- a/include/linux/proc_fs.h
> > +++ b/include/linux/proc_fs.h
> > @@ -73,6 +73,7 @@ struct proc_dir_entry *proc_create_net_single_write(const char *name, umode_t mo
> >                                                     int (*show)(struct seq_file *, void *),
> >                                                     proc_write_t write,
> >                                                     void *data);
> > +extern bool proc_is_procfd(const struct file *file);
> >
> >  #else /* CONFIG_PROC_FS */
> >
> > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > index 2ac3d13a915b..a5ca8cb84566 100644
> > --- a/include/linux/syscalls.h
> > +++ b/include/linux/syscalls.h
> > @@ -907,6 +907,8 @@ asmlinkage long sys_statx(int dfd, const char __user *path, unsigned flags,
> >                           unsigned mask, struct statx __user *buffer);
> >  asmlinkage long sys_rseq(struct rseq __user *rseq, uint32_t rseq_len,
> >                          int flags, uint32_t sig);
> > +asmlinkage long sys_procfd_signal(int fd, int sig, siginfo_t __user *info,
> > +                                 int flags);
> >
> >  /*
> >   * Architecture-specific system calls
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index 9a32bc2088c9..e8a8929de710 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -19,7 +19,9 @@
> >  #include <linux/sched/task.h>
> >  #include <linux/sched/task_stack.h>
> >  #include <linux/sched/cputime.h>
> > +#include <linux/file.h>
> >  #include <linux/fs.h>
> > +#include <linux/proc_fs.h>
> >  #include <linux/tty.h>
> >  #include <linux/binfmts.h>
> >  #include <linux/coredump.h>
> > @@ -3286,6 +3288,16 @@ COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait, compat_sigset_t __user *, uthese,
> >  }
> >  #endif
> >
> > +static inline void prepare_kill_siginfo(int sig, struct kernel_siginfo *info)
> > +{
> > +       clear_siginfo(info);
> > +       info->si_signo = sig;
> > +       info->si_errno = 0;
> > +       info->si_code = SI_USER;
> > +       info->si_pid = task_tgid_vnr(current);
> > +       info->si_uid = from_kuid_munged(current_user_ns(), current_uid());
> > +}
> > +
> >  /**
> >   *  sys_kill - send a signal to a process
> >   *  @pid: the PID of the process
> > @@ -3295,16 +3307,68 @@ SYSCALL_DEFINE2(kill, pid_t, pid, int, sig)
> >  {
> >         struct kernel_siginfo info;
> >
> > -       clear_siginfo(&info);
> > -       info.si_signo = sig;
> > -       info.si_errno = 0;
> > -       info.si_code = SI_USER;
> > -       info.si_pid = task_tgid_vnr(current);
> > -       info.si_uid = from_kuid_munged(current_user_ns(), current_uid());
> > +       prepare_kill_siginfo(sig, &info);
> >
> >         return kill_something_info(sig, &info, pid);
> >  }
> >
> > +/**
> > + *  sys_procfd_signal - send a signal to a process through a process file
> > + *                      descriptor
> > + *  @fd: the file descriptor of the process
> > + *  @sig: signal to be sent
> > + *  @info: the signal info
> > + *  @flags: future flags to be passed
> > + */
> > +SYSCALL_DEFINE4(procfd_signal, int, fd, int, sig, siginfo_t __user *, info,
> > +               int, flags)
> > +{
> > +       int ret;
> > +       struct pid *pid;
> > +       kernel_siginfo_t kinfo;
> > +       struct fd f;
> > +
> > +       /* Enforce flags be set to 0 until we add an extension. */
> > +       if (flags)
> > +               return -EINVAL;
> > +
> > +       f = fdget_raw(fd);
> > +       if (!f.file)
> > +               return -EBADF;
> > +
> > +       ret = -EINVAL;
> > +       /* Is this a process file descriptor? */
> > +       if (!proc_is_procfd(f.file))
> > +               goto err;
> > +
> > +       pid = f.file->private_data;
> 
> You never addressed my comment on the previous patch about your use of

Sorry, that thread exploded so quickly that I might have missed it.

> private_data here. Why can't you use the struct pid reference that's
> already in the inode?

If that's what people prefer we can probably use that. There was
precedent for stashing away such data in fs/proc/base.c already for
various other things including user namespaces and struct mm so I
followed this model. A prior version of my patch (I didn't send out) did
retrive the inode via proc_pid() in .open() took an additional reference
via get_pid() and dropped it in .release(). Do we prefer that?
