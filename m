Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EB2C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9172083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9172083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966821AbeFSP71 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:59:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:35525 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966563AbeFSP70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:59:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 08:59:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,243,1526367600"; 
   d="scan'208";a="238787359"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.135])
  by fmsmga006.fm.intel.com with ESMTP; 19 Jun 2018 08:59:25 -0700
Date:   Tue, 19 Jun 2018 08:59:25 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, nhorman@redhat.com,
        npmccallum@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:INTEL SGX" <intel-sgx-kernel-dev@lists.01.org>
Subject: Re: [PATCH v11 09/13] x86, sgx: basic routines for enclave page cache
Message-ID: <20180619155924.GA13375@linux.intel.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-10-jarkko.sakkinen@linux.intel.com>
 <3c1b04d6-6e93-efaa-1890-101b7fd9784c@intel.com>
 <20180619145753.GB8034@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619145753.GB8034@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 05:57:53PM +0300, Jarkko Sakkinen wrote:
> On Fri, Jun 08, 2018 at 11:24:12AM -0700, Dave Hansen wrote:
> > On 06/08/2018 10:09 AM, Jarkko Sakkinen wrote:
> > > +static __init bool sgx_is_enabled(bool *lc_enabled)
> > >  {
> > >  	unsigned long fc;
> > >  
> > > @@ -41,12 +466,26 @@ static __init bool sgx_is_enabled(void)
> > >  	if (!(fc & FEATURE_CONTROL_SGX_ENABLE))
> > >  		return false;
> > >  
> > > +	*lc_enabled = !!(fc & FEATURE_CONTROL_SGX_LE_WR);
> > > +
> > >  	return true;
> > >  }
> > 
> > I'm baffled why lc_enabled is connected to the enclave page cache.
> 
> KVM works only with writable MSRs. Driver works both with writable
> and read-only MSRs.

That's not true, KVM can/will support SGX regardless of whether or not
Launch Control (LC) is available and/or enabled.  KVM does need to
know whether or not LC is enabled.

Back to Dave's question, LC isn't connected to the EPC management,
the LC code should be split into a separate patch.
 
> Thanks, I'll try my best to deal with all this :-)
> 
> /Jarkko
