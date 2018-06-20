Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AF1C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B12520652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B12520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933357AbeFTVCF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 17:02:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:38425 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932690AbeFTVCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 17:02:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 14:02:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,249,1526367600"; 
   d="scan'208";a="234239676"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.135])
  by orsmga005.jf.intel.com with ESMTP; 20 Jun 2018 14:01:59 -0700
Date:   Wed, 20 Jun 2018 14:01:59 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jethro Beekman <jethro@fortanix.com>
Cc:     Nathaniel McCallum <npmccallum@redhat.com>, luto@kernel.org,
        Neil Horman <nhorman@redhat.com>,
        jarkko.sakkinen@linux.intel.com, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, intel-sgx-kernel-dev@lists.01.org, hpa@zytor.com,
        dvhart@infradead.org, tglx@linutronix.de, andy@infradead.org,
        Peter Jones <pjones@redhat.com>
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 13/13] intel_sgx: in-kernel
 launch enclave
Message-ID: <20180620210158.GA24328@linux.intel.com>
References: <20180608171216.26521-14-jarkko.sakkinen@linux.intel.com>
 <CALCETrW3aZJMMm1GqgPm-cOD3p7JvKxLj7j85KJwfNW2iHTj4A@mail.gmail.com>
 <CALCETrVp1ZhrxF5bQDSaZpLucS88tErejj5JC6Jb0fB5etWRbA@mail.gmail.com>
 <20180611115255.GC22164@hmswarspite.think-freely.org>
 <CALCETrX6SD0ThNzpjkbXd7CbNTguzqiQhWMomGK+tocx_DE9XQ@mail.gmail.com>
 <20180612174535.GE19168@hmswarspite.think-freely.org>
 <CALCETrV-4D-M2ap1EFHQiQerYf_XgwLmBAx5WMvcCUefOODjOA@mail.gmail.com>
 <CAOASepN9t3jF4ajfKLG_odTZddOvXjY_DqLQhRPWhJ-imtjkgg@mail.gmail.com>
 <e3f8e5b9-aa1e-20da-37ac-3c3caafa66bc@fortanix.com>
 <b5c81504-83cd-8150-ebe4-41355026590f@fortanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5c81504-83cd-8150-ebe4-41355026590f@fortanix.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 11:39:00AM -0700, Jethro Beekman wrote:
> On 2018-06-20 11:16, Jethro Beekman wrote:
> > > This last bit is also repeated in different words in Table 35-2 and
> > > Section 42.2.2. The MSRs are *not writable* before the write-lock bit
> > > itself is locked. Meaning the MSRs are either locked with Intel's key
> > > hash, or not locked at all.
> 
> Actually, this might be a documentation bug. I have some test hardware and I
> was able to configure the MSRs in the BIOS and then read the MSRs after boot
> like this:
> 
> MSR 0x3a 0x0000000000040005
> MSR 0x8c 0x20180620aaaaaaaa
> MSR 0x8d 0x20180620bbbbbbbb
> MSR 0x8e 0x20180620cccccccc
> MSR 0x8f 0x20180620dddddddd
> 
> Since this is not production hardware, it could also be a CPU bug of course.
> 
> If it is indeed possible to configure AND lock the MSR values to non-Intel
> values, I'm very much in favor of Nathaniels proposal to treat the launch
> enclave like any other firmware blob.

It's not a CPU or documentation bug (though the latter is arguable).
SGX has an activation step that is triggered by doing a WRMSR(0x7a)
with bit 0 set.  Until SGX is activated, the SGX related bits in
IA32_FEATURE_CONTROL cannot be set, i.e. SGX can't be enabled.  But,
the LE hash MSRs are fully writable prior to activation, e.g. to
allow firmware to lock down the LE key with a non-Intel value.

So yes, it's possible to lock the MSRs to a non-Intel value.  The
obvious caveat is that whatever blob is used to write the MSRs would
need be executed prior to activation.

As for the SDM, it's a documentation... omission?  SGX activation
is intentionally omitted from the SDM.  The intended usage model is
that firmware will always do the activation (if it wants SGX enabled),
i.e. post-firmware software will only ever "see" SGX as disabled or
in the fully activated state, and so the SDM doesn't describe SGX
behavior prior to activation.  I believe the activation process, or
at least what is required from firmware, is documented in the BIOS
writer's guide.
 
> Jethro Beekman | Fortanix
> 


