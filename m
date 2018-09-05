Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EBFC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A352075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A352075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbeIEWHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 18:07:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:5939 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeIEWHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 18:07:23 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 10:36:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,334,1531810800"; 
   d="scan'208";a="83311959"
Received: from gsharm2-mobl1.amr.corp.intel.com (HELO localhost) ([10.249.37.218])
  by fmsmga002.fm.intel.com with ESMTP; 05 Sep 2018 10:36:07 -0700
Date:   Wed, 5 Sep 2018 20:36:06 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        serge.ayoun@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, suresh.b.siddha@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 07/13] x86/sgx: Add data structures for tracking the
 EPC pages
Message-ID: <20180905173606.GF11368@linux.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-8-jarkko.sakkinen@linux.intel.com>
 <CAHp75VcjKkJR4_H-acbVm3BwA4tVR8gUtkg9STqOK2UG20Tvgg@mail.gmail.com>
 <20180904174914.GA5690@linux.intel.com>
 <CAHp75VeC0n82thqKKywfiTwd7_fngrc5Zf_1dMzmNdjgafgMvA@mail.gmail.com>
 <20180904181735.GA5820@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904181735.GA5820@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 11:17:35AM -0700, Sean Christopherson wrote:
> On Tue, Sep 04, 2018 at 09:01:15PM +0300, Andy Shevchenko wrote:
> > On Tue, Sep 4, 2018 a> +/**
> > 
> > > > > +       va = ioremap_cache(addr, size);
> > > > > +       if (!va)
> > > > > +               return -ENOMEM;
> > > >
> > > > I'm not sure this is a right API. Do we operate with memory? Does it
> > > > have I/O side effects?
> > > > If no, memremap() would be better to use.
> > >
> > > Preserving __iomem is desirable.  There aren't side effects per se,
> > > but direct non-enclave accesses to the EPC get abort page semantics so
> > > the kernel shouldn't be directly dereferencing a pointer to the EPC.
> > > Though by that argument, sgx_epc_bank.va, sgx_epc_addr's return and
> > > all ENCLS helpers should be tagged __iomem.
> > 
> > Why?
> > Does it related to *any* I/O?
> 
> No, hence my other comment that __private or a new tag altogether may
> be more appropriate.  The noderef attribute is what we truly care
> about.

My proposal is that we go with memremap() and use

#define __sgx_epc __attribute__((noderef))

It makes sense to check that direct EPC pointers are not passed to
functions when they are not supposed to.

/Jarkko
