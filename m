Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8411FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362292075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362292075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeIHBrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:47:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:53670 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbeIHBrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:47:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 14:04:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,343,1531810800"; 
   d="scan'208";a="68392367"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.20])
  by fmsmga007.fm.intel.com with ESMTP; 07 Sep 2018 14:04:40 -0700
Message-ID: <1536354280.11460.28.camel@intel.com>
Subject: Re: [RFC][PATCH 5/8] x86/mm: fix exception table comments
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, tglx@linutronix.de, x86@kernel.org,
        luto@kernel.org
Date:   Fri, 07 Sep 2018 14:04:40 -0700
In-Reply-To: <20180907194900.DF3B41C0@viggo.jf.intel.com>
References: <20180907194852.3C351B82@viggo.jf.intel.com>
         <20180907194900.DF3B41C0@viggo.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-09-07 at 12:49 -0700, Dave Hansen wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The comments here are wrong.  They are too absolute about where
> faults can occur when running in the kernel.  The comments are
> also a bit hard to match up with the code.
> 
> Trim down the comments, and make them more precise.
> 
> Also add a comment explaining why we are doing the
> bad_area_nosemaphore() path here.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: x86@kernel.org
> Cc: Andy Lutomirski <luto@kernel.org>
> ---
> 
>  b/arch/x86/mm/fault.c |   27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff -puN arch/x86/mm/fault.c~pkeys-fault-warnings-03 arch/x86/mm/fault.c
> --- a/arch/x86/mm/fault.c~pkeys-fault-warnings-03	2018-09-07 11:21:47.696751898 -0700
> +++ b/arch/x86/mm/fault.c	2018-09-07 11:21:47.700751898 -0700
> @@ -1349,24 +1349,25 @@ void do_user_addr_space_fault(struct pt_
>  		flags |= FAULT_FLAG_INSTRUCTION;
>  
>  	/*
> -	 * When running in the kernel we expect faults to occur only to
> -	 * addresses in user space.  All other faults represent errors in
> -	 * the kernel and should generate an OOPS.  Unfortunately, in the
> -	 * case of an erroneous fault occurring in a code path which already
> -	 * holds mmap_sem we will deadlock attempting to validate the fault
> -	 * against the address space.  Luckily the kernel only validly
> -	 * references user space from well defined areas of code, which are
> -	 * listed in the exceptions table.
> +	 * Kernel-mode access to the user address space should only occur
> +	 * inside well-defined areas of code listed in the exception
> +	 * tables.  But, an erroneous kernel fault occurring outside one of
> +	 * those areas which also holds mmap_sem might deadlock attempting
> +	 * to validate the fault against the address space.
>  	 *
> -	 * As the vast majority of faults will be valid we will only perform
> -	 * the source reference check when there is a possibility of a
> -	 * deadlock. Attempt to lock the address space, if we cannot we then
> -	 * validate the source. If this is invalid we can skip the address
> -	 * space check, thus avoiding the deadlock:
> +	 * Only do the expensive exception table search when we might be at
> +	 * risk of a deadlock:
> +	 * 1. We failed to acquire mmap_sem, and
> +	 * 2. The access was an explicit kernel-mode access
> +	 *    (X86_PF_USER=0).

Might be worth reminding the reader that X86_PF_USER will be set in
sw_error_code for implicit accesses.  I saw "explicit" and my mind
immediately jumped to hw_error_code for whatever reason.  E.g.:

	* 2. The access was an explicit kernel-mode access (we set X86_PF_USER
	*    in sw_error_code for implicit kernel-mode accesses).

>  	 */
>  	if (unlikely(!down_read_trylock(&mm->mmap_sem))) {
>  		if (!(sw_error_code & X86_PF_USER) &&
>  		    !search_exception_tables(regs->ip)) {
> +			/*
> +			 * Fault from code in kernel from
> +			 * which we do not expect faults.
> +			 */
>  			bad_area_nosemaphore(regs, sw_error_code, address, NULL);
>  			return;
>  		}
> _
