Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0BFC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE01E21714
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Il+bfc25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE01E21714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeI1ENv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:13:51 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38991 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeI1ENu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:13:50 -0400
Received: by mail-yb1-f193.google.com with SMTP id c4-v6so1792894ybl.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 14:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=411PFaYoH9Ruz6hh6wqaAkuUo2/+Pk8LOr18N6IAi5w=;
        b=Il+bfc25oOvQO9v4rHX4LIi9IyvRIDpfaJLg4cUiWBg+4nplWwOnLdbau42KdbfiHl
         quFpUQHMhi+0EVAz7UMWvfWMFYaIyHfRQwRVBE2fRfEtUsyTpx6momVTf8qLYnuLk5Jf
         2dxlqe0A5YcXZpykcqptJInRmynULVwNZv0DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=411PFaYoH9Ruz6hh6wqaAkuUo2/+Pk8LOr18N6IAi5w=;
        b=M3ZTnUghhyuxlXSJpV9xg0JiAAmOtG2DeBI1ziw/69B6k/Y+d4K7wDTk6EMw/nYKnw
         qKxL2pitDtwCSxw+ZXXWsqyqNi9B27lfdzkV+LWUTCwUu4LVvIQwEgiZ98YJgBmdPulQ
         1YpX9S/5ARg7TTXmdvfV6kuA26zNFl7NMObOymZOK9z2Gd8SyEzGTZhcn/hqD0cJkZSP
         O68qKTPoseLRUSBIw1MOazxpvBddSIqRH6A8C1pVxpHMe0+3CABJ19NSMqUIIlF3KqU0
         k18cw9g4V7f7uWKeTlnREbQKQcw6KW7xxq/ahvJ0ZmIrhbmraUXYCEoxP/aUlpyFj3Lt
         mfGA==
X-Gm-Message-State: ABuFfoh9n0G0+7gxf2x7/ccGGU4IJZ6ECvbrwr4T1gVfF/E7SKhmdBRC
        nociDBxv+2ZxNdVtPENuz8rlqAgka/8=
X-Google-Smtp-Source: ACcGV62Iv3sWxohSJUVme+Th8icfKrdmzLCINwbpLEU4DARol7i2K5jxM7dABcaM1xi/jGRTi7D/Nw==
X-Received: by 2002:a25:4a03:: with SMTP id x3-v6mr6942803yba.231.1538085206433;
        Thu, 27 Sep 2018 14:53:26 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id o202-v6sm6552086ywo.38.2018.09.27.14.53.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 14:53:23 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id b3-v6so1798162yba.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 14:53:22 -0700 (PDT)
X-Received: by 2002:a25:dd82:: with SMTP id u124-v6mr6785789ybg.171.1538085202560;
 Thu, 27 Sep 2018 14:53:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 14:53:21
 -0700 (PDT)
In-Reply-To: <20180927151119.9989-4-tycho@tycho.ws>
References: <20180927151119.9989-1-tycho@tycho.ws> <20180927151119.9989-4-tycho@tycho.ws>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 27 Sep 2018 14:53:21 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+X-HsqM_u3nsvLqAb1Pw+ynYcPtMexDG9nB6XeGdxGYA@mail.gmail.com>
Message-ID: <CAGXu5j+X-HsqM_u3nsvLqAb1Pw+ynYcPtMexDG9nB6XeGdxGYA@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] seccomp: add a way to get a listener fd from ptrace
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
> As an alternative to SECCOMP_FILTER_FLAG_GET_LISTENER, perhaps a ptrace()
> version which can acquire filters is useful. There are at least two reasons
> this is preferable, even though it uses ptrace:
>
> 1. You can control tasks that aren't cooperating with you
> 2. You can control tasks whose filters block sendmsg() and socket(); if the
>    task installs a filter which blocks these calls, there's no way with
>    SECCOMP_FILTER_FLAG_GET_LISTENER to get the fd out to the privileged task.
>
> v2: fix a bug where listener mode was not unset when an unused fd was not
>     available
> v3: fix refcounting bug (Oleg)
> v4: * change the listener's fd flags to be 0
>     * rename GET_LISTENER to NEW_LISTENER (Matthew)
> v5: * add capable(CAP_SYS_ADMIN) requirement
> v7: * point the new listener at the right filter (Jann)
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
>  include/linux/seccomp.h                       |  7 ++
>  include/uapi/linux/ptrace.h                   |  2 +
>  kernel/ptrace.c                               |  4 ++
>  kernel/seccomp.c                              | 31 +++++++++
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 68 +++++++++++++++++++
>  5 files changed, 112 insertions(+)
>
> diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
> index 017444b5efed..234c61b37405 100644
> --- a/include/linux/seccomp.h
> +++ b/include/linux/seccomp.h
> @@ -83,6 +83,8 @@ static inline int seccomp_mode(struct seccomp *s)
>  #ifdef CONFIG_SECCOMP_FILTER
>  extern void put_seccomp_filter(struct task_struct *tsk);
>  extern void get_seccomp_filter(struct task_struct *tsk);
> +extern long seccomp_new_listener(struct task_struct *task,
> +                                unsigned long filter_off);
>  #else  /* CONFIG_SECCOMP_FILTER */
>  static inline void put_seccomp_filter(struct task_struct *tsk)
>  {
> @@ -92,6 +94,11 @@ static inline void get_seccomp_filter(struct task_struct *tsk)
>  {
>         return;
>  }
> +static inline long seccomp_new_listener(struct task_struct *task,
> +                                       unsigned long filter_off)
> +{
> +       return -EINVAL;
> +}
>  #endif /* CONFIG_SECCOMP_FILTER */
>
>  #if defined(CONFIG_SECCOMP_FILTER) && defined(CONFIG_CHECKPOINT_RESTORE)
> diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
> index d5a1b8a492b9..e80ecb1bd427 100644
> --- a/include/uapi/linux/ptrace.h
> +++ b/include/uapi/linux/ptrace.h
> @@ -73,6 +73,8 @@ struct seccomp_metadata {
>         __u64 flags;            /* Output: filter's flags */
>  };
>
> +#define PTRACE_SECCOMP_NEW_LISTENER    0x420e
> +
>  /* Read signals from a shared (process wide) queue */
>  #define PTRACE_PEEKSIGINFO_SHARED      (1 << 0)
>
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 21fec73d45d4..289960ac181b 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -1096,6 +1096,10 @@ int ptrace_request(struct task_struct *child, long request,
>                 ret = seccomp_get_metadata(child, addr, datavp);
>                 break;
>
> +       case PTRACE_SECCOMP_NEW_LISTENER:
> +               ret = seccomp_new_listener(child, addr);
> +               break;
> +
>         default:
>                 break;
>         }
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 44a31ac8373a..17685803a2af 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1777,4 +1777,35 @@ static struct file *init_listener(struct task_struct *task,
>
>         return ret;
>  }
> +
> +long seccomp_new_listener(struct task_struct *task,
> +                         unsigned long filter_off)
> +{
> +       struct seccomp_filter *filter;
> +       struct file *listener;
> +       int fd;
> +
> +       if (!capable(CAP_SYS_ADMIN))
> +               return -EACCES;
> +
> +       filter = get_nth_filter(task, filter_off);
> +       if (IS_ERR(filter))
> +               return PTR_ERR(filter);
> +
> +       fd = get_unused_fd_flags(0);
> +       if (fd < 0) {
> +               __put_seccomp_filter(filter);
> +               return fd;
> +       }
> +
> +       listener = init_listener(task, filter);
> +       __put_seccomp_filter(filter);
> +       if (IS_ERR(listener)) {
> +               put_unused_fd(fd);
> +               return PTR_ERR(listener);
> +       }
> +
> +       fd_install(fd, listener);
> +       return fd;
> +}

Observation both here and with SECCOMP_FILTER_FLAG_NEW_LISTENER:
nothing actually checks that there is a RET_USER_NOTIF bpf rule in the
filter. *shrug* Not a problem, just a weird state.

>  #endif
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 5f4b836a6792..c6ba3ed5392e 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -193,6 +193,10 @@ int seccomp(unsigned int op, unsigned int flags, void *args)
>  }
>  #endif
>
> +#ifndef PTRACE_SECCOMP_NEW_LISTENER
> +#define PTRACE_SECCOMP_NEW_LISTENER 0x420e
> +#endif
> +
>  #if __BYTE_ORDER == __LITTLE_ENDIAN
>  #define syscall_arg(_n) (offsetof(struct seccomp_data, args[_n]))
>  #elif __BYTE_ORDER == __BIG_ENDIAN
> @@ -3175,6 +3179,70 @@ TEST(get_user_notification_syscall)
>         EXPECT_EQ(0, WEXITSTATUS(status));
>  }
>
> +TEST(get_user_notification_ptrace)
> +{
> +       pid_t pid;
> +       int status, listener;
> +       int sk_pair[2];
> +       char c;
> +       struct seccomp_notif req = {};
> +       struct seccomp_notif_resp resp = {};
> +
> +       ASSERT_EQ(socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair), 0);
> +
> +       pid = fork();
> +       ASSERT_GE(pid, 0);
> +
> +       if (pid == 0) {
> +               EXPECT_EQ(user_trap_syscall(__NR_getpid, 0), 0);
> +
> +               /* Test that we get ENOSYS while not attached */
> +               EXPECT_EQ(syscall(__NR_getpid), -1);
> +               EXPECT_EQ(errno, ENOSYS);
> +
> +               /* Signal we're ready and have installed the filter. */
> +               EXPECT_EQ(write(sk_pair[1], "J", 1), 1);
> +
> +               EXPECT_EQ(read(sk_pair[1], &c, 1), 1);
> +               EXPECT_EQ(c, 'H');
> +
> +               exit(syscall(__NR_getpid) != USER_NOTIF_MAGIC);
> +       }
> +
> +       EXPECT_EQ(read(sk_pair[0], &c, 1), 1);
> +       EXPECT_EQ(c, 'J');
> +
> +       EXPECT_EQ(ptrace(PTRACE_ATTACH, pid), 0);
> +       EXPECT_EQ(waitpid(pid, NULL, 0), pid);
> +       listener = ptrace(PTRACE_SECCOMP_NEW_LISTENER, pid, 0);
> +       EXPECT_GE(listener, 0);
> +
> +       /* EBUSY for second listener */
> +       EXPECT_EQ(ptrace(PTRACE_SECCOMP_NEW_LISTENER, pid, 0), -1);
> +       EXPECT_EQ(errno, EBUSY);
> +
> +       EXPECT_EQ(ptrace(PTRACE_DETACH, pid, NULL, 0), 0);
> +
> +       /* Now signal we are done and respond with magic */
> +       EXPECT_EQ(write(sk_pair[0], "H", 1), 1);
> +
> +       req.len = sizeof(req);
> +       EXPECT_EQ(ioctl(listener, SECCOMP_NOTIF_RECV, &req), sizeof(req));
> +
> +       resp.len = sizeof(resp);
> +       resp.id = req.id;
> +       resp.error = 0;
> +       resp.val = USER_NOTIF_MAGIC;
> +
> +       EXPECT_EQ(ioctl(listener, SECCOMP_NOTIF_SEND, &resp), sizeof(resp));
> +
> +       EXPECT_EQ(waitpid(pid, &status, 0), pid);
> +       EXPECT_EQ(true, WIFEXITED(status));
> +       EXPECT_EQ(0, WEXITSTATUS(status));
> +
> +       close(listener);
> +}
> +
>  /*
>   * Check that a pid in a child namespace still shows up as valid in ours.
>   */
> --
> 2.17.1
>

And FWIW, I agree with Jann's review notes here too. :) Looks good!

-Kees

-- 
Kees Cook
Pixel Security
