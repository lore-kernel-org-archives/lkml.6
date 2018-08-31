Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFDBC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9161320661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9161320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeHaQYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:24:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:21175 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727942AbeHaQYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:24:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2018 05:17:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,311,1531810800"; 
   d="scan'208";a="84976574"
Received: from dbarealo-mobl.ger.corp.intel.com (HELO localhost) ([10.252.36.33])
  by fmsmga004.fm.intel.com with ESMTP; 31 Aug 2018 05:17:04 -0700
Date:   Fri, 31 Aug 2018 15:17:03 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "nhorman@redhat.com" <nhorman@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
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
Message-ID: <20180831121645.GA18075@linux.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-11-jarkko.sakkinen@linux.intel.com>
 <1535406078.3416.9.camel@intel.com>
 <20180828070129.GA5301@linux.intel.com>
 <105F7BF4D0229846AF094488D65A09893541037C@PGSMSX112.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <105F7BF4D0229846AF094488D65A09893541037C@PGSMSX112.gar.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 07:33:54AM +0000, Huang, Kai wrote:
> [snip..]
> 
> > > >
> > > > @@ -38,6 +39,18 @@ static LIST_HEAD(sgx_active_page_list);  static
> > > > DEFINE_SPINLOCK(sgx_active_page_list_lock);
> > > >  static struct task_struct *ksgxswapd_tsk;  static
> > > > DECLARE_WAIT_QUEUE_HEAD(ksgxswapd_waitq);
> > > > +static struct notifier_block sgx_pm_notifier; static u64
> > > > +sgx_pm_cnt;
> > > > +
> > > > +/* The cache for the last known values of IA32_SGXLEPUBKEYHASHx
> > > > +MSRs
> > > > for each
> > > > + * CPU. The entries are initialized when they are first used by
> > > > sgx_einit().
> > > > + */
> > > > +struct sgx_lepubkeyhash {
> > > > +	u64 msrs[4];
> > > > +	u64 pm_cnt;
> > >
> > > May I ask why do we need pm_cnt here? In fact why do we need suspend
> > > staff (namely, sgx_pm_cnt above, and related code in this patch) here
> > > in this patch? From the patch commit message I don't see why we need
> > > PM staff here. Please give comment why you need PM staff, or you may
> > > consider to split the PM staff to another patch.
> > 
> > Refining the commit message probably makes more sense because without PM
> > code sgx_einit() would be broken. The MSRs have been reset after waking up.
> > 
> > Some kind of counter is required to keep track of the power cycle. When going
> > to sleep the sgx_pm_cnt is increased. sgx_einit() compares the current value of
> > the global count to the value in the cache entry to see whether we are in a new
> > power cycle.
> 
> You mean reset to Intel default? I think we can also just reset the
> cached MSR values on each power cycle, which would be simpler, IMHO?

I don't really see that much difference in the complexity.

> I think we definitely need some code to handle S3-S5, but should be in
> separate patches, since I think the major impact of S3-S5 is entire
> EPC being destroyed. I think keeping pm_cnt is not sufficient enough
> to handle such case?

The driver has SGX_POWER_LOST_ENCLAVE for ioctls and it deletes the TCS
entries.

> > This brings up one question though: how do we deal with VM host going to sleep?
> > VM guest would not be aware of this.
> 
> IMO VM just gets "sudden loss of EPC" after suspend & resume in host.
> SGX driver and SDK should be able to handle "sudden loss of EPC", ie,
> co-working together to re-establish the missing enclaves.

This is not about EPC. It is already dealt by the driver. I'm concerned
about the MSR cache as it would mess up.

But I guess this logic is part of the KVM code anyway now that I think
more of it.

/Jarkko
