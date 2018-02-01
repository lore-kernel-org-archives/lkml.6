Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752029AbeBAVz7 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 16:55:59 -0500
Received: from mga05.intel.com ([192.55.52.43]:57076 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751730AbeBAVzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 16:55:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,444,1511856000";
   d="scan'208";a="24234122"
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
Subject: RE: [PATCH V5 02/17] perf mmap: fix: recalculate size for overwrite
 mode.
Thread-Topic: [PATCH V5 02/17] perf mmap: fix: recalculate size for
 overwrite mode.
Thread-Index: AQHTkKNt+7LbeQSb0USJiFMkktoFcKOPnliAgACOXpA=
Date: Thu, 1 Feb 2018 21:55:50 +0000
Message-ID: <37D7C6CF3E00A74B8858931C1DB2F0775381C4E7@SHSMSX103.ccr.corp.intel.com>
References: <1516310792-208685-1-git-send-email-kan.liang@intel.com>
 <1516310792-208685-3-git-send-email-kan.liang@intel.com>
 <20180201212313.GD4835@kernel.org>
In-Reply-To: <20180201212313.GD4835@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDVmZTBlNmItOTcwOC00M2JhLWFkMGQtNWNmMTJkOTg4ZWNiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX0lDIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6InF6RldRYVNRRlNrU1phOTJaSXA1ZTZvQTFLQ1RDb0ZnV0NxR1NNK1VjRTQ9In0=
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

> Em Thu, Jan 18, 2018 at 01:26:17PM -0800, kan.liang@intel.com escreveu:
> > From: Kan Liang <kan.liang@intel.com>
> >
> > In perf_mmap__push(), the 'size' need to be recalculated, otherwise
> > the invalid data might be pushed to the record in overwrite mode.
> >
> > The issue is introduced by commit 7fb4b407a124 ("perf mmap: Don't
> > discard prev in backward mode").
> 
> In these cases, please add the Fixes tag, like:
>
> Fixes: 7fb4b407a124 ("perf mmap: Don't discard prev in backward mode")
> 
> I'm doing it this time.
>

Thanks. I'll be careful next time.

Thanks,
Kan
 
> Thanks,
> 
> - Arnaldo
> 
> > When the ringbuffer is full in overwrite mode, backward_rb_find_range
> > will be called to recalculate the 'start' and 'end'. The 'size' needs
> > to be recalculated accordingly.
> >
> > Unconditionally recalculate the 'size', not just for full ringbuffer
> > in overwrite mode. Because,
> > - There is no harmful to recalculate the 'size' for other cases.
> > - The code of calculating 'start' and 'end' will be factored out later.
> >   The new function does not need to return 'size'.
> >
> > Signed-off-by: Kan Liang <kan.liang@intel.com>
> > ---
> >  tools/perf/util/mmap.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c index
> > 05076e6..97cf4fa 100644
> > --- a/tools/perf/util/mmap.c
> > +++ b/tools/perf/util/mmap.c
> > @@ -302,6 +302,8 @@ int perf_mmap__push(struct perf_mmap *md,
> bool overwrite,
> >  			return -1;
> >  	}
> >
> > +	size = end - start;
> > +
> >  	if ((start & md->mask) + size != (end & md->mask)) {
> >  		buf = &data[start & md->mask];
> >  		size = md->mask + 1 - (start & md->mask);
> > --
> > 2.5.5
