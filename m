Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD7EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8C220818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8C220818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbeKJCTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:19:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbeKJCTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:19:42 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 344CB308AA12;
        Fri,  9 Nov 2018 16:38:22 +0000 (UTC)
Received: from krava (unknown [10.40.205.64])
        by smtp.corp.redhat.com (Postfix) with SMTP id 150F95C220;
        Fri,  9 Nov 2018 16:38:19 +0000 (UTC)
Date:   Fri, 9 Nov 2018 17:38:19 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        torvalds@linux-foundation.org
Subject: Re: perf: perf_fuzzer triggers NULL pointer dereference
Message-ID: <20181109163819.GA2750@krava>
References: <alpine.DEB.2.21.1811081041070.7406@macbook-air>
 <alpine.DEB.2.21.1811081100490.7406@macbook-air>
 <87a7mj5yx4.fsf@ashishki-desk.ger.corp.intel.com>
 <alpine.DEB.2.21.1811081145220.8092@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1811081145220.8092@macbook-air>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 09 Nov 2018 16:38:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 11:46:41AM -0500, Vince Weaver wrote:
> On Thu, 8 Nov 2018, Alexander Shishkin wrote:
> 
> > Vince Weaver <vincent.weaver@maine.edu> writes:
> > 
> > > On Thu, 8 Nov 2018, Vince Weaver wrote:
> > >
> > >> [91760.326510] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> > >> [91760.334876] PGD 0 P4D 0 
> > >> [91760.337596] Oops: 0000 [#1] SMP PTI
> > >> [91760.341332] CPU: 6 PID: 0 Comm: swapper/6 Tainted: G        W         4.20.0-rc1+ #119
> > >> [91760.349816] Hardware name: LENOVO 10AM000AUS/SHARKBAY, BIOS FBKT72AUS 01/26/2014
> > >> [91760.357723] RIP: 0010:perf_prepare_sample+0x82/0x4a0
> > >
> > > so what's the best way to do the equivelent of addr2line on something like 
> > > this, now that we aren't allowed to know the RIP anymore?
> > 
> > scripts/decode_stacktrace.sh works most of the time.
> > 
> > Sounds like BTS needs fixing up again. Thanks for looking at it though!
> 
> In case it matters, it looks like the address of the oops comes down to
> 
> 	linux.git/kernel/events/core.c:6393
> 
> 	size += data->callchain->nr;
>

nice ;-) we can actual fake cpu event to become the bts event
and relay on that EARLY callchain stuff

I can bring my server down by:
  perf record -e cpu/event=0xc4/p -g -c 1

where 0xc4 is the branch instructions events

I guess something like below could prevent it,
but haven't tested it yet, will do next week

jirka


---
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index b7b01d762d32..1049b547fdfe 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -577,6 +577,8 @@ void intel_pmu_disable_bts(void)
 	update_debugctlmsr(debugctlmsr);
 }
 
+static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
+
 int intel_pmu_drain_bts_buffer(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -612,6 +614,9 @@ int intel_pmu_drain_bts_buffer(void)
 
 	perf_sample_data_init(&data, 0, event->hw.last_period);
 
+	if (event->attr.sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY)
+		data.callchain = &__empty_callchain;
+
 	/*
 	 * BTS leaks kernel addresses in branches across the cpl boundary,
 	 * such as traps or system calls, so unless the user is asking for
