Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6477CC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E3C20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E3C20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbeICXwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:52:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:36174 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728108AbeICXwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:52:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 12:31:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,326,1531810800"; 
   d="scan'208";a="85697247"
Received: from fonsecan-mobl.ger.corp.intel.com (HELO localhost) ([10.249.36.49])
  by fmsmga004.fm.intel.com with ESMTP; 03 Sep 2018 12:27:55 -0700
Date:   Mon, 3 Sep 2018 22:27:54 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Dr. Greg" <greg@enjellic.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        "Huang, Kai" <kai.huang@intel.com>,
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
Message-ID: <20180903192754.GD13497@linux.intel.com>
References: <20180827185507.17087-11-jarkko.sakkinen@linux.intel.com>
 <1535406078.3416.9.camel@intel.com>
 <20180828070129.GA5301@linux.intel.com>
 <105F7BF4D0229846AF094488D65A09893541037C@PGSMSX112.gar.corp.intel.com>
 <20180829203351.GB7142@linux.intel.com>
 <105F7BF4D0229846AF094488D65A09893541195D@PGSMSX112.gar.corp.intel.com>
 <20180829210901.GA7176@linux.intel.com>
 <105F7BF4D0229846AF094488D65A098935412392@PGSMSX112.gar.corp.intel.com>
 <20180831174330.GA21555@linux.intel.com>
 <20180831213445.GA4098@wind.enjellic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831213445.GA4098@wind.enjellic.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 04:34:45PM -0500, Dr. Greg wrote:
> On Fri, Aug 31, 2018 at 10:43:30AM -0700, Sean Christopherson wrote:
> 
> Good afternoon to everyone.
> 
> > > Sorry I missed this one. To be honest I don't know. I checked the
> > > SDM and all I can find is:
> > >
> > > "On reset, the default value is the digest of Intel's signing key."
> 
> > I confirmed the MSRs are reset any time the EPC is lost.  Not sure
> > what happens if the MSRs contained a non-Intel value but feature
> > control is locked with SGX launch control disabled.  I'll post an
> > update when I have an answer.
> 
> It was our interpretation from the SDM that the identity modulus
> signature MSR's are 'trap-door' registers.  If flexible launch control
> (FLC) is enabled the platform has one opportunity to write a new
> signature value, after which the registers are locked from
> modification until the next platform reset.

In the driver we support only MSRs that are left writable by the BIOS
before locking the feature control.

> From a security architecture perspective it seemed that an FLC based
> SGX implementation would use a modified version of TBOOT to securely
> write that register once per platform boot/reset.  The architecture
> that is being discussed where there is a need to continually check
> whether or not the correct root signing key is loaded sounds a bit
> clunky at best.
> 
> At worst it has potential security implications since it is the
> reponsibility of the enclave launch control infrastructure to control
> which enclaves are allowed to have the PROVISION_KEY attribute bit
> set.

Based on the previous feedback supporting read-only MSRs in the driver
is an unwanted feature i.e. the kernel must be able to decide what gets
lauched (i.e. no launch enclave).

> Have a good weekend.
> 
> Dr. Greg
> 
> As always,
> Dr. G.W. Wettstein, Ph.D.   Enjellic Systems Development, LLC.
> 4206 N. 19th Ave.           Specializing in information infra-structure
> Fargo, ND  58102            development.
> PH: 701-281-1686
> FAX: 701-281-3949           EMAIL: greg@enjellic.com
> ------------------------------------------------------------------------------
> "Extensive interviews show that not one alcoholic has ever actually seen
>  a pink elephant."
>                                 -- Yale University
>                                    Center of Alcohol Studies

/Jarkko
