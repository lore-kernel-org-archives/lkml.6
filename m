Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFD8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA8B205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA8B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbeK2Xdp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:33:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbeK2Xdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:33:45 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D387081DF3;
        Thu, 29 Nov 2018 12:28:32 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-117-253.ams2.redhat.com [10.36.117.253])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23C4F68377;
        Thu, 29 Nov 2018 12:28:25 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        serge@hallyn.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dancol@google.com, timmurray@google.com,
        linux-man@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
References: <20181120105124.14733-1-christian@brauner.io>
Date:   Thu, 29 Nov 2018 13:28:15 +0100
In-Reply-To: <20181120105124.14733-1-christian@brauner.io> (Christian
        Brauner's message of "Tue, 20 Nov 2018 11:51:23 +0100")
Message-ID: <87in0g5aqo.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 29 Nov 2018 12:28:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disclaimer: I'm looking at this patch because Christian requested it.
I'm not a kernel developer.

* Christian Brauner:

> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 3cf7b533b3d1..3f27ffd8ae87 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -398,3 +398,4 @@
>  384	i386	arch_prctl		sys_arch_prctl			__ia32_compat_sys_arch_prctl
>  385	i386	io_pgetevents		sys_io_pgetevents		__ia32_compat_sys_io_pgetevents
>  386	i386	rseq			sys_rseq			__ia32_sys_rseq
> +387	i386	procfd_signal		sys_procfd_signal		__ia32_compat_sys_procfd_signal
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index f0b1709a5ffb..8a30cde82450 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -343,6 +343,7 @@
>  332	common	statx			__x64_sys_statx
>  333	common	io_pgetevents		__x64_sys_io_pgetevents
>  334	common	rseq			__x64_sys_rseq
> +335	64	procfd_signal		__x64_sys_procfd_signal
>  
>  #
>  # x32-specific system call numbers start at 512 to avoid cache impact
> @@ -386,3 +387,4 @@
>  545	x32	execveat		__x32_compat_sys_execveat/ptregs
>  546	x32	preadv2			__x32_compat_sys_preadv64v2
>  547	x32	pwritev2		__x32_compat_sys_pwritev64v2
> +548	x32	procfd_signal		__x32_compat_sys_procfd_signal

Is there a reason why these numbers have to be different?

(See the recent discussion with Andy Lutomirski.)

> +static int do_procfd_signal(int fd, int sig, kernel_siginfo_t *kinfo, int flags,
> +			    bool had_siginfo)
> +{
> +	int ret;
> +	struct fd f;
> +	struct pid *pid;
> +
> +	/* Enforce flags be set to 0 until we add an extension. */
> +	if (flags)
> +		return -EINVAL;
> +
> +	f = fdget_raw(fd);
> +	if (!f.file)
> +		return -EBADF;
> +
> +	/* Is this a process file descriptor? */
> +	ret = -EINVAL;
> +	if (!proc_is_tgid_procfd(f.file))
> +		goto err;
[…]
> +	ret = kill_pid_info(sig, kinfo, pid);

I would like to see some comment here what happens to zombie processes.

> +/**
> + *  sys_procfd_signal - send a signal to a process through a process file
> + *                      descriptor
> + *  @fd: the file descriptor of the process
> + *  @sig: signal to be sent
> + *  @info: the signal info
> + *  @flags: future flags to be passed
> + */
> +SYSCALL_DEFINE4(procfd_signal, int, fd, int, sig, siginfo_t __user *, info,
> +		int, flags)

Sorry, I'm quite unhappy with the name.  “signal” is for signal handler
management.  procfd_sendsignal, procfd_sigqueueinfo or something like
that would be fine.  Even procfd_kill would be better IMHO.

Looking at the rt_tgsigqueueinfo interface, is there a way to implement
the “tg” part with the current procfd_signal interface?  Would you use
openat to retrieve the Tgid: line from "status"?

Thanks,
Florian
