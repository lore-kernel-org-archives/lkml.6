Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4252AC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED2EC208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED2EC208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeH1MJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:09:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726979AbeH1MJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:09:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 053CB87A82;
        Tue, 28 Aug 2018 08:19:13 +0000 (UTC)
Received: from krava (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with SMTP id 972EA2026E18;
        Tue, 28 Aug 2018 08:19:11 +0000 (UTC)
Date:   Tue, 28 Aug 2018 10:19:11 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf/x86/intel: Export mem events only if there's PEBs
 support
Message-ID: <20180828081911.GC23727@krava>
References: <20180813154820.16991-1-jolsa@kernel.org>
 <20180827090624.GI24695@krava>
 <20180828081232.GI24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828081232.GI24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 28 Aug 2018 08:19:13 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 28 Aug 2018 08:19:13 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 10:12:32AM +0200, Peter Zijlstra wrote:
> On Mon, Aug 27, 2018 at 11:06:24AM +0200, Jiri Olsa wrote:
> > +static __init struct attribute **get_hsw_events_attrs(bool *alloc)
> >  {
> > +	if (boot_cpu_has(X86_FEATURE_RTM)) {
> > +		*alloc = true;
> > +		return merge_attr(hsw_events_attrs, hsw_tsx_events_attrs);
> > +	}
> > +	return hsw_events_attrs;
> >  }
> 
> 
> 
> > @@ -4357,6 +4374,15 @@ __init int intel_pmu_init(void)
> >  		WARN_ON(!x86_pmu.format_attrs);
> >  	}
> >  
> > +	if (x86_pmu.pebs && mem_attr) {
> > +		struct attribute **attr = x86_pmu.cpu_events;
> > +
> > +		x86_pmu.cpu_events = merge_attr(x86_pmu.cpu_events, mem_attr);
> > +
> > +		if (alloc_events)
> > +			kfree(attr);
> > +	}
> > +
> >  	if (x86_pmu.num_counters > INTEL_PMC_MAX_GENERIC) {
> >  		WARN(1, KERN_ERR "hw perf events %d > max(%d), clipping!",
> >  		     x86_pmu.num_counters, INTEL_PMC_MAX_GENERIC);
> 
> 
> static __init struct attribute **
> get_events_attrs(struct attribute **base,
> 		 struct attribute **mem,
> 		 struct attribute **tsx)
> {
> 	struct attribute **attrs = base;
> 	struct attribute **old;
> 
> 	if (mem) {
> 		old = attrs;
> 		attrs = merge_attrs(attrs, mem);
> 		if (old != base)
> 			kfree(old);
> 	}
> 
> 	if (tsx && boot_cpu_has(X86_FEATURE_RTM)) {
> 		old = attrs;
> 		attrs = merge_attrs(attrs, tsx);
> 		if (old != base)
> 			kfree(old);
> 	}
> 
> 	return attrs;
> }
> 
> Would that not help to concentrate things a little more?

looks like it would ;-) will check and repost

thanks,
jirka
