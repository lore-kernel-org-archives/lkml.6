Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3577C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A04206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rABhu3Ht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A04206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeJBVNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:13:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56808 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeJBVNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Qcr7sGnqbO+PFiwIq8GBdpYmiY8mqY0mqPx3QQvg+oE=; b=rABhu3Ht4u48F3EBdDfT5ROgr
        EIsQ7OtrZgnLmpqMICp89s1MbLth7vi458ytBKWeqt52La6dRdP5XhI/dfwGtm1jBdkoFM3T/CNsp
        UId7WIAZ/YY9pMy61UTNUTTTxLtkqYCKhkR2ErZWtYmGMKs9Q8xjC3lSqIP5csjEJRxJF7WJUvwrD
        eN4YSiY65az4UiDVCNpfiXX91qfbowGLxoxRKtGSqp5P18YxViWIZ1nL0fwONmOE9K7D5B/OXEuHM
        Ryn1FiVupdYUqvus+pCcRZf7YjFolg85F8rrlDwfEk2eh7/VZ4t8iBqb6TAxZtkxHpdBIYahZhFg6
        Bf5m41w7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7Lfy-0006J7-Ao; Tue, 02 Oct 2018 14:29:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DD852202B9CBE; Tue,  2 Oct 2018 16:29:24 +0200 (CEST)
Date:   Tue, 2 Oct 2018 16:29:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@codeaurora.org,
        skannan@codeaurora.org, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v7 03/14] PM: Introduce an Energy Model management
 framework
Message-ID: <20181002142924.GI26858@hirez.programming.kicks-ass.net>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-4-quentin.perret@arm.com>
 <20181002123031.GZ3439@hirez.programming.kicks-ass.net>
 <20181002125115.245r3ocusvyiexno@queper01-lin>
 <20181002134857.GE26858@hirez.programming.kicks-ass.net>
 <20181002140430.fpeiqzblbcaewg6n@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002140430.fpeiqzblbcaewg6n@queper01-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 03:05:23PM +0100, Quentin Perret wrote:
> On Tuesday 02 Oct 2018 at 15:48:57 (+0200), Peter Zijlstra wrote:
> > +/**
> > + * em_cpu_get() - Return the performance domain for a CPU
> > + * @cpu : CPU to find the performance domain for
> > + *
> > + * Return: the performance domain to which 'cpu' belongs, or NULL if it doesn't
> > + * exist.
> > + */
> > +struct em_perf_domain *em_cpu_get(int cpu)
> > +{
> > +       return READ_ONCE(per_cpu(em_data, cpu));
> > +}
> > +EXPORT_SYMBOL_GPL(em_cpu_get);
> > 
> > But your read side doesn't take, not is required to take em_pd_mutex.
> > 
> > At that point, the mutex_unlock() doesn't guarantee anything.
> > 
> > A CPU observing the em_data store, doesn't need to observe the store
> > that filled the data structure it points to.
> 
> Right but even if I add the smp_store_release(), I can still have a
> CPU observing em_data while another is in the process of updating it.
> So, if smp_store_release() doesn't guarantee that readers will see a
> complete update, do I actually get something interesting from it ?
> (That's not a rhetorical question, I'm actually wondering :-)

I thought the update would fail if em_data was already set.

That is, you can only set this thing up _once_ and then you'll have to
forever live with it.

Or did I read that wrong?

If you want to allow updates, you'll have to do the whole RCU thing, at
which point you'll need rcu_assign_pointer(), which again is exactly
smp_store_release() :-)
