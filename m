Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71810C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105C020647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 105C020647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbeH3BHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:07:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:13779 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727595AbeH3BHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:07:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 14:09:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,304,1531810800"; 
   d="scan'208";a="66976346"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.20])
  by fmsmga008.fm.intel.com with ESMTP; 29 Aug 2018 14:09:01 -0700
Date:   Wed, 29 Aug 2018 14:09:01 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
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
Message-ID: <20180829210901.GA7176@linux.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-11-jarkko.sakkinen@linux.intel.com>
 <1535406078.3416.9.camel@intel.com>
 <20180828070129.GA5301@linux.intel.com>
 <105F7BF4D0229846AF094488D65A09893541037C@PGSMSX112.gar.corp.intel.com>
 <20180829203351.GB7142@linux.intel.com>
 <105F7BF4D0229846AF094488D65A09893541195D@PGSMSX112.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <105F7BF4D0229846AF094488D65A09893541195D@PGSMSX112.gar.corp.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 01:58:09PM -0700, Huang, Kai wrote:
> > -----Original Message-----
> > From: Christopherson, Sean J
> > Sent: Thursday, August 30, 2018 8:34 AM
> > To: Huang, Kai <kai.huang@intel.com>
> > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>; platform-driver-
> > x86@vger.kernel.org; x86@kernel.org; nhorman@redhat.com; linux-
> > kernel@vger.kernel.org; tglx@linutronix.de; suresh.b.siddha@intel.com; Ayoun,
> > Serge <serge.ayoun@intel.com>; hpa@zytor.com; npmccallum@redhat.com;
> > mingo@redhat.com; linux-sgx@vger.kernel.org; Hansen, Dave
> > <dave.hansen@intel.com>
> > Subject: Re: [PATCH v13 10/13] x86/sgx: Add sgx_einit() for initializing enclaves
> > 
> > On Wed, Aug 29, 2018 at 12:33:54AM -0700, Huang, Kai wrote:
> > > [snip..]
> > >
> > > > > >
> > > > > > @@ -38,6 +39,18 @@ static LIST_HEAD(sgx_active_page_list);
> > > > > > static DEFINE_SPINLOCK(sgx_active_page_list_lock);
> > > > > >  static struct task_struct *ksgxswapd_tsk;  static
> > > > > > DECLARE_WAIT_QUEUE_HEAD(ksgxswapd_waitq);
> > > > > > +static struct notifier_block sgx_pm_notifier; static u64
> > > > > > +sgx_pm_cnt;
> > > > > > +
> > > > > > +/* The cache for the last known values of IA32_SGXLEPUBKEYHASHx
> > > > > > +MSRs
> > > > > > for each
> > > > > > + * CPU. The entries are initialized when they are first used by
> > > > > > sgx_einit().
> > > > > > + */
> > > > > > +struct sgx_lepubkeyhash {
> > > > > > +	u64 msrs[4];
> > > > > > +	u64 pm_cnt;
> > > > >
> > > > > May I ask why do we need pm_cnt here? In fact why do we need
> > > > > suspend staff (namely, sgx_pm_cnt above, and related code in this
> > > > > patch) here in this patch? From the patch commit message I don't
> > > > > see why we need PM staff here. Please give comment why you need PM
> > > > > staff, or you may consider to split the PM staff to another patch.
> > > >
> > > > Refining the commit message probably makes more sense because
> > > > without PM code sgx_einit() would be broken. The MSRs have been reset
> > after waking up.
> > > >
> > > > Some kind of counter is required to keep track of the power cycle.
> > > > When going to sleep the sgx_pm_cnt is increased. sgx_einit()
> > > > compares the current value of the global count to the value in the
> > > > cache entry to see whether we are in a new power cycle.
> > >
> > > You mean reset to Intel default? I think we can also just reset the
> > > cached MSR values on each power cycle, which would be simpler, IMHO?
> > 
> > Refresh my brain, does hardware reset the MSRs on a transition to S3 or lower?
> > 
> > > I think we definitely need some code to handle S3-S5, but should be in
> > > separate patches, since I think the major impact of S3-S5 is entire
> > > EPC being destroyed. I think keeping pm_cnt is not sufficient enough
> > > to handle such case?
> > > >
> > > > This brings up one question though: how do we deal with VM host going to
> > sleep?
> > > > VM guest would not be aware of this.
> > >
> > > IMO VM just gets "sudden loss of EPC" after suspend & resume in host.
> > > SGX driver and SDK should be able to handle "sudden loss of EPC", ie,
> > > co-working together to re-establish the missing enclaves.
> > >
> > > Actually supporting "sudden loss of EPC" is a requirement to support
> > > live migration of VM w/ SGX. Internally long time ago we had a
> > > discussion and the decision was we should support SGX live migration given
> > two facts:
> > >
> > > 1) losing platform-dependent is not important. For example, losing
> > > sealing key is not a problem, as we could get secrets provisioned
> > > again from remote. 2) Both windows & linux driver commit to support "sudden
> > loss of EPC".
> > >
> > > I don't think we have to support in very first upstream driver, but I
> > > think we need to support someday.
> > 
> > Actually, we can easily support this in the driver, at least for SGX1 hardware.
> 
> That's my guess too. Just want to check whether we are still on the same page :)
> 
> > SGX2 isn't difficult to handle, but we've intentionally postponed those patches
> > until SGX1 support is in mainline[1].
> > Accesses to the EPC after it is lost will cause faults.  Userspace EPC accesses, e.g.
> > ERESUME, will get a SIGSEGV that the process should interpret as an "I should
> > restart my enclave" event.  The SDK already does this.  In the driver, we just need
> > to be aware of this potential behavior and not freak out.  Specifically, SGX_INVD
> > needs to not WARN on faults that may have been due to a the EPC being nuked.
> > I think we can even remove the sgx_encl_pm_notifier() code altogether.
> 
> Possibly we still need to do some cleanup, ie, all structures of enclaves, upon resume? 

Not for functional reasons.  The driver will automatically do the
cleanup via SGX_INVD when it next accesses the enclave's pages and
takes a fault, e.g. during reclaim.  Proactively reclaiming the EPC
pages would probably affect performance, though not necessarily in
a good way.  And I think it would be a beneficial to get the driver
out of the suspend/hibernate/resume paths, e.g. zapping all enclaves
could noticeably impact suspend/resume latency.
 
> Anyway I am just guessing.
> 
> Thanks,
> -Kai
> 
> > 
> > [1] SGX1 hardware signals a #GP on an access to an invalid EPC page.
> >     SGX2 signals a #PF with the PF_SGX error code bit set.  This is
> >     problematic because the kernel looks at the PTEs for CR2 and sees
> >     nothing wrong, so it thinks it should just restart the
> >     instruction, leading to an infinite fault loop.  Resolving this
> >     is fairly straightforward, but a complete fix requires propagating
> >     PF_SGX down to the ENCLS fixup handler, which means plumbing the
> >     error code through the fixup handlers or smushing PF_SGX into
> >     trapnr.  Since there is a parallel effort to plumb the error code
> >     through the handlers, https://lkml.org/lkml/2018/8/6/924, we opted
> >     to do this in a separate series.
> > 
> > > Sean,
> > >
> > > Would you be able to comment here?
> > >
> > > >
> > > > I think the best measure would be to add a new parameter to
> > > > sgx_einit() that enforces update of the MSRs. The driver can then
> > > > set this parameter in the case when sgx_einit() returns
> > > > SGX_INVALID_LICENSE. This is coherent because the driver requires
> > > > writable MSRs. It would not be coherent to do it directly in the core because
> > KVM does not require writable MSRs.
> > >
> > > IMHO this is not required, as I mentioned above.
> > >
> > > And
> > > [snip...]
> > >
> > > Thanks,
> > > -Kai
