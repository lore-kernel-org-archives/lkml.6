Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751766AbeFDAPE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 20:15:04 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:44632 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751716AbeFDAPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 20:15:03 -0400
X-Google-Smtp-Source: ADUXVKJIYdHZq4CNq89ze+1o3blQasoNBFsnvx48VYipj0AEvjcZ/oPYVWHLrD3si7SeLmAr267stA==
Date: Sun, 3 Jun 2018 18:14:59 -0600
From: Tycho Andersen <tycho@tycho.ws>
To: Alban Crequy <alban.crequy@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, christian.brauner@ubuntu.com,
        tyhicks@canonical.com, Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        me@tobin.cc
Subject: Re: [PATCH v3 4/4] seccomp: add support for passing fds via
 USER_NOTIF
Message-ID: <20180604001459.GD15998@cisco>
References: <20180531144949.24995-1-tycho@tycho.ws>
 <20180531144949.24995-5-tycho@tycho.ws>
 <CAMXgnP7cggXh0M403gqWALm0=Cq0JHJiDoE-q++BbL2hCZHX-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMXgnP7cggXh0M403gqWALm0=Cq0JHJiDoE-q++BbL2hCZHX-g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alban,

On Sat, Jun 02, 2018 at 09:14:09PM +0200, Alban Crequy wrote:
> On Thu, 31 May 2018 at 16:52, Tycho Andersen <tycho@tycho.ws> wrote:
> >
> > The idea here is that the userspace handler should be able to pass an fd
> > back to the trapped task, for example so it can be returned from socket().
> >
> > I've proposed one API here, but I'm open to other options. In particular,
> > this only lets you return an fd from a syscall, which may not be enough in
> > all cases. For example, if an fd is written to an output parameter instead
> > of returned, the current API can't handle this. Another case is that
> > netlink takes as input fds sometimes (IFLA_NET_NS_FD, e.g.). If netlink
> > ever decides to install an fd and output it, we wouldn't be able to handle
> > this either.
> >
> > Still, the vast majority of interesting cases are covered by this API, so
> > perhaps it is Enough.
> >
> > I've left it as a separate commit for two reasons:
> >   * It illustrates the way in which we would grow struct seccomp_notif and
> >     struct seccomp_notif_resp without using netlink
> >   * It shows just how little code is needed to accomplish this :)
> >
> > v2: new in v2
> > v3: no changes
> >
> > Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> > CC: Kees Cook <keescook@chromium.org>
> > CC: Andy Lutomirski <luto@amacapital.net>
> > CC: Oleg Nesterov <oleg@redhat.com>
> > CC: Eric W. Biederman <ebiederm@xmission.com>
> > CC: "Serge E. Hallyn" <serge@hallyn.com>
> > CC: Christian Brauner <christian.brauner@ubuntu.com>
> > CC: Tyler Hicks <tyhicks@canonical.com>
> > CC: Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
> > ---
> >  include/uapi/linux/seccomp.h                  |   2 +
> >  kernel/seccomp.c                              |  49 +++++++-
> >  tools/testing/selftests/seccomp/seccomp_bpf.c | 112 ++++++++++++++++++
> >  3 files changed, 161 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> > index 8160e6cad528..3124427219cb 100644
> > --- a/include/uapi/linux/seccomp.h
> > +++ b/include/uapi/linux/seccomp.h
> > @@ -71,6 +71,8 @@ struct seccomp_notif_resp {
> >         __u64 id;
> >         __s32 error;
> >         __s64 val;
> > +       __u8 return_fd;
> > +       __u32 fd;
> >  };
> >
> >  #endif /* _UAPI_LINUX_SECCOMP_H */
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index 6dc99c65c2f4..2ee958b3efde 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -77,6 +77,8 @@ struct seccomp_knotif {
> >         /* The return values, only valid when in SECCOMP_NOTIFY_REPLIED */
> >         int error;
> >         long val;
> > +       struct file *file;
> > +       unsigned int flags;
> >
> >         /* Signals when this has entered SECCOMP_NOTIFY_REPLIED */
> >         struct completion ready;
> > @@ -780,10 +782,32 @@ static void seccomp_do_user_notification(int this_syscall,
> >                         goto remove_list;
> >         }
> >
> > -       ret = n.val;
> > -       err = n.error;
> > +       if (n.file) {
> > +               int fd;
> > +
> > +               fd = get_unused_fd_flags(n.flags);
> > +               if (fd < 0) {
> > +                       err = fd;
> > +                       ret = -1;
> > +                       goto remove_list;
> > +               }
> > +
> > +               ret = fd;
> > +               err = 0;
> > +
> > +               fd_install(fd, n.file);
> > +               /* Don't fput, since fd has a reference now */
> > +               n.file = NULL;
> 
> Do we want the cgroup classid and netprio to be applied here, before
> the fd_install? I am looking at similar code in net/core/scm.c
> scm_detach_fds():
>                 sock = sock_from_file(fp[i], &err);
>                 if (sock) {
>                         sock_update_netprioidx(&sock->sk->sk_cgrp_data);
>                         sock_update_classid(&sock->sk->sk_cgrp_data);
>                 }
> 
> The listener process might live in a different cgroup with a different
> classid & netprio, so it might not be applied as the app might expect.

Thanks, I hadn't really thought about this. I think doing what
SCM_RIGHTS does makes sense -- the operation is essentially the same.

> Also, should we update the struct sock_cgroup_data of the socket, in
> order to make the BPF helper function bpf_skb_under_cgroup() work wrt
> the cgroup of the target process instead of the listener process? I am
> looking at cgroup_sk_alloc(). I don't know what's the correct
> behaviour we want here.

SCM_RIGHTS seems to omit this (I assume you mean the val field of
struct sock_cgroup_data, which seems to be a pointer to struct
cgroup*), any idea why?

> > +       } else {
> > +               ret = n.val;
> > +               err = n.error;
> > +       }
> > +
> >
> >  remove_list:
> > +       if (n.file)
> > +               fput(n.file);
> > +
> >         list_del(&n.list);
> >  out:
> >         mutex_unlock(&match->notify_lock);
> > @@ -1598,6 +1622,27 @@ static ssize_t seccomp_notify_write(struct file *file, const char __user *buf,
> >         knotif->state = SECCOMP_NOTIFY_REPLIED;
> >         knotif->error = resp.error;
> >         knotif->val = resp.val;
> > +
> > +       if (resp.return_fd) {
> > +               struct fd fd;
> > +
> > +               /*
> > +                * This is a little hokey: we need a real fget() (i.e. not
> > +                * __fget_light(), which is what fdget does), but we also need
> > +                * the flags from strcut fd. So, we get it, put it, and get it
> > +                * again for real.
> > +                */
> > +               fd = fdget(resp.fd);
> > +               knotif->flags = fd.flags;
> > +               fdput(fd);
> > +
> > +               knotif->file = fget(resp.fd);
> > +               if (!knotif->file) {
> > +                       ret = -EBADF;
> > +                       goto out;
> 
> Should the "knotif->state = SECCOMP_NOTIFY_REPLIED" and other changes
> be done after the error case here? In case of bad fd, it seems to
> return -EBADF the first time and -EINVAL the next time because the
> state would have been changed to SECCOMP_NOTIFY_REPLIED already.

Yes, good catch, thanks!

Tycho
