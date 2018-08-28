Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06A2C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6532088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6532088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeH1MSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:18:50 -0400
Received: from mga04.intel.com ([192.55.52.120]:35159 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbeH1MSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:18:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2018 01:28:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,298,1531810800"; 
   d="scan'208";a="76138005"
Received: from jsakkine-mobl1.fi.intel.com (HELO localhost) ([10.237.66.39])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Aug 2018 01:28:11 -0700
Date:   Tue, 28 Aug 2018 11:28:11 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Serge Ayoun <serge.ayoun@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 06/13] x86/sgx: Detect Intel SGX
Message-ID: <20180828082811.GG15508@linux.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-7-jarkko.sakkinen@linux.intel.com>
 <50c199b6-e8eb-9120-0d2a-5e60ac0139b4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c199b6-e8eb-9120-0d2a-5e60ac0139b4@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 12:53:59PM -0700, Dave Hansen wrote:
> > +config INTEL_SGX_CORE
> > +	prompt "Intel SGX core functionality"
> > +	def_bool n
> > +	depends on X86_64 && CPU_SUP_INTEL
> > +	help
> > +	Intel Software Guard eXtensions (SGX) is a set of CPU instructions
> > +	that allows ring 3 applications to create enclaves, private regions
> > +	of memory that are protected, by hardware, from unauthorized access
> > +	and/or modification.
> 
> This is a bit comma-crazy.  Also, considering some of our recent CVE
> fun, I'd probably not claim hardware protection. :)

Agreed :)

> Maybe:
> 
> 	Intel Software Guard eXtensions (SGX) CPU feature that allows
> 	ring 3 applications to create enclaves: private regions
> 	of memory that are architecturally protected from unauthorized
> 	access and/or modification.

Yeah, looks way more better structured.

> > +	This option enables kernel recognition of SGX, high-level management
> > +	of the Enclave Page Cache (EPC), tracking and writing of SGX Launch
> > +	Enclave Hash MSRs, and allows for virtualization of SGX via KVM. By
> > +	iteslf, this option does not provide SGX support to userspace.
> 
> itself
> 
> 
> > diff --git a/arch/x86/include/asm/sgx_pr.h b/arch/x86/include/asm/sgx_pr.h
> > new file mode 100644
> > index 000000000000..c68578127620
> > --- /dev/null
> > +++ b/arch/x86/include/asm/sgx_pr.h
> > @@ -0,0 +1,13 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> > +// Copyright(c) 2016-17 Intel Corporation.
> > +
> > +#ifndef _ASM_X86_SGX_PR_H
> > +#define _ASM_X86_SGX_PR_H
> > +
> > +#include <linux/printk.h>
> > +#include <linux/ratelimit.h>
> > +
> > +#undef pr_fmt
> > +#define pr_fmt(fmt) "sgx: " fmt
> > +
> > +#endif /* _ASM_X86_SGX_PR_H */
> 
> I don't think this belongs in a generic header.  Generally, we do the
> pr_fmt stuff in .c files, not in headers.  If someone includes this
> header directly or indirectly, they'll get a big surprise.
> 
> If you *must* have this in a .h file, put it in
> arch/x86/kernel/cpu/intel_sgx.h or something and #include "intel_sgx.h"
> in all the .c files where you want this.

I think for intel_sgx.c (the core part) we could just manually add the
"sgx:" prefix because there are only few log messages. I would move the
definition to drivers/platform/x86/intel_sgx/sgx.h because the prefix
makes sense for all .c files there AFAIK.

> > +static __init int sgx_init(void)
> > +{
> > +	unsigned long fc;
> > +
> > +	if (!boot_cpu_has(X86_FEATURE_SGX))
> > +		return false;
> > +
> > +	if (!boot_cpu_has(X86_FEATURE_SGX1))
> > +		return false;
> > +
> > +	rdmsrl(MSR_IA32_FEATURE_CONTROL, fc);
> > +	if (!(fc & FEATURE_CONTROL_LOCKED)) {
> > +		pr_info("IA32_FEATURE_CONTROL MSR is not locked\n");
> > +		return false;
> > +	}
> 
> This is a rather crummy error message.  Doesn't this keep sgx from
> initializing?  Would something like this be more informative?
> 
> 	pr_info("failed init: IA32_FEATURE_CONTROL MSR not locked\n");

What about:

pr_err(FW_BUG "IA32_FEATURE_CONTROL MSR not locked\n");

> > +	if (!(fc & FEATURE_CONTROL_SGX_ENABLE)) {
> > +		pr_info("disabled by the firmware\n");
> > +		return false;
> > +	}
> > +
> > +	if (!(fc & FEATURE_CONTROL_SGX_LE_WR))
> > +		pr_info("IA32_SGXLEPUBKEYHASHn MSRs are not writable\n");
> 
> How about something that might help an end user?  Perhaps:
> 
> 	pr_warn("launch configuration not available\n");

I think this message is a false flag here in the first place as KVM does
not require writable MSRs. It really should be moved to the driver.

> > +	sgx_enabled = true;
> > +	sgx_lc_enabled = !!(fc & FEATURE_CONTROL_SGX_LE_WR);
> > +	return 0;
> > +}
> > +
> > +arch_initcall(sgx_init);
> > 
> 
> 

/Jarkko
