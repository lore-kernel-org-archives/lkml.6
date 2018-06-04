Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbeFDASR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 20:18:17 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:42652 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751444AbeFDASP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 20:18:15 -0400
X-Google-Smtp-Source: ADUXVKLycmwNyf5ghmJ57Uf/wEyr6bsagxsmkZjVO07KrsWGuBGHvgeJhGW3b05/nZodkcDaFn8q1w==
Date: Sun, 3 Jun 2018 18:18:12 -0600
From: Tycho Andersen <tycho@tycho.ws>
To: Jann Horn <jannh@google.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, christian.brauner@ubuntu.com,
        Tyler Hicks <tyhicks@canonical.com>, suda.akihiro@lab.ntt.co.jp,
        "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [PATCH v3 1/4] seccomp: add a return code to trap to userspace
Message-ID: <20180604001812.GE15998@cisco>
References: <20180531144949.24995-1-tycho@tycho.ws>
 <20180531144949.24995-2-tycho@tycho.ws>
 <CAG48ez3x9HSkLZc-da6zjPbckyfdPvwyQa3p9P6EzQ5sGk53eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3x9HSkLZc-da6zjPbckyfdPvwyQa3p9P6EzQ5sGk53eg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jann,

On Sun, Jun 03, 2018 at 08:41:01PM +0200, Jann Horn wrote:
> On Sun, Jun 3, 2018 at 2:29 PM Tycho Andersen <tycho@tycho.ws> wrote:
> >
> > This patch introduces a means for syscalls matched in seccomp to notify
> > some other task that a particular filter has been triggered.
> >
> > The motivation for this is primarily for use with containers. For example,
> > if a container does an init_module(), we obviously don't want to load this
> > untrusted code, which may be compiled for the wrong version of the kernel
> > anyway. Instead, we could parse the module image, figure out which module
> > the container is trying to load and load it on the host.
> >
> > As another example, containers cannot mknod(), since this checks
> > capable(CAP_SYS_ADMIN). However, harmless devices like /dev/null or
> > /dev/zero should be ok for containers to mknod, but we'd like to avoid hard
> > coding some whitelist in the kernel. Another example is mount(), which has
> > many security restrictions for good reason, but configuration or runtime
> > knowledge could potentially be used to relax these restrictions.
> >
> > This patch adds functionality that is already possible via at least two
> > other means that I know about, both of which involve ptrace(): first, one
> > could ptrace attach, and then iterate through syscalls via PTRACE_SYSCALL.
> > Unfortunately this is slow, so a faster version would be to install a
> > filter that does SECCOMP_RET_TRACE, which triggers a PTRACE_EVENT_SECCOMP.
> > Since ptrace allows only one tracer, if the container runtime is that
> > tracer, users inside the container (or outside) trying to debug it will not
> > be able to use ptrace, which is annoying. It also means that older
> > distributions based on Upstart cannot boot inside containers using ptrace,
> > since upstart itself uses ptrace to start services.
> >
> > The actual implementation of this is fairly small, although getting the
> > synchronization right was/is slightly complex.
> >
> > Finally, it's worth noting that the classic seccomp TOCTOU of reading
> > memory data from the task still applies here, but can be avoided with
> > careful design of the userspace handler: if the userspace handler reads all
> > of the task memory that is necessary before applying its security policy,
> > the tracee's subsequent memory edits will not be read by the tracer.
> [...]
> > @@ -857,13 +1020,28 @@ static long seccomp_set_mode_filter(unsigned int flags,
> >         if (IS_ERR(prepared))
> >                 return PTR_ERR(prepared);
> >
> > +       if (flags & SECCOMP_FILTER_FLAG_GET_LISTENER) {
> > +               listener = get_unused_fd_flags(O_RDWR);
> 
> I think you want either 0 or O_CLOEXEC here?

Do we? I suppose it makes sense to be able to set CLOEXEC, but I could
imagine a case where a handler wanted to fork+exec to handle
something. I'm happy to make the change, but it's not obvious to me
that it's what we want by default.

> > +out_put_fd:
> > +       if (flags & SECCOMP_FILTER_FLAG_GET_LISTENER) {
> > +               if (ret < 0) {
> > +                       fput(listener_f);
> > +                       put_unused_fd(listener);
> > +               } else {
> > +                       fd_install(listener, listener_f);
> > +                       ret = listener;
> > +               }
> > +       }
> >  out_free:
> >         seccomp_filter_free(prepared);
> >         return ret;
> [...]
> > +static __poll_t seccomp_notify_poll(struct file *file,
> > +                                   struct poll_table_struct *poll_tab)
> > +{
> > +       struct seccomp_filter *filter = file->private_data;
> > +       __poll_t ret = 0;
> > +       struct seccomp_knotif *cur;
> > +
> > +       ret = mutex_lock_interruptible(&filter->notify_lock);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       list_for_each_entry(cur, &filter->notifications, list) {
> > +               if (cur->state == SECCOMP_NOTIFY_INIT)
> > +                       ret |= EPOLLIN | EPOLLRDNORM;
> > +               if (cur->state == SECCOMP_NOTIFY_SENT)
> > +                       ret |= EPOLLOUT | EPOLLWRNORM;
> > +       }
> > +
> > +       mutex_unlock(&filter->notify_lock);
> > +
> > +       return ret;
> > +}
> 
> I don't think f_op->poll handlers work like this. AFAIK you're
> supposed to use something like poll_wait() to connect the caller to
> something like a waitqueue head, so that as soon as the file becomes
> ready for reading/writing, any waiting task is notified. See
> eventfd_poll() in fs/eventfd.c for a simple example. AFAICS in the
> current code, seccomp_notify_poll() only works if an event is pending
> at the time seccomp_notify_poll() is called.

Arg. I was trying to avoid adding yet another piece of
synchronization, but perhaps it's not possible. Thanks for pointing
this out.

Tycho
