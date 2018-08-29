Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F1FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA3B20850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eNsXuN3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA3B20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbeH2P4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:56:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54088 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2P4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KzbiVlZgNUdLsADsELyhbfysFLCZGOLS+IPd+hjqu9U=; b=eNsXuN3uH5z3lfcesG3eBDclr
        8Zq4LW+ccO7yxyPi7QXZ9fezNfXcykXcpen1udQzSM3ps06vxTnLha04vYZbkwTTkOlDv148qLlCv
        5r4Vyvt+rQXcTF/bYfkyDBAZZc8y3kBeiP0Lr4xc8kZ7rcT92np9xHBeXWrih3f69gl0o31E10hro
        HYHKU3reSAc34NWFwKGuIpNzEJa+b+UcUw0G59GtTylp1gPxuMydgY9i1ASaRjbbTBXLT+pSzp4S5
        WbP26uwAZ6APhV8R+Q4RSnmfByXlqOM2R98Ma3pEr8m3t76bGVRrCBjO87Xgs4rPaqOpT9iLXZlJ7
        zMZMWGpqQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuz8g-00031D-34; Wed, 29 Aug 2018 11:59:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E2A552024EB1E; Wed, 29 Aug 2018 13:59:54 +0200 (CEST)
Date:   Wed, 29 Aug 2018 13:59:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Steve Muckle <smuckle@google.com>,
        Miguel de Dios <migueldedios@google.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Todd Kjos <tkjos@google.com>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH] sched/fair: vruntime should normalize when switching
 from fair
Message-ID: <20180829115954.GS24124@hirez.programming.kicks-ass.net>
References: <20180817182728.76129-1-smuckle@google.com>
 <dcd2fa21-7fef-d648-017d-9d42d11793e0@google.com>
 <20180824093227.GN24124@hirez.programming.kicks-ass.net>
 <20180824094742.GJ24142@hirez.programming.kicks-ass.net>
 <ae94fb88-646b-1d82-b61d-103792965dbf@google.com>
 <20180827111458.GB24124@hirez.programming.kicks-ass.net>
 <2ed346fa-dbe8-4928-928b-a34338b2d8c9@arm.com>
 <273b9b52-8c00-0414-ea11-214d81cd57c7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <273b9b52-8c00-0414-ea11-214d81cd57c7@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 11:54:58AM +0100, Dietmar Eggemann wrote:
> I forgot to mention that since fair_task's cpu affinity is restricted to
> CPU4, there is no call to set_task_cpu()->migrate_task_rq_fair() since if
> (task_cpu(p) != cpu) fails.
>
> I think the combination of cpu affinity of the fair_task to CPU4 and the
> fact that the scheduler runs on CPU1 when waking fair_task (with the two
> cpus not sharing LLC) while TTWU_QUEUE is enabled is the situation in which
> this vruntime issue can happen.

Ohhh, D'0h. A remote wakeup that doesn't migrate.

That would suggest something like so:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b39fb596f6c1..b3b62cf37fb6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9638,7 +9638,8 @@ static inline bool vruntime_normalized(struct task_struct *p)
 	 * - A task which has been woken up by try_to_wake_up() and
 	 *   waiting for actually being woken up by sched_ttwu_pending().
 	 */
-	if (!se->sum_exec_runtime || p->state == TASK_WAKING)
+	if (!se->sum_exec_runtime ||
+	    (p->state == TASK_WAKING && p->sched_remote_wakeup))
 		return true;
 
 	return false;



