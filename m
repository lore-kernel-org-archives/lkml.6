Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE76DC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BB9204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BB9204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbeGYRBp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:01:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:32278 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728568AbeGYRBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:01:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41bKRD5PCMz9ty7H;
        Wed, 25 Jul 2018 17:49:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id kISTIzbL2iAP; Wed, 25 Jul 2018 17:49:28 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41bKRD4khlz9ty76;
        Wed, 25 Jul 2018 17:49:28 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 968508A8; Wed, 25 Jul 2018 17:49:27 +0200 (CEST)
Received: from 37.173.118.119 ([37.173.118.119]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Wed, 25 Jul 2018 17:49:27 +0200
Date:   Wed, 25 Jul 2018 17:49:27 +0200
Message-ID: <20180725174927.Horde.Sfg4oyTmcaLgHIJr3Gf-oQ1@messagerie.si.c-s.fr>
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
Subject: Re: [PATCH 6/7] powerpc/traps: Print signal name for unhandled
 signals
References: <20180724192720.32417-1-muriloo@linux.ibm.com>
 <20180724192720.32417-7-muriloo@linux.ibm.com>
In-Reply-To: <20180724192720.32417-7-muriloo@linux.ibm.com>
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

> This adds a human-readable name in the unhandled signal message.
>
> Before this patch, a page fault looked like:
>
>     Jul 11 16:04:11 localhost kernel: pandafault[6303]: unhandled  
> signal 11 at 00000000100007d0 nip 000000001000061c lr  
> 00007fff93c55100 code 2 in pandafault[10000000+10000]
>
> After this patch, a page fault looks like:
>
>     Jul 11 18:14:48 localhost kernel: pandafault[6352]: segfault  
> (11) at 000000013a2a09f8 nip 000000013a2a086c lr 00007fffb63e5100  
> code 2 in pandafault[13a2a0000+10000]
>
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> ---
>  arch/powerpc/kernel/traps.c | 43 +++++++++++++++++++++++++++++++++----
>  1 file changed, 39 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index e6c43ef9fb50..e55ee639d010 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -96,6 +96,41 @@ EXPORT_SYMBOL(__debugger_fault_handler);
>  #define TM_DEBUG(x...) do { } while(0)
>  #endif
>
> +static const char *signames[SIGRTMIN + 1] = {
> +	"UNKNOWN",
> +	"SIGHUP",			// 1
> +	"SIGINT",			// 2
> +	"SIGQUIT",			// 3
> +	"SIGILL",			// 4
> +	"unhandled trap",		// 5 = SIGTRAP
> +	"SIGABRT",			// 6 = SIGIOT
> +	"bus error",			// 7 = SIGBUS
> +	"floating point exception",	// 8 = SIGFPE
> +	"illegal instruction",		// 9 = SIGILL
> +	"SIGUSR1",			// 10
> +	"segfault",			// 11 = SIGSEGV
> +	"SIGUSR2",			// 12
> +	"SIGPIPE",			// 13
> +	"SIGALRM",			// 14
> +	"SIGTERM",			// 15
> +	"SIGSTKFLT",			// 16
> +	"SIGCHLD",			// 17
> +	"SIGCONT",			// 18
> +	"SIGSTOP",			// 19
> +	"SIGTSTP",			// 20
> +	"SIGTTIN",			// 21
> +	"SIGTTOU",			// 22
> +	"SIGURG",			// 23
> +	"SIGXCPU",			// 24
> +	"SIGXFSZ",			// 25
> +	"SIGVTALRM",			// 26
> +	"SIGPROF",			// 27
> +	"SIGWINCH",			// 28
> +	"SIGIO",			// 29 = SIGPOLL = SIGLOST
> +	"SIGPWR",			// 30
> +	"SIGSYS",			// 31 = SIGUNUSED
> +};
> +
>  /*
>   * Trap & Exception support
>   */
> @@ -314,10 +349,10 @@ static void show_signal_msg(int signr, struct  
> pt_regs *regs, int code,
>  	if (!unhandled_signal(current, signr))
>  		return;
>
> -	pr_info("%s[%d]: unhandled signal %d at "REG_FMT \
> -		" nip "REG_FMT" lr "REG_FMT" code %x",
> -		current->comm, current->pid, signr, addr,
> -		regs->nip, regs->link, code);
> +	pr_info("%s[%d]: %s (%d) at "REG_FMT" nip "REG_FMT \
> +		" lr "REG_FMT" code %x",
> +		current->comm, current->pid, signames[signr],
> +		signr, addr, regs->nip, regs->link, code);

Are we sure that signr is always within the limits of the table ?

Christophe
>
>  	print_vma_addr(KERN_CONT " in ", regs->nip);
>
> --
> 2.17.1


