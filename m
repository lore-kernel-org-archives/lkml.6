Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42B1C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD36D20811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD36D20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbeLMS1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:27:16 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:47401 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbeLMS1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 13:27:16 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gXVhZ-0005Be-5c; Thu, 13 Dec 2018 19:27:13 +0100
Date:   Thu, 13 Dec 2018 19:27:13 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, stable-rt@vger.kernel.org
Subject: Re: [PATCH RT] x86/mm/pat: disable preemption __split_large_page()
 after spin_lock()
Message-ID: <20181213182712.gmxuixlcjepr2hfg@linutronix.de>
References: <20181213164430.mggilzfjgr5retz6@linutronix.de>
 <20181213125907.48e75b89@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181213125907.48e75b89@gandalf.local.home>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-13 12:59:07 [-0500], Steven Rostedt wrote:
> On Thu, 13 Dec 2018 17:44:31 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > Disable preemption to avoid the warning in __flush_tlb_all().
> 
> I'm guessing the reason for the warn on is that we don't want a task to
> be scheduled in where we expected the TLB to have been flushed.
during the cr3 read + write, correct.

> > --- a/arch/x86/mm/pageattr.c
> > +++ b/arch/x86/mm/pageattr.c
> > @@ -687,6 +687,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
> >  	pgprot_t ref_prot;
> >  
> >  	spin_lock(&pgd_lock);
> 
> We probably should have comment explaining why we have a
> preempt_disable here.
okay.

> > +	preempt_disable();
> >  	/*
> >  	 * Check for races, another CPU might have split this page
> >  	 * up for us already:
> > @@ -694,6 +695,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
> >  	tmp = _lookup_address_cpa(cpa, address, &level);
> >  	if (tmp != kpte) {
> >  		spin_unlock(&pgd_lock);
> > +		preempt_enable();
> 
> Shouldn't the preempt_enable() be before the unlock?

Yeah, I noticed it once I saw the patch on the list. Will flip it before
I apply it.

> >  		return 1;
> >  	}
> >  

Sebastian
