Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE2BC6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECC220855
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fwb0RljD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ECC220855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbeLLArH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:47:07 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38341 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbeLLArG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:47:06 -0500
Received: by mail-yb1-f195.google.com with SMTP id d187so7550048ybb.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 16:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dvqNIjhJ38H7XHYFmTTGv779swRsELVAegwnTwqcZxg=;
        b=fwb0RljDTPFfTMwEdR9aXYYd64/x0qLy5wm3qXZsF9TPjlJcUzHBlOlemmMWmqGDvu
         +DPnyFJWrwa1W2aX4eufV0ySS7q3RqeyGHomYxBouzUzibaGZ1PUjT7DWZQw/O/FR1hc
         88KFeatnhgsRZ19RKtYZf6rwZbM+zTLrUhuic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dvqNIjhJ38H7XHYFmTTGv779swRsELVAegwnTwqcZxg=;
        b=uehRi2ZqBzNqEnW0LefJd4lcRP11uR9ywQY7WdNtyILbpm69eIq4w2XLRYWMrM4+WC
         lsuaxrE+mIpThnSyH+F+qTJ6uhb2Xgiro0YfWpPFti4ncTsF1/sG6nNZgOVktLTlkvuy
         +EKqKChDA3bu6no0f4OcoFKaAYoq5sfA3ukGE5LyChnC5w+EU8q3L8z/d55uXdB+ueVK
         1g6TXz8WVn9zT2hAWicx2tkpqO83OgO884G4LeJwkih2cdyufU9bqLS+zp4bJvJf46ZF
         sEqf+703ZbWU9PAsxFHxALBnkpmdhWa8OlkhyvXjrjxGvrFWjO6Jj1/ynfR7o0qzg9z2
         hmeQ==
X-Gm-Message-State: AA+aEWbUtc8wVb7WM1g6ABFK+DE/YfsPkxP7pgiv3tc1RFgS9YnfpEbU
        76bLUBsk+oAKCFXPePAlgqpQcv2oIJk=
X-Google-Smtp-Source: AFSGD/XfPTSMwVMT/zFjRuyI8vEC/GighrFEFt5TrN0OWAHU97e7dmF/0AZ3hnSeaFndzcHenZ5Pvg==
X-Received: by 2002:a5b:30f:: with SMTP id j15-v6mr18629354ybp.371.1544575624930;
        Tue, 11 Dec 2018 16:47:04 -0800 (PST)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id e3sm5371457ywe.63.2018.12.11.16.47.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 16:47:04 -0800 (PST)
Received: by mail-yw1-f52.google.com with SMTP id g75so6274741ywb.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 16:47:03 -0800 (PST)
X-Received: by 2002:a81:29cc:: with SMTP id p195mr19359360ywp.407.1544575623495;
 Tue, 11 Dec 2018 16:47:03 -0800 (PST)
MIME-Version: 1.0
References: <20181209182414.30862-1-tycho@tycho.ws> <20181209182414.30862-5-tycho@tycho.ws>
 <20181211222449.GA937@mail.hallyn.com>
In-Reply-To: <20181211222449.GA937@mail.hallyn.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 11 Dec 2018 16:46:52 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKLGXcY_koB+ZijKDVJ1=+iGMj5h8qBQOfpVk0n10e3DQ@mail.gmail.com>
Message-ID: <CAGXu5jKLGXcY_koB+ZijKDVJ1=+iGMj5h8qBQOfpVk0n10e3DQ@mail.gmail.com>
Subject: Re: [PATCH v10 4/4] samples: add an example of seccomp user trap
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>, Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 2:24 PM Serge E. Hallyn <serge@hallyn.com> wrote:
>
> On Sun, Dec 09, 2018 at 11:24:14AM -0700, Tycho Andersen wrote:
> > The idea here is just to give a demonstration of how one could safely use
> > the SECCOMP_RET_USER_NOTIF feature to do mount policies. This particular
> > policy is (as noted in the comment) not very interesting, but it serves to
> > illustrate how one might apply a policy dodging the various TOCTOU issues.
> >
> > Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> > CC: Kees Cook <keescook@chromium.org>
> > CC: Andy Lutomirski <luto@amacapital.net>
> > CC: Oleg Nesterov <oleg@redhat.com>
> > CC: Eric W. Biederman <ebiederm@xmission.com>
> > CC: "Serge E. Hallyn" <serge@hallyn.com>
> > CC: Christian Brauner <christian@brauner.io>
> > CC: Tyler Hicks <tyhicks@canonical.com>
> > CC: Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
> > ---
> > v5: new in v5
> > v7: updates for v7 API changes
> > v8: * add some more comments about what's happening in main() (Kees)
> >     * move from ptrace API to SECCOMP_FILTER_FLAG_NEW_LISTENER
> > v9: * s/mknod/mount in error message
> >     * switch to the SECCOMP_GET_NOTIF_SIZES API
> >     * add a note about getting ENOENT from SECCOMP_IOCTL_NOTIF_SEND
> > ---
> >  samples/seccomp/.gitignore  |   1 +
> >  samples/seccomp/Makefile    |   7 +-
> >  samples/seccomp/user-trap.c | 375 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 382 insertions(+), 1 deletion(-)
> >
> > diff --git a/samples/seccomp/.gitignore b/samples/seccomp/.gitignore
> > index 78fb78184291..d1e2e817d556 100644
> > --- a/samples/seccomp/.gitignore
> > +++ b/samples/seccomp/.gitignore
> > @@ -1,3 +1,4 @@
> >  bpf-direct
> >  bpf-fancy
> >  dropper
> > +user-trap
> > diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
> > index cf34ff6b4065..4920903c8009 100644
> > --- a/samples/seccomp/Makefile
> > +++ b/samples/seccomp/Makefile
> > @@ -1,6 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  ifndef CROSS_COMPILE
> > -hostprogs-$(CONFIG_SAMPLE_SECCOMP) := bpf-fancy dropper bpf-direct
> > +hostprogs-$(CONFIG_SAMPLE_SECCOMP) := bpf-fancy dropper bpf-direct user-trap
> >
> >  HOSTCFLAGS_bpf-fancy.o += -I$(objtree)/usr/include
> >  HOSTCFLAGS_bpf-fancy.o += -idirafter $(objtree)/include
> > @@ -16,6 +16,10 @@ HOSTCFLAGS_bpf-direct.o += -I$(objtree)/usr/include
> >  HOSTCFLAGS_bpf-direct.o += -idirafter $(objtree)/include
> >  bpf-direct-objs := bpf-direct.o
> >
> > +HOSTCFLAGS_user-trap.o += -I$(objtree)/usr/include
> > +HOSTCFLAGS_user-trap.o += -idirafter $(objtree)/include
> > +user-trap-objs := user-trap.o
> > +
> >  # Try to match the kernel target.
> >  ifndef CONFIG_64BIT
> >
> > @@ -33,6 +37,7 @@ HOSTCFLAGS_bpf-fancy.o += $(MFLAG)
> >  HOSTLDLIBS_bpf-direct += $(MFLAG)
> >  HOSTLDLIBS_bpf-fancy += $(MFLAG)
> >  HOSTLDLIBS_dropper += $(MFLAG)
> > +HOSTLDLIBS_user-trap += $(MFLAG)
> >  endif
> >  always := $(hostprogs-m)
> >  endif
> > diff --git a/samples/seccomp/user-trap.c b/samples/seccomp/user-trap.c
> > new file mode 100644
> > index 000000000000..61267cb59c8e
> > --- /dev/null
> > +++ b/samples/seccomp/user-trap.c
> > @@ -0,0 +1,375 @@
> > +#include <signal.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <string.h>
> > +#include <stddef.h>
> > +#include <sys/sysmacros.h>
> > +#include <sys/types.h>
> > +#include <sys/wait.h>
> > +#include <sys/socket.h>
> > +#include <sys/stat.h>
> > +#include <sys/mman.h>
> > +#include <sys/syscall.h>
> > +#include <sys/user.h>
> > +#include <sys/ioctl.h>
> > +#include <sys/ptrace.h>
> > +#include <sys/mount.h>
> > +#include <linux/limits.h>
> > +#include <linux/filter.h>
> > +#include <linux/seccomp.h>
> > +
> > +#define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
> > +
> > +static int seccomp(unsigned int op, unsigned int flags, void *args)
> > +{
> > +     errno = 0;
> > +     return syscall(__NR_seccomp, op, flags, args);
> > +}
> > +
> > +static int send_fd(int sock, int fd)
> > +{
> > +     struct msghdr msg = {};
> > +     struct cmsghdr *cmsg;
> > +     char buf[CMSG_SPACE(sizeof(int))] = {0}, c = 'c';
> > +     struct iovec io = {
> > +             .iov_base = &c,
> > +             .iov_len = 1,
> > +     };
> > +
> > +     msg.msg_iov = &io;
> > +     msg.msg_iovlen = 1;
> > +     msg.msg_control = buf;
> > +     msg.msg_controllen = sizeof(buf);
> > +     cmsg = CMSG_FIRSTHDR(&msg);
> > +     cmsg->cmsg_level = SOL_SOCKET;
> > +     cmsg->cmsg_type = SCM_RIGHTS;
> > +     cmsg->cmsg_len = CMSG_LEN(sizeof(int));
> > +     *((int *)CMSG_DATA(cmsg)) = fd;
> > +     msg.msg_controllen = cmsg->cmsg_len;
> > +
> > +     if (sendmsg(sock, &msg, 0) < 0) {
> > +             perror("sendmsg");
> > +             return -1;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int recv_fd(int sock)
> > +{
> > +     struct msghdr msg = {};
> > +     struct cmsghdr *cmsg;
> > +     char buf[CMSG_SPACE(sizeof(int))] = {0}, c = 'c';
> > +     struct iovec io = {
> > +             .iov_base = &c,
> > +             .iov_len = 1,
> > +     };
> > +
> > +     msg.msg_iov = &io;
> > +     msg.msg_iovlen = 1;
> > +     msg.msg_control = buf;
> > +     msg.msg_controllen = sizeof(buf);
> > +
> > +     if (recvmsg(sock, &msg, 0) < 0) {
> > +             perror("recvmsg");
> > +             return -1;
> > +     }
> > +
> > +     cmsg = CMSG_FIRSTHDR(&msg);
> > +
> > +     return *((int *)CMSG_DATA(cmsg));
> > +}
> > +
> > +static int user_trap_syscall(int nr, unsigned int flags)
> > +{
> > +     struct sock_filter filter[] = {
> > +             BPF_STMT(BPF_LD+BPF_W+BPF_ABS,
> > +                     offsetof(struct seccomp_data, nr)),
> > +             BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, nr, 0, 1),
> > +             BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_USER_NOTIF),
> > +             BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_ALLOW),
> > +     };
> > +
> > +     struct sock_fprog prog = {
> > +             .len = (unsigned short)ARRAY_SIZE(filter),
> > +             .filter = filter,
> > +     };
> > +
> > +     return seccomp(SECCOMP_SET_MODE_FILTER, flags, &prog);
> > +}
> > +
> > +static int handle_req(struct seccomp_notif *req,
> > +                   struct seccomp_notif_resp *resp, int listener)
> > +{
> > +     char path[PATH_MAX], source[PATH_MAX], target[PATH_MAX];
> > +     int ret = -1, mem;
> > +
> > +     resp->id = req->id;
> > +     resp->error = -EPERM;
> > +     resp->val = 0;
> > +
> > +     if (req->data.nr != __NR_mount) {
> > +             fprintf(stderr, "huh? trapped something besides mount? %d\n", req->data.nr);
> > +             return -1;
> > +     }
> > +
> > +     /* Only allow bind mounts. */
> > +     if (!(req->data.args[3] & MS_BIND))
> > +             return 0;
> > +
> > +     /*
> > +      * Ok, let's read the task's memory to see where they wanted their
> > +      * mount to go.
> > +      */
> > +     snprintf(path, sizeof(path), "/proc/%d/mem", req->pid);
> > +     mem = open(path, O_RDONLY);
> > +     if (mem < 0) {
> > +             perror("open mem");
> > +             return -1;
> > +     }
> > +
> > +     /*
> > +      * Now we avoid a TOCTOU: we referred to a pid by its pid, but since
> > +      * the pid that made the syscall may have died, we need to confirm that
> > +      * the pid is still valid after we open its /proc/pid/mem file. We can
> > +      * ask the listener fd this as follows.
> > +      *
> > +      * Note that this check should occur *after* any task-specific
> > +      * resources are opened, to make sure that the task has not died and
> > +      * we're not wrongly reading someone else's state in order to make
> > +      * decisions.
> > +      */
> > +     if (ioctl(listener, SECCOMP_IOCTL_NOTIF_ID_VALID, &req->id) < 0) {
> > +             fprintf(stderr, "task died before we could map its memory\n");
> > +             goto out;
> > +     }
> > +
> > +     /*
> > +      * Phew, we've got the right /proc/pid/mem. Now we can read it. Note
> > +      * that to avoid another TOCTOU, we should read all of the pointer args
> > +      * before we decide to allow the syscall.
> > +      */
> > +     if (lseek(mem, req->data.args[0], SEEK_SET) < 0) {
> > +             perror("seek");
> > +             goto out;
> > +     }
> > +
> > +     ret = read(mem, source, sizeof(source));
> > +     if (ret < 0) {
> > +             perror("read");
> > +             goto out;
> > +     }
> > +
> > +     if (lseek(mem, req->data.args[1], SEEK_SET) < 0) {
> > +             perror("seek");
> > +             goto out;
> > +     }
> > +
> > +     ret = read(mem, target, sizeof(target));
> > +     if (ret < 0) {
> > +             perror("read");
> > +             goto out;
> > +     }
> > +
> > +     /*
> > +      * Our policy is to only allow bind mounts inside /tmp. This isn't very
> > +      * interesting, because we could do unprivlieged bind mounts with user
> > +      * namespaces already, but you get the idea.
> > +      */
> > +     if (!strncmp(source, "/tmp", 4) && !strncmp(target, "/tmp", 4)) {
>
> Of course the host could have a /tmproot or somesuch, so you might want to
> check the first 5 characters :)

I manually bumped this to "/tmp/", 5 in both tests and applied it for -next

-Kees

-- 
Kees Cook
