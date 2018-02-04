Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeBDRhC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 12:37:02 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:36576 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbeBDRgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 12:36:54 -0500
X-Google-Smtp-Source: AH8x227yPYbd3TSP8zvVHP4/83xiBL7oJaVtGRE5BZTbXIhvY79htrtkHgUC9OaS//yDsEdSJq4pjWoi+tImz9a3NtA=
MIME-Version: 1.0
In-Reply-To: <20180204104946.25559-2-tycho@tycho.ws>
References: <20180204104946.25559-1-tycho@tycho.ws> <20180204104946.25559-2-tycho@tycho.ws>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sun, 4 Feb 2018 17:36:33 +0000
Message-ID: <CALCETrWgu5n+SMqrsZQ7MVYPtzs8otuc7hpA5uPH+JNtFrMBkQ@mail.gmail.com>
Subject: Re: [RFC 1/3] seccomp: add a return code to trap to userspace
To: Tycho Andersen <tycho@tycho.ws>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 4, 2018 at 10:49 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> This patch introduces a means for syscalls matched in seccomp to notify
> some other task that a particular filter has been triggered.

Neat!

>
> The motivation for this is primarily for use with containers. For example,
> if a container does an init_module(), we obviously don't want to load this
> untrusted code, which may be compiled for the wrong version of the kernel
> anyway. Instead, we could parse the module image, figure out which module
> the container is trying to load and load it on the host.
>
> As another example, containers cannot mknod(), since this checks
> capable(CAP_SYS_ADMIN). However, harmless devices like /dev/null or
> /dev/zero should be ok for containers to mknod, but we'd like to avoid hard
> coding some whitelist in the kernel. Another example is mount(), which has
> many security restrictions for good reason, but configuration or runtime
> knowledge could potentially be used to relax these restrictions.
>
> This patch adds functionality that is already possible via at least two
> other means that I know about, both of which involve ptrace(): first, one
> could ptrace attach, and then iterate through syscalls via PTRACE_SYSCALL.
> Unfortunately this is slow, so a faster version would be to install a
> filter that does SECCOMP_RET_TRACE, which triggers a PTRACE_EVENT_SECCOMP.
> Since ptrace allows only one tracer, if the container runtime is that
> tracer, users inside the container (or outside) trying to debug it will not
> be able to use ptrace, which is annoying. It also means that older
> distributions based on Upstart cannot boot inside containers using ptrace,
> since upstart itself uses ptrace to start services.
>
> The actual implementation of this is fairly small, although getting the
> synchronization right was/is slightly complex. Also worth noting that there
> is one race still present:
>
>   1. a task does a SECCOMP_RET_USER_NOTIF
>   2. the userspace handler reads this notification
>   3. the task dies
>   4. a new task with the same pid starts
>   5. this new task does a SECCOMP_RET_USER_NOTIF, gets the same cookie id
>      that the previous one did
>   6. the userspace handler writes a response

I'm slightly confused.  I thought the id was never reused for a given
struct seccomp_filter.  (Also, shouldn't the id be u64, not u32?)

On very quick reading, I have a question.  What happens if a process
has two seccomp_filters attached, one of them returns
SECCOMP_RET_USER_NOTIF, and the *other* one has a listener?
