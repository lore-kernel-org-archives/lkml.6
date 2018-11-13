Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9E4C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 03:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A3C21780
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 03:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A3C21780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbeKMNeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 08:34:15 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:45860 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeKMNeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 08:34:15 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 0891872CA5E;
        Tue, 13 Nov 2018 06:38:03 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id E856B7CD1FF; Tue, 13 Nov 2018 06:38:02 +0300 (MSK)
Date:   Tue, 13 Nov 2018 06:38:02 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Elvira Khabirova <lineprinter@altlinux.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, strace-devel@lists.strace.io
Subject: Re: [RFC PATCH] ptrace: add PTRACE_GET_SYSCALL_INFO request
Message-ID: <20181113033802.GA24679@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrV1v-DPRfDRwiH=xn29bxWxiHdZtAH1nw=dsmDtnT0YGQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 12:44:58PM -0800, Andy Lutomirski wrote:
> > On Nov 6, 2018, at 7:27 PM, Elvira Khabirova <lineprinter@altlinux.org> wrote:
> >
> > PTRACE_GET_SYSCALL_INFO lets ptracer obtain details of the syscall
> > the tracee is blocked in. The request returns meaningful data only
> > when the tracee is in a syscall-enter-stop or a syscall-exit-stop.
> >
> > There are two reasons for a special syscall-related ptrace request.
> >
> > Firstly, with the current ptrace API there are cases when ptracer cannot
> > retrieve necessary information about syscalls. Some examples include:
> > * The notorious int-0x80-from-64-bit-task issue. See [1] for details.
> > In short, if a 64-bit task performs a syscall through int 0x80, its tracer
> > has no reliable means to find out that the syscall was, in fact,
> > a compat syscall, and misidentifies it.
> > * Syscall-enter-stop and syscall-exit-stop look the same for the tracer.
> > Common practice is to keep track of the sequence of ptrace-stops in order
> > not to mix the two syscall-stops up. But it is not as simple as it looks;
> > for example, strace had a (just recently fixed) long-standing bug where
> > attaching strace to a tracee that is performing the execve system call
> > led to the tracer identifying the following syscall-exit-stop as
> > syscall-enter-stop, which messed up all the state tracking.
> > * Since the introduction of commit 84d77d3f06e7e8dea057d10e8ec77ad71f721be3
> > ("ptrace: Don't allow accessing an undumpable mm"), both PTRACE_PEEKDATA
> > and process_vm_readv become unavailable when the process dumpable flag
> > is cleared. On ia64 this results in all syscall arguments being unavailable.
> >
> > Secondly, ptracers also have to support a lot of arch-specific code for
> > obtaining information about the tracee. For some architectures, this
> > requires a ptrace(PTRACE_PEEKUSER, ...) invocation for every syscall
> > argument and return value.
> >
> > PTRACE_GET_SYSCALL_INFO returns the following structure:
> >
> > struct ptrace_syscall_info {
> >    __u8 op; /* 0 for entry, 1 for exit */
> 
> Please consider adding another op for a seccomp stop.

If there are going to be more than two values, I'd suggest introducing
a enum or at least define appropriate macros.

wrt PTRACE_EVENT_SECCOMP, I don't see how the current proposed
implementation of PTRACE_GET_SYSCALL_INFO (based on ptrace_message)
could work in case of PTRACE_EVENT_SECCOMP (which also sets
ptrace_message).  Any ideas?


-- 
ldv
