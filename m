Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2CCECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09B220880
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09B220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbeISC0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 22:26:36 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58813 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbeISC0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 22:26:36 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g2Myk-0002x1-8i; Tue, 18 Sep 2018 22:52:14 +0200
Date:   Tue, 18 Sep 2018 22:52:13 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
cc:     LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [REVIEW][PATCH 19/20] signal/x86: Pass pkey by value
In-Reply-To: <20180918000546.12552-19-ebiederm@xmission.com>
Message-ID: <alpine.DEB.2.21.1809182251590.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-19-ebiederm@xmission.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2018, Eric W. Biederman wrote:

> Now that si_code == SEGV_PKUERR is the flag indicating that a pkey
> is present there is no longer a need to pass a pointer to a local
> pkey value, instead pkey can be passed more efficiently by value.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

> ---
>  arch/x86/mm/fault.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 548396aa03e1..c09a0c2fa614 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -769,7 +769,7 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
>  
>  static void
>  __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
> -		       unsigned long address, u32 *pkey, int si_code)
> +		       unsigned long address, u32 pkey, int si_code)
>  {
>  	struct task_struct *tsk = current;
>  
> @@ -818,7 +818,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
>  		tsk->thread.trap_nr	= X86_TRAP_PF;
>  
>  		if (si_code == SEGV_PKUERR)
> -			force_sig_pkuerr((void __user *)address, *pkey);
> +			force_sig_pkuerr((void __user *)address, pkey);
>  
>  		force_sig_fault(SIGSEGV, si_code, (void __user *)address, tsk);
>  
> @@ -835,12 +835,12 @@ static noinline void
>  bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
>  		     unsigned long address)
>  {
> -	__bad_area_nosemaphore(regs, error_code, address, NULL, SEGV_MAPERR);
> +	__bad_area_nosemaphore(regs, error_code, address, 0, SEGV_MAPERR);
>  }
>  
>  static void
>  __bad_area(struct pt_regs *regs, unsigned long error_code,
> -	   unsigned long address, u32 *pkey, int si_code)
> +	   unsigned long address, u32 pkey, int si_code)
>  {
>  	struct mm_struct *mm = current->mm;
>  	/*
> @@ -855,7 +855,7 @@ __bad_area(struct pt_regs *regs, unsigned long error_code,
>  static noinline void
>  bad_area(struct pt_regs *regs, unsigned long error_code, unsigned long address)
>  {
> -	__bad_area(regs, error_code, address, NULL, SEGV_MAPERR);
> +	__bad_area(regs, error_code, address, 0, SEGV_MAPERR);
>  }
>  
>  static inline bool bad_area_access_from_pkeys(unsigned long error_code,
> @@ -906,10 +906,10 @@ bad_area_access_error(struct pt_regs *regs, unsigned long error_code,
>  		 *	     faulted on a pte with its pkey=4.
>  		 */
>  		u32 pkey = vma_pkey(vma);
> -		__bad_area(regs, error_code, address, &pkey, SEGV_PKUERR);
> +		__bad_area(regs, error_code, address, pkey, SEGV_PKUERR);
>  	}
>  	else
> -		__bad_area(regs, error_code, address, NULL, SEGV_ACCERR);
> +		__bad_area(regs, error_code, address, 0, SEGV_ACCERR);
>  }
>  
>  static void
> -- 
> 2.17.1
> 
> 
