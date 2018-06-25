Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457E6C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F7E23D02
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F7E23D02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754943AbeFYJOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:14:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:38241 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754449AbeFYJO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:14:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 02:14:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,269,1526367600"; 
   d="scan'208";a="52653829"
Received: from jsakkine-mobl1.tm.intel.com (HELO sfriis-mobl.ger.corp.intel.com) ([10.237.50.42])
  by orsmga006.jf.intel.com with ESMTP; 25 Jun 2018 02:14:12 -0700
Message-ID: <3ec30640bcb4b38f33e6c92a5e0c1c14ed23bd1b.camel@linux.intel.com>
Subject: Re: [PATCH v11 09/13] x86, sgx: basic routines for enclave page
 cache
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, nhorman@redhat.com,
        npmccallum@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:INTEL SGX" <intel-sgx-kernel-dev@lists.01.org>
Date:   Mon, 25 Jun 2018 12:14:12 +0300
In-Reply-To: <20180619155924.GA13375@linux.intel.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
         <20180608171216.26521-10-jarkko.sakkinen@linux.intel.com>
         <3c1b04d6-6e93-efaa-1890-101b7fd9784c@intel.com>
         <20180619145753.GB8034@linux.intel.com>
         <20180619155924.GA13375@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-19 at 08:59 -0700, Sean Christopherson wrote:
> On Tue, Jun 19, 2018 at 05:57:53PM +0300, Jarkko Sakkinen wrote:
> > On Fri, Jun 08, 2018 at 11:24:12AM -0700, Dave Hansen wrote:
> > > On 06/08/2018 10:09 AM, Jarkko Sakkinen wrote:
> > > > +static __init bool sgx_is_enabled(bool *lc_enabled)
> > > >  {
> > > >  	unsigned long fc;
> > > >  
> > > > @@ -41,12 +466,26 @@ static __init bool sgx_is_enabled(void)
> > > >  	if (!(fc & FEATURE_CONTROL_SGX_ENABLE))
> > > >  		return false;
> > > >  
> > > > +	*lc_enabled = !!(fc & FEATURE_CONTROL_SGX_LE_WR);
> > > > +
> > > >  	return true;
> > > >  }
> > > 
> > > I'm baffled why lc_enabled is connected to the enclave page cache.
> > 
> > KVM works only with writable MSRs. Driver works both with writable
> > and read-only MSRs.
> 
> That's not true, KVM can/will support SGX regardless of whether or not
> Launch Control (LC) is available and/or enabled.  KVM does need to
> know whether or not LC is enabled.

I understood from earlier discussion with talks that this was
additional requirement for KVM but please shed some light.

Could this be dropped altogether from this patch set and then brought up
in the KVM patch set? Right now it is unused.

/Jarkko
