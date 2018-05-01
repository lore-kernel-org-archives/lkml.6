Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756120AbeEAP1u (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 11:27:50 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44130 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755443AbeEAP1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 11:27:48 -0400
X-Google-Smtp-Source: AB8JxZqLAQymGOGE7l7VaESL3Lez8c2e2ZoFUxqN0lm5qVFj62n5bSBAsVcqMXcLwbBWkSb6e7lhIkjCygCJqt3HV78=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <1524856562-22566-4-git-send-email-tyhicks@canonical.com>
References: <1524856562-22566-1-git-send-email-tyhicks@canonical.com> <1524856562-22566-4-git-send-email-tyhicks@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 1 May 2018 11:27:45 -0400
Message-ID: <CAHC9VhSfOCLASK9k07ENwBBP39rPk2uggcVLbWgDeo4bzbgdqg@mail.gmail.com>
Subject: Re: [PATCH 3/3] seccomp: Don't special case audited processes when logging
To: Tyler Hicks <tyhicks@canonical.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
        Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-audit@redhat.com,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 3:16 PM, Tyler Hicks <tyhicks@canonical.com> wrote:
> Seccomp logging for "handled" actions such as RET_TRAP, RET_TRACE, or
> RET_ERRNO can be very noisy for processes that are being audited. This
> patch modifies the seccomp logging behavior to treat processes that are
> being inspected via the audit subsystem the same as processes that
> aren't under inspection. Handled actions will no longer be logged just
> because the process is being inspected. Since v4.14, applications have
> the ability to request logging of handled actions by using the
> SECCOMP_FILTER_FLAG_LOG flag when loading seccomp filters.
>
> With this patch, the logic for deciding if an action will be logged is:
>
>   if action == RET_ALLOW:
>     do not log
>   else if action not in actions_logged:
>     do not log
>   else if action == RET_KILL:
>     log
>   else if action == RET_LOG:
>     log
>   else if filter-requests-logging:
>     log
>   else:
>     do not log
>
> Reported-by: Steve Grubb <sgrubb@redhat.com>
> Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
> ---
>  Documentation/userspace-api/seccomp_filter.rst |  7 -------
>  include/linux/audit.h                          | 10 +---------
>  kernel/auditsc.c                               |  2 +-
>  kernel/seccomp.c                               | 15 +++++----------
>  4 files changed, 7 insertions(+), 27 deletions(-)
>
> diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentation/userspace-api/seccomp_filter.rst
> index 099c412..82a468b 100644
> --- a/Documentation/userspace-api/seccomp_filter.rst
> +++ b/Documentation/userspace-api/seccomp_filter.rst
> @@ -207,13 +207,6 @@ directory. Here's a description of each file in that directory:
>         to the file do not need to be in ordered form but reads from the file
>         will be ordered in the same way as the actions_avail sysctl.
>
> -       It is important to note that the value of ``actions_logged`` does not
> -       prevent certain actions from being logged when the audit subsystem is
> -       configured to audit a task. If the action is not found in
> -       ``actions_logged`` list, the final decision on whether to audit the
> -       action for that task is ultimately left up to the audit subsystem to
> -       decide for all seccomp return values other than ``SECCOMP_RET_ALLOW``.
> -
>         The ``allow`` string is not accepted in the ``actions_logged`` sysctl
>         as it is not possible to log ``SECCOMP_RET_ALLOW`` actions. Attempting
>         to write ``allow`` to the sysctl will result in an EINVAL being
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index b311d7d..1964fbd 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -232,7 +232,7 @@ extern void __audit_file(const struct file *);
>  extern void __audit_inode_child(struct inode *parent,
>                                 const struct dentry *dentry,
>                                 const unsigned char type);
> -extern void __audit_seccomp(unsigned long syscall, long signr, int code);
> +extern void audit_seccomp(unsigned long syscall, long signr, int code);
>  extern void audit_seccomp_actions_logged(const char *names, int res);
>  extern void __audit_ptrace(struct task_struct *t);
>
> @@ -303,12 +303,6 @@ static inline void audit_inode_child(struct inode *parent,
>  }
>  void audit_core_dumps(long signr);
>
> -static inline void audit_seccomp(unsigned long syscall, long signr, int code)
> -{
> -       if (audit_enabled && unlikely(!audit_dummy_context()))
> -               __audit_seccomp(syscall, signr, code);
> -}
> -
>  static inline void audit_ptrace(struct task_struct *t)
>  {
>         if (unlikely(!audit_dummy_context()))
> @@ -499,8 +493,6 @@ static inline void audit_inode_child(struct inode *parent,
>  { }
>  static inline void audit_core_dumps(long signr)
>  { }
> -static inline void __audit_seccomp(unsigned long syscall, long signr, int code)
> -{ }
>  static inline void audit_seccomp(unsigned long syscall, long signr, int code)
>  { }
>  static inline void audit_seccomp_actions_logged(const char *names, int res)
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 3496238..1e64b91 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2464,7 +2464,7 @@ void audit_core_dumps(long signr)
>         audit_log_end(ab);
>  }
>
> -void __audit_seccomp(unsigned long syscall, long signr, int code)
> +void audit_seccomp(unsigned long syscall, long signr, int code)
>  {
>         struct audit_buffer *ab;

Since it is a bit unusual, it might be nice to add a comment at the
top of audit_seccomp() that the event filtering is being done in the
seccomp_log() function, and we may need to force auditing independent
of the audit_enabled and dummy context state.

> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index e28ddcc..947cc0f 100644
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
>
>  /*
> --
> 2.7.4
>



-- 
paul moore
www.paul-moore.com
