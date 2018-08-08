Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C04C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989F1216F3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kr7tRlV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989F1216F3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeHHKRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:17:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59642 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeHHKRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CcJj81gbrsZv5YOLKlSyHb89sgOJWDqb4J9+bqrHXq8=; b=kr7tRlV3W/qfp/feDHkYfO8st
        BcUQKtp+KCW8ua1APhhFYmp6xjtIUVq/MMi8GJRQVXfknIKHbuXuM/jtJgKH+I8Sw5kpo2T7I1K6w
        KoagAluX8kWEt4pzng6UzTbtVEWHlAgsw9v9gVewg0SsQCTHz+Zd+PCz52cqS9vTLWX1Nth62cDBN
        3pT/vSfg5Zm5LhUP/SLVq2dHKluTsIuCrgqwfFwWAf3u3x/JSAFEX5oDJXw4tGDazOg65+cHJUQ0n
        zneHvst+ZnBnAefIqd9wkafjG9cc0JI0zDTzjsp0f1oCvM2DHYBtJCX6S2EubO+n3YGxQ1MIRMjpa
        2Z8otFCwg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fnJMg-0006NB-A6; Wed, 08 Aug 2018 07:58:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0B4A420437360; Wed,  8 Aug 2018 09:58:41 +0200 (CEST)
Date:   Wed, 8 Aug 2018 09:58:41 +0200
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
Message-ID: <20180808075840.GO2494@hirez.programming.kicks-ass.net>
References: <1533712172-11428-1-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533712172-11428-1-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 12:39:31PM +0530, Srikar Dronamraju wrote:
> With Commit 051f3ca02e46 ("sched/topology: Introduce NUMA identity node
> sched domain") scheduler introduces an extra numa level. However that
> leads to
> 
>  - numa topology on 2 node systems no more marked as NUMA_DIRECT.  After
>    this commit, it gets reported as NUMA_BACKPLANE. This is because
>    sched_domains_numa_level now equals 2 on 2 node systems.
> 
>  - Extra numa sched domain that gets added and degenerated on most
>    machines.  The Identity node is only needed on very few systems.
>    Also all non-numa systems will end up populating
>    sched_domains_numa_distance and sched_domains_numa_masks tables.
> 
>  - On shared lpars like powerpc, this extra sched domain creation can
>    lead to repeated rcu stalls, sometimes even causing unresponsive
>    systems on boot. On such stalls, it was noticed that
>    init_sched_groups_capacity() (sg != sd->groups is always true).

The idea was that if the topology level is redundant (as it often is);
then the degenerate code would take it out.

Why is that not working (right) and can we fix that instead?
