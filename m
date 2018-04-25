Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754482AbeDYM7X (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 08:59:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754426AbeDYM7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 08:59:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CED21789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 25 Apr 2018 09:59:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, namhyung@kernel.org, ganapatrao.kulkarni@cavium.com,
        zhangshaokun@hisilicon.com, yao.jin@linux.intel.com,
        will.deacon@arm.com, ak@linux.intel.com, agustinv@codeaurora.org
Subject: Re: [PATCH 4/5] perf parse-events: Specially handle uncore event
 alias in small groups
Message-ID: <20180425125907.GA24891@kernel.org>
References: <1524594014-79243-1-git-send-email-kan.liang@linux.intel.com>
 <1524594014-79243-4-git-send-email-kan.liang@linux.intel.com>
 <20180424191721.GB4427@kernel.org>
 <9a2070b4-9a27-4e38-f235-2d44ae39dd1f@linux.intel.com>
 <20180424192928.GE4427@kernel.org>
 <7c69ed57-94dd-45e1-bdd8-ac0c37bc575a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c69ed57-94dd-45e1-bdd8-ac0c37bc575a@linux.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 25, 2018 at 08:27:31AM -0400, Liang, Kan escreveu:
> 
> 
> On 4/24/2018 3:29 PM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Apr 24, 2018 at 03:23:06PM -0400, Liang, Kan escreveu:
> > > On 4/24/2018 3:17 PM, Arnaldo Carvalho de Melo wrote:
> > > > Em Tue, Apr 24, 2018 at 11:20:13AM -0700, kan.liang@linux.intel.com escreveu:
> > > > > From: Kan Liang <kan.liang@linux.intel.com>
> > > > > 
> > > > > Perf stat doesn't count the uncore event aliases from the same uncore
> > > > > block in a group, for example:
> > > > 
> > > > This one is not applying to acme/perf/urgent, all the rest I got merged
> > > > there, the last one with that change from using strstr() to a new bool
> > > > in perf_evsel for the uniquifying operation having being performed.
> > > 
> > > Sure. Thank you for letting me know.
> > 
> > Just pushed what I have there,
> > 
> 
> Thanks Arnaldo.
> 
> How about this one?
> Will it be applied to acme/perf/core? Or should I resend it for wider
> review?

On acme/perf/urgent, please check

[acme@seventh perf]$ patch -p1 < /wb/1.patch 
patching file tools/perf/util/evsel.h
Hunk #1 succeeded at 127 (offset 1 line).
patching file tools/perf/util/parse-events.c
patching file tools/perf/util/parse-events.h
patching file tools/perf/util/parse-events.y
Hunk #3 FAILED at 232.
1 out of 4 hunks FAILED -- saving rejects to file tools/perf/util/parse-events.y.rej
[acme@seventh perf]$ cat tools/perf/util/parse-events.y.rej
--- tools/perf/util/parse-events.y
+++ tools/perf/util/parse-events.y
@@ -232,7 +232,7 @@ PE_NAME opt_event_config
 		YYABORT;
 
 	ALLOC_LIST(list);
-	if (parse_events_add_pmu(_parse_state, list, $1, $2, false)) {
+	if (parse_events_add_pmu(_parse_state, list, $1, $2, false, false)) {
 		struct perf_pmu *pmu = NULL;
 		int ok = 0;
 		char *pattern;
[acme@seventh perf]$
