Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49045C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7B420664
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7B420664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbeK0NuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 08:50:23 -0500
Received: from air.basealt.ru ([194.107.17.39]:54672 "EHLO air.basealt.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727542AbeK0NuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 08:50:23 -0500
Received: by air.basealt.ru (Postfix, from userid 490)
        id 030A6589AE9; Tue, 27 Nov 2018 02:53:59 +0000 (UTC)
Received: from akathisia (broadband-46-188-15-144.2com.net [46.188.15.144])
        by air.basealt.ru (Postfix) with ESMTPSA id 4C771589AE7;
        Tue, 27 Nov 2018 02:53:58 +0000 (UTC)
Date:   Tue, 27 Nov 2018 03:53:57 +0100
From:   Elvira Khabirova <lineprinter@altlinux.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, ldv@altlinux.org, esyr@redhat.com,
        luto@kernel.org, strace-devel@lists.strace.io,
        linux-api@vger.kernel.org
Subject: Re: [PATCH RESEND v3 1/3] ptrace: pass type of a syscall-stop in
 ptrace_message
Message-ID: <20181127035357.0b381323@akathisia>
In-Reply-To: <20181126145643.GD1660@redhat.com>
References: <20181125022150.46258a20@akathisia>
        <20181125022227.55e8caf7@akathisia>
        <20181126145643.GD1660@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018 15:56:43 +0100
Oleg Nesterov <oleg@redhat.com> wrote:

> On 11/25, Elvira Khabirova wrote:
> >
> > + * These values are stored in task->ptrace_message by tracehook_report_syscall_*
> > + * to describe current syscall-stop.
> > + *
> > + * Values for these constants are chosen so that they do not appear
> > + * in task->ptrace_message by other means.
> > + */
> > +#define PTRACE_EVENTMSG_SYSCALL_ENTRY	0x80000000U
> > +#define PTRACE_EVENTMSG_SYSCALL_EXIT	0x90000000U  
> 
> Stupid question, why not
> 
> 	#define PTRACE_EVENT_SYSCALL_ENTRY	8
> 	#define PTRACE_EVENT_SYSCALL_EXIT	9
> 
> right after other PTRACE_EVENT_* constants?

I thought about adding new events for syscall {entry,exit}.
For tracers, using new events means setting new options and checking
for new values after waitpid(). They will also have to switch from using
PTRACE_SYSCALL to PTRACE_CONT.
Right now (with this version of the patch) tracers can use
PTRACE_GETEVENTMSG without doing any additional configuration.
More importantly, adding these events would require much more complex
modifications of kernel code than this patch does.
The only benefit I see from adding these events instead of letting
syscall-stops put a value in ptrace_message is an ability to subscribe
to syscall entries, but not to exits, and vice-versa, and I don't think
it is worth it.
