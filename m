Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75902C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4732E20685
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4732E20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbeKHSvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:51:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55306 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbeKHSvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:51:17 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 117C87F3E1;
        Thu,  8 Nov 2018 09:16:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id 71E216871F;
        Thu,  8 Nov 2018 09:16:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  8 Nov 2018 10:16:43 +0100 (CET)
Date:   Thu, 8 Nov 2018 10:16:38 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Elvira Khabirova <lineprinter@altlinux.org>
Cc:     Andy Lutomirski <luto@amacapital.net>, rostedt@goodmis.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org, ldv@altlinux.org,
        esyr@redhat.com, luto@kernel.org, strace-devel@lists.strace.io
Subject: Re: [RFC PATCH] ptrace: add PTRACE_GET_SYSCALL_INFO request
Message-ID: <20181108091638.GA9939@redhat.com>
References: <20181107042751.3b519062@akathisia>
 <20181107112100.GA20419@redhat.com>
 <3BDB914D-12F3-4703-A033-EBE02226EC45@amacapital.net>
 <20181107164443.GA8726@redhat.com>
 <20181107210251.542cf8a1@akathisia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107210251.542cf8a1@akathisia>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 08 Nov 2018 09:16:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07, Elvira Khabirova wrote:
>
> On Wed, 7 Nov 2018 17:44:44 +0100
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > To me PT_IN_SYSCALL_STOP makes no real sense, but I won't argue.
> >
> > At least I'd ask to not abuse task->ptrace. ptrace_report_syscall() can clear
> > ->ptrace_message on exit if we really want PTRACE_GET_SYSCALL_INFO to fail after
> > that.
>
> I really would not like to rely on ->ptrace_message remaining empty;
> this looks too fragile.

Well. I do not understand why this is fragile. And certainly this is not more
fragile than

	current->ptrace |= PT_IN_SYSCALL_STOP;
	trace_notify();
	current->ptrace &= ~PT_IN_SYSCALL_STOP;

simply because both ->ptrace updates are technically wrong. The tracee can race
with the exiting tracer which clears ->ptrace.

But even if this was correct. This patch manipulates ->ptrace_message anyway,
I do not understand why should we abuse ->ptrace too just to for the sanity
check in PTRACE_GET_SYSCALL_INFO.

Oleg.

