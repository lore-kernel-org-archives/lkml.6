Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C98C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92D123FE9
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FoaksaM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92D123FE9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754005AbeGESOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:14:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58392 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753716AbeGESO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ojJKiJ+zLfvNh/4G4G+VNPH3g2rn8SikAZOqhFOfpbM=; b=FoaksaM8iCh1gJYfuN9YE3DGQ
        pcTKzKPHF9FMA86D8KWuUASAjIn9dcdB75aMIjBO7gT8f6Ohx5BC7MSkNTkwxKzchSEdxXenpil7C
        7WjSOpMFIxtEc4ZIylpVcS4ET77Xh8stVlPFz0PRl75+QZqq7KOdqZIUb+lYUY70ziuCvsaYDp1ca
        dsWDl/pwsyXrwAW3glCwVqBuyP72dDUvdCwaELCAwoarEIXZhl+9MueP9bO6c3E1l7nulmR7+lMSm
        y6Bcafx4Pv7ERw4ZWcV1QouHrT0kpveCp+5t6q0ydh20vdR1FoEG88TthXk0Ra88ZZGIzhEXkXGX5
        vADmKcuPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fb8ld-0002rp-7c; Thu, 05 Jul 2018 18:14:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 07F5A20289CE4; Thu,  5 Jul 2018 20:14:08 +0200 (CEST)
Date:   Thu, 5 Jul 2018 20:14:07 +0200
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
Subject: Re: [RFC PATCH v4 05/12] sched/topology: Reference the Energy Model
 of CPUs when available
Message-ID: <20180705181407.GI2494@hirez.programming.kicks-ass.net>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-6-quentin.perret@arm.com>
 <20180705173321.GR2458@hirez.programming.kicks-ass.net>
 <20180705175022.GB21903@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705175022.GB21903@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 06:50:22PM +0100, Quentin Perret wrote:
> On Thursday 05 Jul 2018 at 19:33:21 (+0200), Peter Zijlstra wrote:
> > On Thu, Jun 28, 2018 at 12:40:36PM +0100, Quentin Perret wrote:
> > > +			if (cpumask_equal(doms_new[i], doms_cur[j])
> > > +			    && cpu_rq(cpumask_first(doms_cur[j]))->rd->fd)
> > 
> > Please put the operator at the end of the previous line, not the begin
> > of the next line when splitting.
> 
> I did that to be consistent with the to similar loops above, but n/p,
> I'll change it :-)

In that case, feel free to fix those too ;-)
