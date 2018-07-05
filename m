Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D4AC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28ADA23D34
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VCMQCBhx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28ADA23D34
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754008AbeGEPGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:06:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60732 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753770AbeGEPGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PT8gtfoGqrs1u6FOPezYM0dEVDMoEDLXydpCdfsU27k=; b=VCMQCBhxqv7evroeWeWJyT49h
        6EyGxHigWfugOPW1b4yDk1XuMqzHATBBfIi+EOYGCprVn0RDvTr1MFPLGlH+YsEEeddlMNjUiVyrx
        5pgWbKD95jFxy0Cxx6chNFmNxaDe5WekuOuZuOXVUm19Xb868DaVHf7tww0wOzXT6Hx0oOiJddqRA
        wtKE/H7KfNPX13yHOT6HUzKzItPuBKVedxqMMGggJX2JVPWNayYHhuv5Tghg4BPKG492wOIaWrwWJ
        Fm+Xr1qSn1x2SVE7HXfKaATeqpQ+NsTDEf3LB9mWJHyXRrxxvpC6GRxP5VuUjsNEzeWRrVYyEYnrc
        r7E/cRH2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fb5q3-0002LO-M2; Thu, 05 Jul 2018 15:06:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F3D0720291063; Thu,  5 Jul 2018 17:06:29 +0200 (CEST)
Date:   Thu, 5 Jul 2018 17:06:29 +0200
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
Message-ID: <20180705150629.GP2458@hirez.programming.kicks-ass.net>
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
> +/* fd_update_cs_table() - Computes the capacity values of a cs_table
> + *
> + * This assumes a linear relation between capacity and frequency. As such,
> + * the capacity of a CPU at the n^th capacity state is computed as:
> + *           capactity(n) = max_capacity * freq(n) / freq_max
> + */

Broken comment style

> +static void fd_update_cs_table(struct em_cs_table *cs_table, int cpu)
> +{
> +	unsigned long cmax = arch_scale_cpu_capacity(NULL, cpu);
> +	int max_cap_state = cs_table->nr_cap_states - 1;
> +	unsigned long fmax = cs_table->state[max_cap_state].frequency;
> +	int i;
> +
> +	for (i = 0; i < cs_table->nr_cap_states; i++) {
> +		u64 cap = (u64)cmax * cs_table->state[i].frequency;
> +		do_div(cap, fmax);
> +		cs_table->state[i].capacity = (unsigned long)cap;

I prefer div64_*() over do_div(), the calling convention the latter
always confuses the heck out of me.

So this then becomes something like:

		cs_table->state[i].capacity =
			div64_u64(cmax * cs_table->state[i].frequency, fmax);

> +	}
> +}
