Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4066CC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E016F2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E016F2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeH2BQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:16:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:60721 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbeH2BQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:16:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2018 14:22:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,300,1531810800"; 
   d="scan'208";a="85277502"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.9])
  by fmsmga001.fm.intel.com with ESMTP; 28 Aug 2018 14:22:44 -0700
Date:   Tue, 28 Aug 2018 14:22:44 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        Serge Ayoun <serge.ayoun@intel.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 09/13] x86/sgx: Enclave Page Cache (EPC) memory
 manager
Message-ID: <20180828212244.GA29488@linux.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-10-jarkko.sakkinen@linux.intel.com>
 <7c5df14e-3028-46b3-fe93-aa6ba8352317@intel.com>
 <20180828083540.GH15508@linux.intel.com>
 <132d309d-77e2-52ed-7251-abb2c80cdf49@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <132d309d-77e2-52ed-7251-abb2c80cdf49@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 07:07:33AM -0700, Dave Hansen wrote:
> On 08/28/2018 01:35 AM, Jarkko Sakkinen wrote:
> > On Mon, Aug 27, 2018 at 02:15:34PM -0700, Dave Hansen wrote:
> >> On 08/27/2018 11:53 AM, Jarkko Sakkinen wrote:
> >>> +struct sgx_epc_page_ops {
> >>> +	bool (*get)(struct sgx_epc_page *epc_page);
> >>> +	void (*put)(struct sgx_epc_page *epc_page);
> >>> +	bool (*reclaim)(struct sgx_epc_page *epc_page);
> >>> +	void (*block)(struct sgx_epc_page *epc_page);
> >>> +	void (*write)(struct sgx_epc_page *epc_page);
> >>> +};
> >> Why do we need a fancy, slow (retpoline'd) set of function pointers when
> >> we only have one user of these (the SGX driver)?
> > KVM has its own implementation for these operations.
> 
> That belongs in the changelog.
> 
> Also, where is the implementation?  How can we assess this code that was
> built to create an abstraction without both of the users?

I can provide an early preview of the KVM reclaim code, but honestly
I think that would do more harm than good.  The VMX architecture for
EPC reclaim is complex, even for SGX standards.  Opening that can of
worms would likely derail this discussion.  That being said, this
abstraction isn't exactly what KVM will need, but it's pretty close
and gives us something to build on.

Regardless, this layer of indirection is justifiable even with a
single implementation.  Reclaiming an EPC page is not a simple matter
of copying the data somewhere else and marking the page not present.
Actual eviction requires a reference to the Secure Enclave Control
Structure (SECS) of the enclave that owns the page.  Software needs
to ensure it doesn't violate the hardware-enforced access rules, e.g.
most reclaim activites need to be done under a per-enclave lock.
Not all pages have the same reclaim rules, e.g. an SECS can only
be reclaimed after all its child pages have reclaimed, a VA page
doesn't need to be blocked, etc...  And the list goes on...

All of the tracking metadata and logic about what can be evicted when
resides in the driver component[1], e.g. the core SGX code doesn't
even have a software representation of an enclave.  Alternatively the
driver could provide a single "do_reclaim" function if we wanted to
avoid a fancy abstraction layer, and in fact that's how I initially
implemented the abstraction, but that approach has it's own warts and
in a lot of ways makes the end result more complex.

Ultimately, moving pages in/out of the EPC is so abysmally slow that
the raw performance of software is almost completely irrelevant.  The
algorithms certainly matter, but optimizing away things like function
pointers definitely takes a back seat to just about everything else.

[1] Early versions of SGX support tried to put all EPC management in
    the driver, but that approach caused major problems for KVM (even
    without reclaim support) and received a less than enthusiastic
    response from the community.
