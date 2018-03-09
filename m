Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932375AbeCISYp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 13:24:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:36454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751231AbeCISYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 13:24:44 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69545205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Fri, 9 Mar 2018 15:24:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Kim Phillips <kim.phillips@arm.com>, Jiri Olsa <jolsa@kernel.org>
Cc: "Christian Hansen (chansen3)" <chansen3@cisco.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Vuille, Martin (Martin)" <vmartin@avaya.com>,
        Martin Vuille <jpmv27@aim.com>
Subject: Re: [PATCH] perf tools arm64: Add libdw DWARF post unwind support
 for ARM64
Message-ID: <20180309182440.GA25111@kernel.org>
References: <A5E405FE-1BA3-46FC-9A43-CF19A4B369C5@cisco.com>
 <20180226142726.cd413c792d0782f77b60a23e@arm.com>
 <20180226174040.6998bd3c0a79b2f19c491e4d@arm.com>
 <9B701F46-6AEA-48D8-9103-71D35C83776D@cisco.com>
 <20180308211030.4ee4a0d6ff6dc5cda1b567d4@arm.com>
 <20180309150627.GB8347@kernel.org>
 <20180309120720.9358515dbff3b1d1fdf70cc8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309120720.9358515dbff3b1d1fdf70cc8@arm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 09, 2018 at 12:07:20PM -0600, Kim Phillips escreveu:
> On Fri, 9 Mar 2018 12:06:27 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> Hi Arnaldo,
> 
> > Em Thu, Mar 08, 2018 at 09:10:30PM -0600, Kim Phillips escreveu:
> > > Based on prior work:
> > > 
> > > https://lkml.org/lkml/2014/5/6/395
> > 
> > Thanks, looks good, applying.
> > 
> > Jean, is everything ok with you on this?
> 
> By now your email to Jean should have bounced with "The email account
> that you tried to reach does not exist."  Removing Jean from Cc.
> 
> It seems like you're applying patches.  There are a couple that have
> slipped through the cracks: Can you please take a look at applying them?
> 
> - "perf tools: Fixing uninitialised variable"
>   https://patchwork.kernel.org/patch/10179381/

[acme@jouet perf]$ git tag --contains d2785de15f1bd42d613d56bbac5a007e7293b874
perf-core-for-mingo-4.17-20180216

commit d2785de15f1bd42d613d56bbac5a007e7293b874
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Mon Feb 12 13:32:37 2018 -0700
Commit:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri Feb 16 14:55:40 2018 -0300

    perf auxtrace arm: Fixing uninitialised variable
    
    When working natively on arm64 the compiler gets pesky and complains
    that variable 'i' is uninitialised, something that breaks the
    compilation.  Here no further checks are needed since variable
    'found_spe' can only be true if variable 'i' has been initialised as
    part of the for loop.
    
    Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Jin Yao <yao.jin@linux.intel.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: linux-arm-kernel@lists.infradead.org
    Link: http://lkml.kernel.org/r/1518467557-18505-4-git-send-email-mathieu.poirier@linaro.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index 2323581b157d..fa639e3e52ac 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -68,7 +68,7 @@ struct auxtrace_record
        bool found_spe = false;
        static struct perf_pmu **arm_spe_pmus = NULL;
        static int nr_spes = 0;
-       int i;
+       int i = 0;
 
> - "perf unwind: Report error from dwfl_attach_state"
>   https://patchwork.kernel.org/patch/10211483/
>   [Martin, I guess it would help if you replied-all that patch and
>    added your signed-off-by.]

Right, the S-o-B is needed
 
> - "perf unwind: Unwind with libdw doesn't take symfs into account"
>   https://patchwork.kernel.org/patch/10211599/

This one has the S-o-B, applying, Jiri, holler if you disagree,

- Arnaldo
 
> Thanks,
> 
> Kim
