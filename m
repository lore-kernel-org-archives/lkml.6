Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4178C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7FB2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vq2xuS0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7FB2151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732589AbeISV1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:27:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37376 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732471AbeISV1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IdRFGzKgPx+mSTnrPlzqczQqyy1yZQVp2bL/yTgOAQI=; b=Vq2xuS0Y5YqnXuG0mopx8p+kk
        It7zUchJuzQhpSkYR141iuHsXezA/XtlmV4Z32VLDvFqUfmL0BoG0PnBaRqz3j0NUFDfwhjtSrBS0
        SkbH2dPR5i4/2dWt1vocHyo3eCozD9QYf9td2bPUtGwWIWAOFSYlFdlqX+/N5+K9LM0uhIrYBtNF7
        3vus5bXXHBX0I2YAnGxPSM/Cr/J5eD1Vuf/wsP4fW7yxAZvbgdA/reCCvvrW4+Gs1J1O+2b9yUw9c
        TLp+s89ELrLNy6/mb+Ex6X9goVIL+1VHh8VDa7PR9BO/HXFNWis7IzDQv4YN+/yxgqwlWGlH1zp4p
        c23OGM7Hw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2eiN-00040C-Lj; Wed, 19 Sep 2018 15:48:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D5B4E2024E441; Wed, 19 Sep 2018 17:48:28 +0200 (CEST)
Date:   Wed, 19 Sep 2018 17:48:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Schaufler, Casey" <casey.schaufler@intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 0/3] Harden spectrev2 userspace-userspace protection
Message-ID: <20180919154828.GJ24124@hirez.programming.kicks-ass.net>
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809121055070.15880@cbobk.fhfr.pm>
 <99FC4B6EFCEFD44486C35F4C281DC6732144EA58@ORSMSX107.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99FC4B6EFCEFD44486C35F4C281DC6732144EA58@ORSMSX107.amr.corp.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 04:09:33PM +0000, Schaufler, Casey wrote:

> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 5c5e7cb597cd..202a4d9c2af7 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -330,9 +330,7 @@ int __ptrace_may_access(struct task_struct *task, unsigned int mode)
>                !ptrace_has_cap(mm->user_ns, mode))))
>             return -EPERM;
> 
> -       if (!(mode & PTRACE_MODE_NOACCESS_CHK))
> -               return security_ptrace_access_check(task, mode);
> -       return 0;
> +       return security_ptrace_access_check(task, mode);
>  }
> 
>  bool ptrace_may_access(struct task_struct *task, unsigned int mode)
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 161a4f29f860..30d21142e9fe 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2215,7 +2215,12 @@ static int selinux_ptrace_access_check(struct task_struct *child,
>  {
>         u32 sid = current_sid();
>         u32 csid = task_sid(child);
> +       struct av_decision avd;
> 
> +       if (mode == PTRACE_MODE_IBPB)
> +               return avc_has_perm_noaudit(&selinux_state, sid, csid,
> +                                           SECCLASS_PROCESS, PROCESS__PTRACE,
> +                                           0, &avd);
>         if (mode & PTRACE_MODE_READ)
>                 return avc_has_perm(&selinux_state,
>                                     sid, csid, SECCLASS_FILE, FILE__READ, NULL);
> 

As far as I can tell, this still has:

	avc_has_perm_noaudit()
	  security_compute_av()
	    read_lock(&state->ss->policy_rwlock);
	  avc_insert()
	    spin_lock_irqsave();
	  avc_denied()
	    avc_update_node()
	      spin_lock_irqsave();

under the scheduler's raw_spinlock_t, which are invalid lock nestings.
