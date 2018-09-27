Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9AEC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BE7216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BE7216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeI1CDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:03:45 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:50820 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbeI1CDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:03:45 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g5cCJ-0004mD-2v; Thu, 27 Sep 2018 13:43:39 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g5cCG-0001ja-UY; Thu, 27 Sep 2018 13:43:38 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, linux-sgx@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 MM)
References: <20180925130845.9962-1-jarkko.sakkinen@linux.intel.com>
        <20180925130845.9962-10-jarkko.sakkinen@linux.intel.com>
Date:   Thu, 27 Sep 2018 21:43:15 +0200
In-Reply-To: <20180925130845.9962-10-jarkko.sakkinen@linux.intel.com> (Jarkko
        Sakkinen's message of "Tue, 25 Sep 2018 16:06:46 +0300")
Message-ID: <87zhw2ohf0.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g5cCG-0001ja-UY;;;mid=<87zhw2ohf0.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+xE+Rd+QqQGLxya5kt+TXMDzgj14CRP48=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v14 09/19] x86/mm: x86/sgx: Signal SEGV_SGXERR for #PFs w/ PF_SGX
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> writes:

> From: Sean Christopherson <sean.j.christopherson@intel.com>
>
> Signal SIGSEGV(SEGV_SGXERR) for all faults with PF_SGX set in the
> error code.  The PF_SGX bit is set if and only if the #PF is detected
> by the Enclave Page Cache Map (EPCM), which is consulted only after
> an access walks the kernel's page tables, i.e.:
>
>   a. the access was allowed by the kernel
>   b. the kernel's tables have become less restrictive than the EPCM
>   c. the kernel cannot fixup the cause of the fault
>
> Noteably, (b) implies that either the kernel has botched the EPC
> mappings or the EPCM has been invalidated due to a power event.  In
> either case, userspace needs to be alerted so that it can take
> appropriate action, e.g. restart the enclave.  This is reinforced
> by (c) as the kernel doesn't really have any other reasonable option,
> e.g. we could kill the task or panic, but neither is warranted.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  arch/x86/mm/fault.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 85d20516b2f3..3fb2b2838d6c 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -960,10 +960,13 @@ static noinline void
>  bad_area_access_error(struct pt_regs *regs, unsigned long error_code,
>  		      unsigned long address, struct vm_area_struct *vma)
>  {
> +	int si_code = SEGV_ACCERR;
> +
>  	if (bad_area_access_from_pkeys(error_code, vma))
> -		__bad_area(regs, error_code, address, vma, SEGV_PKUERR);
> -	else
> -		__bad_area(regs, error_code, address, vma, SEGV_ACCERR);
> +		si_code = SEGV_PKUERR;
> +	else if (unlikely(error_code & X86_PF_SGX))
> +		si_code = SEGV_SGXERR;
> +	__bad_area(regs, error_code, address, vma, si_code);
>  }

This conflicts with a cleanup in this area I have sitting in linux-next.
It isn't in the x86 tree but you can find my siginfo tree at:

git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git siginfo-next

In my tree bad area no longer takes a vma parameter.

If you are going to make changes to the fault handling code this cycle
please let's figure out how to build it on top of my clean ups.

Thank you,
Eric Biederman


