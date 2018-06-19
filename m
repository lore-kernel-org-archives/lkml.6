Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFA6C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE686204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE686204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966326AbeFSNek (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:34:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:64703 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755203AbeFSNei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:34:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 06:34:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,243,1526367600"; 
   d="scan'208";a="48237895"
Received: from aluisell-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.254.128])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jun 2018 06:34:23 -0700
Date:   Tue, 19 Jun 2018 16:34:22 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Neil Horman <nhorman@redhat.com>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
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
Message-ID: <20180619133422.GJ5609@linux.intel.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-8-jarkko.sakkinen@linux.intel.com>
 <20180611113521.GB22164@hmswarspite.think-freely.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611113521.GB22164@hmswarspite.think-freely.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 07:35:21AM -0400, Neil Horman wrote:
> On Fri, Jun 08, 2018 at 07:09:42PM +0200, Jarkko Sakkinen wrote:
> > From: Sean Christopherson <sean.j.christopherson@intel.com>
> > 
> > Intel(R) SGX is a set of CPU instructions that can be used by applications
> > to set aside private regions of code and data. The code outside the enclave
> > is disallowed to access the memory inside the enclave by the CPU access
> > control.
> > 
> > This commit adds the check for SGX to arch/x86 and a new config option,
> > INTEL_SGX_CORE. Exposes a boolean variable 'sgx_enabled' to query whether
> > or not the SGX support is available.
> > 
> > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >  arch/x86/Kconfig                | 19 ++++++++++++
> >  arch/x86/include/asm/sgx.h      | 25 ++++++++++++++++
> >  arch/x86/include/asm/sgx_pr.h   | 20 +++++++++++++
> >  arch/x86/kernel/cpu/Makefile    |  1 +
> >  arch/x86/kernel/cpu/intel_sgx.c | 53 +++++++++++++++++++++++++++++++++
> >  5 files changed, 118 insertions(+)
> >  create mode 100644 arch/x86/include/asm/sgx.h
> >  create mode 100644 arch/x86/include/asm/sgx_pr.h
> >  create mode 100644 arch/x86/kernel/cpu/intel_sgx.c
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index c07f492b871a..42015d5366ef 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1925,6 +1925,25 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
> >  
> >  	  If unsure, say y.
> >  
> > +config INTEL_SGX_CORE
> > +	prompt "Intel SGX core functionality"
> > +	def_bool n
> > +	depends on X86_64 && CPU_SUP_INTEL
> > +	help
> > +	Intel Software Guard eXtensions (SGX) is a set of CPU instructions
> > +	that allows ring 3 applications to create enclaves; private regions
> > +	of memory that are protected, by hardware, from unauthorized access
> > +	and/or modification.
> > +
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
> > +
> Agree with Dave, this can just be remoed and you can use the feature macro from
> cpuid.h instead
> 
> Neil

Will do, thanks.

/Jarkko
