Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbeEVRT2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:19:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:32863 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751268AbeEVRT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:19:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,430,1520924400";
   d="scan'208";a="201535354"
Date: Tue, 22 May 2018 10:19:25 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Tvrtko Ursulin <tursulin@ursulin.net>, linux-kernel@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Subject: Re: [RFC] perf: Allow fine-grained PMU access control
Message-ID: <20180522171925.GL4486@tassilo.jf.intel.com>
References: <20180521092549.5349-1-tvrtko.ursulin@linux.intel.com>
 <20180522090527.GP12198@hirez.programming.kicks-ass.net>
 <017c4a20-b597-9c0e-4cf3-c0fd1d7bf3d7@ursulin.net>
 <20180522123213.GR12198@hirez.programming.kicks-ass.net>
 <88a005e3-e090-33c1-0107-5c04a4d8f97f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88a005e3-e090-33c1-0107-5c04a4d8f97f@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> IMHO, it is unsafe for CBOX pmu but could IMC, UPI pmus be an exception here?
> Because currently perf stat -I from IMC, UPI counters is only allowed when 
> system wide monitoring is permitted and this prevents joint perf record and 
> perf stat -I in cluster environments where users usually lack ability to 
> modify paranoid. Adding Andi who may have more ideas regarding all that.

PMU isolation is about not making side channels worse. There are normally
already side channels from timing, but it has a degree of noise.

PMU isolation is just to prevent opening side channels with less noise.
But reducing noise is always a trade off, it can never be perfect
and at some point there are dimishing returns.

In general the farther you are from the origin of the noise there 
is already more noise. The PMU can reduce the noise, but if it's far
enough away it may not make much difference.

So there are always trade offs with shades of grey, not a black 
and white situation. Depending on your security requirements
it may be totally reasonable e.g. to allow the PMU 
on the memory controller (which is already very noisy in any case), 
but not on the caches.

Or allow it only on the graphics which is already fairly isolated.

So per pmu paranoid settings are a useful concept.

-Andi
