Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15464C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76FE23FA0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76FE23FA0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753025AbeGCUok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:44:40 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45442 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752399AbeGCUoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:44:39 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1faS9w-0002Uy-N7; Tue, 03 Jul 2018 22:44:24 +0200
Date:   Tue, 3 Jul 2018 22:44:24 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 07/13] x86/sgx: data structures for tracking available
 EPC pages
In-Reply-To: <00ca61d5-5a1d-5c83-3b49-62c899a87041@infradead.org>
Message-ID: <alpine.DEB.2.21.1807032242140.1816@nanos.tec.linutronix.de>
References: <20180703182118.15024-1-jarkko.sakkinen@linux.intel.com> <20180703182118.15024-8-jarkko.sakkinen@linux.intel.com> <alpine.DEB.2.21.1807032110460.1816@nanos.tec.linutronix.de> <00ca61d5-5a1d-5c83-3b49-62c899a87041@infradead.org>
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

On Tue, 3 Jul 2018, Randy Dunlap wrote:
> On 07/03/18 12:46, Thomas Gleixner wrote:
> > On Tue, 3 Jul 2018, Jarkko Sakkinen wrote:
> > 
> >> SGX has a set of data structures to maintain information about the enclaves
> >> and their security properties. BIOS reserves a fixed size region of
> >> physical memory for these structures by setting Processor Reserved Memory
> >> Range Registers (PRMRR). This memory area is called Enclave Page Cache
> >> (EPC).
> >>
> >> This commit adds a database of EPC banks for kernel to easily access the
> 
> what kind of database?  How does one query it?
> 
> >> diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
> >> index 2130e639ab49..77b2294fcfb0 100644
> >> --- a/arch/x86/include/asm/sgx.h
> >> +++ b/arch/x86/include/asm/sgx.h
> 
> 
> >> +/**
> >> + * sgx_get_page - pin an EPC page
> > 
> > Description starts with an uppercase letter.
> 
> How would someone know that?  It's not documented anywhere.

It's a short sentence decribing the function and sentences start usually
with uppercase letters, right?

> I happen to disagree with it.

Then we have to agree that we disagree.

> >> +static __init int sgx_page_cache_init(void)
> >> +{
> >> +	unsigned long size;
> >> +	unsigned int eax;
> >> +	unsigned int ebx;
> >> +	unsigned int ecx;
> >> +	unsigned int edx;
> >> +	unsigned long pa;
> >> +	int i;
> >> +	int ret;
> > 
> > Please aggregate the declarations of the same type. No point in wasting all
> > the screen space. And please use 'u32' for ea-dx
> > 
> >> +
> >> +	for (i = 0; i < SGX_MAX_EPC_BANKS; i++) {
> >> +		cpuid_count(SGX_CPUID, i + SGX_CPUID_EPC_BANKS, &eax, &ebx,
> >> +			    &ecx, &edx);
> >> +		if (!(eax & 0xf))
> >> +			break;
> >> +
> >> +		pa = ((u64)(ebx & 0xfffff) << 32) + (u64)(eax & 0xfffff000);
> >> +		size = ((u64)(edx & 0xfffff) << 32) + (u64)(ecx & 0xfffff000);
> > 
> > These magic constants should be 'U', using uppercase 'F' and defines. Plus
> > this wants a comment how pa and size are cobbled together from the cpuid
> > regs.
> 
> Why the uppercase 'F'?

Makes is more readable IMO, but I'm not religious about that.

Thanks,

	tglx
