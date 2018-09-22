Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7A9ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 14:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908252146E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 14:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WS9iI+0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908252146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbeIVUZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 16:25:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50454 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbeIVUZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 16:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lSVbdL3HDTceWV3oqY2prchSt6K8Ab3m2RIQmqixTr8=; b=WS9iI+0F13cVwSO3Hx+UsnGE1
        Kqx0ZpNmbpD4J0mIL8E1MRrhgNgOp3pDxCKDhsahSZwa/nASkXIP5nSbZgfQ7jT2RvHQUv9ui4rHB
        DlFXMVK7teok0QKrEjhjNDAQzaeQ/gMJN1VDMBBB8H1z8N59XcobUM36CUnNbdK7WOQifrGNXft3b
        1EaVjwaCjUrQA6g1fw8P0KuaDl9kXsDcvIMa336El0CnTJfd2UtUyeux8XEubda3Bvcmg2LJdPCyt
        j4Ar/9ifwmz/esiZEg2G828bw+RoFVI+e0gkCydiFSuwVpK+d7j58AZZ2DG8MDtK4U/28Xweol5Qo
        zag3bGVrg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g3iwU-00051C-DP; Sat, 22 Sep 2018 14:31:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1E42C2024E445; Sat, 22 Sep 2018 16:31:27 +0200 (CEST)
Date:   Sat, 22 Sep 2018 16:31:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 0/3] Harden spectrev2 userspace-userspace protection
Message-ID: <20180922143127.GJ24124@hirez.programming.kicks-ass.net>
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809121055070.15880@cbobk.fhfr.pm>
 <99FC4B6EFCEFD44486C35F4C281DC6732144EA58@ORSMSX107.amr.corp.intel.com>
 <20180919154828.GJ24124@hirez.programming.kicks-ass.net>
 <nycvar.YFH.7.76.1809220936520.15880@cbobk.fhfr.pm>
 <alpine.DEB.2.21.1809221022250.1391@nanos.tec.linutronix.de>
 <20180922101844.GF24124@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1809221219270.1391@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1809221527140.1391@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809221527140.1391@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 03:30:07PM +0200, Thomas Gleixner wrote:
> On Sat, 22 Sep 2018, Thomas Gleixner wrote:
> > On Sat, 22 Sep 2018, Peter Zijlstra wrote:
> > > This has some unfortunate duplication.
> > > 
> > > Lets go with it for now, but I'll see if I can do something about that
> > > later.
> > 
> > Yes, I know. I tried to make the duplication smaller, but all attempts
> > ended up being a convoluted mess. I'll try again after applying more
> > coffee.
> 
> Lunch and coffee indeed made brain work better. The simple solution was way
> too obvious.
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -261,6 +261,9 @@ static int ptrace_check_attach(struct ta
>  
>  static int ptrace_has_cap(struct user_namespace *ns, unsigned int mode)
>  {
> +	if (mode & PTRACE_MODE_SCHED)
> +		return false;
> +
>  	if (mode & PTRACE_MODE_NOAUDIT)
>  		return has_ns_capability_noaudit(current, ns, CAP_SYS_PTRACE);
>  	else
> @@ -328,9 +331,16 @@ static int __ptrace_may_access(struct ta
>  	     !ptrace_has_cap(mm->user_ns, mode)))
>  	    return -EPERM;
>  
> +	if (mode & PTRACE_MODE_SCHED)
> +		return 0;
>  	return security_ptrace_access_check(task, mode);
>  }
>  
> +bool ptrace_may_access_sched(struct task_struct *task, unsigned int mode)
> +{
> +	return __ptrace_may_access(task, mode | PTRACE_MODE_SCHED);
> +}

Ha!, much nicer. Thanks!
