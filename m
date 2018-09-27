Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C15C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C55216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C55216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeI0TbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:31:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:22443 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727545AbeI0TbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:31:22 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2018 06:13:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,310,1534834800"; 
   d="scan'208";a="236458523"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.69])
  by orsmga004.jf.intel.com with ESMTP; 27 Sep 2018 06:13:01 -0700
Date:   Thu, 27 Sep 2018 16:13:00 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, linux-sgx@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v14 10/19] x86/sgx: Detect Intel SGX
Message-ID: <20180927131300.GC5436@linux.intel.com>
References: <20180925130845.9962-1-jarkko.sakkinen@linux.intel.com>
 <20180925130845.9962-11-jarkko.sakkinen@linux.intel.com>
 <7ea823ce-d6ee-1ff0-efb4-3ca93536fb7e@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ea823ce-d6ee-1ff0-efb4-3ca93536fb7e@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 01:02:14PM -0700, Randy Dunlap wrote:
> On 9/25/18 6:06 AM, Jarkko Sakkinen wrote:
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 1a0be022f91d..b47e1a144409 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1913,6 +1913,23 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
> >  
> >  	  If unsure, say y.
> >  
> > +config INTEL_SGX_CORE
> > +	bool "Intel SGX core functionality"
> > +	depends on X86_64 && CPU_SUP_INTEL
> > +	help
> > +	Intel Software Guard eXtensions (SGX) CPU feature that allows ring 3
> > +	applications to create enclaves: private regions of memory that are
> > +	architecturally protected from unauthorized access and/or modification.
> > +
> > +	This option enables kernel recognition of SGX, high-level management
> > +	of the Enclave Page Cache (EPC), tracking and writing of SGX Launch
> > +	Enclave Hash MSRs, and allows for virtualization of SGX via KVM. By
> > +	itself, this option does not provide SGX support to userspace.
> > +
> > +	For details, see Documentation/x86/intel_sgx.rst
> > +
> > +	If unsure, say N.
> > +
> 
> Hi,
> coding-style.rst says that help text should be indented with
> one tab + 2 spaces.
> 
> thanks.

Thank you.

/Jarkko
