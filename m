Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D470C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071A52084D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="w9LlAP8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071A52084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbeH2Mx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:53:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50364 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2Mx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MtwxPm2Nq/MqcdmLhRUmEH0tUSJAWEyAaYBTZN06Xb0=; b=w9LlAP8D60QXppShFd3jsH2hx
        2Yg17u5ohQ62cP3dg1OhRIEqfz+dS6Do0wREl6ob3iiX1D51oRPCHAmnIql9lt8aIyToygT9IKZ9G
        C2uMXNB5nbKA2qpohPsofdpeLEu0axFnufX3g12RRo63jCSPxFWnCxGDB9e+F3IjVjglr/I8jBA89
        NucwMF4/OPv5Xni4ZqbGAa7vejY9c2+LnmOaQwgpjK1rULmFgOSaeUDYgHYg6DL9fVpfi6SQ4vmxj
        TbPE1F5UUB3Nx4YYdqRnlpV9T0aedTp+vUWACqZl1DVeElLL8Ts/UBh6k1ywbefDtbkEtBeiy96sL
        rBUvr2cpA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuwIG-0008T1-NP; Wed, 29 Aug 2018 08:57:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 848CD2024D707; Wed, 29 Aug 2018 10:57:38 +0200 (CEST)
Date:   Wed, 29 Aug 2018 10:57:38 +0200
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
        Andre Wild <wild@linux.vnet.ibm.com>
Subject: Re: [PATCH] sched/topology: Use Identity node only if required
Message-ID: <20180829085738.GS24142@hirez.programming.kicks-ass.net>
References: <1533712172-11428-1-git-send-email-srikar@linux.vnet.ibm.com>
 <20180808075840.GO2494@hirez.programming.kicks-ass.net>
 <20180810164533.GB42350@linux.vnet.ibm.com>
 <20180829084348.GO24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829084348.GO24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 10:43:48AM +0200, Peter Zijlstra wrote:
> DIE(j) should be:
> 
> 	cpu_cpu_mask(j) := cpumask_of_node(cpu_to_node(j))

FWIW, I was expecting that to be topology_core_cpumask(), so I'm a
little confused myself just now.

> and NODE(j) should be:
> 
> 	\Union_k cpumask_of_node(k) ; where node_distance(j,k) <= node_distance(0,0)
> 
> which, _should_ reduce to:
> 
> 	cpumask_of_node(j)
> 
> and thus DIE and NODE _should_ be the same here.
> 
> So what's going sideways?
