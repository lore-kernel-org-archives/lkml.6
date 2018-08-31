Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC75C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A46120661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MlYBTx8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A46120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbeHaQO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:14:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46940 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeHaQO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yf4vlrsey7BLfPTudc4LWGEbJmcE45qXZ6yi9eiY5po=; b=MlYBTx8z/wYU+N1lf9mPJcQgm
        xphes2waV1VKb6KGuC4VzWbPd38OO4gXhjoAd/9uGPVDIP1JcuCZaCyHE/KwXZuorDINJV6nxptbV
        6opdEIayxilZNC1/g4/0twnB2PCY9f3V+dQxFpMwOxrOHUVFh1w0xa3NjK4GwIO63cMvvkqv9AEZS
        n0l3BIqxrlXCCjpNVkiKp0xvK4RZBnQ3tDx1FEw2LeaQ9f3X1+25IKssiYu0LB9Y5B4Xfl9ZmsUHD
        zaqGXLGNIxOkAX+z3+4VOcdJ5rSUxRXcYsGXxbZ7j7c2uZH11OwyAS+8QWC+okfkJvyJGQWQRtokV
        8hJx5EpPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fviB2-0006q0-PC; Fri, 31 Aug 2018 12:05:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 40C522024D700; Fri, 31 Aug 2018 14:05:22 +0200 (CEST)
Date:   Fri, 31 Aug 2018 14:05:22 +0200
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
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH 2/2] sched/topology: Expose numa_mask set/clear functions
 to arch
Message-ID: <20180831120522.GL24124@hirez.programming.kicks-ass.net>
References: <20180808081942.GA37418@linux.vnet.ibm.com>
 <1533920419-17410-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1533920419-17410-2-git-send-email-srikar@linux.vnet.ibm.com>
 <20180829080219.GN24124@hirez.programming.kicks-ass.net>
 <20180831102724.GB8437@linux.vnet.ibm.com>
 <20180831111253.GJ24124@hirez.programming.kicks-ass.net>
 <20180831112639.GA24142@hirez.programming.kicks-ass.net>
 <20180831115350.GC8437@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831115350.GC8437@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 04:53:50AM -0700, Srikar Dronamraju wrote:
> * Peter Zijlstra <peterz@infradead.org> [2018-08-31 13:26:39]:
> 
> > On Fri, Aug 31, 2018 at 01:12:53PM +0200, Peter Zijlstra wrote:
> > > NAK, not until you've fixed every cpu_to_node() user in the kernel to
> > > deal with that mask changing.
> > 
> > Also, what happens if userspace reads that information; uses libnuma and
> > then you go and shift the world underneath their feet?
> > 
> > > This is absolutely insane.
> > 
> 
> The topology events are suppose to be very rare.
> From whatever small experiments I have done till now, unless tasks are
> bound to both cpu and memory, they seem to be coping well with topology
> updates. I know things weren't optimal after a topology change but they
> worked. Now after 051f3ca02e46 "Introduce NUMA identity node sched
> domain", systems stall. I am only exploring at ways to keep them working
> as much as they were before that commit.

I'm saying things were fundamentally buggered and this just made it show.

If you cannot guarantee cpu:node relations, you do not have NUMA, end of
story.
