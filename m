Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0EDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99453208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99453208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbeK2BW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:22:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728387AbeK2BW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:22:28 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 55FB84D4DF;
        Wed, 28 Nov 2018 14:20:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.12])
        by smtp.corp.redhat.com (Postfix) with SMTP id A88AC1057042;
        Wed, 28 Nov 2018 14:20:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 28 Nov 2018 15:20:39 +0100 (CET)
Date:   Wed, 28 Nov 2018 15:20:06 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        strace-devel@lists.strace.io
Subject: Re: [PATCH v4 1/2] ptrace: save the type of syscall-stop in
 ptrace_message
Message-ID: <20181128142006.GE30395@redhat.com>
References: <20181128130439.GB28206@altlinux.org>
 <20181128130601.GC28206@altlinux.org>
 <20181128134913.GC30395@redhat.com>
 <20181128140533.GF28206@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128140533.GF28206@altlinux.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 28 Nov 2018 14:20:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28, Dmitry V. Levin wrote:
>
> On Wed, Nov 28, 2018 at 02:49:14PM +0100, Oleg Nesterov wrote:
> > On 11/28, Dmitry V. Levin wrote:
> > >
> > > +/*
> > > + * These values are stored in task->ptrace_message by tracehook_report_syscall_*
> > > + * to describe current syscall-stop.
> > > + *
> > > + * Values for these constants are chosen so that they do not appear
> > > + * in task->ptrace_message by other means.
> > > + */
> > > +#define PTRACE_EVENTMSG_SYSCALL_ENTRY	0x80000000U
> > > +#define PTRACE_EVENTMSG_SYSCALL_EXIT	0x90000000U
> > 
> > Again, I do not really understand the comment... Why should we care about
> > "do not appear in task->ptrace_message by other means" ?
> > 
> > 2/2 should detect ptrace_report_syscall() case correctly, so we can use any
> > numbers, say, 1 and 2?
> > 
> > If debugger does PTRACE_GETEVENTMSG it should know how to interpet the value
> > anyway after wait(status).
> 
> Given that without this patch the value returned by PTRACE_GETEVENTMSG
> during syscall stop is undefined, we need two different ptrace_message
> values that cannot be set by other ptrace events to enable reliable
> identification of syscall-enter-stop and syscall-exit-stop in userspace:
> if we make PTRACE_GETEVENTMSG return 0 or any other value routinely set by
> other ptrace events, it would be hard for userspace to find out whether
> the kernel implements new semantics or not.

Hmm, why? Debugger can just do ptrace(PTRACE_GET_SYSCALL_INFO, NULL), if it
returns EIO then it is not implemented?

Oleg.

