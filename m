Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbeEBQ5O (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 12:57:14 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:39976 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751602AbeEBQ5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 12:57:08 -0400
X-Google-Smtp-Source: AB8JxZrx1YQ172gRVsikCWxQ/PcMG2fC5eXKuslaoQXK4KIioh4tvRBGKhcUpS5onv6tVGQ7kFVC4gflz8uAyUnJlrM=
MIME-Version: 1.0
In-Reply-To: <1525276400-7161-5-git-send-email-tyhicks@canonical.com>
References: <1525276400-7161-1-git-send-email-tyhicks@canonical.com> <1525276400-7161-5-git-send-email-tyhicks@canonical.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 2 May 2018 09:57:05 -0700
X-Google-Sender-Auth: GB4wDQPPPhD2zcH22WBY16U0fnE
Message-ID: <CAGXu5jLnD=g=LxR5KTrvcwr1qaYiYXbH-ersvhs5NPRR6JA91w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] seccomp: Don't special case audited processes when logging
To: Tyler Hicks <tyhicks@canonical.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
        Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Linux Audit <linux-audit@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 2, 2018 at 8:53 AM, Tyler Hicks <tyhicks@canonical.com> wrote:
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index da78835..9029d9d 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -584,18 +584,13 @@ static inline void seccomp_log(unsigned long syscall, long signr, u32 action,
>         }
>
>         /*
> -        * Force an audit message to be emitted when the action is RET_KILL_*,
> -        * RET_LOG, or the FILTER_FLAG_LOG bit was set and the action is
> -        * allowed to be logged by the admin.
> +        * Emit an audit message when the action is RET_KILL_*, RET_LOG, or the
> +        * FILTER_FLAG_LOG bit was set. The admin has the ability to silence
> +        * any action from being logged by removing the action name from the
> +        * seccomp_actions_logged sysctl.
>          */
>         if (log)
> -               return __audit_seccomp(syscall, signr, action);
> -
> -       /*
> -        * Let the audit subsystem decide if the action should be audited based
> -        * on whether the current task itself is being audited.
> -        */
> -       return audit_seccomp(syscall, signr, action);
> +               audit_seccomp(syscall, signr, action);
>  }

This whole series looks great to me. If I can get an Ack from Paul for
the audit bits, I can take it via the seccomp tree. One minor nit on
seccomp_log() above, I'd probably change this to show the "exception"
case as "out of line" of normal code flow. i.e. instead of "if (log)
audit_seccomp", invert it to return early:

...
    if (!log)
        return;

    audit_seccomp(syscall, signr, action);
}

But if there isn't some other need for a v3, I can just make this
change when I commit.

Thanks for fixing this up!

-Kees

-- 
Kees Cook
Pixel Security
