Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313F9C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FAA20833
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0FAA20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbeI0Q2i convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:28:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:36862 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbeI0Q2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 12:28:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2018 03:11:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,310,1534834800"; 
   d="scan'208";a="76650746"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga008.jf.intel.com with ESMTP; 27 Sep 2018 03:10:55 -0700
Received: from fmsmsx116.amr.corp.intel.com (10.18.116.20) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 27 Sep 2018 03:10:55 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 fmsmsx116.amr.corp.intel.com (10.18.116.20) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 27 Sep 2018 03:10:55 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.140]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.220]) with mapi id 14.03.0319.002;
 Thu, 27 Sep 2018 18:10:53 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Liang, Kan" <kan.liang@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Xu, Like" <like.xu@intel.com>,
        "jannh@google.com" <jannh@google.com>,
        "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>
Subject: RE: [PATCH v3 4/5] KVM/x86/vPMU: Add APIs to support host
 save/restore the guest lbr stack
Thread-Topic: [PATCH v3 4/5] KVM/x86/vPMU: Add APIs to support host
 save/restore the guest lbr stack
Thread-Index: AQHUUM3pU3aoeAw5SE6eJtMPeYOl0qT4xgeAgAAO9YCACxkHwA==
Date:   Thu, 27 Sep 2018 10:10:52 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7397FCAF8@shsmsx102.ccr.corp.intel.com>
References: <1537437959-8751-1-git-send-email-wei.w.wang@intel.com>
 <1537437959-8751-5-git-send-email-wei.w.wang@intel.com>
 <20180920153035.GB10360@tassilo.jf.intel.com>
 <20180920162407.GA24124@hirez.programming.kicks-ass.net>
In-Reply-To: <20180920162407.GA24124@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZWI3NzM1ZjgtYTQ3Mi00YjViLWJlZDctNDRlZDZiZTI0OWFlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSzU2VTRUQnJtYjJvMFJuQzlnU3RqOEdcL2YydkNQRWpTUW5Seko0cFBISDRhZUZvYlBBbEZpTE5zbWFvdm9nNlYifQ==
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

On Friday, September 21, 2018 12:24 AM, Peter Zijlstra wrote:
> On Thu, Sep 20, 2018 at 08:30:35AM -0700, Andi Kleen wrote:
> > > +int intel_pmu_enable_save_guest_lbr(struct kvm_vcpu *vcpu) {
> > > +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> > > +	struct perf_event *event;
> > > +	struct perf_event_attr attr = {
> > > +		.type = PERF_TYPE_RAW,
> > > +		.size = sizeof(attr),
> > > +		.pinned = true,
> > > +		.exclude_host = true,
> > > +		.sample_type = PERF_SAMPLE_BRANCH_STACK,
> > > +		.branch_sample_type = PERF_SAMPLE_BRANCH_CALL_STACK
> |
> > > +				      PERF_SAMPLE_BRANCH_USER |
> > > +				      PERF_SAMPLE_BRANCH_KERNEL,
> >
> > I think that will allocate an extra perfmon counter, right?
> 
> I throught the same too, but I think the exclude_host/guest, whichever is the
> right one makes that work for regular counters too.

Sorry for being late.

I'm not sure if exclude_host/guest would be suitable, for example, if the guest wants to use a perf counter, host will create a perf event with "exclude_host=true" to have the counter not count in host. And "exclude_guest=true" is a flag to the perf core that the counter should not count when the guest runs.

What would you think if we add a new flag (e.g. .force_no_counters) to the perf core to indicate not allocating a perf counter?

> That code is a wee bit magical and I didn't take the time to reverse engineer
> that. It most certainly needs a comment.

No problem. I will add more comments in the next version.

Best,
Wei

