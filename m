Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BF8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7252086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="BXZ5ptGS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfARQLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:11:45 -0500
Received: from one.firstfloor.org ([193.170.194.197]:41356 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbfARQLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:11:44 -0500
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 92F7586864; Fri, 18 Jan 2019 17:11:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1547827902;
        bh=sWDLW0JGimhzVjWzl/2+arSaInGPnJaydihj+YvKmsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BXZ5ptGSWw58MgKcizCv+F/wwDpL+beWJqyrwGhPPLHjh5EVsALNXn8b/W06K06sp
         m1doRIcTa/PrZfN8YhgbZylbPLuvawlhHkjU5ljEqkMJAgRvf4XujRbVmGxq5kc98g
         p3/KNKwTf4t966Ue1z0N0wX9uEsjrxrbR0yZYWxE=
Date:   Fri, 18 Jan 2019 08:11:42 -0800
From:   Andi Kleen <andi@firstfloor.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC] Don't print sample_type bits in non-group events not set
 in the group's was Re: [PATCH] perf, script: Fix crash with printing mixed
 trace point and other events
Message-ID: <20190118161140.z45vl3milw2vk4hy@two.firstfloor.org>
References: <20190117194834.21940-1-andi@firstfloor.org>
 <20190118094919.GA28346@krava>
 <20190118125920.GG5823@kernel.org>
 <20190118130106.GH5823@kernel.org>
 <20190118134205.GI5823@kernel.org>
 <20190118161000.GC28346@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118161000.GC28346@krava>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static bool perf_evsel__should_skip(struct perf_evsel *evsel)
> +{
> +	struct perf_event_attr *attr = &evsel->attr;
> +	struct perf_evsel *leader = evsel->leader;
> +
> +	return (leader != evsel) && !attr->freq && !attr->sample_freq;
> +}
> +
>  static int process_sample_event(struct perf_tool *tool,
>  				union perf_event *event,
>  				struct perf_sample *sample,
> @@ -1934,6 +1942,9 @@ static int process_sample_event(struct perf_tool *tool,
>  	struct perf_script *scr = container_of(tool, struct perf_script, tool);
>  	struct addr_location al;
>  
> +	if (perf_evsel__should_skip(evsel))
> +		return 0;

That just skips, but surely it has to be displayed somewhere?

-Andi
