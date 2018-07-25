Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62BEC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E0920852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E0920852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbeGYRNz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:13:55 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:57521 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728600AbeGYRNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:13:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41bKjD0bXcz9ttgH;
        Wed, 25 Jul 2018 18:01:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id JmzXKJiaOXmg; Wed, 25 Jul 2018 18:01:36 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41bKjD01mtz9ttg8;
        Wed, 25 Jul 2018 18:01:36 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id E71FBCAA; Wed, 25 Jul 2018 18:01:34 +0200 (CEST)
Received: from 37.173.118.119 ([37.173.118.119]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Wed, 25 Jul 2018 18:01:34 +0200
Date:   Wed, 25 Jul 2018 18:01:34 +0200
Message-ID: <20180725180134.Horde.BdhyE2b-TXhoVB7W8bsBhg1@messagerie.si.c-s.fr>
From:   LEROY Christophe <christophe.leroy@c-s.fr>
To:     Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, "Tobin C . Harding" <me@tobin.cc>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Neuling <mikey@neuling.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Cyril Bur <cyrilbur@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Alastair D'Silva <alastair@d-silva.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] powerpc/traps: Show instructions on exceptions
References: <20180724192720.32417-1-muriloo@linux.ibm.com>
 <20180724192720.32417-8-muriloo@linux.ibm.com>
In-Reply-To: <20180724192720.32417-8-muriloo@linux.ibm.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Murilo Opsfelder Araujo <muriloo@linux.ibm.com> a écrit :

> Move show_instructions() declaration to arch/powerpc/include/asm/stacktrace.h
> and include asm/stracktrace.h in arch/powerpc/kernel/process.c,  
> which contains
> the implementation.
>
> Modify show_instructions() not to call __kernel_text_address(), allowing
> userspace instruction dump.  probe_kernel_address(), which returns -EFAULT if
> something goes wrong, is still being called.
>
> Call show_instructions() in arch/powerpc/kernel/traps.c to dump  
> instructions at
> faulty location, useful to debugging.

Shouldn't this part be in a second patch ?

Wouldn't it be better to also see regs in addition if we want to use  
this to understand what happened ?
So you could call show_regs() instead of show_instructions() ?

Christophe

>
> Before this patch, an unhandled signal message looked like:
>
>     Jul 24 09:57:00 localhost kernel: pandafault[10524]: segfault  
> (11) at 00000000100007d0 nip 000000001000061c lr 00007fffbd295100  
> code 2 in pandafault[10000000+10000]
>
> After this patch, it looks like:
>
>     Jul 24 09:57:00 localhost kernel: pandafault[10524]: segfault  
> (11) at 00000000100007d0 nip 000000001000061c lr 00007fffbd295100  
> code 2 in pandafault[10000000+10000]
>     Jul 24 09:57:00 localhost kernel: Instruction dump:
>     Jul 24 09:57:00 localhost kernel: 4bfffeec 4bfffee8 3c401002  
> 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
>     Jul 24 09:57:00 localhost kernel: 392988d0 f93f0020 e93f0020  
> 39400048 <99490000> 39200000 7d234b78 383f0040
>
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/stacktrace.h | 7 +++++++
>  arch/powerpc/kernel/process.c         | 6 +++---
>  arch/powerpc/kernel/traps.c           | 3 +++
>  3 files changed, 13 insertions(+), 3 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/stacktrace.h
>
> diff --git a/arch/powerpc/include/asm/stacktrace.h  
> b/arch/powerpc/include/asm/stacktrace.h
> new file mode 100644
> index 000000000000..46e5ef451578
> --- /dev/null
> +++ b/arch/powerpc/include/asm/stacktrace.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_POWERPC_STACKTRACE_H
> +#define _ASM_POWERPC_STACKTRACE_H
> +
> +void show_instructions(struct pt_regs *regs);
> +
> +#endif /* _ASM_POWERPC_STACKTRACE_H */
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index b1af3390249c..ee1d63e03c52 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -52,6 +52,7 @@
>  #include <asm/machdep.h>
>  #include <asm/time.h>
>  #include <asm/runlatch.h>
> +#include <asm/stacktrace.h>
>  #include <asm/syscalls.h>
>  #include <asm/switch_to.h>
>  #include <asm/tm.h>
> @@ -1261,7 +1262,7 @@ struct task_struct *__switch_to(struct  
> task_struct *prev,
>
>  static int instructions_to_print = 16;
>
> -static void show_instructions(struct pt_regs *regs)
> +void show_instructions(struct pt_regs *regs)
>  {
>  	int i;
>  	unsigned long pc = regs->nip - (instructions_to_print * 3 / 4 *
> @@ -1283,8 +1284,7 @@ static void show_instructions(struct pt_regs *regs)
>  			pc = (unsigned long)phys_to_virt(pc);
>  #endif
>
> -		if (!__kernel_text_address(pc) ||
> -		     probe_kernel_address((unsigned int __user *)pc, instr)) {
> +		if (probe_kernel_address((unsigned int __user *)pc, instr)) {
>  			pr_cont("XXXXXXXX ");
>  		} else {
>  			if (regs->nip == pc)
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index e55ee639d010..3beca17ac1b1 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -70,6 +70,7 @@
>  #include <asm/hmi.h>
>  #include <sysdev/fsl_pci.h>
>  #include <asm/kprobes.h>
> +#include <asm/stacktrace.h>
>
>  #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC_CORE)
>  int (*__debugger)(struct pt_regs *regs) __read_mostly;
> @@ -357,6 +358,8 @@ static void show_signal_msg(int signr, struct  
> pt_regs *regs, int code,
>  	print_vma_addr(KERN_CONT " in ", regs->nip);
>
>  	pr_cont("\n");
> +
> +	show_instructions(regs);
>  }
>
>  void _exception_pkey(int signr, struct pt_regs *regs, int code,
> --
> 2.17.1


