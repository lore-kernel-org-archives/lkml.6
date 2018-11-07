Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512E0C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 11:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208DC208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 11:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208DC208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbeKGUvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:51:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbeKGUvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:51:03 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 989702D7E8;
        Wed,  7 Nov 2018 11:21:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id D1F075D75C;
        Wed,  7 Nov 2018 11:21:01 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  7 Nov 2018 12:21:07 +0100 (CET)
Date:   Wed, 7 Nov 2018 12:21:01 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Elvira Khabirova <lineprinter@altlinux.org>
Cc:     rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, ldv@altlinux.org, esyr@redhat.com,
        luto@kernel.org, strace-devel@lists.strace.io
Subject: Re: [RFC PATCH] ptrace: add PTRACE_GET_SYSCALL_INFO request
Message-ID: <20181107112100.GA20419@redhat.com>
References: <20181107042751.3b519062@akathisia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107042751.3b519062@akathisia>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 07 Nov 2018 11:21:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07, Elvira Khabirova wrote:
>
> In short, if a 64-bit task performs a syscall through int 0x80, its tracer
> has no reliable means to find out that the syscall was, in fact,
> a compat syscall, and misidentifies it.
> * Syscall-enter-stop and syscall-exit-stop look the same for the tracer.

Yes, this was discussed many times...

So perhaps it makes sense to encode compat/is_enter in ->ptrace_message,
debugger can use PTRACE_GETEVENTMSG to get this info.

> Secondly, ptracers also have to support a lot of arch-specific code for
> obtaining information about the tracee. For some architectures, this
> requires a ptrace(PTRACE_PEEKUSER, ...) invocation for every syscall
> argument and return value.

I am not sure about this change... I won't really argue, but imo this
needs a separate patch.

> +#define PT_IN_SYSCALL_STOP	0x00000004	/* task is in a syscall-stop */
...
> -static inline int ptrace_report_syscall(struct pt_regs *regs)
> +static inline int ptrace_report_syscall(struct pt_regs *regs,
> +					unsigned long message)
>  {
>  	int ptrace = current->ptrace;
>  
>  	if (!(ptrace & PT_PTRACED))
>  		return 0;
> +	current->ptrace |= PT_IN_SYSCALL_STOP;
>  
> +	current->ptrace_message = message;
>  	ptrace_notify(SIGTRAP | ((ptrace & PT_TRACESYSGOOD) ? 0x80 : 0));
>  
>  	/*
> @@ -76,6 +79,7 @@ static inline int ptrace_report_syscall(struct pt_regs *regs)
>  		current->exit_code = 0;
>  	}
>  
> +	current->ptrace &= ~PT_IN_SYSCALL_STOP;
>  	return fatal_signal_pending(current);
...

> +	case PTRACE_GET_SYSCALL_INFO:
> +		if (child->ptrace & PT_IN_SYSCALL_STOP)
> +			ret = ptrace_get_syscall(child, datavp);
> +		break;

Why? If debugger uses PTRACE_O_TRACESYSGOOD it can know if the tracee reported
syscall entry/exit or not. PTRACE_GET_SYSCALL_INFO is pointless if not, but
nothing bad can happen.

Oleg.

