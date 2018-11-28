Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6417AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2930A20989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2930A20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbeK1XhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:37:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727676AbeK1XhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:37:24 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8E4FE308FF0C;
        Wed, 28 Nov 2018 12:35:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.12])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3A4ED2DE67;
        Wed, 28 Nov 2018 12:35:47 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 28 Nov 2018 13:35:52 +0100 (CET)
Date:   Wed, 28 Nov 2018 13:35:46 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        strace-devel@lists.strace.io, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RESEND v3 3/3] ptrace: add PTRACE_EVENT_SECCOMP
 support to PTRACE_GET_SYSCALL_INFO
Message-ID: <20181128123545.GA30395@redhat.com>
References: <20181125022150.46258a20@akathisia>
 <20181125022340.5703400f@akathisia>
 <20181126143524.GB1660@redhat.com>
 <20181127040732.1c9f7965@akathisia>
 <20181127123116.GA13284@redhat.com>
 <20181127232753.GA18755@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127232753.GA18755@altlinux.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 28 Nov 2018 12:35:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28, Dmitry V. Levin wrote:
>
> > Just like ptrace_request(PTRACE_LISTEN)
> > does but you can do this lockless (no need to lock_task_sighand()).
>
> Why this can be done lockless?  All other places in that file do
> the locking,

PTRACE_LISTEN too doesn't need lock_task_sighand() to access ->last_siginfo,
this code predates ptrace_freeze_traced() which ensures that the tracee can't
go away and clear ->last_siginfo.

However, unlike ptrace_get_syscall(), PTRACE_LISTEN needs spin_lock_irq(siglock),
it modifies ->jobctl and calls signal_wake_up().

> > Of course, debugger can do PTRACE_SETSIGINFO and confuse itself but probably we
> > do not care?
>
> The only potential issue I could think of is whether PTRACE_SETSIGINFO
> could be used this way to cause an information leak by making
> PTRACE_GET_SYSCALL_INFO access some unrelated data.

Well, afaics ptrace_get_syscall() does nothing "special", debugger can use other
PTRACE_ requests to get the same info?

Oleg.

