Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819B5C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47ED12082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JFLmURi+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47ED12082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeJCXOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 19:14:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45056 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeJCXOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 19:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R5iG0gNhzz8EExh16pZXFI1PpEoMAci7ycbYW0Y5aKo=; b=JFLmURi+wDWRXTu+o6iczYGWB
        lQ83ETjrKgXnyZGGDryVLOirOKZhh7qoqSsDmc+l7cNi8BIlwAOAFWZRsJBlset1w+6Agt/Wz+CCX
        0Rhw9qblSkj98wbQCM8GIxeJtDh50V/9hRwUVUUFOhul7aqcQg0RHMDCtOptNLGOVBk/Bebqf6Xgp
        bE4m1bY2OUAaxXnj9vyKaHfPGNXDWJladz2j8tIDdbwuGmQZvAkJq2zThwg19uZfDLCrThr3Gn6+k
        evyaZ5sjacyqADkzLkDN0/MR7MME546rSCeMZpJ8FOtjTFKIMWN+W2cFx1rCsOx4LtspCLHpvUVV3
        Fb/+lH4QQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7jxc-0004RZ-Qi; Wed, 03 Oct 2018 16:25:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E532202C416E; Wed,  3 Oct 2018 18:24:35 +0200 (CEST)
Date:   Wed, 3 Oct 2018 18:24:35 +0200
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
Subject: Re: [PATCH v7 05/14] sched: Introduce a sched_feat for Energy Aware
 Scheduling
Message-ID: <20181003162435.GA19252@hirez.programming.kicks-ass.net>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-6-quentin.perret@arm.com>
 <20181002123416.GA3439@hirez.programming.kicks-ass.net>
 <20181002130818.fciw7cmlwggymxrz@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002130818.fciw7cmlwggymxrz@queper01-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 02:08:21PM +0100, Quentin Perret wrote:
> On Tuesday 02 Oct 2018 at 14:34:16 (+0200), Peter Zijlstra wrote:

> > So these are debug knobs.. I would expect there to be a regular
> > static_key that is controlled by the presence of EM data.
> 
> Right, the issue I'm trying to solve with this is basically that _some_
> users will want to have an EM for the thermal stuff, but they will want
> EAS disabled. Some people (not very many that's true, but still) use
> big.little and don't care much about energy ...
> 
> So, there is a need for an EAS knob on the scheduler side. I don't mind
> it being something else than a sched_feat, but I couldn't see a better
> option. Another Kconfig (CONFIG_SCHED_ENERGY) ? A sysctl ?

Yeah, sysctl, see for example: sysctl.kernel.numa_balancing and the
sched_numa_balancing static_key that goes with it.

I would default enable EAS if the EM is there and valid, but allow
people to disable it.

