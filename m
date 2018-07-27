Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC799C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD0F208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD0F208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388836AbeG0SlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:41:03 -0400
Received: from smtprelay0229.hostedemail.com ([216.40.44.229]:39774 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728713AbeG0SlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:41:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 3BCAB18224D9C;
        Fri, 27 Jul 2018 17:18:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: waste09_8176f2ae0cf38
X-Filterd-Recvd-Size: 3682
Received: from XPS-9350 (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Fri, 27 Jul 2018 17:18:09 +0000 (UTC)
Message-ID: <26f07092cdde378ebb42c1034badde1b56521c36.camel@perches.com>
Subject: Re: [PATCH v2 04/10] powerpc/traps: Use REG_FMT in show_signal_msg()
From:   Joe Perches <joe@perches.com>
To:     LEROY Christophe <christophe.leroy@c-s.fr>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
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
Date:   Fri, 27 Jul 2018 10:18:08 -0700
In-Reply-To: <20180727184023.Horde.KRXPzZpG18uxt_B9sy_FBg5@messagerie.si.c-s.fr>
References: <20180727145811.12334-1-muriloo@linux.ibm.com>
         <20180727145811.12334-5-muriloo@linux.ibm.com>
         <20180727184023.Horde.KRXPzZpG18uxt_B9sy_FBg5@messagerie.si.c-s.fr>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-27 at 18:40 +0200, LEROY Christophe wrote:
> Murilo Opsfelder Araujo <muriloo@linux.ibm.com> a écrit :
> 
> > Simplify the message format by using REG_FMT as the register format.  This
> > avoids having two different formats and avoids checking for MSR_64BIT.
> 
> Are you sure it is what we want ?
> 
> Won't it change the behaviour for a 32 bits app running on a 64bits kernel ?

[]

> > diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
[]
> > @@ -311,17 +311,13 @@ static bool show_unhandled_signals_ratelimited(void)
> >  static void show_signal_msg(int signr, struct pt_regs *regs, int code,
> >  			    unsigned long addr)
> >  {
> > -	const char fmt32[] = KERN_INFO "%s[%d]: unhandled signal %d " \
> > -		"at %08lx nip %08lx lr %08lx code %x\n";
> > -	const char fmt64[] = KERN_INFO "%s[%d]: unhandled signal %d " \
> > -		"at %016lx nip %016lx lr %016lx code %x\n";
> > -
> >  	if (!unhandled_signal(current, signr))
> >  		return;
> > 
> > -	printk(regs->msr & MSR_64BIT ? fmt64 : fmt32,
> > -	       current->comm, current->pid, signr,
> > -	       addr, regs->nip, regs->link, code);
> > +	pr_info("%s[%d]: unhandled signal %d at "REG_FMT \

I think it better to use a space after the close "
and also the line continuation is unnecessary.

> > +		" nip "REG_FMT" lr "REG_FMT" code %x\n",

And spaces before the open quotes too.

I'd also prefer the format on a single line:

	pr_info("%s[%d]: unhandled signal %d at " REG_FMT " nip " REG_FMT " lr " REG_FMT " code %x\n",

> > +		current->comm, current->pid, signr, addr,
> > +		regs->nip, regs->link, code);

Seeing as these are all unsigned long, a better way to do
this is to use %p and cast to pointer.

This might be better anyway as this output exposes pointer
addresses and instead would now use pointer hashed output.

	pr_info("%s[%d]: unhandled signal %d at %p nip %p lr %p code %x\n",
		current->comm, current->pid, signr,
		(void *)addr, (void *)regs->nip, (void *)regs->link, code);

Use %px if you _really_ need to emit unhashed addresses.

see: Documentation/core-api/printk-formats.rst

