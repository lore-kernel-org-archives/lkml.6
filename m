Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CBDECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E132133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E132133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbeISCWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 22:22:37 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58786 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729902AbeISCWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 22:22:37 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g2Mut-0002pe-88; Tue, 18 Sep 2018 22:48:15 +0200
Date:   Tue, 18 Sep 2018 22:48:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
cc:     LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [REVIEW][PATCH 16/20] signal/x86: Pass pkey not vma into
 __bad_area
In-Reply-To: <20180918000546.12552-16-ebiederm@xmission.com>
Message-ID: <alpine.DEB.2.21.1809182247010.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-16-ebiederm@xmission.com>
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

> There is only one caller of __bad_area that passes in PKUERR and thus
> will generate a siginfo with si_pkey set.  Therefore simplify the
> logic and hoist reading of vma_pkey up into that caller, and just
> pass *pkey into __bad_area.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/x86/mm/fault.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index f82106578364..11a93f14a674 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -904,22 +904,16 @@ bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
>  
>  static void
>  __bad_area(struct pt_regs *regs, unsigned long error_code,
> -	   unsigned long address,  struct vm_area_struct *vma, int si_code)
> +	   unsigned long address, u32 *pkey, int si_code)
>  {
>  	struct mm_struct *mm = current->mm;
> -	u32 pkey;
> -
> -	if (vma)
> -		pkey = vma_pkey(vma);
> -
>  	/*
>  	 * Something tried to access memory that isn't in our memory map..
>  	 * Fix it, but check if it's kernel or user first..
>  	 */
>  	up_read(&mm->mmap_sem);
>  
> -	__bad_area_nosemaphore(regs, error_code, address,
> -			       (vma) ? &pkey : NULL, si_code);
> +	__bad_area_nosemaphore(regs, error_code, address, pkey, si_code);
>  }
>  
>  static noinline void
> @@ -954,10 +948,12 @@ bad_area_access_error(struct pt_regs *regs, unsigned long error_code,
>  	 * But, doing it this way allows compiler optimizations
>  	 * if pkeys are compiled out.
>  	 */
> -	if (bad_area_access_from_pkeys(error_code, vma))
> -		__bad_area(regs, error_code, address, vma, SEGV_PKUERR);
> +	if (bad_area_access_from_pkeys(error_code, vma)) {
> +		u32 pkey = vma_pkey(vma);
> +		__bad_area(regs, error_code, address, &pkey, SEGV_PKUERR);
> +	}
>  	else
> -		__bad_area(regs, error_code, address, vma, SEGV_ACCERR);
> +		__bad_area(regs, error_code, address, NULL, SEGV_ACCERR);

Please make that:

	} else {
		__bad_area(regs, error_code, address, NULL, SEGV_ACCERR);
	}
       
With that fixed:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
