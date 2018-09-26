Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F135AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C49720685
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C49720685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeIZRYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:24:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:16864 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbeIZRYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:24:17 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 04:11:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,306,1534834800"; 
   d="scan'208";a="236057646"
Received: from imahmed1-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.50.69])
  by orsmga004.jf.intel.com with ESMTP; 26 Sep 2018 04:11:40 -0700
Date:   Wed, 26 Sep 2018 14:11:39 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, linux-sgx@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        David Wang <davidwang@zhaoxin.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v14 04/19] x86/cpufeatures: Add SGX feature bits
Message-ID: <20180926111139.GA12037@linux.intel.com>
References: <20180925130845.9962-1-jarkko.sakkinen@linux.intel.com>
 <20180925130845.9962-5-jarkko.sakkinen@linux.intel.com>
 <20180925164854.GF23986@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925164854.GF23986@zn.tnic>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 06:48:54PM +0200, Borislav Petkov wrote:
> > +	eax = cpuid_eax(SGX_CPUID);
> > +
> > +	if (eax & _X86_FEATURE_SGX1)
> > +		set_cpu_cap(c, X86_FEATURE_SGX1);
> > +
> > +	if (eax & _X86_FEATURE_SGX2)
> > +		set_cpu_cap(c, X86_FEATURE_SGX2);
> > +
> > +	if (eax & _X86_FEATURE_SGX_ENCLV)
> > +		set_cpu_cap(c, X86_FEATURE_SGX_ENCLV);
> > +
> > +	if (eax & _X86_FEATURE_SGX_ENCLS_C)
> > +		set_cpu_cap(c, X86_FEATURE_SGX_ENCLS_C);
> 
> 
> Look at arch/x86/kernel/cpu/scattered.c for how to do this properly.

Thank you. I guess I understand what you want me to do i.e.

+       { X86_FEATURE_SGX1,             CPUID_EAX,  0, 0x00000012, 0 },
+       { X86_FEATURE_SGX2,             CPUID_EAX,  1, 0x00000012, 0 },
+       { X86_FEATURE_ENCLV,            CPUID_EAX,  5, 0x00000012, 0 },
+       { X86_FEATURE_ENCLS_C,          CPUID_EAX,  6, 0x00000012, 0 },

What puzzles me is that I cannot find any call site for
get_scattered_cpuid_leaf():

$ git grep get_scattered
arch/x86/kernel/cpu/cpu.h:extern u32 get_scattered_cpuid_leaf(unsigned int level,
arch/x86/kernel/cpu/scattered.c:u32 get_scattered_cpuid_leaf(unsigned int level, unsigned int sub_leaf,
arch/x86/kernel/cpu/scattered.c:EXPORT_SYMBOL_GPL(get_scattered_cpuid_leaf);

/Jarkko
