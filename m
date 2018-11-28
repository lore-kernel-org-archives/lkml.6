Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E019DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A671B20989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUVpQ9US"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A671B20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeK2KVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:21:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:42564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbeK2KVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:21:20 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7360F2154B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 23:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543447083;
        bh=bxAM7ltx5XC6qmxKpnV3A+uLJ2l1kN84hmfOSjSQGQ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mUVpQ9USZQEPf5vOngflrM1xMH7g2menQd410kOIzXGvGjAKAijQm7RyiUi9K076l
         uFGZurIetgxXzC34k6fucXQUsJ1ueB5cogbbENwQMg6BPIdzvo27S8Z3606h66BWLU
         KnFyzMT0t3tH/UUFjJqctY5nIjYe8zIqGCJ4wpCE=
Received: by mail-wr1-f52.google.com with SMTP id v13so12903wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 15:18:03 -0800 (PST)
X-Gm-Message-State: AA+aEWaZlwW0cnWV7b8p9KuKynYY/yeZnwMWfP7T2/nhaTYYPjHPa7iQ
        dqCYkRvLJx7k2c/iHl1S1U4idI+323sOf2/yLbSW7Q==
X-Google-Smtp-Source: AFSGD/XgYIh+gz4d7B1moYaGTn09nObDfnqXScbToF83XB02ucudP6vERM2p0zBKSPWbYfH1YIr9Sy8ty7kqVgzVjsg=
X-Received: by 2002:a5d:5541:: with SMTP id g1mr33776117wrw.330.1543447081767;
 Wed, 28 Nov 2018 15:18:01 -0800 (PST)
MIME-Version: 1.0
References: <20181128130439.GB28206@altlinux.org> <20181128130601.GC28206@altlinux.org>
 <20181128134913.GC30395@redhat.com> <20181128140533.GF28206@altlinux.org>
 <20181128142006.GE30395@redhat.com> <20181128152346.GG28206@altlinux.org> <20181128221125.GA2800@altlinux.org>
In-Reply-To: <20181128221125.GA2800@altlinux.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 28 Nov 2018 15:17:49 -0800
X-Gmail-Original-Message-ID: <CALCETrVjMorQDsJzQGaREEB5_7B24ApWSoNQfRd3K3QNSGAyEA@mail.gmail.com>
Message-ID: <CALCETrVjMorQDsJzQGaREEB5_7B24ApWSoNQfRd3K3QNSGAyEA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] ptrace: save the type of syscall-stop in ptrace_message
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, strace-devel@lists.strace.io
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 2:11 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> On Wed, Nov 28, 2018 at 06:23:46PM +0300, Dmitry V. Levin wrote:
> > On Wed, Nov 28, 2018 at 03:20:06PM +0100, Oleg Nesterov wrote:
> > > On 11/28, Dmitry V. Levin wrote:
> > > > On Wed, Nov 28, 2018 at 02:49:14PM +0100, Oleg Nesterov wrote:
> > > > > On 11/28, Dmitry V. Levin wrote:
> > > > > >
> > > > > > +/*
> > > > > > + * These values are stored in task->ptrace_message by tracehook_report_syscall_*
> > > > > > + * to describe current syscall-stop.
> > > > > > + *
> > > > > > + * Values for these constants are chosen so that they do not appear
> > > > > > + * in task->ptrace_message by other means.
> > > > > > + */
> > > > > > +#define PTRACE_EVENTMSG_SYSCALL_ENTRY        0x80000000U
> > > > > > +#define PTRACE_EVENTMSG_SYSCALL_EXIT 0x90000000U
> > > > >
> > > > > Again, I do not really understand the comment... Why should we care about
> > > > > "do not appear in task->ptrace_message by other means" ?
> > > > >
> > > > > 2/2 should detect ptrace_report_syscall() case correctly, so we can use any
> > > > > numbers, say, 1 and 2?
> > > > >
> > > > > If debugger does PTRACE_GETEVENTMSG it should know how to interpet the value
> > > > > anyway after wait(status).
> > > >
> > > > Given that without this patch the value returned by PTRACE_GETEVENTMSG
> > > > during syscall stop is undefined, we need two different ptrace_message
> > > > values that cannot be set by other ptrace events to enable reliable
> > > > identification of syscall-enter-stop and syscall-exit-stop in userspace:
> > > > if we make PTRACE_GETEVENTMSG return 0 or any other value routinely set by
> > > > other ptrace events, it would be hard for userspace to find out whether
> > > > the kernel implements new semantics or not.
> > >
> > > Hmm, why? Debugger can just do ptrace(PTRACE_GET_SYSCALL_INFO, NULL), if it
> > > returns EIO then it is not implemented?
> >
> > The debugger that uses PTRACE_GET_SYSCALL_INFO does not need to call
> > PTRACE_GETEVENTMSG for syscall stops.
> > My concern here is the PTRACE_GETEVENTMSG interface itself.  If we use
> > ptrace_message to implement PTRACE_GET_SYSCALL_INFO and expose
> > PTRACE_EVENTMSG_SYSCALL_{ENTRY,EXIT} for regular PTRACE_GETEVENTMSG users,
> > it should have clear semantics.
>
> Since our implementation of PTRACE_GET_SYSCALL_INFO uses ptrace_message
> to distinguish syscall-enter-stop from syscall-exit-stop, we could choose
> one of the following approaches:
>
> 1. Do not document the values saved into ptrace_message during syscall
> stops (and exposed via PTRACE_GETEVENTMSG) as a part of ptrace API,
> leaving the value returned by PTRACE_GETEVENTMSG during syscall stops
> as undefined.
>
> 2. Document these values chosen to avoid collisions with ptrace_message values
> set by other ptrace events so that PTRACE_GETEVENTMSG users can easily tell
> whether this new semantics is supported by the kernel or not.

I don't like any of this at all.  Can we please choose a sensible API
design and let the API drive the implementation instead of vice versa?
 ISTM the correct solution is to add some new state to task_struct for
this.

If we're concerned about making task_struct bigger, I have a
half-finished patch to factor all the ptrace tracee state into a
separate struct.
