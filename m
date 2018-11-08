Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41E7C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE5D20685
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uIxNB/iJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE5D20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbeKHT10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 14:27:26 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57654 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbeKHT10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 14:27:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LlkJUTLDNsaj+mk6xpXWJLdd4sLNgs8yF4/l4NiECRU=; b=uIxNB/iJt7uxD8nPM776cm+1dT
        oQ7g9d0STGAJutUxCjhbeGvv100HZ6BbQmhKSYhVm5iwtWv/MTvqDQnLor8kxoIc2gAxGO3MMm0NV
        AjqVUcq49JWcilnSisSeCot1VEdQkc5YMyO3TBM9uQR72o3p8WnA8Bvfo6r+OtE4GLuehYKGwaxDn
        3P9zCLHc2XRZ9m4wmbBPBwU41G+sbCRV3tMFiz/OcvitIrpfvSoDHsjfL3XVJYtBB6xVsU6jWwepn
        nH1A1jEAQ4dHilIBUcwSn4gY08GTx7sWmJzdXSX+1vlXVA2eTIP5IzUP5RHMtUCUngOyxy6PpNKar
        UeX/4eOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKgzR-00087b-BJ; Thu, 08 Nov 2018 09:52:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AED2D20284F98; Thu,  8 Nov 2018 10:52:39 +0100 (CET)
Date:   Thu, 8 Nov 2018 10:52:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Muchun Song <smuchun@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org
Subject: Re: [PATCH] sched/rt: Introduce prio_{higher,lower}() helper for
 comparing RT task prority
Message-ID: <20181108095239.GO9761@hirez.programming.kicks-ass.net>
References: <20181107161505.42769-1-smuchun@gmail.com>
 <20181107173140.GK9761@hirez.programming.kicks-ass.net>
 <CAPSr9jGXPr-fcywjBTmGa5myeKSoGn+N3ybs9b2s2ayfU=sL2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPSr9jGXPr-fcywjBTmGa5myeKSoGn+N3ybs9b2s2ayfU=sL2A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 10:15:49AM +0800, Muchun Song wrote:
> Peter Zijlstra <peterz@infradead.org> 于2018年11月8日周四 上午1:31写道：

> > I think you only need the less thing, because:
> >
> > static inline bool prio_lower(int a, int b)
> > {
> >         return a > b;
> > }
> >
> > prio_higher(a,b) := prio_lower(b,a)
> > prio_higher_eq(a,b) := !prio_lower(a,b)
> > prio_lower_eq(a,b) := !prio_lower(b,a)
> 
> Yeah, it can be simpler here. Thanks for your advice.
> I will send a v2 patch which will fix it.
> 
> >
> > Now, I'm not sure if that actually improves readability if you go around
> > and directly substitute those identities instead of doing those defines.
> >
> 
> When I first read rt.c, I couldn't quickly realize which priority was higher
> in if condition. With this patch applied, if I know what's the meaning
> of prio_higher()
> or prio_lower() so that I can quickly know who's priority is higher.
> So I think that
> it can improves readability.

Ah, yes, I agree it improves readability; what I wondered was if instead
of doing:

@@ -1424,7 +1446,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
 	 */
 	if (curr && unlikely(rt_task(curr)) &&
 	    (curr->nr_cpus_allowed < 2 ||
-	     curr->prio <= p->prio)) {
+	     prio_higher_eq(curr->prio, p->prio))) {
 		int target = find_lowest_rq(p);
 
 		/*
@@ -1432,7 +1454,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
 		 * not running a lower priority task.
 		 */
 		if (target != -1 &&
-		    p->prio < cpu_rq(target)->rt.highest_prio.curr)
+		    prio_higher(p->prio, cpu_rq(target)->rt.highest_prio.curr))
 			cpu = target;
 	}
 	rcu_read_unlock();


Something like so might be better:


@@ -1424,7 +1446,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
 	 */
 	if (curr && unlikely(rt_task(curr)) &&
 	    (curr->nr_cpus_allowed < 2 ||
-	     curr->prio <= p->prio)) {
+	     !prio_lower(curr->prio, p->prio))) {
 		int target = find_lowest_rq(p);
 
 		/*
@@ -1432,7 +1454,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
 		 * not running a lower priority task.
 		 */
 		if (target != -1 &&
-		    p->prio < cpu_rq(target)->rt.highest_prio.curr)
+		    prio_lower(cpu_rq(target)->rt.highest_prio.curr, p->prio))
 			cpu = target;
 	}
 	rcu_read_unlock();

That is, always use prio_lower() and not introduce the other helpers.

I'm not sure; those identities are faily basic for me; but I can imagine
someone who's not yet read code for 30 odd years might struggle with
that a bit.
