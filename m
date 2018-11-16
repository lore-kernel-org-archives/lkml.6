Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBC5C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D632087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D632087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389716AbeKPWym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 17:54:42 -0500
Received: from ozlabs.org ([203.11.71.1]:51243 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbeKPWyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 17:54:41 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42xHtn347bz9sDC;
        Fri, 16 Nov 2018 23:42:25 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Elvira Khabirova <lineprinter@altlinux.org>,
        benh@kernel.crashing.org, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        leitao@debian.org, oleg@redhat.com, luto@kernel.org,
        ldv@altlinux.org, esyr@redhat.com
Subject: Re: [PATCH v2] powerpc/ptrace: replace ptrace_report_syscall() with a tracehook call
In-Reply-To: <20181116121701.14359da0@akathisia>
References: <20181116121701.14359da0@akathisia>
Date:   Fri, 16 Nov 2018 23:42:24 +1100
Message-ID: <87ftw12nyn.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Elvira Khabirova <lineprinter@altlinux.org> writes:

> Arch code should use tracehook_*() helpers, as documented
> in include/linux/tracehook.h.

Thanks.

It probably also should have a comment explaining why we're ignoring the
return value and why that's OK.

cheers

> Fixes: 5521eb4bca2d ("powerpc/ptrace: Add support for PTRACE_SYSEMU")
> Signed-off-by: Elvira Khabirova <lineprinter@altlinux.org>
> ---
>  arch/powerpc/kernel/ptrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index afb819f4ca68..d79d907f9acc 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -3266,7 +3266,7 @@ long do_syscall_trace_enter(struct pt_regs *regs)
>  	user_exit();
>  
>  	if (test_thread_flag(TIF_SYSCALL_EMU)) {
> -		ptrace_report_syscall(regs);
> +		(void) tracehook_report_syscall_entry(regs);
>  		/*
>  		 * Returning -1 will skip the syscall execution. We want to
>  		 * avoid clobbering any register also, thus, not 'gotoing'
> -- 
> 2.19.1
