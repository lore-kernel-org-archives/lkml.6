Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57949C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254DE20851
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254DE20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeK1Kfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:35:47 -0500
Received: from mga18.intel.com ([134.134.136.126]:43762 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbeK1Kfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 05:35:47 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 15:36:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,288,1539673200"; 
   d="scan'208";a="116120835"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga001.fm.intel.com with ESMTP; 27 Nov 2018 15:36:15 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 4B0D23011E3; Tue, 27 Nov 2018 15:36:15 -0800 (PST)
Date:   Tue, 27 Nov 2018 15:36:15 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Kyle Huey <me@kylehuey.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Robert O'Callahan <robert@ocallahan.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, acme@kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] x86, perf: counter freezing breaks rr
Message-ID: <20181127233615.GY13936@tassilo.jf.intel.com>
References: <CAP045Ap6Mm+r_44YmxNbz6HWtYArg3SAFgzk4Cm_K5HRJaRG7w@mail.gmail.com>
 <20181120194129.GC13936@tassilo.jf.intel.com>
 <CAP045ApoZamGdgVd=-MJE52rUU5hnOg=j95B1WV2x_bVtRQpWA@mail.gmail.com>
 <20181120201144.GD13936@tassilo.jf.intel.com>
 <20181120221642.GE2131@hirez.programming.kicks-ass.net>
 <20181120222549.GA2149@hirez.programming.kicks-ass.net>
 <20181120223854.GH13936@tassilo.jf.intel.com>
 <20181121081420.GF2131@hirez.programming.kicks-ass.net>
 <CAP045AqRs4+F5rNKXLYHeuvLCvzd9U=eZY0X0NnHXxz3qk9TUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP045AqRs4+F5rNKXLYHeuvLCvzd9U=eZY0X0NnHXxz3qk9TUw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It does seem that FREEZE_PERFMON_ON_PMI (misnamed as it is) is of
> rather limited use (or even negative, in our case) to a counter that's
> already restricted to ring 3.

It's much faster. The PMI cost goes down dramatically.

I still the the right fix is to add an perf event opt-out and let it be 
used by rr.

   V3 is without counter freezing.
    V4 is with counter freezing.
    The value is the average cost of the PMI handler.
    (lower is better)

    perf options    `           V3(ns) V4(ns)  delta
    -c 100000                   1088   894     -18%
    -g -c 100000                1862   1646    -12%
    --call-graph lbr -c 100000  3649   3367    -8%
    --c.g. dwarf -c 100000      2248   1982    -12%


-Andi

