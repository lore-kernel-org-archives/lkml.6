Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15695C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D202084A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mWZH2Exo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D202084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733293AbeGKNBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:01:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37990 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbeGKNB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/VFqgvoFfd/mu2OGdRKjmrVAr7jSMt45bphOTwn6cUQ=; b=mWZH2ExoRPvdFnv0n8Amkenmc
        8jiwcCpYIPRToXG8p1R2rFOI87Fpjb26vJs1ThrouGjtAyCWYq6QOwEv+e1JtSoFBxWQ21qk5fbfj
        ZCzRCxlSe4NDO402hcWSqfQ1Up+HGfNZYw03lApc9GLku6oT09wi+52Jq/K9cfcWosErAa47KSRen
        /C9o/BhKmaZqPbbkSPWPQnbS5Fy4JLuR62exRhGEwMmbB4WbZmlARez2lvW3nai6aF8TCBwl6F3Nj
        mNo5IrYSuJwum5I5Cg6grTACGn0p9qDFf4KUmV/ktQHcuEtUuPyzyeLcqzZa0rVjK6R47nuPLM5Cl
        BOcYCXTWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdEfp-0008Is-4v; Wed, 11 Jul 2018 12:56:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D807220289CE4; Wed, 11 Jul 2018 14:56:47 +0200 (CEST)
Date:   Wed, 11 Jul 2018 14:56:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v9 4/7] tracepoint: Make rcuidle tracepoint callers use
 SRCU
Message-ID: <20180711125647.GG2476@hirez.programming.kicks-ass.net>
References: <20180628182149.226164-1-joel@joelfernandes.org>
 <20180628182149.226164-5-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628182149.226164-5-joel@joelfernandes.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 11:21:46AM -0700, Joel Fernandes wrote:
>  static inline void tracepoint_synchronize_unregister(void)
>  {
> +	synchronize_srcu(&tracepoint_srcu);
>  	synchronize_sched();
>  }

Given you below do call_rcu_sched() and then call_srcu(), isn't the
above the wrong way around?

Also, does the above want to be barrier instead of synchronize, so as to
guarantee completion of the callbacks.

> +static void srcu_free_old_probes(struct rcu_head *head)
>  {
>  	kfree(container_of(head, struct tp_probes, rcu));
>  }
>  
> +static void rcu_free_old_probes(struct rcu_head *head)
> +{
> +	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
> +}
> +
>  static inline void release_probes(struct tracepoint_func *old)
>  {
>  	if (old) {
>  		struct tp_probes *tp_probes = container_of(old,
>  			struct tp_probes, probes[0]);
> +		/*
> +		 * Tracepoint probes are protected by both sched RCU and SRCU,
> +		 * by calling the SRCU callback in the sched RCU callback we
> +		 * cover both cases. So let us chain the SRCU and sched RCU
> +		 * callbacks to wait for both grace periods.
> +		 */
>  		call_rcu_sched(&tp_probes->rcu, rcu_free_old_probes);
>  	}
>  }
