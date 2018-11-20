Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23716C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60A7206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VyVJMx3b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E60A7206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbeKUDjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:39:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeKUDjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=r4zhrAr+Rv/qy9luOKSIiSQXOcePqOTlh7D/inHgBHg=; b=VyVJMx3bekEl/LsKwRieE8/0j
        9VX8ug8KiZvow0iQZ9kb7FitpgR+8H7/Nft1yNQQxmv+88Rb8H3FEtQZj9N/sFLbj7WDlOdoLzXYU
        amBLY+CLxot9GxJ3bDDvhK/dQfCiGzNk4WcLN44VjdxU060sQJa9ZB2mhsxJTdXLD9uo4TbuREylZ
        E5jcjnHL9rgYnrfOBK+qz9w7OUjlOzwv5feeXZH/DFQSoXJo8+6hq0ArRoaM6uPU2kKWkpA6fz6ay
        xZ6HHzEvWXbca3BZ478XZGhk1lRSDAasFN91ztB1eAhCkdah6U9ktOO4RAwt7mhMrpKPfi0csv1sh
        9tbZq8rhQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gP9W1-0002av-47; Tue, 20 Nov 2018 17:08:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 480A02029F87F; Tue, 20 Nov 2018 18:08:42 +0100 (CET)
Date:   Tue, 20 Nov 2018 18:08:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kyle Huey <me@kylehuey.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Robert O'Callahan <robert@ocallahan.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, acme@kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] x86, perf: counter freezing breaks rr
Message-ID: <20181120170842.GZ2131@hirez.programming.kicks-ass.net>
References: <CAP045Ap6Mm+r_44YmxNbz6HWtYArg3SAFgzk4Cm_K5HRJaRG7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP045Ap6Mm+r_44YmxNbz6HWtYArg3SAFgzk4Cm_K5HRJaRG7w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 08:19:39AM -0800, Kyle Huey wrote:
> tl;dr: rr is currently broken on 4.20rc2, which I bisected to
> af3bdb991a5cb57c189d34aadbd3aa88995e0d9f. I further confirmed that
> booting the 4.20rc2 kernel with `disable_counter_freezing=true` allows
> rr to work.
> 
> rr, a userspace record and replay debugger[0], uses the PMU interrupt
> (PMI) to stop a program during replay to inject asynchronous events
> such as signals. With perf counter freezing enabled we are reliably
> seeing perf event overcounts during replay. This behavior is easily
> demonstrated by attempting to record and replay the `alarm` test from
> rr's test suite. Through bisection I determined that [1] is the first
> bad commit, and further testing showed that booting the kernel with
> `disable_counter_freezing=true` fixes rr.
> 
> This behavior has been observed on two different CPUs (a Core i7-6700K
> and a Xeon E3-1505M v5). We have no reason to believe it is limited to
> specific CPU models, this information is included only for
> completeness.
> 
> Given that we're already at rc3, and that this renders rr unusable,
> we'd ask that counter freezing be disabled for the 4.20 release.

Andi, can you have a look at this?

Meanwhile, I suppose we should do something along these lines.


---
Subject: perf/x86/intel: Default disable perfmon v4 interrupt handling

Rework the 'disable_counter_freezing' __setup() parameter such that we
can explicitly enable/disable it and switch to default disabled.

To this purpose, rename the parameter to "perf_v4_pmi=" which is a much
better description and allows requiring a bool argument.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 ++-
 arch/x86/events/intel/core.c                    | 12 ++++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 76c82c01bf5e..ff6d1d4229e0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -856,7 +856,8 @@
 			causing system reset or hang due to sending
 			INIT from AP to BSP.
 
-	disable_counter_freezing [HW]
+	perf_v4_pmi=	[X86,INTEL]
+			Format: <bool>
 			Disable Intel PMU counter freezing feature.
 			The feature only exists starting from
 			Arch Perfmon v4 (Skylake and newer).
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 273c62e81546..af8bea9d4006 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2306,14 +2306,18 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	return handled;
 }
 
-static bool disable_counter_freezing;
+static bool disable_counter_freezing = true;
 static int __init intel_perf_counter_freezing_setup(char *s)
 {
-	disable_counter_freezing = true;
-	pr_info("Intel PMU Counter freezing feature disabled\n");
+	bool res;
+
+	if (kstrtobool(s, &res))
+		return -EINVAL;
+
+	disable_counter_freezing = !res;
 	return 1;
 }
-__setup("disable_counter_freezing", intel_perf_counter_freezing_setup);
+__setup("perf_v4_pmi=", intel_perf_counter_freezing_setup);
 
 /*
  * Simplified handler for Arch Perfmon v4:
