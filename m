Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B511FC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714AD214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iOFoDPQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714AD214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbeLFBLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:11:05 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38607 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFBLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 20:11:04 -0500
Received: by mail-yb1-f196.google.com with SMTP id d187so1498681ybb.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 17:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YMsFPOwp+HYuQfKFu9COzZPdWHtGKQJMtECRPLEDAaA=;
        b=iOFoDPQesDyogJo9GYnMT/IyfMDQgqUjVHWcy41ovY8oNDgtNmemTGH69m+iRtz4/G
         n4m/kY9MPmq3/J9ow86qmMllfTIvd3Ko8NrJnfyajL6nMtRw4q5ss1qqJmVFDouhKAIJ
         pdAStRLIaEwQwBhmXubejRWGccZwkQfgwOXEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YMsFPOwp+HYuQfKFu9COzZPdWHtGKQJMtECRPLEDAaA=;
        b=aUpCZ1KtjX3R8bK4DXPo5nbuXtkBd1NyB0DEjIGVL4NshbLbc62VSaN1Taiawc3i5v
         YfZdMZy9nGZjPIUdUfAYhBvM0LVCZoNpgPZR0cXZ51M7BkcXyk5hkuVARscK0OvhXue0
         OFJLmros46TrYJvIAmcm0fCySZh6EKUlmYoveI9yxQIcW4W1KLMHJImtypg27oX2Ha/A
         MiQXXeNR4YGKkRXwHf2vErEGdsmp2NcCmQ1AqgUNv+JpSzMzESG6AdI2x1ArOyQfo0H8
         XOrvKtaBBA9wotEP9WulOQvm4ny9UfLPurIDy3g8gQEtkSYNDOk+1Sdis/r75v2xzR19
         O66A==
X-Gm-Message-State: AA+aEWY9jlQov9EKw0EuhX2Gq6Kbr5qgg6FdivqrVykLYwciPDXuMT5J
        O8iIMs5tFBPxB0Gbo8XMJq56QUjKmuc=
X-Google-Smtp-Source: AFSGD/VCrAu7aCv2POqMV6T8fyteAlx62LoY9rhjbbb5/gAjPbHfshsNIRzbVyBfUPrNvFhsgxuOOQ==
X-Received: by 2002:a5b:192:: with SMTP id r18mr7570972ybl.404.1544058662235;
        Wed, 05 Dec 2018 17:11:02 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id x4sm23978619ywj.80.2018.12.05.17.11.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 17:11:01 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id w203so5988915ybg.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 17:11:00 -0800 (PST)
X-Received: by 2002:a81:98e:: with SMTP id 136mr26259370ywj.47.1544058660007;
 Wed, 05 Dec 2018 17:11:00 -0800 (PST)
MIME-Version: 1.0
References: <feac7efa-df6f-cca1-e321-28d220bf0411@linux.intel.com> <b1a4fa08-482d-0fcc-c798-efb9a9894a47@linux.intel.com>
In-Reply-To: <b1a4fa08-482d-0fcc-c798-efb9a9894a47@linux.intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 5 Dec 2018 17:10:48 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJ_CyE5A2VUSyyi-uj4webfZM9ZOACp523p5xFhv1KCAQ@mail.gmail.com>
Message-ID: <CAGXu5jJ_CyE5A2VUSyyi-uj4webfZM9ZOACp523p5xFhv1KCAQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] Documentation/admin-guide: introduce
 perf-security.rst file
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 12:15 AM Alexey Budankov
<alexey.budankov@linux.intel.com> wrote:
>
>
> Implement initial version of perf-security.rst documentation file
> covering security concerns of perf_event_paranoid settings.
>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> Changes in v4:
> - added docs for perf_event related capabilities
> Changes in v3:
> - toning down of the markup for "scope, access and resource"
> - adding definite article for "Linux implementation"
> Changes in v2:
> - reverted patches order in the set to avoid CI issue
> - replaced old PCL referencing by PE (Perf Events)
> - skipped >=3 setting documentation at the moment
> ---
>  Documentation/admin-guide/perf-security.rst | 97 +++++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/admin-guide/perf-security.rst
>
> diff --git a/Documentation/admin-guide/perf-security.rst b/Documentation/admin-guide/perf-security.rst
> new file mode 100644
> index 000000000000..f73ebfe9bfe2
> --- /dev/null
> +++ b/Documentation/admin-guide/perf-security.rst
> @@ -0,0 +1,97 @@
> +.. _perf_security:
> +
> +Perf Events and tool security
> +=============================
> +
> +Overview
> +--------
> +
> +Usage of Performance Counters for Linux (perf_events) [1]_ , [2]_ , [3]_ can
> +impose a considerable risk of leaking sensitive data accessed by monitored
> +processes. The data leakage is possible both in scenarios of direct usage of
> +perf_events system call API [2]_ and over data files generated by Perf tool user
> +mode utility (Perf) [3]_ , [4]_ . The risk depends on the nature of data that
> +perf_events performance monitoring units (PMU) [2]_ collect and expose for
> +performance analysis. Having that said perf_events/Perf performance monitoring
> +is the subject for security access control management [5]_ .
> +
> +perf_events/Perf access control
> +-------------------------------
> +
> +To perform security checks, the Linux implementation splits processes into two
> +categories [6]_ : a) privileged processes (whose effective user ID is 0, referred
> +to as superuser or root), and b) unprivileged processes (whose effective UID is
> +nonzero). Privileged processes bypass all kernel security permission checks so
> +perf_events performance monitoring is fully available to privileged processes
> +without access, scope and resource restrictions.
> +
> +Unprivileged processes are subject to a full security permission check based on
> +the process's credentials [5]_ (usually: effective UID, effective GID, and
> +supplementary group list).
> +
> +Linux divides the privileges traditionally associated with superuser into
> +distinct units, known as capabilities [6]_ , which can be independently enabled
> +and disabled on per-thread basis for processes and files of unprivileged users.
> +
> +Unprivileged processes with enabled CAP_SYS_ADMIN capability are treated as
> +privileged processes with respect to perf_events performance monitoring and
> +bypass *scope* permissions checks in the kernel.
> +
> +Unprivileged processes using perf_events system call API is also subject for
> +PTRACE_MODE_READ_REALCREDS ptrace access mode check [7]_ , whose outcome
> +determines whether monitoring is permitted. So unprivileged processes provided
> +with CAP_SYS_PTRACE capability are effectively permitted to pass the check.
> +
> +Other capabilities being granted to unprivileged processes can effectively
> +enable capturing of additional data required for later performance analysis of
> +monitored processes or a system. For example, CAP_SYSLOG capability permits
> +reading kernel space memory addresses from /proc/kallsyms file.
> +
> +perf_events/Perf unprivileged users
> +-----------------------------------
> +
> +perf_events/Perf *scope* and *access* control for unprivileged processes is
> +governed by perf_event_paranoid [2]_ setting:
> +
> +-1:
> +     Impose no *scope* and *access* restrictions on using perf_events performance
> +     monitoring. Per-user per-cpu perf_event_mlock_kb [2]_ locking limit is
> +     ignored when allocating memory buffers for storing performance data.
> +     This is the least secure mode since allowed monitored *scope* is
> +     maximized and no perf_events specific limits are imposed on *resources*
> +     allocated for performance monitoring.
> +
> +>=0:
> +     *scope* includes per-process and system wide performance monitoring
> +     but excludes raw tracepoints and ftrace function tracepoints monitoring.
> +     CPU and system events happened when executing either in user or
> +     in kernel space can be monitored and captured for later analysis.
> +     Per-user per-cpu perf_event_mlock_kb locking limit is imposed but
> +     ignored for unprivileged processes with CAP_IPC_LOCK [6]_ capability.
> +
> +>=1:
> +     *scope* includes per-process performance monitoring only and excludes
> +     system wide performance monitoring. CPU and system events happened when
> +     executing either in user or in kernel space can be monitored and
> +     captured for later analysis. Per-user per-cpu perf_event_mlock_kb
> +     locking limit is imposed but ignored for unprivileged processes with
> +     CAP_IPC_LOCK capability.
> +
> +>=2:
> +     *scope* includes per-process performance monitoring only. CPU and system
> +     events happened when executing in user space only can be monitored and
> +     captured for later analysis. Per-user per-cpu perf_event_mlock_kb
> +     locking limit is imposed but ignored for unprivileged processes with
> +     CAP_IPC_LOCK capability.
> +
> +Bibliography
> +------------
> +
> +.. [1] `<https://lwn.net/Articles/337493/>`_
> +.. [2] `<http://man7.org/linux/man-pages/man2/perf_event_open.2.html>`_
> +.. [3] `<http://web.eece.maine.edu/~vweaver/projects/perf_events/>`_
> +.. [4] `<https://perf.wiki.kernel.org/index.php/Main_Page>`_
> +.. [5] `<https://www.kernel.org/doc/html/latest/security/credentials.html>`_
> +.. [6] `<http://man7.org/linux/man-pages/man7/capabilities.7.html>`_
> +.. [7] `<http://man7.org/linux/man-pages/man2/ptrace.2.html>`_
> +



-- 
Kees Cook
