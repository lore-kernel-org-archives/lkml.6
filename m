Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDCFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0EE20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfARQRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:17:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbfARQRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:17:11 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0B6C6C05AA51;
        Fri, 18 Jan 2019 16:17:11 +0000 (UTC)
Received: from krava (unknown [10.40.205.156])
        by smtp.corp.redhat.com (Postfix) with SMTP id 26646600C2;
        Fri, 18 Jan 2019 16:17:08 +0000 (UTC)
Date:   Fri, 18 Jan 2019 17:17:08 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC] Don't print sample_type bits in non-group events not set
 in the group's was Re: [PATCH] perf, script: Fix crash with printing mixed
 trace point and other events
Message-ID: <20190118161708.GE28346@krava>
References: <20190117194834.21940-1-andi@firstfloor.org>
 <20190118094919.GA28346@krava>
 <20190118125920.GG5823@kernel.org>
 <20190118130106.GH5823@kernel.org>
 <20190118134205.GI5823@kernel.org>
 <20190118161000.GC28346@krava>
 <20190118161140.z45vl3milw2vk4hy@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118161140.z45vl3milw2vk4hy@two.firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 18 Jan 2019 16:17:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 08:11:42AM -0800, Andi Kleen wrote:
> > +static bool perf_evsel__should_skip(struct perf_evsel *evsel)
> > +{
> > +	struct perf_event_attr *attr = &evsel->attr;
> > +	struct perf_evsel *leader = evsel->leader;
> > +
> > +	return (leader != evsel) && !attr->freq && !attr->sample_freq;
> > +}
> > +
> >  static int process_sample_event(struct perf_tool *tool,
> >  				union perf_event *event,
> >  				struct perf_sample *sample,
> > @@ -1934,6 +1942,9 @@ static int process_sample_event(struct perf_tool *tool,
> >  	struct perf_script *scr = container_of(tool, struct perf_script, tool);
> >  	struct addr_location al;
> >  
> > +	if (perf_evsel__should_skip(evsel))
> > +		return 0;
> 
> That just skips, but surely it has to be displayed somewhere?
>

yea as I wrote in that email:

.......   we should probably skip (something like below) that and
add script field that would output the sample_read values for the
leader

jirka
