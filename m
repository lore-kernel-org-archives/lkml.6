Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6308C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD3F2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD3F2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeIEWK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 18:10:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:24442 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeIEWK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 18:10:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 10:39:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,334,1531810800"; 
   d="scan'208";a="83312554"
Received: from gsharm2-mobl1.amr.corp.intel.com (HELO localhost) ([10.249.37.218])
  by fmsmga002.fm.intel.com with ESMTP; 05 Sep 2018 10:39:41 -0700
Date:   Wed, 5 Sep 2018 20:39:40 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     "Huang, Kai" <kai.huang@intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "nhorman@redhat.com" <nhorman@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "suresh.b.siddha@intel.com" <suresh.b.siddha@intel.com>,
        "Ayoun, Serge" <serge.ayoun@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "npmccallum@redhat.com" <npmccallum@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH v13 10/13] x86/sgx: Add sgx_einit() for initializing
 enclaves
Message-ID: <20180905173940.GG11368@linux.intel.com>
References: <1535406078.3416.9.camel@intel.com>
 <20180828070129.GA5301@linux.intel.com>
 <105F7BF4D0229846AF094488D65A09893541037C@PGSMSX112.gar.corp.intel.com>
 <20180831121645.GA18075@linux.intel.com>
 <20180831181509.GB21555@linux.intel.com>
 <20180903191926.GC13497@linux.intel.com>
 <105F7BF4D0229846AF094488D65A09893541970F@PGSMSX112.gar.corp.intel.com>
 <20180904145451.GA5233@linux.intel.com>
 <20180904153021.GB8344@linux.intel.com>
 <20180904163546.GA5421@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904163546.GA5421@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 09:35:46AM -0700, Sean Christopherson wrote:
> On Tue, Sep 04, 2018 at 06:30:21PM +0300, Jarkko Sakkinen wrote:
> > On Tue, Sep 04, 2018 at 07:54:51AM -0700, Sean Christopherson wrote:
> > > I don't see any value in trying to rule out specific causes of
> > > INVALID_TOKEN, but we should only retry EINIT if ret==INVALID_TOKEN
> > > and RDMSR(HASH0) != sgx_lepubkeyhash[0].  Only the first MSR needs to
> > > be checked for validity as they're a package deal, i.e. they'll all be
> > > valid or all be reset.  There shouldn't be a limit on retry attempts,
> > > e.g. the MSRs could theoretically be reset between WRMSR and EINIT.
> > 
> > Why is doing rdmsrs necessary? With the INVALID_TOKEN error we know we
> > are out-of-sync i.e. have been sleeping and then one just needs to do
> > wrmsrs.
> 
> As Kai mentioned, INVALID_TOKEN is returned for other reasons, e.g. a
> production enclave trying to use a debug token or reserved bits set in
> the token.  And in the KVM case, the hash and token are provided by
> the guest, so it's entirely possible the enclave/token is not signed
> with the key specified in the hash.  RDMSR is relatively inexpensive
> compared to the overall cost of EINIT.  Though of course EINIT failure
> isn't exactly a fast path, so I'm ok if you want to opt for simplicity
> and retry on INVALID_TOKEN without checking the MSRs, just make sure
> to add a comment indicating we're intentionally not checking the MSRs.

Great!

> > I think one retry should be enough given that VMM traps EINIT. One retry
> > is needed to take care of the guest itself (or host if we are running on
> > bare metal) having been in a sleep state.
> 
> Assuming we do RDMSR(hash0), that should be sufficient to prevent
> infinite retry and it protects against the MSRs being lost between
> WRMSR and EINIT during retry.  That being said, I'm ok retrying only
> once, especially if you want to omit the RDMSR.  Disabling preemption
> should prevent the kernel from suspending between WRMSR and EINIT,
> I'm just being paranoid.

But they are in the same preempt-disabled-region already?

/Jarkko
