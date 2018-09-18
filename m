Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B72AC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25F12133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25F12133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbeISCUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 22:20:39 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58771 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729824AbeISCUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 22:20:38 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g2Msz-0002m5-UL; Tue, 18 Sep 2018 22:46:18 +0200
Date:   Tue, 18 Sep 2018 22:46:17 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
cc:     LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [REVIEW][PATCH 14/20] signal/x86: Remove pkey parameter from
 mm_fault_error
In-Reply-To: <20180918000546.12552-14-ebiederm@xmission.com>
Message-ID: <alpine.DEB.2.21.1809182246030.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-14-ebiederm@xmission.com>
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

> After the previous cleanups to do_sigbus and and bad_area_nosemaphore
> mm_fault_error no now longer uses it's pkey parameter.  Therefore
> remove the unused parameter.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

> ---
>  arch/x86/mm/fault.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 6886866c072d..7ba00519fa5d 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -999,7 +999,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
>  
>  static noinline void
>  mm_fault_error(struct pt_regs *regs, unsigned long error_code,
> -	       unsigned long address, u32 *pkey, vm_fault_t fault)
> +	       unsigned long address, vm_fault_t fault)
>  {
>  	if (fatal_signal_pending(current) && !(error_code & X86_PF_USER)) {
>  		no_context(regs, error_code, address, 0, 0);
> @@ -1419,7 +1419,7 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
>  
>  	up_read(&mm->mmap_sem);
>  	if (unlikely(fault & VM_FAULT_ERROR)) {
> -		mm_fault_error(regs, error_code, address, &pkey, fault);
> +		mm_fault_error(regs, error_code, address, fault);
>  		return;
>  	}
>  
> -- 
> 2.17.1
> 
> 
