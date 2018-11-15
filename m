Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC358C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99F320868
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99F320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeKPGL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:11:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbeKPGL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:11:27 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 967EB5F722;
        Thu, 15 Nov 2018 20:02:13 +0000 (UTC)
Received: from krava (ovpn-204-59.brq.redhat.com [10.40.204.59])
        by smtp.corp.redhat.com (Postfix) with SMTP id 80FF2608E6;
        Thu, 15 Nov 2018 20:02:11 +0000 (UTC)
Date:   Thu, 15 Nov 2018 21:02:10 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        ak@linux.intel.com
Subject: Re: [PATCH 1/2] perf vendor events: Add stepping in CPUID string for
 x86
Message-ID: <20181115200210.GN9600@krava>
References: <20181114212416.15665-1-kan.liang@linux.intel.com>
 <20181115135347.GI9600@krava>
 <7a63fdf4-828f-0685-e146-6d3d86d8655b@linux.intel.com>
 <20181115152534.GL9600@krava>
 <13ef65c9-1622-2bb7-3d61-65f469fe1a10@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13ef65c9-1622-2bb7-3d61-65f469fe1a10@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 15 Nov 2018 20:02:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 10:53:42AM -0500, Liang, Kan wrote:
> 
> > > > > +	/*
> > > > > +	 * Full CPUID format is required to identify a platform.
> > > > > +	 * Error out if the cpuid string is incomplete.
> > > > > +	 */
> > > > > +	if (full_mapcpuid && !full_cpuid) {
> > > > > +		pr_info("Invalid CPUID %s. Full CPUID is required, "
> > > > > +			"vendor-family-model-stepping\n", cpuid);
> > > > > +		return 1;
> > > > > +	}
> > > > > +
> > > > > +	if (regcomp(&re, mapcpuid, REG_EXTENDED) != 0) {
> > > > > +		/* Warn unable to generate match particular string. */
> > > > > +		pr_info("Invalid regular expression %s\n", mapcpuid);
> > > > > +		return 1;
> > > > > +	}
> > > > > +
> > > > > +	match = !regexec(&re, cpuid, 1, pmatch, 0);
> > > > > +	regfree(&re);
> > > > > +	if (match) {
> > > > > +		size_t match_len = (pmatch[0].rm_eo - pmatch[0].rm_so);
> > > > > +		size_t cpuid_len;
> > > > > +
> > > > > +		/* If the full CPUID format isn't required,
> > > > > +		 * ignoring the stepping.
> > > > > +		 */
> > > > > +		if (!full_mapcpuid && full_cpuid)
> > > > > +			cpuid_len = strrchr(cpuid, '-') - cpuid;
> > > > > +		else
> > > > > +			cpuid_len = strlen(cpuid);
> > > > > +
> > > > > +
> > > > > +		/* Verify the entire string matched. */
> > > > > +		if (match_len == cpuid_len)
> > > > > +			return 0;
> > > > 
> > > > why is this necessary?
> > > > 
> > > 
> > > It's from previous common code. As my understanding, it just double check
> > > the matched strings. There is no harmful. So I keep it.
> > 
> > right.. did you consider using the wildcard in the map file
> > so it'd cover the stepping, having entries like:
> > 
> >    GenuineIntel-6-1F-*,v2,nehalemep,core
> > 
> > I haven't thought this one through, but seems we could bypass
> > those '-stepping' checks.. but probably other changes would be
> > necessary for the wildcard
> > 
> 
> If using wildcard, the full cpuid format is required for all platforms.
> The script which using environment string "PERF_CPUID" will definitely be
> broken on all platforms.
> This patch (non-wildcard) only breaks the script on Skylake server and
> Cascadelake server.
> 
> I think that's the only drawback of using wildcard.

ok, let's keep your way

jirk
