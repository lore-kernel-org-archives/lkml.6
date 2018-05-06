Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751891AbeEFVbq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 17:31:46 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33940 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751834AbeEFVbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 17:31:43 -0400
X-Google-Smtp-Source: AB8JxZojsH637OXT/TCXFJXtAJ0eulPZZb9Yob9ys3kawYR26fna2ihNBOZCUPZ95vYTi/T7kUwDbd0ok3btVr/3Wys=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <1525396095-27737-1-git-send-email-tyhicks@canonical.com>
References: <1525396095-27737-1-git-send-email-tyhicks@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 6 May 2018 17:31:40 -0400
Message-ID: <CAHC9VhQb46F0q4bbum9NMqi-spuDHaVDG7xSPDmOsWDP0RZ47g@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Better integrate seccomp logging and auditing
To: Tyler Hicks <tyhicks@canonical.com>, Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-audit@redhat.com, linux-security-module@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 3, 2018 at 9:08 PM, Tyler Hicks <tyhicks@canonical.com> wrote:
> Seccomp received improved logging controls in v4.14. Applications can opt into
> logging of "handled" actions (SECCOMP_RET_TRAP, SECCOMP_RET_TRACE,
> SECCOMP_RET_ERRNO) using the SECCOMP_FILTER_FLAG_LOG bit when loading filters.
> They can also debug filter matching with the new SECCOMP_RET_LOG action.
> Administrators can prevent specific actions from being logged using the
> kernel.seccomp.actions_logged sysctl.
>
> However, one corner case intentionally wasn't addressed in those v4.14 changes.
> When a process is being inspected by the audit subsystem, seccomp's decision
> making for logging ignores the new controls and unconditionally logs every
> action taken except for SECCOMP_RET_ALLOW. This isn't particularly useful since
> many existing applications don't intend to log handled actions due to them
> occurring very frequently. This amount of logging fills the audit logs without
> providing many benefits now that application authors have fine grained controls
> at their disposal.
>
> This patch set aligns the seccomp logging behavior for both audited and
> non-audited processes. It also emits an audit record, if auditing is enabled,
> when the kernel.seccomp.actions_logged sysctl is written to so that there's a
> paper trail when entire actions are quieted.
>
> Changes in v3:
> * Patch 3
>   - Never drop a field when emitting the audit record
>   - Use the value "?" for the actions field when an error occurred while
>     writing to the sysctl
>   - Use the value "?" for the actions and/or old-actions fields when a failure
>     to translate actions to names
>   - Use the value "(none)" for the actions and/or old-actions fields when no
>     actions are specified
>     + This is possible when writing an empty string to the sysctl
>   - Update the commit message to note the new values and give an example of
>     when an empty string is written
> * Patch 4
>   - Adjust the control flow of seccomp_log() to exit early if nothing should be
>     logged
>
> Changes in v2:
> * Patch 2
>   - New patch, allowing for a configurable separator between action names
> * Patch 3
>   - The value of the actions field in the audit record now uses a comma instead
>     of a space
>   - The value of the actions field in the audit record is no longer enclosed in
>     quotes
>   - audit_log_start() is called with the current processes' audit_context in
>     audit_seccomp_actions_logged()
>   - audit_seccomp_actions_logged() no longer records the pid, uid, auid, tty,
>     ses, task context, comm, or executable path
>   - The new and old value of seccomp_actions_logged is recorded in the
>     AUDIT_CONFIG_CHANGE record
>   - The value of the "res" field in the CONFIG_CHANGE audit record is corrected
>     (1 indicates success, 0 failure)
>   - Updated patch 3's commit message to reflect the updated audit record format
>     in the examples
> * Patch 4
>   - A function comment for audit_seccomp() was added to explain, among other
>     things, that event filtering is performed in seccomp_log()

Kees, are you still okay with v3?  Also, are you okay with these
patches going in via the audit tree, or would you prefer to take them
via seccomp?  I've got a slight preference for the audit tree myself,
but as I said before, as long as it hits Linus' tree I'm happy.

-- 
paul moore
www.paul-moore.com
