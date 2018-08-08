Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6730DC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30D121722
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C8OzGjYN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30D121722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeHHLtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:49:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47672 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbeHHLtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yBy8GC4j5bX113zc5eBNgEEebzQMiz9HLG0ZMm87CeM=; b=C8OzGjYNW9e6MECK1IoOFdbrl
        Pzq22RZVdJwqlcnUxYtDOsVbrvaEtRUA+KvWYCpJ4782bdodWv0bl31aNafUYdjvydOL9oOhEK3xr
        OcOl3486xGXzyswJ9Tl96Cx9VL63kgS4flUT/IPcAbte8YUy2AJs1yfnrboCcRGFUx3KdlzilR456
        RfP7NaV/kBWJkBjEdxCS4HCfLSWKj5ODP5zegrpALMzOr8es6ob+28YAoSVgojDNYCX6IwXBmLab/
        jNexyCdvxwvQh/v6AuTlFyMF2QTKBc6V3SN3u+voN8wI5NEgv5/AujYpYltQ1pAPQK02XWvCEP5Nt
        Mkbu9xqrg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fnKnK-0008Uk-7B; Wed, 08 Aug 2018 09:30:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6EFCA20437393; Wed,  8 Aug 2018 11:30:16 +0200 (CEST)
Date:   Wed, 8 Aug 2018 11:30:16 +0200
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
Message-ID: <20180808093016.GS2512@hirez.programming.kicks-ass.net>
References: <1533712172-11428-1-git-send-email-srikar@linux.vnet.ibm.com>
 <20180808075840.GO2494@hirez.programming.kicks-ass.net>
 <20180808081942.GA37418@linux.vnet.ibm.com>
 <20180808084302.GQ2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808084302.GQ2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 10:43:02AM +0200, Peter Zijlstra wrote:
> On Wed, Aug 08, 2018 at 01:19:42AM -0700, Srikar Dronamraju wrote:

> > We could fix the numa topology to be NUMA_DIRECT for 2 node machines, by
> > checking if sched_domains_numa_levels == 2, but then I dont know what it
> > means for a system that has only NODE but not NUMA level.
> 
> You have a point there; I think we should not have added the NODE thing
> to sched_domains_numa_level, let me see if we can fix that sanely.

Hurm,. looking this over I don't see anything better than changing that
NUMA_DIRECT test to <= 2.

But as the comment says, DIRECT means: all nodes are directly connected,
or not a NUMA system. A system with a single node is not a NUMA system
and would thus qualify.
