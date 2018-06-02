Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbeFBSS3 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 14:18:29 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:32985 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751837AbeFBSS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 14:18:27 -0400
X-Google-Smtp-Source: ADUXVKIaVh8PPkoXKO5E6WTRAOT6t9unlOYH3Cr75ePhwOlEw5mHs8C/pQg7gvidM2yYWbujnJBqqA==
Date: Sat, 2 Jun 2018 12:18:23 -0600
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
Subject: Re: [PATCH v3 4/4] seccomp: add support for passing fds via
 USER_NOTIF
Message-ID: <20180602181823.GC15998@cisco>
References: <20180531144949.24995-1-tycho@tycho.ws>
 <20180531144949.24995-5-tycho@tycho.ws>
 <CAG48ez1WQ5FQXz8=NZ=ahAvte8FK8nSsnMeknMC1wQ=PWKE3dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1WQ5FQXz8=NZ=ahAvte8FK8nSsnMeknMC1wQ=PWKE3dw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jann,

Thanks for taking a look!

On Sat, Jun 02, 2018 at 03:13:39PM +0200, Jann Horn wrote:
> On Sat, Jun 2, 2018 at 2:58 PM Tycho Andersen <tycho@tycho.ws> wrote:
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
> [...]
> > +               fd = get_unused_fd_flags(n.flags);
> 
> Here, you're using n.flags in a context where it will be tested
> against O_CLOEXEC to determine whether the new fd should be
> close-on-exec.
> 
> [...]
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
> > +               }
> 
> But here fd.flags contains the low 2 bits of the return value of
> __fget_light, which are either 0 or FDPUT_FPUT (encoded as 1). This
> flag states whether fdget() took a reference on the file, which is
> mostly equivalent to "is the current process multithreaded?". (This is
> the reason why fdget returns flags and fget doesn't - the flag from
> fdget is to decide whether you'll need an fput(), which is
> unconditional for fget().)

Oof, yes.

> Apart from this issue, I think that in general, it's probably not a
> good idea to copy the close-on-exec flag from the fd in the
> supervising process - the supervising process might want all the fds
> it is working with to be O_CLOEXEC independent of whether the
> supervised process wants an O_CLOEXEC fd. It might make sense to add a
> field for this to struct seccomp_notif_resp instead.

Yes, I wondered about this. In particular, maybe it just makes sense
to pass back the exact flags that the FD should be opened with too, so
if in the future there's some other flag we might want to twiddle, we
don't need another patch. I'll make the change for v4.

Thanks!

Tycho
