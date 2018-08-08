Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B172C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DAFD216FB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RCrv9bQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DAFD216FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeHHLBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:01:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33708 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbeHHLBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bSjMVNarQjEUpBMngpczBpqlWPM1MqUvow+2CQ4p+sg=; b=RCrv9bQ7LOwO0HhUEZenjb5u4
        NO54klfWiRMi5azB3LaOlwppO8OBHchgGcWnfggAAc8JyZ66h0uzWLQumbxcBDOu6VEBywYKKk4wk
        oCKT+CIrhbu5UMgXZBAEsxkSuSRjhF8QCetllcFrCcyAlFMlaHpS5qzZ+LYwqrkGwR3KAHRYTRxtY
        RuI7+J5HXkCwZeS1qxmDUXD9Pz0GDUbkZhs/+0ZEhRh8dLAQspV6L6MRe6tlTiEgL6/55fhXi2Dtm
        W3wQqKdp3TddD4d4ngUGytL+B4c25cDZnHr2ReBlE/kTGBef2LoJyOAdU0+OFW+SP+N39Ao0mu6af
        KELYoKpjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fnK3c-0005eY-Do; Wed, 08 Aug 2018 08:43:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D2EB20163EB8; Wed,  8 Aug 2018 10:43:02 +0200 (CEST)
Date:   Wed, 8 Aug 2018 10:43:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Andre Wild <wild@linux.vnet.ibm.com>
Subject: Re: [PATCH] sched/topology: Use Identity node only if required
Message-ID: <20180808084302.GQ2494@hirez.programming.kicks-ass.net>
References: <1533712172-11428-1-git-send-email-srikar@linux.vnet.ibm.com>
 <20180808075840.GO2494@hirez.programming.kicks-ass.net>
 <20180808081942.GA37418@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808081942.GA37418@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 01:19:42AM -0700, Srikar Dronamraju wrote:

> However, I still think if majority of the cases the identity node is
> going to be redundant, then we should use hint.

No, same way we always generate SMT domains when we have
CONFIG_SCHED_SMT irrespective of the hardware having SMT.

Also, an arch hook like you did is just fugly. If anything you add the
single node thing to the regular topology setup of x86_numa_in_package.

But the thing is, even for x86_numa_in_package the single node domain is
mostly redundant because the MC domain will match the NODE domain most
times.

> We could fix the numa topology to be NUMA_DIRECT for 2 node machines, by
> checking if sched_domains_numa_levels == 2, but then I dont know what it
> means for a system that has only NODE but not NUMA level.

You have a point there; I think we should not have added the NODE thing
to sched_domains_numa_level, let me see if we can fix that sanely.
