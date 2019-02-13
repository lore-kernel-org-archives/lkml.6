Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB15C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E3E222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mh1nsDXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393446AbfBMRyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:54:44 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45778 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393391AbfBMRyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:54:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IRyXFg4JLpBBpOJeWQ4Eikv97DxSrcMsCx7jjOxQ8wI=; b=Mh1nsDXq6YmDj9dScJiypo+Ay
        h2WqaZ37R19TvoJGrk0CizmToFwyKVx0Bt/PmCW0ktTgZ8mgSsodY5PKcMcqxN1V3wakNQF6wGCxc
        5oJF7WOFDCEsDhBOQWg7FOUFjYd13upPTz1s8m1fwLy2EDeO3RzmNn7cSzwUsFXU56tqlTXTKLTZS
        2UYtHcvJCZTP7h48OBTz2iNsglyLQFG0y9ad3LOrNXUlQhpvZHGEJLI1vvQqQgskVkMp33qcoqStH
        Nbq2TKggudpOkAATbcWKewfMtHZTGZ+deWZo73HVFozmhfjHyEniQ5g8TMckOMN+qL4f89Zz4Cw4l
        rnw0h2pXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtyk1-00040K-Go; Wed, 13 Feb 2019 17:54:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C9FFD23EB6D00; Wed, 13 Feb 2019 18:54:34 +0100 (CET)
Date:   Wed, 13 Feb 2019 18:54:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com
Subject: Re: [PATCH v0 1/2] perf: Add an option to ask for high order
 allocations for AUX buffers
Message-ID: <20190213175434.GA32494@hirez.programming.kicks-ass.net>
References: <20190213114716.63972-1-alexander.shishkin@linux.intel.com>
 <20190213114716.63972-2-alexander.shishkin@linux.intel.com>
 <20190213130755.GQ32494@hirez.programming.kicks-ass.net>
 <20190213174756.GU9565@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213174756.GU9565@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 05:47:56PM +0000, Mel Gorman wrote:
> If there is a tangiable performance benefit from using contiguous regions
> then I would suggest optimistically allocating them with appropriate
> GFP flags to avoid large latencies at startup time and fall back if
> necessary. 

Right; the code does the fallback thing. It successively tries smaller
order allocations until 0-order fails.

It currently uses:

#define PERF_AUX_GFP    (GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY)

Is that what you could consider appropriate?
