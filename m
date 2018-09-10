Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E070EC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24D820833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24D820833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeIJNG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:06:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726165AbeIJNG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:06:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B8C8640201BC;
        Mon, 10 Sep 2018 08:13:38 +0000 (UTC)
Received: from krava (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with SMTP id 553D02166BA3;
        Mon, 10 Sep 2018 08:13:37 +0000 (UTC)
Date:   Mon, 10 Sep 2018 10:13:36 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Kernel Team <Kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v2 1/1] perf: Sharing PMU counters across compatible
 events
Message-ID: <20180910081336.GB31644@krava>
References: <20180815170313.455943-1-songliubraving@fb.com>
 <20180815170313.455943-2-songliubraving@fb.com>
 <20180830151355.GA23723@krava>
 <34EEDB74-35C5-49C4-9947-6C0248F194B3@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34EEDB74-35C5-49C4-9947-6C0248F194B3@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 10 Sep 2018 08:13:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 10 Sep 2018 08:13:38 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 06:35:37PM +0000, Song Liu wrote:
> 
> 
> > On Aug 30, 2018, at 8:13 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> > 
> > On Wed, Aug 15, 2018 at 10:03:13AM -0700, Song Liu wrote:
> > 
> > SNIP
> > 
> >> 
> >> +	perf_event_remove_dup(event, ctx);
> >> 	/*
> >> 	 * We can have double detach due to exit/hot-unplug + close.
> >> 	 */
> >> @@ -1982,6 +2123,92 @@ event_filter_match(struct perf_event *event)
> >> 	       perf_cgroup_match(event) && pmu_filter_match(event);
> >> }
> >> 
> >> +/* PMU sharing aware version of event->pmu->add() */
> >> +static int event_pmu_add(struct perf_event *event,
> >> +			 struct perf_event_context *ctx)
> >> +{
> >> +	struct perf_event_dup *dup;
> >> +	int ret;
> >> +
> >> +	/* no sharing, just do event->pmu->add() */
> >> +	if (event->dup_id == -1)
> >> +		return event->pmu->add(event, PERF_EF_START);
> >> +
> >> +	dup = &ctx->dup_events[event->dup_id];
> >> +
> >> +	if (dup->active_event_count) {
> >> +		/* already enabled */
> >> +		dup->active_event_count++;
> >> +		dup->master->pmu->read(dup->master);
> >> +		event->dup_base_count = dup_read_count(dup);
> >> +		event->dup_base_child_count = dup_read_child_count(dup);
> >> +		return 0;
> >> +	}
> >> +
> >> +	/* try add master */
> >> +	ret = event->pmu->add(dup->master, PERF_EF_START);
> >> +
> >> +	if (!ret) {
> >> +		dup->active_event_count = 1;
> >> +		event->pmu->read(dup->master);
> >> +		event->dup_base_count = dup_read_count(dup);
> >> +		event->dup_base_child_count = dup_read_child_count(dup);
> > 
> > should you read the base before calling pmu->add ?
> > should be same for any dup event not just master
> > 
> > jirka
> 
> I am not sure I am following. The pmu is disabled when we call
> event_pmu_add(). Why do we need to read before calling pmu->add()? 
> And this is the first added dup event for this master, so we don't
> need to worry about others. 
> 
> Does this make sense? 

I was just thinking since the pmu is disable we could
we don't need to read the event on 2 places.. it's almost
identic code

jirka
