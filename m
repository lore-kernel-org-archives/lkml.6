Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E08EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F942086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F942086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbeKHCQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:16:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727627AbeKHCQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:16:00 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 250054E33B;
        Wed,  7 Nov 2018 16:44:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.205.86])
        by smtp.corp.redhat.com (Postfix) with SMTP id B1ABD105704E;
        Wed,  7 Nov 2018 16:44:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  7 Nov 2018 17:44:51 +0100 (CET)
Date:   Wed, 7 Nov 2018 17:44:44 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>, rostedt@goodmis.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org, ldv@altlinux.org,
        esyr@redhat.com, luto@kernel.org, strace-devel@lists.strace.io
Subject: Re: [RFC PATCH] ptrace: add PTRACE_GET_SYSCALL_INFO request
Message-ID: <20181107164443.GA8726@redhat.com>
References: <20181107042751.3b519062@akathisia>
 <20181107112100.GA20419@redhat.com>
 <3BDB914D-12F3-4703-A033-EBE02226EC45@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3BDB914D-12F3-4703-A033-EBE02226EC45@amacapital.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 07 Nov 2018 16:44:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07, Andy Lutomirski wrote:
>
>
> > On Nov 7, 2018, at 3:21 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> >> On 11/07, Elvira Khabirova wrote:
> >>
> >> In short, if a 64-bit task performs a syscall through int 0x80, its tracer
> >> has no reliable means to find out that the syscall was, in fact,
> >> a compat syscall, and misidentifies it.
> >> * Syscall-enter-stop and syscall-exit-stop look the same for the tracer.
> >
> > Yes, this was discussed many times...
> >
> > So perhaps it makes sense to encode compat/is_enter in ->ptrace_message,
> > debugger can use PTRACE_GETEVENTMSG to get this info.
>
> As I said before, I strongly object to the use of “compat” here.

Not sure I understand you... I do not like "compat" too, but this patch uses
is_compat/etc and I agree with any naming.

> >> Secondly, ptracers also have to support a lot of arch-specific code for
> >> obtaining information about the tracee. For some architectures, this
> >> requires a ptrace(PTRACE_PEEKUSER, ...) invocation for every syscall
> >> argument and return value.
> >
> > I am not sure about this change... I won't really argue, but imo this
> > needs a separate patch.
>
> Why?  Having a single struct that the tracer can read to get the full state is extremely helpful.

As I said, I won't argue, but why can't it come as a separate change?

More info in ->ptrace_message looks usable even without PTRACE_GET_SYSCALL_INFO,
while ptrace_syscall_info layout/API may need more discussion.

> Also, we really want it to work for seccomp events as well as PTRACE_SYSCALL, and the event info trick doesn’t make sense for seccomp events.

I too thought about PTRACE_EVENT_SECCOMP (or I misunderstoo you?), looks like
another reason to make a separate patch.

> >> +#define PT_IN_SYSCALL_STOP    0x00000004    /* task is in a syscall-stop */
> > ...
> >> -static inline int ptrace_report_syscall(struct pt_regs *regs)
> >> +static inline int ptrace_report_syscall(struct pt_regs *regs,
> >> +                    unsigned long message)
> >> {
> >>    int ptrace = current->ptrace;
> >>
> >>    if (!(ptrace & PT_PTRACED))
> >>        return 0;
> >> +    current->ptrace |= PT_IN_SYSCALL_STOP;
> >>
> >> +    current->ptrace_message = message;
> >>    ptrace_notify(SIGTRAP | ((ptrace & PT_TRACESYSGOOD) ? 0x80 : 0));
> >>
> >>    /*
> >> @@ -76,6 +79,7 @@ static inline int ptrace_report_syscall(struct pt_regs *regs)
> >>        current->exit_code = 0;
> >>    }
> >>
> >> +    current->ptrace &= ~PT_IN_SYSCALL_STOP;
> >>    return fatal_signal_pending(current);
> > ...
> >
> >> +    case PTRACE_GET_SYSCALL_INFO:
> >> +        if (child->ptrace & PT_IN_SYSCALL_STOP)
> >> +            ret = ptrace_get_syscall(child, datavp);
> >> +        break;
> >
> > Why? If debugger uses PTRACE_O_TRACESYSGOOD it can know if the tracee reported
> > syscall entry/exit or not. PTRACE_GET_SYSCALL_INFO is pointless if not, but
> > nothing bad can happen.
>
> I think it’s considerably nicer to the user to avoid reporting garbage if the user misused the API.  (And Elvira got this right in the patch — I just missed it.)

To me PT_IN_SYSCALL_STOP makes no real sense, but I won't argue.

At least I'd ask to not abuse task->ptrace. ptrace_report_syscall() can clear
->ptrace_message on exit if we really want PTRACE_GET_SYSCALL_INFO to fail after
that.

Oleg.

