Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E65ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BEC2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sxi47nb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BEC2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbeIQNuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:50:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60250 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbeIQNuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eNKH6e6fBgoHo9OQgEsILNApHLL7uWcVvbojj6a9/2U=; b=sxi47nb2tbbYXr6cYguIPfs0d
        nn/jptU/oueeHuI09/Osw4lNpt1Z4jS/4Ds+TkUNReIdYRp8ABd155QVLi+N2TlAqNB9Rdypa/GfA
        SzXYhZuP8AplKpLmPTyV4ePg25z5vvlyMa2EtU+josqLHfSPqNrWXX/SsuF8GSXePgKvHolmOXN1L
        snXrKF8oid2Jp/GeNCKl0XfHeyMRvLlC/TllEKIW0ZsuOwUT7jxRDddqKLF9w9UOLKcWSe9jz2XOw
        VVGWZDsP4WrRGhETmnWj+XigTCLOde5MVVUVSLcQ1OTL64Z49dzBWoC/eysFrN8f8S60r2pQ9jhNq
        rxdC44a0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g1ooj-0001d1-K4; Mon, 17 Sep 2018 08:23:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 17FE4202C1A2E; Mon, 17 Sep 2018 10:23:36 +0200 (CEST)
Date:   Mon, 17 Sep 2018 10:23:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        mingo@redhat.com, acme@kernel.org, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/6] perf/core: Add helper to obtain performance
 counter index
Message-ID: <20180917082336.GP24124@hirez.programming.kicks-ass.net>
References: <cover.1536685533.git.reinette.chatre@intel.com>
 <6f93048a74c66a275f8eb6e1298f10552d1e5d95.1536685533.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f93048a74c66a275f8eb6e1298f10552d1e5d95.1536685533.git.reinette.chatre@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 10:14:33AM -0700, Reinette Chatre wrote:
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 53c500f0ca79..c04dc666425c 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1025,6 +1025,27 @@ static inline int in_software_context(struct perf_event *event)
>  	return event->ctx->pmu->task_ctx_nr == perf_sw_context;
>  }
>  
> +/**
> + * perf_rdpmc_index - Return PMC counter used for event
> + * @event: the perf_event to which the PMC counter was assigned
> + *
> + * The counter assigned to this performance event may change if interrupts
> + * are enabled. This counter should thus never be used while interrupts are
> + * enabled. Before this function is used to obtain the assigned counter the
> + * event could be checked for validity using, for example,
> + * perf_event_read_local(), within the same interrupt disabled section in
> + * which this counter is planned to be used.
> + *
> + * Return: The index of the performance monitoring counter assigned to
> + * @perf_event.
> + */
> +static inline int perf_rdpmc_index(struct perf_event *event)
> +{
> +	lockdep_assert_irqs_disabled();
> +
> +	return event->hw.event_base_rdpmc;
> +}

I said arch/x86/include/asm/perf_events.h and call it:
x86_perf_rdpmc_index().

This function is very much x86 specific.
