Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_HK_NAME_DR,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD57C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E7420841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E7420841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeIABoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:44:22 -0400
Received: from wind.enjellic.com ([76.10.64.91]:51293 "EHLO wind.enjellic.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727248AbeIABoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:44:22 -0400
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.14.3/8.14.3) with ESMTP id w7VLYkam004351;
        Fri, 31 Aug 2018 16:34:46 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.14.3/8.14.3/Submit) id w7VLYjDq004350;
        Fri, 31 Aug 2018 16:34:45 -0500
Date:   Fri, 31 Aug 2018 16:34:45 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     "Huang, Kai" <kai.huang@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
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
Subject: Re: [PATCH v13 10/13] x86/sgx: Add sgx_einit() for initializing enclaves
Message-ID: <20180831213445.GA4098@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com> <20180827185507.17087-11-jarkko.sakkinen@linux.intel.com> <1535406078.3416.9.camel@intel.com> <20180828070129.GA5301@linux.intel.com> <105F7BF4D0229846AF094488D65A09893541037C@PGSMSX112.gar.corp.intel.com> <20180829203351.GB7142@linux.intel.com> <105F7BF4D0229846AF094488D65A09893541195D@PGSMSX112.gar.corp.intel.com> <20180829210901.GA7176@linux.intel.com> <105F7BF4D0229846AF094488D65A098935412392@PGSMSX112.gar.corp.intel.com> <20180831174330.GA21555@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831174330.GA21555@linux.intel.com>
User-Agent: Mutt/1.4i
X-Operating-System: uname -s -r
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [0.0.0.0]); Fri, 31 Aug 2018 16:34:46 -0500 (CDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 10:43:30AM -0700, Sean Christopherson wrote:

Good afternoon to everyone.

> > Sorry I missed this one. To be honest I don't know. I checked the
> > SDM and all I can find is:
> >
> > "On reset, the default value is the digest of Intel's signing key."

> I confirmed the MSRs are reset any time the EPC is lost.  Not sure
> what happens if the MSRs contained a non-Intel value but feature
> control is locked with SGX launch control disabled.  I'll post an
> update when I have an answer.

It was our interpretation from the SDM that the identity modulus
signature MSR's are 'trap-door' registers.  If flexible launch control
(FLC) is enabled the platform has one opportunity to write a new
signature value, after which the registers are locked from
modification until the next platform reset.

From a security architecture perspective it seemed that an FLC based
SGX implementation would use a modified version of TBOOT to securely
write that register once per platform boot/reset.  The architecture
that is being discussed where there is a need to continually check
whether or not the correct root signing key is loaded sounds a bit
clunky at best.

At worst it has potential security implications since it is the
reponsibility of the enclave launch control infrastructure to control
which enclaves are allowed to have the PROVISION_KEY attribute bit
set.

Have a good weekend.

Dr. Greg

As always,
Dr. G.W. Wettstein, Ph.D.   Enjellic Systems Development, LLC.
4206 N. 19th Ave.           Specializing in information infra-structure
Fargo, ND  58102            development.
PH: 701-281-1686
FAX: 701-281-3949           EMAIL: greg@enjellic.com
------------------------------------------------------------------------------
"Extensive interviews show that not one alcoholic has ever actually seen
 a pink elephant."
                                -- Yale University
                                   Center of Alcohol Studies
