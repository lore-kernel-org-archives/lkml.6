Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4134C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D3220870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D3220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbeLMR7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:59:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:44620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727618AbeLMR7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 12:59:11 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A084020851;
        Thu, 13 Dec 2018 17:59:09 +0000 (UTC)
Date:   Thu, 13 Dec 2018 12:59:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, stable-rt@vger.kernel.org
Subject: Re: [PATCH RT] x86/mm/pat: disable preemption __split_large_page()
 after spin_lock()
Message-ID: <20181213125907.48e75b89@gandalf.local.home>
In-Reply-To: <20181213164430.mggilzfjgr5retz6@linutronix.de>
References: <20181213164430.mggilzfjgr5retz6@linutronix.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 17:44:31 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Commit "x86/mm/pat: Disable preemption around __flush_tlb_all()" added a
> warning if __flush_tlb_all() is invoked in preemptible context. On !RT
> the warning does not trigger because a spin lock is acquired which
> disables preemption. On RT the spin lock does not disable preemption and
> so the warning is seen.
> 
> Disable preemption to avoid the warning in __flush_tlb_all().

I'm guessing the reason for the warn on is that we don't want a task to
be scheduled in where we expected the TLB to have been flushed.


> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/mm/pageattr.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
> index e2d4b25c7aa44..abbe3e93ec266 100644
> --- a/arch/x86/mm/pageattr.c
> +++ b/arch/x86/mm/pageattr.c
> @@ -687,6 +687,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
>  	pgprot_t ref_prot;
>  
>  	spin_lock(&pgd_lock);

We probably should have comment explaining why we have a
preempt_disable here.

> +	preempt_disable();
>  	/*
>  	 * Check for races, another CPU might have split this page
>  	 * up for us already:
> @@ -694,6 +695,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
>  	tmp = _lookup_address_cpa(cpa, address, &level);
>  	if (tmp != kpte) {
>  		spin_unlock(&pgd_lock);
> +		preempt_enable();

Shouldn't the preempt_enable() be before the unlock?

>  		return 1;
>  	}
>  
> @@ -727,6 +729,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
>  
>  	default:
>  		spin_unlock(&pgd_lock);
> +		preempt_enable();

Here too.

-- Steve

>  		return 1;
>  	}
>  
> @@ -764,6 +767,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
>  	 * going on.
>  	 */
>  	__flush_tlb_all();
> +	preempt_enable();
>  	spin_unlock(&pgd_lock);
>  
>  	return 0;

