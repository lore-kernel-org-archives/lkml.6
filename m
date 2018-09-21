Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0CFC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0312150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2tEJBCM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0312150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390182AbeIUTQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:16:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35304 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeIUTQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Pc8y5ObW5iB1gjT/bvTwWtkmgMJj9g0S6D9w0mEuhnE=; b=2tEJBCM/XB1EoifGfv3RoWK4k
        sVa45HwhxPol0bKXTDYoecKr7YYgDjx8ZFqif0qmeKZtTnKX9t+wk2OWoUsTBpqaCaanuCC3WTsY6
        1dCBmp4z9r681ooTQalOQN5D2EjZ46hr8gMbcnSkBdBYJao3DQq76MqoXT+nTI9/VvisQ0hjF2yod
        eYBRCAdNMOu8F1CguP60UMbkI9kwHs1f149GwUfxJmUNkx+8feCAhnoSoExwXmoqjWisJn3/SCRMT
        wuxnmwNafNnS6BLyLpuUJg5LUTCnRcF/i9t63cJwkE8eFVX5GOKP8NKax+THU+EIycPPMbc+QZ/6/
        riGWTAS3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g3LSZ-0005ux-UX; Fri, 21 Sep 2018 13:27:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D1A8D2024E445; Fri, 21 Sep 2018 15:26:58 +0200 (CEST)
Date:   Fri, 21 Sep 2018 15:26:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-kernel@vger.kernel.org,
        David Carrillo-Cisneros <davidcc@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2] perf/core: Avoid removing shared pmu_context on
 unregister
Message-ID: <20180921132658.GP24106@hirez.programming.kicks-ass.net>
References: <20170512104032.2918-1-chris@chris-wilson.co.uk>
 <20170512114525.17575-1-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170512114525.17575-1-chris@chris-wilson.co.uk>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2017 at 12:45:25PM +0100, Chris Wilson wrote:
> In commit 1fd7e4169954 ("perf/core: Remove perf_cpu_context::unique_pmu"),
> the search for another user of the pmu_cpu_context was removed, and so
> we unconditionally free it during perf_pmu_unregister. This leads to
> random corruption later and a BUG at mm/percpu.c:689.
> 
> v2: Check for shared pmu_contexts under the mutex.
> 
> Fixes: 1fd7e4169954 ("perf/core: Remove perf_cpu_context::unique_pmu")
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: David Carrillo-Cisneros <davidcc@google.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: <stable@vger.kernel.org> # v4.11+
> ---
>  kernel/events/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index aaefaa27e1a6..4f60f66b35ad 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8983,10 +8983,12 @@ EXPORT_SYMBOL_GPL(perf_pmu_register);
>  void perf_pmu_unregister(struct pmu *pmu)
>  {
>  	int remove_device;
> +	int remove_context;
>  
>  	mutex_lock(&pmus_lock);
>  	remove_device = pmu_bus_running;
>  	list_del_rcu(&pmu->entry);
> +	remove_context = !find_pmu_context(pmu->task_ctx_nr);
>  	mutex_unlock(&pmus_lock);
>  
>  	/*
> @@ -9005,7 +9007,8 @@ void perf_pmu_unregister(struct pmu *pmu)
>  		device_del(pmu->dev);
>  		put_device(pmu->dev);
>  	}
> -	free_pmu_context(pmu);
> +	if (remove_context)
> +		free_pmu_context(pmu);
>  }
>  EXPORT_SYMBOL_GPL(perf_pmu_unregister);

I was recently made aware of this patch again; which for some reason
never got resumbitted.

Looking at it I'm not at all sure it is correct.

The first clue is that only task_ctx_nr == perf_sw_context PMUs should
ever be sharing a context; which was noted in the original patch
discussion but that never made it in a comment:

  https://lkml.kernel.org/r/20170118192454.58008-3-davidcc@google.com

And the software PMUs _should_ never get unregistered. Of course it
looks like some:

  arch/powerpc/perf/imc-pmu.c
  drivers/perf/arm_spe_pmu.c

seem to do just that. But I doubt you're running with any of those
drivers active.

Aah, it looks like Will actually fixed this when he did that SPE driver,
see commit:

  df0062b27ebf ("perf/core: Avoid freeing static PMU contexts when PMU is unregistered")

Still, there is another bug there, we should not be doing idr_remove()
outside the lock.

Still, no idea what you hit and why. Or if either or both of these
patches will fix that.

---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c80549bf82c6..a7ab1d31208c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9425,9 +9425,7 @@ static void free_pmu_context(struct pmu *pmu)
 	if (pmu->task_ctx_nr > perf_invalid_context)
 		return;
 
-	mutex_lock(&pmus_lock);
 	free_percpu(pmu->pmu_cpu_context);
-	mutex_unlock(&pmus_lock);
 }
 
 /*
@@ -9697,6 +9695,7 @@ void perf_pmu_unregister(struct pmu *pmu)
 	synchronize_srcu(&pmus_srcu);
 	synchronize_rcu();
 
+	mutex_lock(&pmus_lock);
 	free_percpu(pmu->pmu_disable_count);
 	if (pmu->type >= PERF_TYPE_MAX)
 		idr_remove(&pmu_idr, pmu->type);
@@ -9707,6 +9706,7 @@ void perf_pmu_unregister(struct pmu *pmu)
 		put_device(pmu->dev);
 	}
 	free_pmu_context(pmu);
+	mutex_unlock(&pmus_lock);
 }
 EXPORT_SYMBOL_GPL(perf_pmu_unregister);
 
