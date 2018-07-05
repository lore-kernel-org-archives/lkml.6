Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B495EC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524DB23DC6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O4JLXEV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524DB23DC6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753975AbeGEOjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:39:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50650 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753604AbeGEOja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=quQO+PSmiLFmvJE3C23pWLrbrvvbiefvIvobRcBA4qk=; b=O4JLXEV2ZUGefes0Fqg0lAbsE
        EYgYRLI95Ng480ToK0KzX2cnorXVvFgBf+yGgpirLH1/6ztWAiMkOnqwoL7n4mrBO4OQpPrYB3IMs
        W0NIWCFeDIlB28oNGbOhFJH6lV5DToBf1cG4hzbD4rCQqs18Wev4DomRhb14mY6hQO+d7+VnhDy7y
        ceofZcUrU1HpBl4m4uRpwUkSp1t6GLDPc2GGNbRyEPvaeiIZAQ01wPXqINwqZmocMMM8lU6m05DIi
        XppSGijvyV6e4poUoIpz6MoDbDqlnUSghAAiiDXwRnrg+2STuSIyFEkifcNfL/YP1OZqN3IQ5w16t
        +jI+LVivQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fb5PT-0000UT-Gw; Thu, 05 Jul 2018 14:39:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF92E20289CF4; Thu,  5 Jul 2018 16:39:01 +0200 (CEST)
Date:   Thu, 5 Jul 2018 16:39:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v4 03/12] PM: Introduce an Energy Model management
 framework
Message-ID: <20180705143901.GO2458@hirez.programming.kicks-ass.net>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-4-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628114043.24724-4-quentin.perret@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 12:40:34PM +0100, Quentin Perret wrote:
> +/**
> + * em_fd_nr_cap_states() - Get the number of capacity states of a freq. domain
> + * @fd		: frequency domain for which want to do this
> + *
> + * Return: the number of capacity state in the frequency domain table
> + */
> +static inline int em_fd_nr_cap_states(struct em_freq_domain *fd)
> +{
> +	struct em_cs_table *table;
> +	int nr_states;
> +
> +	rcu_read_lock();
> +	table = rcu_dereference(fd->cs_table);
> +	nr_states = table->nr_cap_states;
> +	rcu_read_unlock();

So right here, we can continue to free @table...

> +
> +	return nr_states;
> +}

and then what does the value we return mean?

