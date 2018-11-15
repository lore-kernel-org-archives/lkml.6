Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF58EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8871D223DD
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8871D223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388506AbeKPBeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:34:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54638 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbeKPBeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:34:01 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A76630024E1;
        Thu, 15 Nov 2018 15:25:45 +0000 (UTC)
Received: from krava (unknown [10.40.205.128])
        by smtp.corp.redhat.com (Postfix) with SMTP id A1640105B1FF;
        Thu, 15 Nov 2018 15:25:35 +0000 (UTC)
Date:   Thu, 15 Nov 2018 16:25:34 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        ak@linux.intel.com
Subject: Re: [PATCH 1/2] perf vendor events: Add stepping in CPUID string for
 x86
Message-ID: <20181115152534.GL9600@krava>
References: <20181114212416.15665-1-kan.liang@linux.intel.com>
 <20181115135347.GI9600@krava>
 <7a63fdf4-828f-0685-e146-6d3d86d8655b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a63fdf4-828f-0685-e146-6d3d86d8655b@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 15 Nov 2018 15:25:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 09:26:50AM -0500, Liang, Kan wrote:
> 
> 
> On 11/15/2018 8:53 AM, Jiri Olsa wrote:
> > On Wed, Nov 14, 2018 at 01:24:15PM -0800, kan.liang@linux.intel.com wrote:
> > 
> > SNIP
> > 
> > > diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
> > > index fb0d71afee8b..b428a4b00bf7 100644
> > > --- a/tools/perf/arch/x86/util/header.c
> > > +++ b/tools/perf/arch/x86/util/header.c
> > > @@ -4,6 +4,7 @@
> > >   #include <stdio.h>
> > >   #include <stdlib.h>
> > >   #include <string.h>
> > > +#include <regex.h>
> > >   #include "../../util/header.h"
> > > @@ -70,9 +71,73 @@ get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
> > >   {
> > >   	char *buf = malloc(128);
> > > -	if (buf && __get_cpuid(buf, 128, "%s-%u-%X$") < 0) {
> > > +	if (buf && __get_cpuid(buf, 128, "%s-%u-%X-%X$") < 0) {
> > >   		free(buf);
> > >   		return NULL;
> > >   	}
> > >   	return buf;
> > >   }
> > > +
> > > +/* Full CPUID format for x86 is vendor-family-model-stepping */
> > > +static bool is_full_cpuid(const char *cpuid)
> > > +{
> > > +	const char *tmp = cpuid;
> > > +	int count = 0;
> > > +
> > > +	while ((tmp = strchr(tmp, '-')) != NULL) {
> > > +		count++;
> > > +		tmp++;
> > > +	}
> > > +
> > > +	if (count == 3)
> > > +		return true;
> > > +
> > > +	return false;
> > > +}
> > > +
> > > +int strcmp_cpuid_str(const char *mapcpuid, const char *cpuid)
> > > +{
> > > +	regex_t re;
> > > +	regmatch_t pmatch[1];
> > > +	int match;
> > > +	bool full_mapcpuid = is_full_cpuid(mapcpuid);
> > > +	bool full_cpuid = is_full_cpuid(cpuid);
> > 
> > cpuid will be always full from now right? why do we need to check it?
> > 
> 
> User may set cpuid by environment string "PERF_CPUID", which may not be full
> format.

ok, forgot about this one

> 
> > also please move this to arch/x86/util/pmu.c
> > so it matches the weak function object
> 
> Sure.
> 
> > 
> > > +
> > > +	/*
> > > +	 * Full CPUID format is required to identify a platform.
> > > +	 * Error out if the cpuid string is incomplete.
> > > +	 */
> > > +	if (full_mapcpuid && !full_cpuid) {
> > > +		pr_info("Invalid CPUID %s. Full CPUID is required, "
> > > +			"vendor-family-model-stepping\n", cpuid);
> > > +		return 1;
> > > +	}
> > > +
> > > +	if (regcomp(&re, mapcpuid, REG_EXTENDED) != 0) {
> > > +		/* Warn unable to generate match particular string. */
> > > +		pr_info("Invalid regular expression %s\n", mapcpuid);
> > > +		return 1;
> > > +	}
> > > +
> > > +	match = !regexec(&re, cpuid, 1, pmatch, 0);
> > > +	regfree(&re);
> > > +	if (match) {
> > > +		size_t match_len = (pmatch[0].rm_eo - pmatch[0].rm_so);
> > > +		size_t cpuid_len;
> > > +
> > > +		/* If the full CPUID format isn't required,
> > > +		 * ignoring the stepping.
> > > +		 */
> > > +		if (!full_mapcpuid && full_cpuid)
> > > +			cpuid_len = strrchr(cpuid, '-') - cpuid;
> > > +		else
> > > +			cpuid_len = strlen(cpuid);
> > > +
> > > +
> > > +		/* Verify the entire string matched. */
> > > +		if (match_len == cpuid_len)
> > > +			return 0;
> > 
> > why is this necessary?
> > 
> 
> It's from previous common code. As my understanding, it just double check
> the matched strings. There is no harmful. So I keep it.

right.. did you consider using the wildcard in the map file
so it'd cover the stepping, having entries like:

  GenuineIntel-6-1F-*,v2,nehalemep,core

I haven't thought this one through, but seems we could bypass
those '-stepping' checks.. but probably other changes would be
necessary for the wildcard

thanks,
jirka
