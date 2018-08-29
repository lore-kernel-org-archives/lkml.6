Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE5BC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC4220897
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC4220897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeH2L3a convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:29:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:53881 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbeH2L3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:29:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 00:33:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,301,1531810800"; 
   d="scan'208";a="76416389"
Received: from pgsmsx108.gar.corp.intel.com ([10.221.44.103])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Aug 2018 00:33:56 -0700
Received: from pgsmsx112.gar.corp.intel.com ([169.254.3.58]) by
 PGSMSX108.gar.corp.intel.com ([169.254.8.56]) with mapi id 14.03.0319.002;
 Wed, 29 Aug 2018 15:33:54 +0800
From:   "Huang, Kai" <kai.huang@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     "platform-driver-x86@vger.kernel.org" 
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
Subject: RE: [PATCH v13 10/13] x86/sgx: Add sgx_einit() for initializing
 enclaves
Thread-Topic: [PATCH v13 10/13] x86/sgx: Add sgx_einit() for initializing
 enclaves
Thread-Index: AQHUPjfc29Kn4Rp1DkeLR/DtZ2Q8VaTTmtMAgACchICAAhw1QA==
Date:   Wed, 29 Aug 2018 07:33:54 +0000
Message-ID: <105F7BF4D0229846AF094488D65A09893541037C@PGSMSX112.gar.corp.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-11-jarkko.sakkinen@linux.intel.com>
 <1535406078.3416.9.camel@intel.com> <20180828070129.GA5301@linux.intel.com>
In-Reply-To: <20180828070129.GA5301@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTAzZDgwMzMtZjVmNi00YWVjLWExYWEtMDc1ZjY3OTAxYzIwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVm1aTzRIbDVWZVk5bGFQNFlMZGhTT2I4azArRDBIeTB3U2hiYU5DYmZWSmxZbU9yVnVUTkVcL0NaaGN1K1RuSHgifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [172.30.20.205]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[snip..]

> > >
> > > @@ -38,6 +39,18 @@ static LIST_HEAD(sgx_active_page_list);  static
> > > DEFINE_SPINLOCK(sgx_active_page_list_lock);
> > >  static struct task_struct *ksgxswapd_tsk;  static
> > > DECLARE_WAIT_QUEUE_HEAD(ksgxswapd_waitq);
> > > +static struct notifier_block sgx_pm_notifier; static u64
> > > +sgx_pm_cnt;
> > > +
> > > +/* The cache for the last known values of IA32_SGXLEPUBKEYHASHx
> > > +MSRs
> > > for each
> > > + * CPU. The entries are initialized when they are first used by
> > > sgx_einit().
> > > + */
> > > +struct sgx_lepubkeyhash {
> > > +	u64 msrs[4];
> > > +	u64 pm_cnt;
> >
> > May I ask why do we need pm_cnt here? In fact why do we need suspend
> > staff (namely, sgx_pm_cnt above, and related code in this patch) here
> > in this patch? From the patch commit message I don't see why we need
> > PM staff here. Please give comment why you need PM staff, or you may
> > consider to split the PM staff to another patch.
> 
> Refining the commit message probably makes more sense because without PM
> code sgx_einit() would be broken. The MSRs have been reset after waking up.
> 
> Some kind of counter is required to keep track of the power cycle. When going
> to sleep the sgx_pm_cnt is increased. sgx_einit() compares the current value of
> the global count to the value in the cache entry to see whether we are in a new
> power cycle.

You mean reset to Intel default? I think we can also just reset the cached MSR values on each power cycle, which would be simpler, IMHO?

I think we definitely need some code to handle S3-S5, but should be in separate patches, since I think the major impact of S3-S5 is entire EPC being destroyed. I think keeping pm_cnt is not sufficient enough to handle such case?

> 
> This brings up one question though: how do we deal with VM host going to sleep?
> VM guest would not be aware of this.

IMO VM just gets "sudden loss of EPC" after suspend & resume in host. SGX driver and SDK should be able to handle "sudden loss of EPC", ie, co-working together to re-establish the missing enclaves.

Actually supporting "sudden loss of EPC" is a requirement to support live migration of VM w/ SGX. Internally long time ago we had a discussion and the decision was we should support SGX live migration given two facts:

1) losing platform-dependent is not important. For example, losing sealing key is not a problem, as we could get secrets provisioned again from remote. 2) Both windows & linux driver commit to support "sudden loss of EPC".

I don't think we have to support in very first upstream driver, but I think we need to support someday.

Sean, 

Would you be able to comment here?

> 
> I think the best measure would be to add a new parameter to sgx_einit() that
> enforces update of the MSRs. The driver can then set this parameter in the case
> when sgx_einit() returns SGX_INVALID_LICENSE. This is coherent because the
> driver requires writable MSRs. It would not be coherent to do it directly in the
> core because KVM does not require writable MSRs.

IMHO this is not required, as I mentioned above.

And 
[snip...]

Thanks,
-Kai
