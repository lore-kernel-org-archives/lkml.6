Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755527AbeCSNAR convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 09:00:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:54845 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755194AbeCSNAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 09:00:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,330,1517904000";
   d="scan'208";a="209478274"
From: "Liang, Kan" <kan.liang@intel.com>
To: "'Peter Zijlstra'" <peterz@infradead.org>
CC: "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "eranian@google.com" <eranian@google.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>
Subject: RE: [PATCH V6 5/8] perf/x86/intel/uncore: add infrastructure for
 free running counter
Thread-Topic: [PATCH V6 5/8] perf/x86/intel/uncore: add infrastructure for
 free running counter
Thread-Index: AQHTlhkdbIHwBgso+EGyqTzZBmqr86PT9AcAgAMLAJA=
Date: Mon, 19 Mar 2018 13:00:09 +0000
Message-ID: <37D7C6CF3E00A74B8858931C1DB2F0775385655B@SHSMSX103.ccr.corp.intel.com>
References: <1516911228-5293-1-git-send-email-kan.liang@intel.com>
 <1516911228-5293-5-git-send-email-kan.liang@intel.com>
 <20180317093438.GI4064@hirez.programming.kicks-ass.net>
In-Reply-To: <20180317093438.GI4064@hirez.programming.kicks-ass.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzg3YjA2MWItYjQzNS00YjRiLWIyZDItZDZhMzViMzRmMGQ4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX0lDIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6ImtDWm91MzdJcGxSbG5HV1pBVHdqQVNyTFYwVlhLa2hqMGdDVFJuY0czZlE9In0=
x-ctpclassification: CTP_IC
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Jan 25, 2018 at 12:13:45PM -0800, kan.liang@intel.com wrote:
> > @@ -512,6 +538,17 @@ static int uncore_pmu_event_add(struct
> perf_event *event, int flags)
> >  	if (!box)
> >  		return -ENODEV;
> >
> > +	/*
> > +	 * The free funning counter is assigned in event_init().
> > +	 * The free running counter event and free running counter
> > +	 * are 1:1 mapped. It doesn't need to be tracked in event_list.
> > +	 */
> > +	if (uncore_pmc_freerunning(hwc->idx)) {
> > +		if (flags & PERF_EF_START)
> > +			uncore_pmu_event_start(event, 0);
> > +		return 0;
> > +	}
> > +
> >  	ret = n = uncore_collect_events(box, event, false);
> >  	if (ret < 0)
> >  		return ret;
> 
> This will result in some (probably) unexpected scheduling artifacts.
> Probably the only way to really cure that is to have the free running
> counters in their own PMU and not share with the GP counters of this
> box.

I'm not quite sure what the unexpected scheduling artifacts could be.
But, yes, I can move all the free running counters to new PMU for SKX
and later platforms.

Thanks,
Kan
