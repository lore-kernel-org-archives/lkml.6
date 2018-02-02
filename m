Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbeBBOxv convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:53:51 -0500
Received: from mga04.intel.com ([192.55.52.120]:35423 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751643AbeBBOxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:53:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,448,1511856000";
   d="scan'208";a="171166997"
From: "Liang, Kan" <kan.liang@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wangnan0@huawei.com" <wangnan0@huawei.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "yao.jin@linux.intel.com" <yao.jin@linux.intel.com>
Subject: RE: [PATCH V5 12/17] perf evsel: expose
 perf_missing_features.write_backward
Thread-Topic: [PATCH V5 12/17] perf evsel: expose
 perf_missing_features.write_backward
Thread-Index: AQHTkKM1a8KwiOsTq0WQ+0cXwu++jaOQvEkAgACKakA=
Date: Fri, 2 Feb 2018 14:53:42 +0000
Message-ID: <37D7C6CF3E00A74B8858931C1DB2F07753826CC8@SHSMSX103.ccr.corp.intel.com>
References: <1516310792-208685-1-git-send-email-kan.liang@intel.com>
 <1516310792-208685-13-git-send-email-kan.liang@intel.com>
 <20180202142638.GC26905@kernel.org>
In-Reply-To: <20180202142638.GC26905@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZmIwZmY5NWQtMDg1ZC00Yjc3LWJiMTItNTI1MmIwYzU4NWVjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX0lDIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6InBLNHRBTjkxT2hzZlRkNUgwbkliK0c4TVFaMkMrSHAxTFpmd1lQNXhFblk9In0=
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

> Em Thu, Jan 18, 2018 at 01:26:27PM -0800, kan.liang@intel.com escreveu:
> > From: Kan Liang <kan.liang@intel.com>
> >
> > perf top need it to handle overwrite fallback later.
> >
> > Signed-off-by: Kan Liang <kan.liang@intel.com>
> > ---
> >  tools/perf/util/evsel.c | 5 +++++
> >  tools/perf/util/evsel.h | 2 ++
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c index
> > 4eea3b4..1dd3700 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1670,6 +1670,11 @@ static bool ignore_missing_thread(struct
> perf_evsel *evsel,
> >  	return true;
> >  }
> >
> > +bool is_write_backward_fail(void)
> > +{
> > +	return perf_missing_features.write_backward;
> > +}
> > +
> 
> Humm,  I think we better expose perf_missing_features, i.e. tools using
> 
> 	if (perf_missing_features.write_backward)
> 

It looks good.
Thanks a lot.

Kan

> looks more clear than:
> 
> 	if (is_write_backward_fail())
> 
> This is minor, so I'm doing this myself, please holler if you disagree.
> 
> - Arnaldo
> 
> >  int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
> >  		     struct thread_map *threads)
> >  {
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h index
> > 846e416..1f46728 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -448,4 +448,6 @@ int perf_event_attr__fprintf(FILE *fp, struct
> > perf_event_attr *attr,
> >
> >  struct perf_env *perf_evsel__env(struct perf_evsel *evsel);
> >
> > +bool is_write_backward_fail(void);
> > +
> >  #endif /* __PERF_EVSEL_H */
> > --
> > 2.5.5
