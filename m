Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F048AC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6A823F4B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VHXcvzVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6A823F4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753903AbeGEOcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:32:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44216 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753353AbeGEOcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K318wGPGo716pdD3tuII+638SPJEDvOmyn0NHoqtTo4=; b=VHXcvzVt2lZ8MDo9qRWYVRNzV
        CLu5X4b5XIdmyVk0jbO6ca42T8W/KZtS77kdEK6ejbkAKJNYxq58VkqUGv9+noFUODNh0/5d4a2gQ
        dIOT1Wtcwwo3Eqt3F2txjBkRUPwvgEt3InXL9zMoHvTpRgGUvod/UmWwGoew7Geng1heon9SOroR0
        rM3F1A9sYzzXGGpy3re8jMEYfrfhqnmV/S0tR58SmcRKRMv14YUYCVjPbK0EoY6f2HSCdFy7PkLIX
        zGtkZyj46CUTQktoma9R5Abx0G1a1NMRMuFJWblo/o5T/kx5Tbrnt1ui5CxE6hfJ7jk/TEQoJePps
        NRsLOZ49A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fb5IX-0002oo-9H; Thu, 05 Jul 2018 14:31:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 75B7820289CF4; Thu,  5 Jul 2018 16:31:51 +0200 (CEST)
Date:   Thu, 5 Jul 2018 16:31:51 +0200
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
Message-ID: <20180705143151.GN2458@hirez.programming.kicks-ass.net>
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
> + * em_fd_energy() - Estimates the energy consumed by the CPUs of a freq. domain
> + * @fd		: frequency domain for which energy has to be estimated
> + * @max_util	: highest utilization among CPUs of the domain
> + * @sum_util	: sum of the utilization of all CPUs in the domain
> + *
> + * em_fd_energy() dereferences the capacity state table of the frequency
> + * domain, so it must be called under RCU read lock.
> + *
> + * Return: the sum of the energy consumed by the CPUs of the domain assuming
> + * a capacity state satisfying the max utilization of the domain.
> + */
> +static inline unsigned long em_fd_energy(struct em_freq_domain *fd,
> +				unsigned long max_util, unsigned long sum_util)
> +{
> +	struct em_cs_table *cs_table;
> +	struct em_cap_state *cs;
> +	unsigned long freq;
> +	int i;
> +
> +	cs_table = rcu_dereference(fd->cs_table);
> +	if (!cs_table)
> +		return 0;
> +
> +	/* Map the utilization value to a frequency */
> +	cs = &cs_table->state[cs_table->nr_cap_states - 1];
> +	freq = map_util_freq(max_util, cs->frequency, cs->capacity);
> +
> +	/* Find the lowest capacity state above this frequency */
> +	for (i = 0; i < cs_table->nr_cap_states; i++) {
> +		cs = &cs_table->state[i];
> +		if (cs->frequency >= freq)
> +			break;
> +	}
> +
> +	return cs->power * sum_util / cs->capacity;
> +}

I keep reading @max_util as the highest possible util (iow capacity) of
the freq domain, instead of the current highest instant capacity across
the CPUs in the domain.

At the same time I'm struggling for a better name. Maybe just @util? But
that would then maybe confuse against @sum_util. argh..

And I'm confused by what exactly this function computes; are you
(through sum_util) effectively setting idle power at 0?
