Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D76DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9798208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9798208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbeK0X3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:29:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726544AbeK0X3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:29:24 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 783A1307EAA6;
        Tue, 27 Nov 2018 12:31:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.12])
        by smtp.corp.redhat.com (Postfix) with SMTP id 35A4F105B1E8;
        Tue, 27 Nov 2018 12:31:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 27 Nov 2018 13:31:37 +0100 (CET)
Date:   Tue, 27 Nov 2018 13:31:17 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Elvira Khabirova <lineprinter@altlinux.org>
Cc:     rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, ldv@altlinux.org, esyr@redhat.com,
        luto@kernel.org, strace-devel@lists.strace.io,
        linux-api@vger.kernel.org
Subject: Re: [RFC PATCH RESEND v3 3/3] ptrace: add PTRACE_EVENT_SECCOMP
 support to PTRACE_GET_SYSCALL_INFO
Message-ID: <20181127123116.GA13284@redhat.com>
References: <20181125022150.46258a20@akathisia>
 <20181125022340.5703400f@akathisia>
 <20181126143524.GB1660@redhat.com>
 <20181127040732.1c9f7965@akathisia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127040732.1c9f7965@akathisia>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 27 Nov 2018 12:31:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27, Elvira Khabirova wrote:
>
> On Mon, 26 Nov 2018 15:35:24 +0100
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > On 11/25, Elvira Khabirova wrote:
> > >
> > > Extend PTRACE_GET_SYSCALL_INFO to support PTRACE_EVENT_SECCOMP stops.
> > > The information returned is the same as for syscall-enter-stops.
> >
> > Oh, this is not nice ;) there must be a better option, I hope... Plus
> >
> >
> > Can't ptrace_get_syscall() check
> >
> > 	child->exit_code == (PTRACE_EVENT_SECCOMP << 8) | SIGTRAP;
> >
> > to detect the PTRACE_EVENT_SECCOMP case?
>
> Nope; looks like exit_code is zeroed after wait().

Yes, thanks for correcting me,

but we can use child->last_siginfo->si_code. Just like ptrace_request(PTRACE_LISTEN)
does but you can do this lockless (no need to lock_task_sighand()).

And if we require that the user of ptrace_get_syscall() should also use TRACESYSGOOD
then ptrace_get_syscall() can probably do something like

	int entry;

	if (!child->last_siginfo)
		return -EINVAL;
	else if (child->last_siginfo->si_code == (PTRACE_EVENT_SECCOMP << 8) | SIGTRAP)
		entry = 1;
	else if (child->last_siginfo->si_code == SIGTRAP | 0x80)
		entry = child->ptrace_message == PTRACE_EVENTMSG_SYSCALL_ENTRY;
	else
		return -EINVAL;

and this way PTRACE_EVENTMSG_SYSCALL_ENTRY/EXIT can't confict with seccomp or
anything else.

No?

Of course, debugger can do PTRACE_SETSIGINFO and confuse itself but probably we
do not care?

Oleg.

