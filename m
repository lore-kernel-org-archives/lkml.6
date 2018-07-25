Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB434C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547D920843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547D920843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbeGYQyn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 12:54:43 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:8367 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728436AbeGYQyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 12:54:43 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41bKH9273sz9ty7H;
        Wed, 25 Jul 2018 17:42:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 4ikm6VBsBF6w; Wed, 25 Jul 2018 17:42:29 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41bKH91Ym5z9ty76;
        Wed, 25 Jul 2018 17:42:29 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 1E352781; Wed, 25 Jul 2018 17:42:28 +0200 (CEST)
Received: from 37.173.118.119 ([37.173.118.119]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Wed, 25 Jul 2018 17:42:28 +0200
Date:   Wed, 25 Jul 2018 17:42:28 +0200
Message-ID: <20180725174228.Horde.-PsCOyKHj9skAHIMbqyLDg1@messagerie.si.c-s.fr>
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
Subject: Re: [PATCH 2/7] powerpc/traps: Return early in show_signal_msg()
References: <20180724192720.32417-1-muriloo@linux.ibm.com>
 <20180724192720.32417-3-muriloo@linux.ibm.com>
In-Reply-To: <20180724192720.32417-3-muriloo@linux.ibm.com>
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

> Modify logic of show_signal_msg() to return early, if possible.  Replace
> printk_ratelimited() by printk() and a default rate limit burst to limit
> displaying unhandled signals messages.

Can you explain more the benefits of this change ?

Christophe

>
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> ---
>  arch/powerpc/kernel/traps.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index cbd3dc365193..4faab4705774 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -301,6 +301,13 @@ void user_single_step_siginfo(struct task_struct *tsk,
>  	info->si_addr = (void __user *)regs->nip;
>  }
>
> +static bool show_unhandled_signals_ratelimited(void)
> +{
> +	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
> +				      DEFAULT_RATELIMIT_BURST);
> +	return show_unhandled_signals && __ratelimit(&rs);
> +}
> +
>  static void show_signal_msg(int signr, struct pt_regs *regs, int code,
>  			    unsigned long addr)
>  {
> @@ -309,11 +316,12 @@ static void show_signal_msg(int signr, struct  
> pt_regs *regs, int code,
>  	const char fmt64[] = KERN_INFO "%s[%d]: unhandled signal %d " \
>  		"at %016lx nip %016lx lr %016lx code %x\n";
>
> -	if (show_unhandled_signals && unhandled_signal(current, signr)) {
> -		printk_ratelimited(regs->msr & MSR_64BIT ? fmt64 : fmt32,
> -				   current->comm, current->pid, signr,
> -				   addr, regs->nip, regs->link, code);
> -	}
> +	if (!unhandled_signal(current, signr))
> +		return;
> +
> +	printk(regs->msr & MSR_64BIT ? fmt64 : fmt32,
> +	       current->comm, current->pid, signr,
> +	       addr, regs->nip, regs->link, code);
>  }
>
>  void _exception_pkey(int signr, struct pt_regs *regs, int code,
> @@ -326,7 +334,8 @@ void _exception_pkey(int signr, struct pt_regs  
> *regs, int code,
>  		return;
>  	}
>
> -	show_signal_msg(signr, regs, code, addr);
> +	if (show_unhandled_signals_ratelimited())
> +		show_signal_msg(signr, regs, code, addr);
>
>  	if (arch_irqs_disabled() && !arch_irq_disabled_regs(regs))
>  		local_irq_enable();
> --
> 2.17.1


