Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE02FC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930F32086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RdLVZhG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930F32086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbeIYSkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:40:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41888 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbeIYSkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fVeypW0c9yXTee3kTdE5jLY+GhHFXVY9Trn7iK79WZQ=; b=RdLVZhG+lDkTXc9gPp6JKufWK
        XYlEPTdEsYb5m/FWU0aWrOza2KZ+bdH0Z9EwY5OnN6aBeJz5+Y6K296s6j6sEXbAzKvnFDah2gKZE
        jdbZvcDhXnt8T/NOP4WCScOZCzud2CiDfyTxComHG/D+cJG5/7SbiFvuVRTzL3pkZpNmYtx/LLdaF
        gWWpf+RLxMGoeFqqMcLLuKt90bA9UGl4iYAdpi7C/wm5sipmZ9MYL8i7ZZib5Y25FvIqUcf15ebNy
        aB6+jEPDnNLhhqJFv30zZS6anOycuXpSw2uA8eSgSYDdc7D/t+niJiBsk9xRgQTEQEDZTjDF71i+/
        oYvPYnm5A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g4mVt-0004Yy-9i; Tue, 25 Sep 2018 12:32:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 07D5620289D10; Tue, 25 Sep 2018 14:32:23 +0200 (CEST)
Date:   Tue, 25 Sep 2018 14:32:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v5 5/5] cpuset: Rebuild root domain deadline accounting
 information
Message-ID: <20180925123222.GA29985@hirez.programming.kicks-ass.net>
References: <20180903142801.20046-1-juri.lelli@redhat.com>
 <20180903142801.20046-6-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903142801.20046-6-juri.lelli@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 04:28:01PM +0200, Juri Lelli wrote:
> +/*
> + * Called with cpuset_mutex held (rebuild_sched_domains())
> + * Called with hotplug lock held (rebuild_sched_domains_locked())
> + * Called with sched_domains_mutex held (partition_and_rebuild_domains())

Isn't that what we have lockdep_assert_held() for?

> + */
> +static void rebuild_root_domains(void)
> +{
> +	struct cpuset *cs = NULL;
> +	struct cgroup_subsys_state *pos_css;
> +
> +	rcu_read_lock();
> +
> +	/*
> +	 * Clear default root domain DL accounting, it will be computed again
> +	 * if a task belongs to it.
> +	 */
> +	dl_clear_root_domain(&def_root_domain);
> +
> +	cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
> +
> +		if (cpumask_empty(cs->effective_cpus)) {
> +			pos_css = css_rightmost_descendant(pos_css);
> +			continue;
> +		}
> +
> +		css_get(&cs->css);
> +
> +		rcu_read_unlock();

That looks really dodgy, but I suppose the comment near
css_next_descendant_pre() spells out that this is in fact OK.

> +		update_tasks_root_domain(cs);
> +
> +		rcu_read_lock();
> +		css_put(&cs->css);
> +	}
> +	rcu_read_unlock();
> +}
