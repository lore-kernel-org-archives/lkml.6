Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15AAECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7FA20868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e31aduPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7FA20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbeJ0DVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 23:21:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727595AbeJ0DVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 23:21:07 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6619C20848;
        Fri, 26 Oct 2018 18:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540579378;
        bh=mxq+ieLheTOQ6IZPkrnp3ex+cArE7LAZam8rypvEdpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e31aduPCzTk8OmCOMIw7sCJ2rZG7PrNS1j4mSlh+l1R3/2GA4AEF5v+Kcr/8NwjqE
         9KCCQAUo2CQZUp8YhpeLmAxsY1PNCYaPJpKq1ey1AzUDIFq1gdY0Y3IaAI4+0WObOn
         lz6GTY9XBRS1Y6V7WGd8SmFFUfKmSxonZm+dAEfw=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 9D686142C5F; Fri, 26 Oct 2018 15:42:55 -0300 (-03)
Date:   Fri, 26 Oct 2018 15:42:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Wang Nan <wangnan0@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: A concern about overflow ring buffer mode
Message-ID: <20181026184255.GE3353@kernel.org>
References: <20181026.104513.2239058788450235574.davem@davemloft.net>
 <20181026183805.GD3353@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026183805.GD3353@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 26, 2018 at 03:38:05PM -0300, Arnaldo Carvalho de Melo escreveu:
> Addind a few folks to the CC list, Wang implemented the backwards ring
> buffer code.

Adding a few more, since the patch switching 'perf top' to overwrite
mode and the motivation for doing so is this one:

commit ebebbf082357f86cc84a4d46ce897a5750e41b7a
Author: Kan Liang <kan.liang@intel.com>
Date:   Thu Jan 18 13:26:31 2018 -0800

    perf top: Switch default mode to overwrite mode
    
    perf_top__mmap_read() has a severe performance issue in the Knights
    Landing/Mill platform, when monitoring heavy load systems. It costs
    several minutes to finish, which is unacceptable.

    Currently, 'perf top' uses the non overwrite mode. For non overwrite
    mode, it tries to read everything in the ringbuffer and doesn't pause
    it. Once there are lots of samples delivered persistently, the
    processing time could be very long. Also, the latest samples could be
    lost when the ringbuffer is full.
    
    For overwrite mode, it takes a snapshot for the system by pausing the
    ringbuffer, which could significantly reduce the processing time.  Also,
    the overwrite mode always keep the latest samples.  Considering the real
    time requirement for 'perf top', the overwrite mode is more suitable for
    it.
    
    Actually, 'perf top' was overwrite mode. It is changed to non overwrite
    mode since commit 93fc64f14472 ("perf top: Switch to non overwrite
    mode"). It's better to change it back to overwrite mode by default.
    
    For the kernel which doesn't support overwrite mode, it will fall back
    to non overwrite mode.
    
    There would be some records lost in overwrite mode because of pausing
    the ringbuffer. It has little impact for the accuracy of the snapshot
    and can be tolerated.
    
    For overwrite mode, unconditionally wait 100 ms before each snapshot. It
    also reduces the overhead caused by pausing ringbuffer, especially on
    light load system.
    
    Signed-off-by: Kan Liang <kan.liang@intel.com>
    Acked-by: Jiri Olsa <jolsa@kernel.org>
    Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    Cc: Andi Kleen <ak@linux.intel.com>
    Cc: Jin Yao <yao.jin@linux.intel.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Wang Nan <wangnan0@huawei.com>
    Link: http://lkml.kernel.org/r/1516310792-208685-17-git-send-email-kan.liang@intel.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

 
> Em Fri, Oct 26, 2018 at 10:45:13AM -0700, David Miller escreveu:
> > Since the last time I looked deeply into perf I notice that
> > perf top now uses a new ring buffer mode by default.
> > 
> > Basically, events are written in reverse order, and when fetching
> > events the tool uses an ioctl to "pause" the ring buffer.
> > 
> > I understand some of the reasons for pursing this kind of scheme but I
> > think there may be a huge downside to this design.
> > 
> > Yes, if the tool can't keep up with the kernel, we'd rather see newer
> > rather than older events.
> > 
> > However, pausing the ring buffer during the fetch is going to
> > virtually guaratee that we lose critical events that impact
> > interpretation of future events in a non-recoverable way.
> > 
> > The thing is, the new scheme causes events to be lost even if the tool
> > can keep up with the kernel.
> > 
> > Any event that happens while the tool is fetching the ring entries
> > will be lost forever.  The kernel simply skips queuing up the event
> > and increments a lost counter.  During a kernel build, I typically see
> > 9 or so events lost each fetch.
> > 
> > Ok, if this is just a SAMPLE then fine, it's not a big deal.
> > 
> > But what if the lost event is a FORK or an EXEC or the worst one to
> > lose, an MMAP?
> 
> Right, we can't lose those, so for using this, we need something like
> the intel_pt tooling code does, i.e. add an extra event to the mix, a
> software event, "dummy", that then gets used to track just the
> PERF_RECORD_!SAMPLE metadata events and then this one never gets paused.
> 
> The intel pt motivation is different, but the technique perhaps will
> allow for using the backward code while not losing metadata events.
> 
> wdyt? Wang?
> 
> - Arnaldo
>  
> > Now we can't even match up events properly and we get tons of those
> > dreaded "Unknown" symbols and DSOs.  The output looks terrible and the
> > tool becomes useless.
> > 
> > And yes this happens frequently.
> > 
> > I think the overwrite ring buffer mode should be seriously
> > reconsidered.  The "I'd rather see new than old events" part is fine,
> > but the "pause" part is not.  You can't turn event recording off on
> 
> > the kernel side while you fetch some events, because it means that
> > critical events that allow us to properly interpret future events will
> > be lost.
