Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE4AC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CA6218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfAYQA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:00:57 -0500
Received: from mga06.intel.com ([134.134.136.31]:12904 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfAYQA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:00:57 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 08:00:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,521,1539673200"; 
   d="scan'208";a="111064134"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga006.jf.intel.com with ESMTP; 25 Jan 2019 08:00:56 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 56EB8300FE9; Fri, 25 Jan 2019 08:00:56 -0800 (PST)
Date:   Fri, 25 Jan 2019 08:00:56 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        eranian@google.com, vincent.weaver@maine.edu,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
Message-ID: <20190125160056.GG6118@tassilo.jf.intel.com>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> [Fri Jan 25 10:28:53 2019] perf: interrupt took too long (2501 > 2500), lowering kernel.perf_event_max_sample_rate to 79750
> [Fri Jan 25 10:29:08 2019] perf: interrupt took too long (3136 > 3126), lowering kernel.perf_event_max_sample_rate to 63750
> [Fri Jan 25 10:29:11 2019] perf: interrupt took too long (4140 > 3920), lowering kernel.perf_event_max_sample_rate to 48250
> [Fri Jan 25 10:29:11 2019] perf: interrupt took too long (5231 > 5175), lowering kernel.perf_event_max_sample_rate to 38000
> [Fri Jan 25 10:29:11 2019] perf: interrupt took too long (6736 > 6538), lowering kernel.perf_event_max_sample_rate to 29500

These are fairly normal.

> [Fri Jan 25 10:32:44 2019] ------------[ cut here ]------------
> [Fri Jan 25 10:32:44 2019] perfevents: irq loop stuck!

I believe it's always possible to cause an irq loop. This happens when
the PMU is programmed to cause PMIs on multiple counters 
too quickly. Maybe should just recover from it without printing such
scary messages.

Right now the scary message is justified because it resets the complete
PMU. Perhaps need to be a bit more selective resetting on only
the events that loop.

> [Fri Jan 25 10:32:44 2019] WARNING: CPU: 1 PID: 0 at arch/x86/events/intel/core.c:2440 intel_pmu_handle_irq+0x158/0x170

This looks independent.

I would apply the following patch (cut'n'pasted, so may need manual apply) 
and then run with

cd /sys/kernel/debug/tracing
echo 50000 > buffer_size_kb
echo default_do_nmi > set_graph_function 
echo 1 > events/msr/enable 
echo 'msr != 0xc0000100 && msr != 0x6e0' > events/msr/write_msr/filter
echo function_graph > current_tracer 
echo printk:traceoff > set_ftrace_filter
echo 1 > tracing_on

and then collect the trace from /sys/kernel/debug/tracing/trace
after the oops.  This should show the context of when it happens.

diff --git a/kernel/events/Makefile b/kernel/events/Makefile
index 3c022e33c109..8afc997110e0 100644
--- a/kernel/events/Makefile
+++ b/kernel/events/Makefile
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-ifdef CONFIG_FUNCTION_TRACER
-CFLAGS_REMOVE_core.o = $(CC_FLAGS_FTRACE)
-endif
 
 obj-y := core.o ring_buffer.o callchain.o
 
