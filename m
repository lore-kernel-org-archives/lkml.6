Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FB5C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642632085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642632085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387474AbeKFA5o convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:57:44 -0500
Received: from mga11.intel.com ([192.55.52.93]:10459 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727623AbeKFA5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:57:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 07:37:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,468,1534834800"; 
   d="scan'208";a="105554438"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga001.jf.intel.com with ESMTP; 05 Nov 2018 07:37:27 -0800
Received: from fmsmsx117.amr.corp.intel.com (10.18.116.17) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 5 Nov 2018 07:37:27 -0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 fmsmsx117.amr.corp.intel.com (10.18.116.17) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 5 Nov 2018 07:37:26 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.84]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.102]) with mapi id 14.03.0415.000;
 Mon, 5 Nov 2018 23:37:24 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Xu, Like" <like.xu@intel.com>
Subject: RE: [PATCH v1 1/8] perf/x86: add support to mask counters from host
Thread-Topic: [PATCH v1 1/8] perf/x86: add support to mask counters from host
Thread-Index: AQHUcc7PbgvjsPCQwkKtzZyGKHImp6U6e2yAgAG4NoCABDgQgIAAHUiAgAAPbICAAJ7WoA==
Date:   Mon, 5 Nov 2018 15:37:24 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73DE3AC8B@shsmsx102.ccr.corp.intel.com>
References: <1541066648-40690-1-git-send-email-wei.w.wang@intel.com>
 <1541066648-40690-2-git-send-email-wei.w.wang@intel.com>
 <20181101145257.GD3178@hirez.programming.kicks-ass.net>
 <5BDC140F.6060303@intel.com>
 <20181105093413.GO3178@hirez.programming.kicks-ass.net>
 <5BE02725.3010707@intel.com>
 <20181105121413.GC22431@hirez.programming.kicks-ass.net>
In-Reply-To: <20181105121413.GC22431@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODdjNmRkNzctNmM2ZS00N2YxLWIyMGEtNDc5YjdiOGY1M2I5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibCs1Q001MHpKOGFyRGMrbmVRU21xMk52WVdFVGJyWCt4N0xQZ0xhcU9obnVNS2JGaVphNFFqXC82d1hwdG1nb3kifQ==
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

On Monday, November 5, 2018 8:14 PM, Peter Zijlstra wrote:
> The answer for PEBS is really simple; PEBS does not virtualize (Andi tried and
> can tell you why; IIRC it has something to do with how the hardware asks for
> a Linear Address instead of a Physical Address). So the problem will not arrise.
> 
> But there are certainly constrained events that will result in the same
> problem.

Yes. I just followed the PEBS assumption to discuss the counter contention that you mentioned.

> 
> The traditional approach of perf on resource contention is to share it; you
> get only partial runtime and can scale up the events given the runtime
> metrics provided.
> 
> We also have perf_event_attr::pinned, which is normally only available to
> root, in which case we'll end up marking any contending event to an error
> state.

Yes,  that's one of the limitations with the existing host event emulation approach - in that case (i.e. both require counter 0 to work) the existing approach fails to have the guest perf function, even the pinned event has ".exclude_guest" set.

> 
> Neither are ideal for MSR level emulation.
> 
> That can only work if the host counter has perf_event_attr::exclude_guest=1,
> any counter without that must also count when the guest is running.
> 
> (and, IIRC, normal perf tool events do not have that set by default)

Probably no. Please see Line 81 at
https://github.com/torvalds/linux/blob/master/tools/perf/util/util.c
perf_guest by default is false, which makes "attr->exclude_guest = 1"


> The thing is; you cannot do blind pass-through of the PMU, some of its
> features simply do not work in a guest. Also, the host perf driver expects
> certain functionality that must be respected.

Actually we are not blindly assigning the perf counters. Guest works with its own complete perf stack (like the one on the host) which also has its own constraints. The perf counter that the guest is requesting from the hypervisor is the one that comes out from its event constraints (i.e. the one that will work for that feature on the guest). 

The counter is also not passed through to the guest, guest accesses to the assigned counter will still exit to the hypervisor, and the hypervisor helps update the counter. 

Please correct me if I misunderstood your point.

> 
> Those are the constraints you have to work with.
> 
> Back when we all started down this virt rathole, I proposed people do
> paravirt perf, where events would be handed to the host kernel and let the
> host kernel do its normal thing. But people wanted to do the MSR based
> thing because of !linux guests.

IMHO, it is worthwhile to care more about the real use case. When a user gets a virtual machine from a vendor, all he can do is to run perf inside the guest. The above contention concerns would not happen, because the user wouldn't be able to come to the host to run perf on the virtualization software (e.g. ./perf qemu..) and in the meantime running perf in the guest to cause the contention.

On the other hand, when we improve the user experience of running perf inside the guest by reducing the virtualization overhead, that would bring real benefits to the real use case.

Best,
Wei

