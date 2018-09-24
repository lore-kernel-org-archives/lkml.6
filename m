Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65F0ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9116520883
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lvcEFd/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9116520883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbeIXV7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:59:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46526 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729466AbeIXV7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cd4dloH5vUxWJQ5leOBmd7ke16LGZpzczxS1cOU2ocY=; b=lvcEFd/FkCnOvcIA9+Te4gNEo
        YIfCQuvA6fyV7/4R7THppO4Y7yGnXTzcgi8prVaDxSwhWpD7x+nEFNdkF6YQ+2adEKJP+G8uZ/8zU
        IRyidsymuVscr4wc7J/Z0cWUMrPhX1Ius+G53BBzXhPioPgea99PL+cbY4gFWoq1HS5yYmN6yEdI4
        L1pYAZ5AyxfWgCGvYvdO58ljgULkndj3dlsC9aqWrPwdwKLDN/0mYCYK0586cYdF1D4s/gKaOGwHI
        hXgbJG/0rYb6bBKrD6S8XfcQUSfwLAfUYCJAp5Okb/tW0M1N+6g8EeK5fMPfAZx37zIPRiDCDW40Q
        4xZgpAZ2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g4TDg-0003bK-3C; Mon, 24 Sep 2018 15:56:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 87CC52029F875; Mon, 24 Sep 2018 17:56:16 +0200 (CEST)
Date:   Mon, 24 Sep 2018 17:56:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 14/16] sched/core: uclamp: request CAP_SYS_ADMIN by
 default
Message-ID: <20180924155616.GA7060@hirez.programming.kicks-ass.net>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-15-patrick.bellasi@arm.com>
 <20180904134748.GA4974@localhost.localdomain>
 <20180906144053.GD25636@e110439-lin>
 <20180914111003.GC24082@hirez.programming.kicks-ass.net>
 <20180914140732.GR1413@e110439-lin>
 <20180914142813.GM24124@hirez.programming.kicks-ass.net>
 <20180917122723.GS1413@e110439-lin>
 <20180921091308.GD24082@hirez.programming.kicks-ass.net>
 <20180924151400.GT1413@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924151400.GT1413@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 04:14:00PM +0100, Patrick Bellasi wrote:
> On 21-Sep 11:13, Peter Zijlstra wrote:
> > Laptops with active cooling however...
> 
> How do you see active cooling playing a role ?
> 
> Are you thinking, for example, at reduced fan noise if we remain below
> a certain OPP ?
> 
> Are you factoring fans power consumptions into the overall P consumption ?

Nothing as fancy as that; I just figured that with a larger cooling
capacity, you can push chips higher onto that curve past the optimal
IPC/Watt point. Make it go fast etc..
