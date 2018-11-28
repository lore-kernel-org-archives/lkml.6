Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FE8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3211D2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3211D2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeK1PpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:45:07 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:43095 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbeK1PpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:45:07 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gRriR-0000Oe-W4; Tue, 27 Nov 2018 21:44:48 -0700
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gRriC-00044z-Jf; Tue, 27 Nov 2018 21:44:47 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181112171144.GI3645@cisco> <87efbqi1xa.fsf@xmission.com>
        <20181112185538.GK3645@cisco> <20181112192443.GL3645@cisco>
        <20181127232126.GA23658@cisco>
        <CAGXu5jLw0m8pG16u3huThNM2fYGjKoB2-5baUmg_FH6Z=L2SAg@mail.gmail.com>
        <CAGXu5jJaZAOzP1qFz66tYrtbuywqb+UN2SOA1VLHpCCOiYvYeg@mail.gmail.com>
Date:   Tue, 27 Nov 2018 22:44:21 -0600
In-Reply-To: <CAGXu5jJaZAOzP1qFz66tYrtbuywqb+UN2SOA1VLHpCCOiYvYeg@mail.gmail.com>
        (Kees Cook's message of "Tue, 27 Nov 2018 17:17:41 -0800")
Message-ID: <87zhtthkuy.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gRriC-00044z-Jf;;;mid=<87zhtthkuy.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+rFwvuMPmkoMbLVuu3j4qmgFDR58J/6L4=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: siginfo pid not populated from ptrace?
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Tue, Nov 27, 2018 at 4:38 PM, Kees Cook <keescook@chromium.org> wrote:
>> On Tue, Nov 27, 2018 at 3:21 PM, Tycho Andersen <tycho@tycho.ws> wrote:
>>> On Mon, Nov 12, 2018 at 12:24:43PM -0700, Tycho Andersen wrote:
>>>> On Mon, Nov 12, 2018 at 11:55:38AM -0700, Tycho Andersen wrote:
>>>> > I haven't manage to reproduce it on stock v4.20-rc2, unfortunately.
>>>>
>>>> Ok, now I have,
>>>>
>>>> seccomp_bpf.c:2736:global.syscall_restart:Expected getpid() (1493) == info._sifields._kill.si_pid (0)
>>>> global.syscall_restart: Test failed at step #22
>>>
>>> Seems like this is still happening on v4.20-rc4,
>>>
>>> [ RUN      ] global.syscall_restart
>>> seccomp_bpf.c:2736:global.syscall_restart:Expected getpid() (1901) == info._sifields._kill.si_pid (0)
>>> global.syscall_restart: Test failed at step #22
>>
>> This fails every time for me -- is it still racey for you?
>>
>> I'm attempting a bisect, hoping it doesn't _become_ racey for me. ;)
>
> This bisect to here for me:
>
> commit f149b31557446aff9ca96d4be7e39cc266f6e7cc
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Mon Sep 3 09:50:36 2018 +0200
>
>     signal: Never allocate siginfo for SIGKILL or SIGSTOP
>
>     The SIGKILL and SIGSTOP signals are never delivered to userspace so
>     queued siginfo for these signals can never be observed.  Therefore
>     remove the chance of failure by never even attempting to allocate
>     siginfo in those cases.
>
>     Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>     Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> They are certainly visible via seccomp ;)

Well SIGSTOP is visible via PTRACE_GETSIGINFO.

I see what is happening now.  Since we don't have queued siginfo
we generate some as:
		/*
		 * Ok, it wasn't in the queue.  This must be
		 * a fast-pathed signal or we must have been
		 * out of queue space.  So zero out the info.
		 */
		clear_siginfo(info);
		info->si_signo = sig;
		info->si_errno = 0;
		info->si_code = SI_USER;
		info->si_pid = 0;
		info->si_uid = 0;

Which allows last_signfo to be set,
so despite not really having any siginfo PTRACE_GET_SIGINFO
has something to return so does not return -EINVAL.

Reconstructing my context that was part of removing SEND_SIG_FORCED
so this looks like it will take a little more than a revert to fix
this.

This is definitely a change that is visible to user space.  The logic in
my patch was definitely wrong with respect to SIGSTOP and
PTRACE_GETSIGINFO.  Is there something in userspace that actually cares?
AKA is the idiom that the test seccomp_bpf.c is using something that
non-test code does?

The change below should restore the old behavior.  I am just wondering
if this is something we want to do.  siginfo is allocated with
GFP_ATOMIC so if your maching is under memory pressure there is a real
chance the allocation can fail.  Which would cause whatever is breaking
now to break less deterministically then.

If we need to fix this do we need to make siginfo allocation more
reliable?

Eric


diff --git a/kernel/signal.c b/kernel/signal.c
index 4fd431ce4f91..5c34c55bfea4 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1057,10 +1057,10 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
 
 	result = TRACE_SIGNAL_DELIVERED;
 	/*
-	 * Skip useless siginfo allocation for SIGKILL SIGSTOP,
+	 * Skip useless siginfo allocation for SIGKILL,
 	 * and kernel threads.
 	 */
-	if (sig_kernel_only(sig) || (t->flags & PF_KTHREAD))
+	if ((sig == SIGKILL) || (t->flags & PF_KTHREAD))
 		goto out_set;
 
 	/*

