Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +4KGNdpAGVsKZgAAmS7hNA
	; Thu, 07 Jun 2018 14:28:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 869F0607E7; Thu,  7 Jun 2018 14:28:10 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v6jAzqmf"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C835C602FC;
	Thu,  7 Jun 2018 14:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C835C602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933442AbeFGO2H (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:28:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933109AbeFGO2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:28:05 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C634F20874;
        Thu,  7 Jun 2018 14:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528381685;
        bh=cKfTWHn4bApmxNupxe0cN6bVHenJzbuAqXzobEilQlc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=v6jAzqmf7DAFZdhPSDM7gzi0mBnAFJH1J56pCOb/oAnZJ+RH8IIWF+4k4JMpNA9Hz
         +QxGDdQ7POOj95EmzTiuBgLP3AB5vplXkzTD0dqt+ezeW8U5f4DBy3WwjurIG7snZE
         0Hp2G4p4Pf7TfgxKEDE+Z6AAtIy4USgJ7CcRm608=
Date: Thu, 7 Jun 2018 23:28:02 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH -tip v5 18/27] powerpc/kprobes: Don't call the
 ->break_handler() in arm kprobes code
Message-Id: <20180607232802.c5fcea960e94ef2f3cd4cde8@kernel.org>
In-Reply-To: <1528371112.vwnh1m0k39.naveen@linux.ibm.com>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
        <152812783350.10068.4690566636762511152.stgit@devbox>
        <1528371112.vwnh1m0k39.naveen@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Jun 2018 17:07:00 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Masami Hiramatsu wrote:
> > Don't call the ->break_handler() from the arm kprobes code,
> 					    ^^^ powerpc
> 
> > because it was only used by jprobes which got removed.
> > 
> > This also makes skip_singlestep() a static function since
> > only ftrace-kprobe.c is using this function.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > ---
> >  arch/powerpc/include/asm/kprobes.h   |   10 ----------
> >  arch/powerpc/kernel/kprobes-ftrace.c |   16 +++-------------
> >  arch/powerpc/kernel/kprobes.c        |   31 +++++++++++--------------------
> >  3 files changed, 14 insertions(+), 43 deletions(-)
> 
> With 2 small comments...

2 ? or 1 ?

> Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> 
> - Naveen
> 
> > 
> > diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
> > index 674036db558b..785c464b6588 100644
> > --- a/arch/powerpc/include/asm/kprobes.h
> > +++ b/arch/powerpc/include/asm/kprobes.h
> > @@ -102,16 +102,6 @@ extern int kprobe_exceptions_notify(struct notifier_block *self,
> >  extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
> >  extern int kprobe_handler(struct pt_regs *regs);
> >  extern int kprobe_post_handler(struct pt_regs *regs);
> > -#ifdef CONFIG_KPROBES_ON_FTRACE
> > -extern int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
> > -			   struct kprobe_ctlblk *kcb);
> > -#else
> > -static inline int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
> > -				  struct kprobe_ctlblk *kcb)
> > -{
> > -	return 0;
> > -}
> > -#endif
> >  #else
> >  static inline int kprobe_handler(struct pt_regs *regs) { return 0; }
> >  static inline int kprobe_post_handler(struct pt_regs *regs) { return 0; }
> > diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/kprobes-ftrace.c
> > index 1b316331c2d9..3869b0e5d5c7 100644
> > --- a/arch/powerpc/kernel/kprobes-ftrace.c
> > +++ b/arch/powerpc/kernel/kprobes-ftrace.c
> > @@ -26,8 +26,8 @@
> >  #include <linux/ftrace.h>
> > 
> >  static nokprobe_inline
> > -int __skip_singlestep(struct kprobe *p, struct pt_regs *regs,
> > -		      struct kprobe_ctlblk *kcb, unsigned long orig_nip)
> > +int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
> > +		    struct kprobe_ctlblk *kcb, unsigned long orig_nip)
> >  {
> >  	/*
> >  	 * Emulate singlestep (and also recover regs->nip)
> > @@ -44,16 +44,6 @@ int __skip_singlestep(struct kprobe *p, struct pt_regs *regs,
> >  	return 1;
> >  }
> > 
> > -int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
> > -		    struct kprobe_ctlblk *kcb)
> > -{
> > -	if (kprobe_ftrace(p))
> > -		return __skip_singlestep(p, regs, kcb, 0);
> > -	else
> > -		return 0;
> > -}
> > -NOKPROBE_SYMBOL(skip_singlestep);
> > -
> >  /* Ftrace callback handler for kprobes */
> >  void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
> >  			   struct ftrace_ops *ops, struct pt_regs *regs)
> > @@ -82,7 +72,7 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
> >  		__this_cpu_write(current_kprobe, p);
> >  		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> >  		if (!p->pre_handler || !p->pre_handler(p, regs))
> > -			__skip_singlestep(p, regs, kcb, orig_nip);
> > +			skip_singlestep(p, regs, kcb, orig_nip);
> 
> We can probably get rid of skip_singlestep() completely along with 
> orig_nip since instructions are always 4 bytes on powerpc. So, the 
> changes we do to nip should help to recover the value automatically.

Good point! Yes, skip_singlestep() is no more exported, so we just consolidate
it into kprobe_ftrace_handler() for simplifying operation.

Thank you!
> 
> - Naveen
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
