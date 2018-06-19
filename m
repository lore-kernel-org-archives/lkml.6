Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13887C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9CC20652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QMRMagH3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9CC20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937793AbeFSNYR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:24:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46074 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937149AbeFSNYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=U57xOQyJi2xZKWb1RAkS8/IyrISuzfq2d4ES0Bn+lN8=; b=QMRMagH37aZQpQnPWZe+2Gfn1
        53S+1TJtIacIqaxM/iKfHL1hYkIWddHBli4wisUbYwMKQo4OeQdBzirtF7Ayk9/AAjrIGTvDyQ8VA
        I65J0sm1r4QOji+tctOTYMSMCB2ijZTKHcM0fyRjaZhz8uNQxuWNEhY6CHSgAjR1ROO07wOJ3xxtD
        cvLrcGIMzNRXPb7za5v52SbESzCrQS04wmkcDF0YxCPUk1GQRbhWv//k4+v0vDz64Lzd+RDFnwBrw
        spFYoocL9mXtwfAy2bXxWWvAjlmeSoCVZqpPrXRK/C0+6PADR/xDk5heeOMaKQzngAZy4dtSUkxcO
        LDGATOgPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVGbk-0002Bb-Kh; Tue, 19 Jun 2018 13:23:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 010AF202A607E; Tue, 19 Jun 2018 15:23:38 +0200 (CEST)
Date:   Tue, 19 Jun 2018 15:23:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Message-ID: <20180619132338.GF2476@hirez.programming.kicks-ass.net>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <20180619113408.GQ2458@hirez.programming.kicks-ass.net>
 <20180619125857.GY17720@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619125857.GY17720@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 01:58:58PM +0100, Quentin Perret wrote:
> On Tuesday 19 Jun 2018 at 13:34:08 (+0200), Peter Zijlstra wrote:
> > On Mon, May 21, 2018 at 03:24:58PM +0100, Quentin Perret wrote:
> > > +struct em_freq_domain *em_cpu_get(int cpu)
> > > +{
> > > +	struct em_freq_domain *fd;
> > > +	unsigned long flags;
> > > +
> > > +	read_lock_irqsave(&em_data_lock, flags);
> > > +	fd = per_cpu(em_data, cpu);
> > > +	read_unlock_irqrestore(&em_data_lock, flags);
> > 
> > Why can't this use RCU? This is the exact thing read_locks are terrible
> > at and RCU excells at.
> 
> So the idea was that clients (the scheduler for ex) can get a reference
> to a frequency domain object once, and they're guaranteed it always
> exists without asking for it again.
> 
> For example, my proposal was to have the scheduler (patch 05) build its
> own private list of frequency domains on which it can iterate efficiently
> in the wake-up path. If we protect this per_cpu variable with RCU, then
> this isn't possible any-more. The scheduler will have to re-ask
> em_cpu_get() at every wake-up, and that makes iterating over frequency
> domains a whole lot more complex.
> 
> Does that make any sense ?

None what so ever... The lock doesn't guarantee stability any more than
RCU does.

If you hand out the pointer and then drop the read-lock, the write-lock
can proceed and change the pointer right after you.

The very easiest solution is to never change the data, as I think was
suggested elsewhere in the thread. Construct the thing once and then
never mutate.
