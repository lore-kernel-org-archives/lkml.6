Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606E8C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E200420841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E200420841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387467AbeHAIV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 04:21:27 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:49089 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729769AbeHAIV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 04:21:26 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41gNrf2tnsz9tvqG;
        Wed,  1 Aug 2018 08:37:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id J04Q4ohTvEPf; Wed,  1 Aug 2018 08:37:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41gNrf2CzHz9tvq9;
        Wed,  1 Aug 2018 08:37:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AF7E78B82B;
        Wed,  1 Aug 2018 08:37:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id y4cpvG8Fouo4; Wed,  1 Aug 2018 08:37:18 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5A6508B756;
        Wed,  1 Aug 2018 08:37:18 +0200 (CEST)
Subject: Re: [PATCH v3 5/9] powerpc/traps: Print signal name for unhandled
 signals
To:     Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     Alastair D'Silva <alastair@d-silva.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Cyril Bur <cyrilbur@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Joe Perches <joe@perches.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
References: <20180731145020.14009-1-muriloo@linux.ibm.com>
 <20180731145020.14009-6-muriloo@linux.ibm.com>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <631e9a9b-dbbe-ede7-eb81-81520cc36ad5@c-s.fr>
Date:   Wed, 1 Aug 2018 08:37:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731145020.14009-6-muriloo@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 31/07/2018 à 16:50, Murilo Opsfelder Araujo a écrit :
> This adds a human-readable name in the unhandled signal message.
> 
> Before this patch, a page fault looked like:
> 
>    pandafault[6303]: unhandled signal 11 at 100007d0 nip 1000061c lr 7fff93c55100 code 2 in pandafault[10000000+10000]
> 
> After this patch, a page fault looks like:
> 
>    pandafault[6352]: segfault (11) at 13a2a09f8 nip 13a2a086c lr 7fffb63e5100 code 2 in pandafault[13a2a0000+10000]
> 
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> ---
>   arch/powerpc/kernel/traps.c | 39 +++++++++++++++++++++++++++++++++++--
>   1 file changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 1c4f06fca370..e71f12bca146 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -96,6 +96,41 @@ EXPORT_SYMBOL(__debugger_fault_handler);
>   #define TM_DEBUG(x...) do { } while(0)
>   #endif
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

I don't think is is worth having that full table when we only use a few 
of them. (As discussed in v1 https://patchwork.ozlabs.org/patch/948802/)

I would suggest to instead use a function like this:

static const char *signame(int signr)
{
	if (signr == SIGBUS)
		return "bus error";
	if (signr == SIGFPE)
		return "floating point exception";
	if (signr == SIGILL)
		return "illegal instruction";
	if (signr == SIGILL)
		return "segfault";
	if (signr == SIGTRAP)
		return "unhandled trap";
	return "unknown signal";
}

Christophe

> +
>   /*
>    * Trap & Exception support
>    */
> @@ -314,8 +349,8 @@ static void show_signal_msg(int signr, struct pt_regs *regs, int code,
>   	if (!unhandled_signal(current, signr))
>   		return;
>   
> -	pr_info("%s[%d]: unhandled signal %d at %lx nip %lx lr %lx code %x",
> -		current->comm, current->pid, signr,
> +	pr_info("%s[%d]: %s (%d) at %lx nip %lx lr %lx code %x",
> +		current->comm, current->pid, signames[signr], signr,
>   		addr, regs->nip, regs->link, code);
>   
>   	print_vma_addr(KERN_CONT " in ", regs->nip);
> 
