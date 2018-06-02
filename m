Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751603AbeFBNNx (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 09:13:53 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:44682 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeFBNNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 09:13:51 -0400
X-Google-Smtp-Source: ADUXVKJNdWnK9eipVeVTTCNp3U//sBhKf4/SylK7Gm7tJ5zicr21XWPYWA2Jbli5/GzRao6hOdmIJCMnP090u/JTvSE=
MIME-Version: 1.0
References: <20180531144949.24995-1-tycho@tycho.ws> <20180531144949.24995-5-tycho@tycho.ws>
In-Reply-To: <20180531144949.24995-5-tycho@tycho.ws>
From: Jann Horn <jannh@google.com>
Date: Sat, 2 Jun 2018 15:13:39 +0200
Message-ID: <CAG48ez1WQ5FQXz8=NZ=ahAvte8FK8nSsnMeknMC1wQ=PWKE3dw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] seccomp: add support for passing fds via USER_NOTIF
To: tycho@tycho.ws
Cc: kernel list <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, christian.brauner@ubuntu.com,
        Tyler Hicks <tyhicks@canonical.com>, suda.akihiro@lab.ntt.co.jp,
        "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 2, 2018 at 2:58 PM Tycho Andersen <tycho@tycho.ws> wrote:
> The idea here is that the userspace handler should be able to pass an fd
> back to the trapped task, for example so it can be returned from socket().
>
> I've proposed one API here, but I'm open to other options. In particular,
> this only lets you return an fd from a syscall, which may not be enough in
> all cases. For example, if an fd is written to an output parameter instead
> of returned, the current API can't handle this. Another case is that
> netlink takes as input fds sometimes (IFLA_NET_NS_FD, e.g.). If netlink
> ever decides to install an fd and output it, we wouldn't be able to handle
> this either.
>
> Still, the vast majority of interesting cases are covered by this API, so
> perhaps it is Enough.
>
> I've left it as a separate commit for two reasons:
>   * It illustrates the way in which we would grow struct seccomp_notif and
>     struct seccomp_notif_resp without using netlink
>   * It shows just how little code is needed to accomplish this :)
[...]
> +               fd = get_unused_fd_flags(n.flags);

Here, you're using n.flags in a context where it will be tested
against O_CLOEXEC to determine whether the new fd should be
close-on-exec.

[...]
> +               /*
> +                * This is a little hokey: we need a real fget() (i.e. not
> +                * __fget_light(), which is what fdget does), but we also need
> +                * the flags from strcut fd. So, we get it, put it, and get it
> +                * again for real.
> +                */
> +               fd = fdget(resp.fd);
> +               knotif->flags = fd.flags;
> +               fdput(fd);
> +
> +               knotif->file = fget(resp.fd);
> +               if (!knotif->file) {
> +                       ret = -EBADF;
> +                       goto out;
> +               }

But here fd.flags contains the low 2 bits of the return value of
__fget_light, which are either 0 or FDPUT_FPUT (encoded as 1). This
flag states whether fdget() took a reference on the file, which is
mostly equivalent to "is the current process multithreaded?". (This is
the reason why fdget returns flags and fget doesn't - the flag from
fdget is to decide whether you'll need an fput(), which is
unconditional for fget().)

Apart from this issue, I think that in general, it's probably not a
good idea to copy the close-on-exec flag from the fd in the
supervising process - the supervising process might want all the fds
it is working with to be O_CLOEXEC independent of whether the
supervised process wants an O_CLOEXEC fd. It might make sense to add a
field for this to struct seccomp_notif_resp instead.
