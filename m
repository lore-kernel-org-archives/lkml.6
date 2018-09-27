Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F67C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AFA421582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AFA421582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeI0QXc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:23:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:50287 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbeI0QXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 12:23:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2018 03:06:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,310,1534834800"; 
   d="scan'208";a="92363092"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga004.fm.intel.com with ESMTP; 27 Sep 2018 03:05:50 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 27 Sep 2018 03:05:50 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.140]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.37]) with mapi id 14.03.0319.002;
 Thu, 27 Sep 2018 18:05:49 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Liang, Kan" <kan.liang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Xu, Like" <like.xu@intel.com>,
        "jannh@google.com" <jannh@google.com>,
        "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>
Subject: RE: [PATCH v3 4/5] KVM/x86/vPMU: Add APIs to support host
 save/restore the guest lbr stack
Thread-Topic: [PATCH v3 4/5] KVM/x86/vPMU: Add APIs to support host
 save/restore the guest lbr stack
Thread-Index: AQHUUM3pU3aoeAw5SE6eJtMPeYOl0qT4xgeAgAsk5FA=
Date:   Thu, 27 Sep 2018 10:05:48 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7397FCAD0@shsmsx102.ccr.corp.intel.com>
References: <1537437959-8751-1-git-send-email-wei.w.wang@intel.com>
 <1537437959-8751-5-git-send-email-wei.w.wang@intel.com>
 <20180920153035.GB10360@tassilo.jf.intel.com>
In-Reply-To: <20180920153035.GB10360@tassilo.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTVkNmU1YWQtMjEzMC00Yzk5LTk5ZjYtZTBhMGUxZWU4ZGI3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMTBZZmNTZVhZNFc3MWVcL0RJc2d4bVJGUTBLYkRLTUZDSzlWdFNpclZ5N012djJxbEVuRXdhSUJlVHpCZlFtSHIifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 20, 2018 11:31 PM, Andi Kleen wrote:
> > +int intel_pmu_enable_save_guest_lbr(struct kvm_vcpu *vcpu) {
> > +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> > +	struct perf_event *event;
> > +	struct perf_event_attr attr = {
> > +		.type = PERF_TYPE_RAW,
> > +		.size = sizeof(attr),
> > +		.pinned = true,
> > +		.exclude_host = true,
> > +		.sample_type = PERF_SAMPLE_BRANCH_STACK,
> > +		.branch_sample_type = PERF_SAMPLE_BRANCH_CALL_STACK
> |
> > +				      PERF_SAMPLE_BRANCH_USER |
> > +				      PERF_SAMPLE_BRANCH_KERNEL,


Sorry for my late response (I was digging into some of the details).


> I think that will allocate an extra perfmon counter, right?
> 
> So if the guest wants to use all perfmon counters we would start to multiplex,
> which would be bad

Right. The host side counter allocation is not necessary.


> Would need to fix perf core to not allocate a perfmon counter in this case, if
> no period and no event count is requested.
> 

If no period (i.e. .sample_period = 0), the current code still uses one counter with the period set to the max period.
If we change that to do no counter allocation, would that break any of the existing usages (I didn't find the reason why the existing code not avoid that allocation for a non-sampling event)?

Best,
Wei
