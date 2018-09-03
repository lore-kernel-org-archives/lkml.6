Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86675C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 23:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C9620862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 23:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C9620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbeIDEHv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 00:07:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:48514 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725750AbeIDEHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 00:07:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 16:45:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,327,1531810800"; 
   d="scan'208";a="77704707"
Received: from kmsmsx156.gar.corp.intel.com ([172.21.138.133])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Sep 2018 16:45:15 -0700
Received: from pgsmsx112.gar.corp.intel.com ([169.254.3.58]) by
 KMSMSX156.gar.corp.intel.com ([169.254.1.252]) with mapi id 14.03.0319.002;
 Tue, 4 Sep 2018 07:45:15 +0800
From:   "Huang, Kai" <kai.huang@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>
CC:     "platform-driver-x86@vger.kernel.org" 
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
Subject: RE: [PATCH v13 10/13] x86/sgx: Add sgx_einit() for initializing
 enclaves
Thread-Topic: [PATCH v13 10/13] x86/sgx: Add sgx_einit() for initializing
 enclaves
Thread-Index: AQHUPjfc29Kn4Rp1DkeLR/DtZ2Q8VaTTmtMAgACchICAAhw1QIAC8vSAgABkDoCABMj0AIAAzxpQ
Date:   Mon, 3 Sep 2018 23:45:14 +0000
Message-ID: <105F7BF4D0229846AF094488D65A09893541970F@PGSMSX112.gar.corp.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-11-jarkko.sakkinen@linux.intel.com>
 <1535406078.3416.9.camel@intel.com> <20180828070129.GA5301@linux.intel.com>
 <105F7BF4D0229846AF094488D65A09893541037C@PGSMSX112.gar.corp.intel.com>
 <20180831121645.GA18075@linux.intel.com>
 <20180831181509.GB21555@linux.intel.com>
 <20180903191926.GC13497@linux.intel.com>
In-Reply-To: <20180903191926.GC13497@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiY2ViNWI3YzYtOGFkNS00MDI4LWIxMzAtOWYzYzc2MDlkODViIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRG94K2VmM0xDMVg0UlFsT0JqR21iZ1ZcL3BvRHFNaWhlWFdLVmRHUnR6eHFZZk4xbll1SjByckxmK3lTNGtZMEkifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [172.30.20.206]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-sgx-owner@vger.kernel.org [mailto:linux-sgx-
> owner@vger.kernel.org] On Behalf Of Jarkko Sakkinen
> Sent: Tuesday, September 4, 2018 7:19 AM
> To: Christopherson, Sean J <sean.j.christopherson@intel.com>
> Cc: Huang, Kai <kai.huang@intel.com>; platform-driver-x86@vger.kernel.org;
> x86@kernel.org; nhorman@redhat.com; linux-kernel@vger.kernel.org;
> tglx@linutronix.de; suresh.b.siddha@intel.com; Ayoun, Serge
> <serge.ayoun@intel.com>; hpa@zytor.com; npmccallum@redhat.com;
> mingo@redhat.com; linux-sgx@vger.kernel.org; Hansen, Dave
> <dave.hansen@intel.com>
> Subject: Re: [PATCH v13 10/13] x86/sgx: Add sgx_einit() for initializing enclaves
> 
> On Fri, Aug 31, 2018 at 11:15:09AM -0700, Sean Christopherson wrote:
> > On Fri, Aug 31, 2018 at 03:17:03PM +0300, Jarkko Sakkinen wrote:
> > > On Wed, Aug 29, 2018 at 07:33:54AM +0000, Huang, Kai wrote:
> > > > [snip..]
> > > >
> > > > > > >
> > > > > > > @@ -38,6 +39,18 @@ static LIST_HEAD(sgx_active_page_list);
> > > > > > > static DEFINE_SPINLOCK(sgx_active_page_list_lock);
> > > > > > >  static struct task_struct *ksgxswapd_tsk;  static
> > > > > > > DECLARE_WAIT_QUEUE_HEAD(ksgxswapd_waitq);
> > > > > > > +static struct notifier_block sgx_pm_notifier; static u64
> > > > > > > +sgx_pm_cnt;
> > > > > > > +
> > > > > > > +/* The cache for the last known values of
> > > > > > > +IA32_SGXLEPUBKEYHASHx MSRs
> > > > > > > for each
> > > > > > > + * CPU. The entries are initialized when they are first
> > > > > > > + used by
> > > > > > > sgx_einit().
> > > > > > > + */
> > > > > > > +struct sgx_lepubkeyhash {
> > > > > > > +	u64 msrs[4];
> > > > > > > +	u64 pm_cnt;
> > > > > >
> > > > > > May I ask why do we need pm_cnt here? In fact why do we need
> > > > > > suspend staff (namely, sgx_pm_cnt above, and related code in
> > > > > > this patch) here in this patch? From the patch commit message
> > > > > > I don't see why we need PM staff here. Please give comment why
> > > > > > you need PM staff, or you may consider to split the PM staff to another
> patch.
> > > > >
> > > > > Refining the commit message probably makes more sense because
> > > > > without PM code sgx_einit() would be broken. The MSRs have been reset
> after waking up.
> > > > >
> > > > > Some kind of counter is required to keep track of the power
> > > > > cycle. When going to sleep the sgx_pm_cnt is increased.
> > > > > sgx_einit() compares the current value of the global count to
> > > > > the value in the cache entry to see whether we are in a new power cycle.
> > > >
> > > > You mean reset to Intel default? I think we can also just reset
> > > > the cached MSR values on each power cycle, which would be simpler,
> IMHO?
> > >
> > > I don't really see that much difference in the complexity.
> >
> > Tracking the validity of the cache means we're hosed if we miss any
> > condition that causes the MSRs to be reset.  I think we're better off
> > assuming the cache can be stale at any time, i.e. don't track power
> > cyles and instead handle EINIT failure due to INVALID_TOKEN by writing
> > the cache+MSRs with the desired hash and retrying EINIT.  EINIT is
> > interruptible and its latency is extremely variable in any case, e.g.
> > tens of thousands of cycles, so this rarely-hit "slow path" probably
> > wouldn't affect the worst case latency of EINIT.
> 
> Sounds a good refiniment. Pretty good solution to heal from host sleep on the
> guest VM and then there is no need for driver changes.

To me either way should be OK, keeping MSR cache or retrying EINIT, since EINIT should not be in performance critical path I think.

But INVALID_TOKEN is not only returned when MSRs are mismatched, so do you plan to check to rule out other cases that cause INVALID_TOKEN before retrying EINIT, or unconditionally  retry EINIT? And we should only retry once?

Thanks,
-Kai
> 
> /Jarkko
