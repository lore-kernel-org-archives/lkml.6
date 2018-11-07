Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06F8C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743B520827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jm6qsNfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743B520827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbeKGTjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:39:02 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55698 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeKGTjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:39:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hlUwO1VZrUM9HCiTW+9Tathdzf6Whp66v77agIKu3lc=; b=jm6qsNfO3GJc5OFNn68Ln8/vB
        ieAVrieDSAYLlg5QltOqBqd1FIIfcKqIG/9nAoVxq16BpnoK1QeoOl6/lyPnedr87dIdDwMoqYiJP
        RYPErdtU22Ob8Gp+7AHsY5ZkzNagm5cSriaH0vUTSv5VDh/0480wd6fxd1aPrAHuMyN89SMQ3S28E
        1hr0hXMLm5mOHAMzfgShiqNuecKMq117L/bZlB7bzQotzdCL/As5bLtM5jj19Tt66X12qpnoP2JQe
        65joCwiJjvpSio/21tCUWoGmP24oW2Vh9BecDVsFa69Bx1N764Lt4CsVjgB8kqZE7jF/kGrW98mH8
        1G4olkd8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKKls-0003yB-Eg; Wed, 07 Nov 2018 10:09:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9888E20284F9D; Wed,  7 Nov 2018 11:09:08 +0100 (CET)
Date:   Wed, 7 Nov 2018 11:09:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [RFC][PATCH] irq/timings: Ignore predictions in the past
Message-ID: <20181107100908.GJ9781@hirez.programming.kicks-ass.net>
References: <1556808.yKVbhZSazi@aspire.rjw.lan>
 <20181106170442.GC9781@hirez.programming.kicks-ass.net>
 <CAJZ5v0hmm2UWRt1j6hQo14nZLgPrE3DZkOznfo2kMxsZ1spo-Q@mail.gmail.com>
 <20181106195127.GD9781@hirez.programming.kicks-ass.net>
 <CAJZ5v0iPs8Wt0PneBVWptqJPP6dEze+=GvxjU=dHBRbmty+kOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iPs8Wt0PneBVWptqJPP6dEze+=GvxjU=dHBRbmty+kOw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 12:39:31AM +0100, Rafael J. Wysocki wrote:
> In general, however, I need to be convinced that interrupts that
> didn't wake up the CPU from idle are relevant for next wakeup
> prediction.

So you're worried about the case where we're 100% busy and generating IO
interrupts (disk, network, etc..) and then go idle and those interrupts
stop happening, but we'll base a prediction off of them?

Any predictor will have some of those trancients, but note that we'll
only actually train the irq timing thing when here is idle time. If
we're 100% busy, we'll never actually consume the data.

Also, I think the below delta (on top of my earlier patch) would make
sense; as I don't see how the current code makes sense there.

--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -306,22 +306,17 @@ u64 irq_timings_next_event(u64 now)
 			continue;
 
 		if (irqs->next_evt <= now) {
-			irq = i;
-			next_evt = now;
-
 			/*
-			 * This interrupt mustn't use in the future
-			 * until new events occur and update the
-			 * statistics.
+			 * If the last prediction was in the past, mark the IRQ
+			 * as invalid until a next interrupt updates the
+			 * prediction.
 			 */
 			irqs->valid = 0;
-			break;
+			continue;
 		}
 
-		if (irqs->next_evt < next_evt) {
-			irq = i;
+		if (irqs->next_evt < next_evt)
 			next_evt = irqs->next_evt;
-		}
 	}
 
 	return next_evt;
