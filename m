Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BBAC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C075216C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pKxrWze3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C075216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeHURUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:20:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42788 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbeHURUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LDnIvO0k5C2Q9NZTkVnMt1bnlbAwGe7QKEP/lGnz/Z8=; b=pKxrWze3CNydmOHe9dmjmIhe1
        cL4p5jEHjx8P/HgB3RfcLeEBKVVM/vptji/jU2liTEDOUfUo9X0fH19ooy2n8qMetniRLcGbJVMSA
        Qm0z6OXNDpiJhpCDY70rKogaSDAWL4lVSHKD565gg6dvCspmWStSyUvggYixFBOSJp8FJvxB01xtD
        sqJMzMcJzNQn7OFa2bTcRZcutldZd9N8+E6nFTn3ccjWxssV2RcoHNZ05u/0VXf0WHZLouRhu5CQj
        y0rnN+XWzI7W+yio4PPd714vaPBz/PLqgwrdtOlqr7OdQ3mg0Dx06Z077sqpPV93Sre52dVVdyJvw
        vBNkzJM3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fs7CK-0006ri-7g; Tue, 21 Aug 2018 13:59:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 46080202975C6; Tue, 21 Aug 2018 15:59:49 +0200 (CEST)
Date:   Tue, 21 Aug 2018 15:59:49 +0200
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
        Andre Wild <wild@linux.vnet.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 1/2] sched/topology: Set correct numa topology type
Message-ID: <20180821135949.GI24082@hirez.programming.kicks-ass.net>
References: <20180808081942.GA37418@linux.vnet.ibm.com>
 <1533920419-17410-1-git-send-email-srikar@linux.vnet.ibm.com>
 <20180821110258.GA2080@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821110258.GA2080@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 04:02:58AM -0700, Srikar Dronamraju wrote:
> * Srikar Dronamraju <srikar@linux.vnet.ibm.com> [2018-08-10 22:30:18]:
> 
> > With commit 051f3ca02e46 ("sched/topology: Introduce NUMA identity node
> > sched domain") scheduler introduces an new numa level. However this
> > leads to numa topology on 2 node systems no more marked as NUMA_DIRECT.
> > After this commit, it gets reported as NUMA_BACKPLANE. This is because
> > sched_domains_numa_level is now 2 on 2 node systems.
> > 
> > Fix this by allowing setting systems that have upto 2 numa levels as
> > NUMA_DIRECT.
> > 
> > While here remove a code that assumes level can be 0.
> > 
> > Fixes: 051f3ca02e46 "Introduce NUMA identity node sched domain"
> > Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > ---
> 
> Hey Peter,
> 
> Did you look at these two patches?

Nope, been on holidays and the inbox is an even bigger mess than normal.
I'll get to it, eventually :/
