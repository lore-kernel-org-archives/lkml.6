Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19935C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D329720877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tN5oT/6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D329720877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbeJDTN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:13:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34062 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbeJDTN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=v7pL1j6omxzEbtqGNokJV0j7V2CQAY4hx58HtWUfndc=; b=tN5oT/6KPxD9vM050D+JHtQ6I
        7ZSthfwqKQZQsdbraLSsxuN6SXTnsQJGzS4HbEyo4qnBzBrzNwzfLiyNml13UpYhywKAiUC6ukbAo
        Ws2bBiBP7bt8GCKmNPfui2L4nW+8Lej33JcQfBukkhK22HOYVkgmYHooNSWdGF7cJyvJU5A+7vqTQ
        jMfW2pCCnTowPv2hI0KP2Cl38SHVJ5fOMJiC7xunnMaVgP6qn2vKDMQLubBjKT4IOmJh4hNZvbDgZ
        kmTSzIheuQE0LkXr5HjVtBdjtcRoDd58wroNTVmr74CjuwRTraiH34H+FxaKKv3/1jQ3k/EZAvPZR
        sHli/eg8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g82aH-00074A-4z; Thu, 04 Oct 2018 12:20:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7D2FD2026A8C7; Thu,  4 Oct 2018 14:18:07 +0200 (CEST)
Date:   Thu, 4 Oct 2018 14:18:07 +0200
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
Subject: Re: [PATCH v7 12/14] sched/fair: Select an energy-efficient CPU on
 task wake-up
Message-ID: <20181004121807.GO19272@hirez.programming.kicks-ass.net>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-13-quentin.perret@arm.com>
 <20181004094412.GD19252@hirez.programming.kicks-ass.net>
 <20181004102722.izp7y42cvayq4pqg@queper01-lin>
 <20181004104107.GN19272@hirez.programming.kicks-ass.net>
 <20181004105507.ordjpa3hsb6zoelc@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004105507.ordjpa3hsb6zoelc@queper01-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 11:55:09AM +0100, Quentin Perret wrote:
> On Thursday 04 Oct 2018 at 12:41:07 (+0200), Peter Zijlstra wrote:
> > Not sure, see what it looks like ;-) My main concern here was to get rid
> > of that giant blob in select_task_rq_fair().
> 
> OK, got it. I'll probably just move the checks into the function and
> merge that large comment into the already massive comment above
> find_energy_efficient_cpu() or something. We'll see :-)
> 
> And do you actually care about the function name ? We've been using
> find_energy_efficient_cpu() for some time in Android now, so that's just
> slightly easier for us if that can be re-used. Not a big deal either,
> though.

Sure, that's fine I suppose.
