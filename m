Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED43BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 00:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7A120824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 00:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSo4j7P4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7A120824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407951AbeKWLBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 06:01:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:52694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405050AbeKWLBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 06:01:18 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FD2B20878
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 00:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542932364;
        bh=8/wxv7W73DqHr6kxpiRnZfl3rIoXdiSPP4K8G497PhM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HSo4j7P4b0HS7a4HgOdg92NKKfpXG217fQzs5iCA3q1kxd+XxAEdhPZ+nkhT/wBDk
         fnGIdUCWscOpzCCYhG8+VVjTXIAA3B7lNMBH/Uj2YCTzM903u5RQXQKCmTtxpV3M7r
         VVjnJnfNgaGX/DgSjgphmpxeflqMPxVscv3ooUy4=
Received: by mail-wr1-f43.google.com with SMTP id j2so10752990wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 16:19:24 -0800 (PST)
X-Gm-Message-State: AA+aEWYbQCQZPyfnmOPL4cnGhv3+KAY2EduKu2v/8zLeJ/7mcgdwHrke
        /7L+bfFsiP/r/a/ZuKE8EUREq+uYmdhkgKbGCVVxyg==
X-Google-Smtp-Source: AFSGD/WC4QGAWLZ1Jt3BQkDVQ8znvxK7aT653LfubOTbdAWWS867PvZfNZcxGWTek/9uRJ6GLF44RQnLr/DujJ2TQ6Y=
X-Received: by 2002:a5d:5541:: with SMTP id g1mr12065543wrw.330.1542932362678;
 Thu, 22 Nov 2018 16:19:22 -0800 (PST)
MIME-Version: 1.0
References: <20181121165806.07da7c98@akathisia> <CALCETrV3TPCkYyhoLLcikXVeF-RdZUuLTCvKReK3Qb9LSS9Csw@mail.gmail.com>
 <20181121235634.GA14146@altlinux.org> <CALCETrXea_uRAqw_srW5CWgOzeM=RubaDbjnxZ=cUMy5Zv1TsA@mail.gmail.com>
 <20181122191504.GB27204@altlinux.org>
In-Reply-To: <20181122191504.GB27204@altlinux.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 22 Nov 2018 16:19:10 -0800
X-Gmail-Original-Message-ID: <CALCETrXvXzRzoEqwEY_VZ7Vpt-sLwaF+rZPg+y_eG2xyzubXtw@mail.gmail.com>
Message-ID: <CALCETrXvXzRzoEqwEY_VZ7Vpt-sLwaF+rZPg+y_eG2xyzubXtw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] ptrace: add PTRACE_GET_SYSCALL_INFO request
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        strace-devel@lists.strace.io
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 11:15 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> On Thu, Nov 22, 2018 at 06:55:29AM -0800, Andy Lutomirski wrote:
> > On Wed, Nov 21, 2018 at 3:56 PM Dmitry V. Levin wrote:
> > > On Wed, Nov 21, 2018 at 02:56:57PM -0800, Andy Lutomirski wrote:
> > > > Please cc linux-api@vger.kernel.org for future versions.
> > > >
> > > > On Wed, Nov 21, 2018 at 7:58 AM Elvira Khabirova wrote:
> > > > >
> > > > > struct ptrace_syscall_info {
> > > > >         __u8 op; /* 0 for entry, 1 for exit */
> > > >
> > > > Can you add proper defines, like:
> > > >
> > > > #define PTRACE_SYSCALL_ENTRY 0
> > > > #define PTRACE_SYSCALL_EXIT 1
> > > > #define PTRACE_SYSCALL_SECCOMP 2
> > > >
> > > > and make seccomp work from the start?  I'd rather we don't merge an
> > > > implementation that doesn't work for seccomp and then have to rework
> > > > it later.
> > >
> > > What's the difference between PTRACE_EVENT_SECCOMP and syscall-entry-stop
> > > with regards to PTRACE_GET_SYSCALL_INFO request?  At least they have the
> > > same entry_info to return.
> >
> > I'm not sure there's any material difference.
>
> In that case we don't really need PTRACE_SYSCALL_SECCOMP: op field
> describes the structure inside the union to use, not the ptrace stop.

Unless we think the structures might diverge in the future.

>
> > > As long as implementation (ab)uses ptrace_message to tell one kind of stop
> > > from another, it can distinguish syscall-entry-stop and syscall-exit-stop
> > > from each other and from many other kinds of stops, but it cannot
> > > distinguish PTRACE_EVENT_SECCOMP from e.g. PTRACE_EVENT_EXIT.
> >
> > Hmm.  PTRACE_GET_SYSCALL_INFO should fail for PTRACE_EVENT_EXIT, I think.
>
> Unless we can change PTRACE_EVENT_SECCOMP to set some higher bits of
> ptrace_message (beyond SECCOMP_RET_DATA) which is very unlikely because
> it would qualify as an ABI change, this would require an additional field
> in struct task_struct because ptrace_message wouldn't be enough
> to distinguish PTRACE_EVENT_SECCOMP from PTRACE_EVENT_EXIT.

At the risk of making the patch more complicated, there's room to
massively clean up the ptrace state.  We could add a struct
ptrace_tracee and put a struct ptrace_tracee *ptrace_tracee into
task_struct.  The struct would contain a pointer to the task_struct as
well as ptrace (the flag field, I think), ptrace_entry, ptracer_cred,
ptrace_message, and last_siginfo.  And then we could add a field for
the ptrace stop state that would indicate the actual reason for the
current stop.  We'd only allocate ptrace_tracee when someone attaches
with ptrace, thus saving quite a few bytes for each task.

It's a bit unfortunate if we allow PTRACE_GET_SYSCALL_INFO to success
if the event is PTRACE_EVENT_EXIT.  I'd also be a bit nervous about
info leaks if we start calling the syscall accessors for tasks that
aren't in syscalls.

--Andy
