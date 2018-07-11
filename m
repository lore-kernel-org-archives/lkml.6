Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F549C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280DA2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kVun+o5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280DA2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733073AbeGKM54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:57:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41310 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeGKM54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nLevQ8qfld1UFe+jJVodaBAEfEq1X4zUTwKjy4tLpRQ=; b=kVun+o5RXtZC7BMfvXNOxSZG3
        sx73HKfd0d8/tYVChXY7b59WPrLMg6cdyq/nxYonDrAcdFdnlA8zVJqpk0p2Bu6H2g4XQ+bK2dcSv
        YVC3MHVli6cvLmGbXT4gp31vu56HP/djffSuqNvIUkrPQkqTZ5PYWEArhl/zXT17CRalUKMEtBaPy
        BQr7PbIfsRfIFg4wbOkfGq3+Kg1G6EYyLHlGVW3By4HqCgKsBgdJBznpZSC909PEJ/PDhc9LBheNq
        PqMJAT9DWzfk4b+gTt3631suENv27AdxjRZ3W7gaF/BEiSaebZ+iZ6k9yRIQVYLl3XBeYenR6L3hE
        g9zycCn1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdEcW-0000EE-FT; Wed, 11 Jul 2018 12:53:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E700420289CE4; Wed, 11 Jul 2018 14:53:22 +0200 (CEST)
Date:   Wed, 11 Jul 2018 14:53:22 +0200
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
Message-ID: <20180711125322.GF2476@hirez.programming.kicks-ass.net>
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
> -		rcu_read_lock_sched_notrace();				\
> -		it_func_ptr = rcu_dereference_sched((tp)->funcs);	\
> +									\
> +		/*							\
> +		 * For rcuidle callers, use srcu since sched-rcu	\
> +		 * doesn't work from the idle path.			\
> +		 */							\
> +		if (rcuidle) {						\
> +			if (in_nmi()) {					\
> +				WARN_ON_ONCE(1);			\
> +				return; /* no srcu from nmi */		\
> +			}						\
> +									\
> +			idx = srcu_read_lock_notrace(&tracepoint_srcu);	\
> +			it_func_ptr =					\
> +				srcu_dereference_notrace((tp)->funcs,	\
> +						&tracepoint_srcu);	\
> +			/* To keep it consistent with !rcuidle path */	\
> +			preempt_disable_notrace();			\
> +		} else {						\
> +			rcu_read_lock_sched_notrace();			\
> +			it_func_ptr =					\
> +				rcu_dereference_sched((tp)->funcs);	\
> +		}							\
> +									\
>  		if (it_func_ptr) {					\
>  			do {						\
>  				it_func = (it_func_ptr)->func;		\
> @@ -148,9 +177,13 @@ extern void syscall_unregfunc(void);
>  				((void(*)(proto))(it_func))(args);	\
>  			} while ((++it_func_ptr)->func);		\
>  		}							\
> -		rcu_read_unlock_sched_notrace();			\
> -		if (rcucheck)						\
> -			rcu_irq_exit_irqson();				\
> +									\
> +		if (rcuidle) {						\
> +			preempt_enable_notrace();			\
> +			srcu_read_unlock_notrace(&tracepoint_srcu, idx);\
> +		} else {						\
> +			rcu_read_unlock_sched_notrace();		\
> +		}							\
>  	} while (0)

In fact, I would write the thing like:

		preempt_disable_notrace();
		if (rcuidle)
			idx = srcu_read_lock_notrace(&tracepoint_srcu);

		it_func_ptr = rcu_dereference_raw((tp)->funcs);

		/* ... */

		if (rcu_idle)
			srcu_read_unlock_notrace(&tracepoint_srcu, idx);
		preempt_enable_notrace();

Much simpler and very much the same.
