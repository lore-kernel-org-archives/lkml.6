Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87740ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 10:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40EDD21523
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 10:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ufkh0eZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40EDD21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeIVQMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 12:12:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49924 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbeIVQME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 12:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1bNhqFpd+/d6m4CxLiz9FXUYWUZNpxNbSe5s88iOrO4=; b=ufkh0eZMNlfjPKRCKJOyCnEAS
        +R+JP48Y5oaRDzHLuDi4G0unQvB20kqkyYHyIKVPUZA6/XlBYEDQ+BfvvBmuhI028ME6wd3sV55YR
        EgPGlLhielvTpiU30hW658iOIjsa1J3enXkx+LOrWIFsVWafz8jo5oWMcpgaTF9NtLRgtEruRFOiY
        gv1ezIa1Wb/xl3RgAC243BHQRXwvBIOanT26HzlHx3tg40N0eZacXJrUZpjZajsnM5H8XbNe6rns7
        rZUOc5ppieW8TgvYq+9UZlhucXKPOM85d921GuEfX6oc9hro3hrAUUS+d3OZJYv/1OU3gMoYQcYS8
        srguGPsiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g3ezv-0004Zb-5e; Sat, 22 Sep 2018 10:18:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 149412024E449; Sat, 22 Sep 2018 12:18:44 +0200 (CEST)
Date:   Sat, 22 Sep 2018 12:18:44 +0200
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
Message-ID: <20180922101844.GF24124@hirez.programming.kicks-ass.net>
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809121055070.15880@cbobk.fhfr.pm>
 <99FC4B6EFCEFD44486C35F4C281DC6732144EA58@ORSMSX107.amr.corp.intel.com>
 <20180919154828.GJ24124@hirez.programming.kicks-ass.net>
 <nycvar.YFH.7.76.1809220936520.15880@cbobk.fhfr.pm>
 <alpine.DEB.2.21.1809221022250.1391@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809221022250.1391@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 11:53:14AM +0200, Thomas Gleixner wrote:
> @@ -86,6 +88,7 @@ extern void exit_ptrace(struct task_stru
>   * process_vm_writev or ptrace (and should use the real credentials).
>   */
>  extern bool ptrace_may_access(struct task_struct *task, unsigned int mode);
> +extern bool ptrace_may_access_sched(struct task_struct *task, unsigned int mode);

I like that..

>  static inline int ptrace_reparented(struct task_struct *child)
>  {
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c

> +bool ptrace_may_access_sched(struct task_struct *task, unsigned int mode)
> +{
> +	struct mm_struct *mm;
> +	int res;
> +
> +	res = __ptrace_may_access_basic(task, mode);
> +	if (res <= 0)
> +		return !res;
> +
> +	rcu_read_lock();
> +	res = __ptrace_may_access_cred(__task_cred(task), mode);
>  	rcu_read_unlock();
> +	if (res)
> +		return false;
> +
> +	mm = task->mm;
> +	if (mm && get_dumpable(mm) != SUID_DUMP_USER)
> +		return false;
> +	return true;
> +}
> +
> +/* Returns 0 on success, -errno on denial. */
> +static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
> +{
> +	const struct cred *tcred;
> +	struct mm_struct *mm;
> +	int res;
> +
> +	res = __ptrace_may_access_basic(task, mode);
> +	if (res <= 0)
> +		return res;
> +
> +	rcu_read_lock();
> +	tcred = __task_cred(task);
> +	res = __ptrace_may_access_cred(tcred, mode);
> +	if (res > 0)
> +		res = ptrace_has_cap(tcred->user_ns, mode) ? 0 : -EPERM;
>  	rcu_read_unlock();
> +	if (res < 0)
> +		return res;
> +
>  	mm = task->mm;
> +	if (mm && (get_dumpable(mm) != SUID_DUMP_USER &&
> +		   !ptrace_has_cap(mm->user_ns, mode)))
> +		return -EPERM;
>  
>  	return security_ptrace_access_check(task, mode);
>  }

This has some unfortunate duplication.

Lets go with it for now, but I'll see if I can do something about that
later.
