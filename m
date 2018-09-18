Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13D6ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E472133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E472133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbeISCUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 22:20:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58764 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729824AbeISCUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 22:20:08 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g2MsV-0002kY-7E; Tue, 18 Sep 2018 22:45:47 +0200
Date:   Tue, 18 Sep 2018 22:45:46 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
cc:     LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [REVIEW][PATCH 13/20] signal/x86: Remove the pkey parameter from
 do_sigbus
In-Reply-To: <20180918000546.12552-13-ebiederm@xmission.com>
Message-ID: <alpine.DEB.2.21.1809182245260.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-13-ebiederm@xmission.com>
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

> The function do_sigbus never sets si_code to PKUERR so it can never
> return a pkey to userspace.  Therefore remove the unusable pkey
> parameter from do_sigbus.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

> ---
>  arch/x86/mm/fault.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index cfc88920716f..6886866c072d 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -962,7 +962,7 @@ bad_area_access_error(struct pt_regs *regs, unsigned long error_code,
>  
>  static void
>  do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
> -	  u32 *pkey, unsigned int fault)
> +	  unsigned int fault)
>  {
>  	struct task_struct *tsk = current;
>  
> @@ -994,7 +994,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
>  		return;
>  	}
>  #endif
> -	force_sig_info_fault(SIGBUS, BUS_ADRERR, address, tsk, pkey);
> +	force_sig_info_fault(SIGBUS, BUS_ADRERR, address, tsk, NULL);
>  }
>  
>  static noinline void
> @@ -1023,7 +1023,7 @@ mm_fault_error(struct pt_regs *regs, unsigned long error_code,
>  	} else {
>  		if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|
>  			     VM_FAULT_HWPOISON_LARGE))
> -			do_sigbus(regs, error_code, address, pkey, fault);
> +			do_sigbus(regs, error_code, address, fault);
>  		else if (fault & VM_FAULT_SIGSEGV)
>  			bad_area_nosemaphore(regs, error_code, address);
>  		else
> -- 
> 2.17.1
> 
> 
