Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E191C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335822569F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 335822569F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754898AbeFYJV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:21:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:58839 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754449AbeFYJV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:21:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 02:21:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,269,1526367600"; 
   d="scan'208";a="240363011"
Received: from jsakkine-mobl1.tm.intel.com (HELO sfriis-mobl.ger.corp.intel.com) ([10.237.50.42])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jun 2018 02:21:23 -0700
Message-ID: <b8ea3787ae99637a8aae286ff90ac6889d8b55f4.camel@linux.intel.com>
Subject: Re: [PATCH v11 09/13] x86, sgx: basic routines for enclave page
 cache
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        x86@kernel.org, platform-driver-x86@vger.kernel.org
Cc:     dave.hansen@intel.com, nhorman@redhat.com, npmccallum@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:INTEL SGX" <intel-sgx-kernel-dev@lists.01.org>
Date:   Mon, 25 Jun 2018 12:21:22 +0300
In-Reply-To: <1529500871.9779.58.camel@intel.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
         <20180608171216.26521-10-jarkko.sakkinen@linux.intel.com>
         <1529500871.9779.58.camel@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-20 at 06:21 -0700, Sean Christopherson wrote:
> On Fri, 2018-06-08 at 19:09 +0200, Jarkko Sakkinen wrote:
> > SGX has a set of data structures to maintain information about the enclaves
> > and their security properties. BIOS reserves a fixed size region of
> > physical memory for these structures by setting Processor Reserved Memory
> > Range Registers (PRMRR). This memory area is called Enclave Page Cache
> > (EPC).
> > 
> > This commit implements the basic routines to allocate and free pages from
> > different EPC banks. There is also a swapper thread ksgxswapd for EPC pages
> > that gets woken up by sgx_alloc_page() when we run below the low watermark.
> > The swapper thread continues swapping pages up until it reaches the high
> > watermark.
> > 
> > Each subsystem that uses SGX must provide a set of callbacks for EPC
> > pages that are used to reclaim, block and write an EPC page. Kernel
> > takes the responsibility of maintaining LRU cache for them.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >  arch/x86/include/asm/sgx.h      |  67 +++++
> >  arch/x86/include/asm/sgx_arch.h | 224 ++++++++++++++++
> >  arch/x86/kernel/cpu/intel_sgx.c | 443 +++++++++++++++++++++++++++++++-
> >  3 files changed, 732 insertions(+), 2 deletions(-)
> >  create mode 100644 arch/x86/include/asm/sgx_arch.h
> 
> ...
> 
> > +struct sgx_pcmd {
> > +	struct sgx_secinfo secinfo;
> > +	uint64_t enclave_id;
> > +	uint8_t reserved[40];
> > +	uint8_t mac[16];
> > +};
> 
> sgx_pcmd has a 128-byte alignment requirement.  I think it's
> worth specifying here as sgx_pcmd is small enough that it could
> be put on the stack, e.g. by KVM when trapping and executing
> ELD* on behalf of a guest VM.
> 
> In fact, it probably makes sense to add alightment attributes
> to all SGX structs for self-documentation purposes, even though
> many of them will never be allocated statically or on the stack.

I agree with this. It also documents stuff so that you don't have
to look it up from the SDM.

Neil: this should also clear your concerns.

/Jarkko
