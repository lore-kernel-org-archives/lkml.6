Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409E6C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 21:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C2F20883
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 21:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C2F20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeIXDnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 23:43:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbeIXDnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 23:43:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 159135D5E6;
        Sun, 23 Sep 2018 21:44:30 +0000 (UTC)
Received: from krava (ovpn-204-66.brq.redhat.com [10.40.204.66])
        by smtp.corp.redhat.com (Postfix) with SMTP id AA90610694C4;
        Sun, 23 Sep 2018 21:44:27 +0000 (UTC)
Date:   Sun, 23 Sep 2018 23:44:26 +0200
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
Message-ID: <20180923214426.GL30923@krava>
References: <20180815170313.455943-1-songliubraving@fb.com>
 <20180815170313.455943-2-songliubraving@fb.com>
 <20180830151355.GA23723@krava>
 <34EEDB74-35C5-49C4-9947-6C0248F194B3@fb.com>
 <20180910081336.GB31644@krava>
 <90BE3370-3006-426A-80DC-279F07192E70@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90BE3370-3006-426A-80DC-279F07192E70@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sun, 23 Sep 2018 21:44:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 01:29:32PM +0000, Song Liu wrote:

SNIP

> >>> 
> >>> jirka
> >> 
> >> I am not sure I am following. The pmu is disabled when we call
> >> event_pmu_add(). Why do we need to read before calling pmu->add()? 
> >> And this is the first added dup event for this master, so we don't
> >> need to worry about others. 
> >> 
> >> Does this make sense? 
> > 
> > I was just thinking since the pmu is disable we could
> > we don't need to read the event on 2 places.. it's almost
> > identic code
> 
> How about something like:
> 
> 
> +/* PMU sharing aware version of event->pmu->add() */
> +static int event_pmu_add(struct perf_event *event,
> +			 struct perf_event_context *ctx)
> +{
> +	struct perf_event_dup *dup;
> +	int ret;
> +
> +	/* no sharing, just do event->pmu->add() */
> +	if (event->dup_id == -1)
> +		return event->pmu->add(event, PERF_EF_START);
> +
> +	dup = &ctx->dup_events[event->dup_id];
> +
> +	if (dup->active_event_count = 0) {
> +		/* try add master */
> +		ret = event->pmu->add(dup->master, PERF_EF_START);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	dup->active_event_count++;
> +	event->pmu->read(dup->master);
> +	event->dup_base_count = dup_read_count(dup);
> +	event->dup_base_child_count = dup_read_child_count(dup);
> +	
> +	return 0;
> +}

yep, seems ok

jirka
