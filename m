Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70694C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045AE2438C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045AE2438C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933395AbeFVO2v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:28:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41809 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbeFVO2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:28:49 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWN3B-0006WO-C4; Fri, 22 Jun 2018 16:28:33 +0200
Date:   Fri, 22 Jun 2018 16:28:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
cc:     Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/7] x86/fsgsbase/64: Introduce FS/GS base helper
 functions
In-Reply-To: <1529536506-26237-2-git-send-email-chang.seok.bae@intel.com>
Message-ID: <alpine.DEB.2.21.1806221610500.2402@nanos.tec.linutronix.de>
References: <1529536506-26237-1-git-send-email-chang.seok.bae@intel.com> <1529536506-26237-2-git-send-email-chang.seok.bae@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018, Chang S. Bae wrote:
> +void write_fsbase(unsigned long fsbase)
> +{
> +	/* set the selector to 0 to not confuse __switch_to */

'to not confuse __switch_to' is not that helpful of a comment as it
requires to stare into __switch_to to figure out what might get confused
there. Please write it out why this needs to be done in technical terms.

> +	loadseg(FS, 0);
> +	wrmsrl(MSR_FS_BASE, fsbase);
> +}
> +
> +void write_inactive_gsbase(unsigned long gsbase)
> +{
> +	/* set the selector to 0 to not confuse __switch_to */

Ditto

> +	loadseg(GS, 0);
> +	wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
> +}
> +
> +unsigned long read_task_fsbase(struct task_struct *task)
> +{
> +	unsigned long fsbase;
> +
> +	if (task == current) {
> +		fsbase = read_fsbase();
> +	} else {
> +		/*
> +		 * XXX: This will not behave as expected if called
> +		 * if fsindex != 0. This preserves an existing bug
> +		 * that will be fixed.

I'm late to this party, but let me ask the obvious question:

    Why is the existing bug not fixed as the first patch in the series?

We do not preserve bugs when adding new stuff as that makes it a pain to
backport the fix.

> +int write_task_fsbase(struct task_struct *task, unsigned long fsbase)
> +{
> +	int cpu;
> +
> +	/*
> +	 * Not strictly needed for fs, but do it for symmetry
> +	 * with gs
> +	 */
> +	if (unlikely(fsbase >= TASK_SIZE_MAX))
> +		return -EPERM;
> +
> +	cpu = get_cpu();

What's the point of using get_cpu()? There is nothing at all which needs
'cpu' here.  The only point is to prevent preemption, then please use
preempt_disable() and not some random function which happens to disable
preemption underneath.

> +	task->thread.fsbase = fsbase;
> +	if (task == current)
> +		write_fsbase(fsbase);
> +	task->thread.fsindex = 0;
> +	put_cpu();
> +
> +	return 0;
> +}
> +
> +int write_task_gsbase(struct task_struct *task, unsigned long gsbase)
> +{
> +	int cpu;
> +
> +	if (unlikely(gsbase >= TASK_SIZE_MAX))
> +		return -EPERM;
> +
> +	cpu = get_cpu();

Ditto

> +	task->thread.gsbase = gsbase;
> +	if (task == current)
> +		write_inactive_gsbase(gsbase);
> +	task->thread.gsindex = 0;
> +	put_cpu();
> +
> +	return 0;
> +}
> +
>  int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
>  		unsigned long arg, struct task_struct *p, unsigned long tls)
>  {
> @@ -618,54 +707,27 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
>  long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
>  {
>  	int ret = 0;
> -	int doit = task == current;
> -	int cpu;
>  
>  	switch (option) {
> -	case ARCH_SET_GS:
> -		if (arg2 >= TASK_SIZE_MAX)
> -			return -EPERM;
> -		cpu = get_cpu();

Ah. You copied it from here where it makes no sense either. Copy and paste
is useful, but you really want to think about it.

> diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
> index e2ee403..c53c2bcf6 100644
> --- a/arch/x86/kernel/ptrace.c
> +++ b/arch/x86/kernel/ptrace.c

....

>  		if (child->thread.fsbase != value)
> -			return do_arch_prctl_64(child, ARCH_SET_FS, value);
> +			return write_task_fsbase(child, value);

This patch wants to be split into:

     1) Adding the new functions

     2) Convert vdso

     3) Convert ptrace

_AFTER_ fixing the existing bug.

Thanks,

	tglx
