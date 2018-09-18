Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268BDC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCEB92133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCEB92133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbeISCSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 22:18:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58755 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729770AbeISCSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 22:18:40 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g2Mr2-0002dZ-EP; Tue, 18 Sep 2018 22:44:16 +0200
Date:   Tue, 18 Sep 2018 22:44:16 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
cc:     LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [REVIEW][PATCH 12/20] signal/x86: Remove pkey parameter from
 bad_area_nosemaphore
In-Reply-To: <20180918000546.12552-12-ebiederm@xmission.com>
Message-ID: <alpine.DEB.2.21.1809182242380.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-12-ebiederm@xmission.com>
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
> The function bad_area_nosemaphore always sets si_code to SEGV_MAPERR
> and as such can never return a pkey parameter.  Therefore remove the
> unusable pkey parameter from bad_area_nosemaphore.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Keeping patch for Dave...

> ---
>  arch/x86/mm/fault.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 4112b05d0dec..cfc88920716f 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -897,9 +897,9 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
>  
>  static noinline void
>  bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
> -		     unsigned long address, u32 *pkey)
> +		     unsigned long address)
>  {
> -	__bad_area_nosemaphore(regs, error_code, address, pkey, SEGV_MAPERR);
> +	__bad_area_nosemaphore(regs, error_code, address, NULL, SEGV_MAPERR);
>  }
>  
>  static void
> @@ -1025,7 +1025,7 @@ mm_fault_error(struct pt_regs *regs, unsigned long error_code,
>  			     VM_FAULT_HWPOISON_LARGE))
>  			do_sigbus(regs, error_code, address, pkey, fault);
>  		else if (fault & VM_FAULT_SIGSEGV)
> -			bad_area_nosemaphore(regs, error_code, address, pkey);
> +			bad_area_nosemaphore(regs, error_code, address);
>  		else
>  			BUG();
>  	}
> @@ -1255,7 +1255,7 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
>  		 * Don't take the mm semaphore here. If we fixup a prefetch
>  		 * fault we could otherwise deadlock:
>  		 */
> -		bad_area_nosemaphore(regs, error_code, address, NULL);
> +		bad_area_nosemaphore(regs, error_code, address);
>  
>  		return;
>  	}
> @@ -1268,7 +1268,7 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
>  		pgtable_bad(regs, error_code, address);
>  
>  	if (unlikely(smap_violation(error_code, regs))) {
> -		bad_area_nosemaphore(regs, error_code, address, NULL);
> +		bad_area_nosemaphore(regs, error_code, address);
>  		return;
>  	}
>  
> @@ -1277,7 +1277,7 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
>  	 * in a region with pagefaults disabled then we must not take the fault
>  	 */
>  	if (unlikely(faulthandler_disabled() || !mm)) {
> -		bad_area_nosemaphore(regs, error_code, address, NULL);
> +		bad_area_nosemaphore(regs, error_code, address);
>  		return;
>  	}
>  
> @@ -1323,7 +1323,7 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
>  	if (unlikely(!down_read_trylock(&mm->mmap_sem))) {
>  		if (!(error_code & X86_PF_USER) &&
>  		    !search_exception_tables(regs->ip)) {
> -			bad_area_nosemaphore(regs, error_code, address, NULL);
> +			bad_area_nosemaphore(regs, error_code, address);
>  			return;
>  		}
>  retry:
> -- 
> 2.17.1
> 
> 
