Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501EAC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105BC2073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 105BC2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbeH3Om1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 10:42:27 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49865 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbeH3Om1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 10:42:27 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fvKNh-000137-H5; Thu, 30 Aug 2018 12:40:53 +0200
Date:   Thu, 30 Aug 2018 12:40:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dave Hansen <dave.hansen@intel.com>
cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH] x86/pkeys: Explicitly treat PK #PF on kernel address as
 a bad area
In-Reply-To: <b7fe6fad-7ce4-c7c1-31d7-cb609cf45b2f@intel.com>
Message-ID: <alpine.DEB.2.21.1808301239440.1210@nanos.tec.linutronix.de>
References: <20180807172920.8766-1-sean.j.christopherson@intel.com> <b7fe6fad-7ce4-c7c1-31d7-cb609cf45b2f@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2018, Dave Hansen wrote:
> On 08/07/2018 10:29 AM, Sean Christopherson wrote:
> >  	if (unlikely(fault_in_kernel_space(address))) {
> > +		/*
> > +		 * We should never encounter a protection keys fault on a
> > +		 * kernel address as kernel address are always mapped with
> > +		 * _PAGE_USER=0, i.e. PKRU isn't enforced.
> > +		 */
> > +		if (WARN_ON_ONCE(error_code & X86_PF_PK))
> > +			goto bad_kernel_address;
> 
> I just realized one more thing: the vsyscall page can bite us here.
> It's at a fault_in_kernel_space() address and we *can* trigger a pkey
> fault on it if we jump to an instruction that reads from a
> pkey-protected area.
> 
> We can make a gadget out of unaligned vsyscall instructions that does
> that.  See:
> 
> 0xffffffffff600002:  shlb   $0x0,0x0(%rax)
> 
> Then, we turn off access to all pkeys, including pkey-0, then jump to
> the unaligned vsyscall instruction, which reads %rax, which is a kernel
> address:
> 
>         asm("movl $0xffffffff, %eax;\
>              movl $0x00000000, %ecx;\
>              movl $0x00000000, %edx;\
>              wrpkru;\
>              movq $0xffffffffff600000, %rax;\
>              movq $0xffffffffff600002, %rbx;\
>              jmpq *%rbx;");
> 
> So, my bad.  It was not a good suggestion to do a WARN_ON().  But, the
> other funny thing is I would have expected spurious_fault() to get us
> into a fault loop, which it doesn't.  It's definitely getting *called*
> with my little test program (I see it in ftrace) but it's not quite
> doing what I expect.
> 
> I need to dig a bit more.

Given the time span you should be close to ground water with your digging
by now.

Thanks,

	tglx

