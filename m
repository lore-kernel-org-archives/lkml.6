Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 166CFC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACC6208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CACC6208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965890AbeFONbj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:31:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:50260 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965572AbeFONbi (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:31:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 06:31:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,227,1526367600"; 
   d="scan'208";a="59498889"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga003.jf.intel.com with ESMTP; 15 Jun 2018 06:31:37 -0700
Received: from fmsmsx121.amr.corp.intel.com (10.18.125.36) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 15 Jun 2018 06:31:37 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx121.amr.corp.intel.com (10.18.125.36) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 15 Jun 2018 06:31:37 -0700
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.51]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.70]) with mapi id 14.03.0319.002;
 Fri, 15 Jun 2018 21:31:35 +0800
From:   "Liang, Kan" <kan.liang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>
CC:     "yao.jin@linux.intel.com" <yao.jin@linux.intel.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "me@kylehuey.com" <me@kylehuey.com>,
        LKML <Linux-kernel@vger.kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Will Deacon <will.deacon@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, "Jin, Yao" <yao.jin@intel.com>
Subject: RE: [PATCH v1 1/2] perf/core: Use sysctl to turn on/off dropping
 leaked kernel samples
Thread-Topic: [PATCH v1 1/2] perf/core: Use sysctl to turn on/off dropping
 leaked kernel samples
Thread-Index: AQHUBE35KTYpGu+lpEWTfGTCsD8h0KRgTkaAgAAldACAANvvEA==
Date:   Fri, 15 Jun 2018 13:31:34 +0000
Message-ID: <37D7C6CF3E00A74B8858931C1DB2F07753939C70@SHSMSX103.ccr.corp.intel.com>
References: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
 <1529057003-2212-2-git-send-email-yao.jin@linux.intel.com>
 <CABPqkBTyEZX7DebLR-nbzXs0ZYGT1xWNmOmvKgRsvr4mxWJg=w@mail.gmail.com>
 <20180615081656.GC2458@hirez.programming.kicks-ass.net>
In-Reply-To: <20180615081656.GC2458@hirez.programming.kicks-ass.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMWE1M2I0MzYtNTI4OS00ZDIzLWFjN2YtMjkxYWViNjNkNTNlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoib1FGM0NibGYrNlRRd09RSmFMVDhDc1l1ckFzQU5seGlhWkVoMXhnZlQrYkRBdlwvK2JkVUhkTjBHdFhRdFJyXC8zIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Jun 14, 2018 at 11:02:53PM -0700, Stephane Eranian wrote:
> > On Thu, Jun 14, 2018 at 7:10 PM Jin Yao <yao.jin@linux.intel.com> wrote:
> > > +       /*
> > > +        * Due to interrupt latency (AKA "skid"), we may enter the
> > > +        * kernel before taking an overflow, even if the PMU is only
> > > +        * counting user events.
> > > +        * To avoid leaking information to userspace, we must always
> > > +        * reject kernel samples when exclude_kernel is set.
> > > +        */
> > > +       if (event->attr.exclude_kernel && !user_mode(regs))
> > > +               return false;
> > > +
> > And how does that filter PEBS or LBR records?
> 
> I suspect the user_mode() thing actually covers PEBS, but yes LBR might need
> additional filtering.

I think the large PEBS still need to be specially handled.

Thanks,
Kan
