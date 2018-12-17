Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9BCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A59E2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732131AbeLQL1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:27:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38111 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbeLQL1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:27:33 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 357F9C0495B4;
        Mon, 17 Dec 2018 11:27:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.131])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2DF1C60F8D;
        Mon, 17 Dec 2018 11:27:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 17 Dec 2018 12:27:32 +0100 (CET)
Date:   Mon, 17 Dec 2018 12:27:31 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ptrace: cleanup do_syscall_trace_enter
Message-ID: <20181217112730.GA25465@redhat.com>
References: <87efbe166y.fsf@concordia.ellerman.id.au>
 <20181203031823.GE11573@altlinux.org>
 <20181207011946.GA18558@altlinux.org>
 <87y391k2tq.fsf@concordia.ellerman.id.au>
 <20181207154255.GA28964@altlinux.org>
 <20181207155605.GB28964@altlinux.org>
 <20181207185226.GB31278@altlinux.org>
 <20181210132806.GA4177@redhat.com>
 <20181210133655.GH11942@altlinux.org>
 <20181216172828.GA25359@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181216172828.GA25359@altlinux.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 17 Dec 2018 11:27:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16, Dmitry V. Levin wrote:
>
>  long do_syscall_trace_enter(struct pt_regs *regs)
>  {
> +	u32 cached_flags;
> +
>  	user_exit();
>  
> -	if (test_thread_flag(TIF_SYSCALL_EMU)) {
> -		/*
> -		 * A nonzero return code from tracehook_report_syscall_entry()
> -		 * tells us to prevent the syscall execution, but we are not
> -		 * going to execute it anyway.
> -		 *
> -		 * Returning -1 will skip the syscall execution. We want to
> -		 * avoid clobbering any register also, thus, not 'gotoing'
> -		 * skip label.
> -		 */
> -		if (tracehook_report_syscall_entry(regs))
> -			;
> -		return -1;
> -	}
> +	cached_flags = READ_ONCE(current_thread_info()->flags) &
> +		       (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE);
>  
> -	/*
> -	 * The tracer may decide to abort the syscall, if so tracehook
> -	 * will return !0. Note that the tracer may also just change
> -	 * regs->gpr[0] to an invalid syscall number, that is handled
> -	 * below on the exit path.
> -	 */
> -	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
> -	    tracehook_report_syscall_entry(regs))
> -		goto skip;
> +	if (cached_flags) {
> +		int rc = tracehook_report_syscall_entry(regs);
> +
> +		if (unlikely(cached_flags & _TIF_SYSCALL_EMU)) {
> +			/*
> +			 * A nonzero return code from
> +			 * tracehook_report_syscall_entry() tells us
> +			 * to prevent the syscall execution, but
> +			 * we are not going to execute it anyway.
> +			 *
> +			 * Returning -1 will skip the syscall execution.
> +			 * We want to avoid clobbering any register also,
> +			 * thus, not 'gotoing' skip label.
> +			 */
> +			return -1;
> +		}
> +
> +		if (rc) {
> +			/*
> +			 * The tracer decided to abort the syscall.
> +			 * Note that the tracer may also just change
> +			 * regs->gpr[0] to an invalid syscall number,
> +			 * that is handled below on the exit path.
> +			 */
> +			goto skip;
> +		}
> +	}

Looks good to me,

Oleg.

