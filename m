Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F9BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54A2216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I9kOCIYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54A2216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeI1EcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:32:00 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:39981 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbeI1Eb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:31:59 -0400
Received: by mail-yb1-f195.google.com with SMTP id w7-v6so1807328ybm.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 15:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Est+QkEFve4zrOJwco5qdie7uvfHUjsH10A0Aki51QA=;
        b=I9kOCIYsnWZSQ+VJoPFQ3c/GpAzV6zjwWS+U9mN5uIFS1QYADIC+kbbnpENFqhkxis
         0ux9HrZ5WSX7POT/SoTS2RgkpCzkjNQvpto1dMusRqqZ9MzPCupQYgludhqUY8nvq0jO
         oZnJ/8cp9Rrfu0xHHvCBOhtxQL1WYsGwaMQgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Est+QkEFve4zrOJwco5qdie7uvfHUjsH10A0Aki51QA=;
        b=MqdTSpW0UK+G5i0HB10NqCKaKuejHpHr0AaC63NC7wqS1WtfqRbPGPvuKlbD8SK+8u
         Dy+WKDpjIddxNMXBvSmG66a42wlYelRew3gDVA+b0hrXIb3xatOuHagQ9DFRRFW4EjhW
         uFUbycEpVtPDkmRHtwYacKJNP7DsJ9yV6ezdbpt61w+qMCJfn38phSjRqlLrI+Y3oEFg
         PbO0i3x16f530XZBiY0Wh3pj0/m8e4vrGe/cxv+Md7mgZlJz5Z50syyymyooJAHSzMy4
         5SbmBO8+fSZF8LWZw4LKF8AjgS/UTlOoxrNHtVPyU+0ekql5M74QRcD71B+P2El/Plj4
         v8eA==
X-Gm-Message-State: ABuFfoi5zFqsjvIVDYsM9JwH1aHLHuLg4mWHnpl+jEW2POw9gmEdNglX
        GnhDigYkn9SVjzOK2YjrMPy5fPGdUIw=
X-Google-Smtp-Source: ACcGV63Mfw8IslM1suDpf3/kKGg9OrQVoMXdj5Y583UTvcWyl8zbqoERfu792vpatH8+cEOgz6coBg==
X-Received: by 2002:a25:be0f:: with SMTP id h15-v6mr7122614ybk.241.1538086292211;
        Thu, 27 Sep 2018 15:11:32 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id b7-v6sm2105830ywe.1.2018.09.27.15.11.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 15:11:29 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id w80-v6so1796846ybe.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 15:11:28 -0700 (PDT)
X-Received: by 2002:a25:19c3:: with SMTP id 186-v6mr7051478ybz.410.1538086288195;
 Thu, 27 Sep 2018 15:11:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 15:11:27
 -0700 (PDT)
In-Reply-To: <20180927151119.9989-7-tycho@tycho.ws>
References: <20180927151119.9989-1-tycho@tycho.ws> <20180927151119.9989-7-tycho@tycho.ws>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 27 Sep 2018 15:11:27 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJG0RNPabcuiRa7g3xU+mDjXj6qjQCNrKcOooEfCy2aCg@mail.gmail.com>
Message-ID: <CAGXu5jJG0RNPabcuiRa7g3xU+mDjXj6qjQCNrKcOooEfCy2aCg@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] samples: add an example of seccomp user trap
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
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 8:11 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> The idea here is just to give a demonstration of how one could safely use
> the SECCOMP_RET_USER_NOTIF feature to do mount policies. This particular
> policy is (as noted in the comment) not very interesting, but it serves to
> illustrate how one might apply a policy dodging the various TOCTOU issues.
>
> v5: new in v5
> v7: updates for v7 API changes
>
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> CC: Kees Cook <keescook@chromium.org>
> CC: Andy Lutomirski <luto@amacapital.net>
> CC: Oleg Nesterov <oleg@redhat.com>
> CC: Eric W. Biederman <ebiederm@xmission.com>
> CC: "Serge E. Hallyn" <serge@hallyn.com>
> CC: Christian Brauner <christian.brauner@ubuntu.com>
> CC: Tyler Hicks <tyhicks@canonical.com>
> CC: Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
> ---
>  samples/seccomp/.gitignore  |   1 +
>  samples/seccomp/Makefile    |   7 +-
>  samples/seccomp/user-trap.c | 312 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 319 insertions(+), 1 deletion(-)
>
> diff --git a/samples/seccomp/.gitignore b/samples/seccomp/.gitignore
> index 78fb78184291..d1e2e817d556 100644
> --- a/samples/seccomp/.gitignore
> +++ b/samples/seccomp/.gitignore
> @@ -1,3 +1,4 @@
>  bpf-direct
>  bpf-fancy
>  dropper
> +user-trap
> diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
> index cf34ff6b4065..4920903c8009 100644
> --- a/samples/seccomp/Makefile
> +++ b/samples/seccomp/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  ifndef CROSS_COMPILE
> -hostprogs-$(CONFIG_SAMPLE_SECCOMP) := bpf-fancy dropper bpf-direct
> +hostprogs-$(CONFIG_SAMPLE_SECCOMP) := bpf-fancy dropper bpf-direct user-trap
>
>  HOSTCFLAGS_bpf-fancy.o += -I$(objtree)/usr/include
>  HOSTCFLAGS_bpf-fancy.o += -idirafter $(objtree)/include
> @@ -16,6 +16,10 @@ HOSTCFLAGS_bpf-direct.o += -I$(objtree)/usr/include
>  HOSTCFLAGS_bpf-direct.o += -idirafter $(objtree)/include
>  bpf-direct-objs := bpf-direct.o
>
> +HOSTCFLAGS_user-trap.o += -I$(objtree)/usr/include
> +HOSTCFLAGS_user-trap.o += -idirafter $(objtree)/include
> +user-trap-objs := user-trap.o
> +
>  # Try to match the kernel target.
>  ifndef CONFIG_64BIT
>
> @@ -33,6 +37,7 @@ HOSTCFLAGS_bpf-fancy.o += $(MFLAG)
>  HOSTLDLIBS_bpf-direct += $(MFLAG)
>  HOSTLDLIBS_bpf-fancy += $(MFLAG)
>  HOSTLDLIBS_dropper += $(MFLAG)
> +HOSTLDLIBS_user-trap += $(MFLAG)
>  endif
>  always := $(hostprogs-m)
>  endif
> diff --git a/samples/seccomp/user-trap.c b/samples/seccomp/user-trap.c
> new file mode 100644
> index 000000000000..63c9a5994dc1
> --- /dev/null
> +++ b/samples/seccomp/user-trap.c
> @@ -0,0 +1,312 @@
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <string.h>
> +#include <stddef.h>
> +#include <sys/sysmacros.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <sys/socket.h>
> +#include <sys/stat.h>
> +#include <sys/mman.h>
> +#include <sys/syscall.h>
> +#include <sys/user.h>
> +#include <sys/ioctl.h>
> +#include <sys/ptrace.h>
> +#include <sys/mount.h>
> +#include <linux/limits.h>
> +#include <linux/filter.h>
> +#include <linux/seccomp.h>
> +
> +/*
> + * Because of some grossness, we can't include linux/ptrace.h here, so we
> + * re-define PTRACE_SECCOMP_NEW_LISTENER.
> + */
> +#ifndef PTRACE_SECCOMP_NEW_LISTENER
> +#define PTRACE_SECCOMP_NEW_LISTENER    0x420e
> +#endif
> +
> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
> +
> +static int seccomp(unsigned int op, unsigned int flags, void *args)
> +{
> +       errno = 0;
> +       return syscall(__NR_seccomp, op, flags, args);
> +}
> +
> +static int user_trap_syscall(int nr, unsigned int flags)
> +{
> +       struct sock_filter filter[] = {
> +               BPF_STMT(BPF_LD+BPF_W+BPF_ABS,
> +                       offsetof(struct seccomp_data, nr)),
> +               BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, nr, 0, 1),
> +               BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_USER_NOTIF),
> +               BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_ALLOW),
> +       };
> +
> +       struct sock_fprog prog = {
> +               .len = (unsigned short)ARRAY_SIZE(filter),
> +               .filter = filter,
> +       };
> +
> +       return seccomp(SECCOMP_SET_MODE_FILTER, flags, &prog);
> +}
> +
> +static int handle_req(struct seccomp_notif *req,
> +                     struct seccomp_notif_resp *resp, int listener)
> +{
> +       char path[PATH_MAX], source[PATH_MAX], target[PATH_MAX];
> +       int ret = -1, mem;
> +
> +       resp->len = sizeof(*resp);
> +       resp->id = req->id;
> +       resp->error = -EPERM;
> +       resp->val = 0;
> +
> +       if (req->data.nr != __NR_mount) {
> +               fprintf(stderr, "huh? trapped something besides mknod? %d\n", req->data.nr);
> +               return -1;
> +       }
> +
> +       /* Only allow bind mounts. */
> +       if (!(req->data.args[3] & MS_BIND))
> +               return 0;
> +
> +       /*
> +        * Ok, let's read the task's memory to see where they wanted their
> +        * mount to go.
> +        */
> +       snprintf(path, sizeof(path), "/proc/%d/mem", req->pid);
> +       mem = open(path, O_RDONLY);
> +       if (mem < 0) {
> +               perror("open mem");
> +               return -1;
> +       }
> +
> +       /*
> +        * Now we avoid a TOCTOU: we referred to a pid by its pid, but since
> +        * the pid that made the syscall may have died, we need to confirm that
> +        * the pid is still valid after we open its /proc/pid/mem file. We can
> +        * ask the listener fd this as follows.
> +        *
> +        * Note that this check should occur *after* any task-specific
> +        * resources are opened, to make sure that the task has not died and
> +        * we're not wrongly reading someone else's state in order to make
> +        * decisions.
> +        */
> +       if (ioctl(listener, SECCOMP_NOTIF_ID_VALID, &req->id) < 0) {
> +               fprintf(stderr, "task died before we could map its memory\n");
> +               goto out;
> +       }
> +
> +       /*
> +        * Phew, we've got the right /proc/pid/mem. Now we can read it. Note
> +        * that to avoid another TOCTOU, we should read all of the pointer args
> +        * before we decide to allow the syscall.
> +        */
> +       if (lseek(mem, req->data.args[0], SEEK_SET) < 0) {
> +               perror("seek");
> +               goto out;
> +       }
> +
> +       ret = read(mem, source, sizeof(source));
> +       if (ret < 0) {
> +               perror("read");
> +               goto out;
> +       }
> +
> +       if (lseek(mem, req->data.args[1], SEEK_SET) < 0) {
> +               perror("seek");
> +               goto out;
> +       }
> +
> +       ret = read(mem, target, sizeof(target));
> +       if (ret < 0) {
> +               perror("read");
> +               goto out;
> +       }
> +
> +       /*
> +        * Our policy is to only allow bind mounts inside /tmp. This isn't very
> +        * interesting, because we could do unprivlieged bind mounts with user
> +        * namespaces already, but you get the idea.
> +        */
> +       if (!strncmp(source, "/tmp", 4) && !strncmp(target, "/tmp", 4)) {
> +               if (mount(source, target, NULL, req->data.args[3], NULL) < 0) {
> +                       ret = -1;
> +                       perror("actual mount");
> +                       goto out;
> +               }
> +               resp->error = 0;
> +       }
> +
> +       /* Even if we didn't allow it because of policy, generating the
> +        * response was be a success, because we want to tell the worker EPERM.
> +        */
> +       ret = 0;
> +
> +out:
> +       close(mem);
> +       return ret;
> +}
> +
> +int main(void)
> +{
> +       int sk_pair[2], ret = 1, status, listener;
> +       pid_t worker = 0 , tracer = 0;
> +       char c;
> +
> +       if (socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair) < 0) {
> +               perror("socketpair");
> +               return 1;
> +       }
> +
> +       worker = fork();
> +       if (worker < 0) {
> +               perror("fork");
> +               goto close_pair;
> +       }
> +
> +       if (worker == 0) {
> +               if (user_trap_syscall(__NR_mount, 0) < 0) {
> +                       perror("seccomp");
> +                       exit(1);
> +               }
> +
> +               if (setuid(1000) < 0) {
> +                       perror("setuid");
> +                       exit(1);
> +               }
> +
> +               if (write(sk_pair[1], "a", 1) != 1) {
> +                       perror("write");
> +                       exit(1);
> +               }
> +
> +               if (read(sk_pair[1], &c, 1) != 1) {
> +                       perror("write");
> +                       exit(1);
> +               }
> +
> +               if (mkdir("/tmp/foo", 0755) < 0) {
> +                       perror("mkdir");
> +                       exit(1);
> +               }
> +
> +               if (mount("/dev/sda", "/tmp/foo", NULL, 0, NULL) != -1) {
> +                       fprintf(stderr, "huh? mounted /dev/sda?\n");
> +                       exit(1);
> +               }
> +
> +               if (errno != EPERM) {
> +                       perror("bad error from mount");
> +                       exit(1);
> +               }
> +
> +               if (mount("/tmp/foo", "/tmp/foo", NULL, MS_BIND, NULL) < 0) {
> +                       perror("mount");
> +                       exit(1);
> +               }
> +
> +               exit(0);
> +       }
> +
> +       if (read(sk_pair[0], &c, 1) != 1) {
> +               perror("read ready signal");
> +               goto out_kill;
> +       }
> +
> +       if (ptrace(PTRACE_ATTACH, worker) < 0) {
> +               perror("ptrace");
> +               goto out_kill;
> +       }
> +
> +       if (waitpid(worker, NULL, 0) != worker) {
> +               perror("waitpid");
> +               goto out_kill;
> +       }
> +
> +       listener = ptrace(PTRACE_SECCOMP_NEW_LISTENER, worker, 0);
> +       if (listener < 0) {
> +               perror("ptrace get listener");
> +               goto out_kill;
> +       }
> +
> +       if (ptrace(PTRACE_DETACH, worker, NULL, 0) < 0) {
> +               perror("ptrace detach");
> +               goto out_kill;
> +       }
> +
> +       if (write(sk_pair[0], "a", 1) != 1) {
> +               perror("write");
> +               exit(1);
> +       }
> +
> +       tracer = fork();
> +       if (tracer < 0) {
> +               perror("fork");
> +               goto out_kill;
> +       }
> +
> +       if (tracer == 0) {
> +               while (1) {
> +                       struct seccomp_notif req = {};
> +                       struct seccomp_notif_resp resp = {};
> +
> +                       req.len = sizeof(req);
> +                       if (ioctl(listener, SECCOMP_NOTIF_RECV, &req) != sizeof(req)) {
> +                               perror("ioctl recv");
> +                               goto out_close;
> +                       }
> +
> +                       if (handle_req(&req, &resp, listener) < 0)
> +                               goto out_close;
> +
> +                       if (ioctl(listener, SECCOMP_NOTIF_SEND, &resp) != sizeof(resp)) {
> +                               perror("ioctl send");
> +                               goto out_close;
> +                       }
> +               }
> +out_close:
> +               close(listener);
> +               exit(1);
> +       }
> +
> +       close(listener);
> +
> +       if (waitpid(worker, &status, 0) != worker) {
> +               perror("waitpid");
> +               goto out_kill;
> +       }
> +
> +       if (umount2("/tmp/foo", MNT_DETACH) < 0 && errno != EINVAL) {
> +               perror("umount2");
> +               goto out_kill;
> +       }
> +
> +       if (remove("/tmp/foo") < 0 && errno != ENOENT) {
> +               perror("remove");
> +               exit(1);
> +       }
> +
> +       if (!WIFEXITED(status) || WEXITSTATUS(status)) {
> +               fprintf(stderr, "worker exited nonzero\n");
> +               goto out_kill;
> +       }
> +
> +       ret = 0;
> +
> +out_kill:
> +       if (tracer > 0)
> +               kill(tracer, SIGKILL);
> +       if (worker > 0)
> +               kill(worker, SIGKILL);
> +
> +close_pair:
> +       close(sk_pair[0]);
> +       close(sk_pair[1]);
> +       return ret;
> +}
> --
> 2.17.1
>

handle_req() is well commented, but main() isn't. Since this is
explicitly a "sample", can you add operational comments to main() as
well? I think it might help people follow what is happening (and what
is expected) during main().

Beyond that, yay! Samples! :)

-Kees

-- 
Kees Cook
Pixel Security
