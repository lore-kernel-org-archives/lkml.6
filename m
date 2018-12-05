Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD65C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5C820892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C5C820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbeLESde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:33:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728460AbeLESd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:33:29 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2DF053082A34;
        Wed,  5 Dec 2018 18:33:29 +0000 (UTC)
Received: from krava (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7E77D194AF;
        Wed,  5 Dec 2018 18:33:27 +0000 (UTC)
Date:   Wed, 5 Dec 2018 19:33:26 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <andi@firstfloor.org>
Subject: Re: perf: perf_fuzzer triggers GPF in perf_prepare_sample
Message-ID: <20181205183326.GE3836@krava>
References: <alpine.DEB.2.21.1812041039220.19558@macbook-air>
 <20181205124538.GA19343@krava>
 <20181205163838.GA3836@krava>
 <alpine.DEB.2.21.1812051208580.29892@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812051208580.29892@macbook-air>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 05 Dec 2018 18:33:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 12:11:19PM -0500, Vince Weaver wrote:
> On Wed, 5 Dec 2018, Jiri Olsa wrote:
> 
> > On Wed, Dec 05, 2018 at 01:45:38PM +0100, Jiri Olsa wrote:
> > > On Tue, Dec 04, 2018 at 10:54:55AM -0500, Vince Weaver wrote:
> > > > Hello,
> > > > 
> > > > I was able to trigger another oops with the perf_fuzzer with current git.
> > > > 
> > > > This is 4.20-rc5 after the fix for the very similar oops I previously 
> > > > reported got committed.
> > > > 
> > > > It seems to be pointing to the same location in the source as 
> > > > before, I guess maybe triggered a different way?
> > > 
> > > nice.. yep, looks the same
> > > 
> > > > 
> > > > Unfortunately this crash is not easily reproducible like the last one was.
> > > 
> > > will check
> > 
> > what model are hitting this on?
> 
> Haswell.  6/60/3.
> 
> While I can't deterministically trigger this, the fuzzer usually hits it
> within an hour or two.  Is there any debug or printk messages I can
> add that would help figure out what's going on?

I can't see how we could end up with that config other than
some corruption.. the only way I see could be that we touch
cpu->events array without checking its active_mask bit

but that does not explain why the crash happened in the same
place as before

jirka


---
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ecc3e34ca955..9a2fd5a68d87 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2404,7 +2404,7 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 	struct cpu_hw_events *cpuc;
 	int loops;
 	u64 status;
-	int handled;
+	int handled = 0;
 	int pmu_enabled;
 
 	cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -2423,8 +2423,10 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 	intel_bts_disable_local();
 	cpuc->enabled = 0;
 	__intel_pmu_disable_all();
-	handled = intel_pmu_drain_bts_buffer();
-	handled += intel_bts_interrupt();
+	if (test_bit(INTEL_PMC_IDX_FIXED_BTS, cpuc->active_mask)) {
+		handled += intel_pmu_drain_bts_buffer();
+		handled += intel_bts_interrupt();
+	}
 	status = intel_pmu_get_status();
 	if (!status)
 		goto done;
