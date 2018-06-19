Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F5FC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37643204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37643204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966283AbeFSNdy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:33:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:7674 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966110AbeFSNdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:33:52 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 06:33:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,243,1526367600"; 
   d="scan'208";a="48237726"
Received: from aluisell-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.254.128])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jun 2018 06:33:44 -0700
Date:   Tue, 19 Jun 2018 16:33:43 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:INTEL SGX" <intel-sgx-kernel-dev@lists.01.org>
Subject: Re: [PATCH v11 07/13] x86, sgx: detect Intel SGX
Message-ID: <20180619133343.GI5609@linux.intel.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-8-jarkko.sakkinen@linux.intel.com>
 <4fc3b6b0-6e4b-3d5f-4d54-2bf7539c7a17@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fc3b6b0-6e4b-3d5f-4d54-2bf7539c7a17@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 10:36:14AM -0700, Dave Hansen wrote:
> > +config INTEL_SGX_CORE
> > +	prompt "Intel SGX core functionality
> > +	depends on X86_64 && CPU_SUP_INTEL
> > +	help
> > +	Intel Software Guard eXtensions (SGX) is a set of CPU instructions
> > +	that allows ring 3 applications to create enclaves; private regions
> > +	of memory that are protected, by hardware, from unauthorized access
> > +	and/or modification.
> 
> That semicolon needs to be a colon.  The second half of that sentence is
> not a stand-alone statement.
> 
> > +	This option enables kernel recognition of SGX, high-level management
> > +	of the Enclave Page Cache (EPC), tracking and writing of SGX Launch
> > +	Enclave Hash MSRs, and allows for virtualization of SGX via KVM. By
> > +	iteslf, this option does not provide SGX support to userspace.
> > +
> > +	For details, see Documentation/x86/intel_sgx.rst
> > +
> > +	If unsure, say N.
> > +
> >  config EFI
> >  	bool "EFI runtime service support"
> >  	depends on ACPI
> > diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
> > new file mode 100644
> > index 000000000000..fa3e6e0eb8af
> > --- /dev/null
> > +++ b/arch/x86/include/asm/sgx.h
> > @@ -0,0 +1,25 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> > +// Copyright(c) 2016-18 Intel Corporation.
> > +//
> > +// Authors:
> > +//
> > +// Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > +// Suresh Siddha <suresh.b.siddha@intel.com>
> > +// Sean Christopherson <sean.j.christopherson@intel.com>
> > +
> > +#ifndef _ASM_X86_SGX_H
> > +#define _ASM_X86_SGX_H
> > +
> > +#include <linux/types.h>
> > +
> > +#define SGX_CPUID 0x12
> 
> Hey, I just saw 0x12 as a magic, hard-coded number earlier in these
> patches.  It seems cruel to hard-code it, and then also have a #define
> that isn't used.

It i then is a regression in the series. I'll fix it.

> > +enum sgx_cpuid {
> > +	SGX_CPUID_CAPABILITIES	= 0,
> > +	SGX_CPUID_ATTRIBUTES	= 1,
> > +	SGX_CPUID_EPC_BANKS	= 2,
> > +};
> 
> These are cpuid *leaves*, right?  Please make this clear that these are
> hardware-defined values and not some kind of software construct.
> 
> > +bool sgx_enabled __ro_after_init = false;
> > +EXPORT_SYMBOL(sgx_enabled);
> > +
> > +static __init bool sgx_is_enabled(void)
> > +{
> > +	unsigned long fc;
> > +
> > +	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
> > +		return false;
> 
> Not necessary. CPUID does this part for you.
> 
> > +	if (!boot_cpu_has(X86_FEATURE_SGX))
> > +		return false;
> > +
> > +	if (!boot_cpu_has(X86_FEATURE_SGX1))
> > +		return false;
> > +
> > +	rdmsrl(MSR_IA32_FEATURE_CONTROL, fc);
> > +	if (!(fc & FEATURE_CONTROL_LOCKED))
> > +		return false;
> > +
> > +	if (!(fc & FEATURE_CONTROL_SGX_ENABLE))
> > +		return false;
> 
> Comments, please.  Why would this happen?  What would it mean?

Thanks for the feedback! I'll refine the parts that you pointed out.

/Jarkko
