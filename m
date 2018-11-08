Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E683ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F2220825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F2220825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbeKIAJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:09:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbeKIAJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:09:34 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 391B93154852;
        Thu,  8 Nov 2018 14:33:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id EAE75662FF;
        Thu,  8 Nov 2018 14:33:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  8 Nov 2018 15:33:48 +0100 (CET)
Date:   Thu, 8 Nov 2018 15:33:43 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>, rostedt@goodmis.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org, ldv@altlinux.org,
        esyr@redhat.com, luto@kernel.org, strace-devel@lists.strace.io
Subject: Re: [RFC PATCH] ptrace: add PTRACE_GET_SYSCALL_INFO request
Message-ID: <20181108143342.GC9939@redhat.com>
References: <20181107042751.3b519062@akathisia>
 <20181107112100.GA20419@redhat.com>
 <3BDB914D-12F3-4703-A033-EBE02226EC45@amacapital.net>
 <20181107164443.GA8726@redhat.com>
 <35B601B0-4D56-4706-B7A1-C9A522AB2D6F@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35B601B0-4D56-4706-B7A1-C9A522AB2D6F@amacapital.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 08 Nov 2018 14:33:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07, Andy Lutomirski wrote:
>
> > On Nov 7, 2018, at 8:44 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Not sure I understand you... I do not like "compat" too, but this patch uses
> > is_compat/etc and I agree with any naming.
>
> My point is: returning a value to user code that is:
>
> 0 if the kernel and tracee are 32-bit
> 0 if the kernel and tracer are 64-but
> 1 if the kernel is 64-bit and the tracer is 32-bit
> ? If the tracer is arm64 ILP32
>
> Is not a good design.  And 32-bit builds of strace will not appreciate it.

Sure, I agree.

> While oddly named, audit_arch fits the bill nicely, and we already
> require it to have the right semantics for seccomp support.

Again, I agree, and I even mentioned PTRACE_EVENT_SECCOMP.


This reminds me about in_ia32_syscall/TS_COMPAT problems... The 1st one is
get_nr_restart_syscall, I'll try to re-send the fix tomorrow.

Another problem is in_compat_syscall() in get_unmapped_area() paths, it can
return the addr > TASK_SIZE for uprobed 32-bit task.

There was something else but I forgot...

Oleg.

