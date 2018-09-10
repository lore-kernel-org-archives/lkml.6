Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD4CC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF932086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF932086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeIJNIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:08:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727353AbeIJNIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:08:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 223C4407519F;
        Mon, 10 Sep 2018 08:15:33 +0000 (UTC)
Received: from krava (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with SMTP id CFE37A9E69;
        Mon, 10 Sep 2018 08:15:31 +0000 (UTC)
Date:   Mon, 10 Sep 2018 10:15:31 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "lkp@intel.com" <lkp@intel.com>, Kernel Team <Kernel-team@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v2 1/1] perf: Sharing PMU counters across compatible
 events
Message-ID: <20180910081531.GC31644@krava>
References: <20180815170313.455943-1-songliubraving@fb.com>
 <20180815170313.455943-2-songliubraving@fb.com>
 <20180830151810.GB23723@krava>
 <2199C5F6-31A9-46F1-8656-F63087F2C67C@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2199C5F6-31A9-46F1-8656-F63087F2C67C@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 10 Sep 2018 08:15:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 10 Sep 2018 08:15:33 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 06:51:07PM +0000, Song Liu wrote:
> 
> 
> > On Aug 30, 2018, at 8:18 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> > 
> > On Wed, Aug 15, 2018 at 10:03:13AM -0700, Song Liu wrote:
> > 
> > SNIP
> > 
> >> @@ -6100,7 +6333,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
> >> 
> >> 		if ((sub != event) &&
> >> 		    (sub->state == PERF_EVENT_STATE_ACTIVE))
> >> -			sub->pmu->read(sub);
> >> +			event_pmu_read(sub);
> >> 
> >> 		values[n++] = perf_event_count(sub);
> >> 		if (read_format & PERF_FORMAT_ID)
> >> @@ -9109,7 +9342,7 @@ static enum hrtimer_restart perf_swevent_hrtimer(struct hrtimer *hrtimer)
> >> 	if (event->state != PERF_EVENT_STATE_ACTIVE)
> >> 		return HRTIMER_NORESTART;
> >> 
> >> -	event->pmu->read(event);
> >> +	event_pmu_read(event);
> >> 
> >> 	perf_sample_data_init(&data, 0, event->hw.last_period);
> >> 	regs = get_irq_regs();
> >> @@ -10504,6 +10737,14 @@ SYSCALL_DEFINE5(perf_event_open,
> >> 		goto err_cred;
> >> 	}
> >> 
> >> +	if (perf_event_can_share(event)) {
> >> +		event->tmp_master = perf_event_alloc(&event->attr, cpu,
> >> +						     task, NULL, NULL,
> >> +						     NULL, NULL, -1);
> > 
> > can't get around this.. I understand the need, but AFAICS you allocate
> > the whole 'struct perf_event', just because there's count field in it
> > otherwise the 'struct hw_perf_event' should be enough to carry all that's
> > needed to read hw event
> > 
> > would it be better to move the count to 'struct hw_perf_event' and use
> > that instead? assuming I'm not missing anything..
> > 
> > jirka
> 
> I am trying to make the master event function the same as a real event, 
> while keep dup events as followers. This avoids "switching master" in 
> earlier versions (and Tejun's RFC). 

yep, I understand.. still, it seems too much to allocate
the whole 'struct perf_even't just to get separated 'count'
variable

jirka
