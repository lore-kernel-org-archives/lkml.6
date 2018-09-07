Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0AAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764A02075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764A02075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbeIGTKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:10:01 -0400
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:40781 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727783AbeIGTKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:10:01 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id 3A69F986EE
        for <linux-kernel@vger.kernel.org>; Fri,  7 Sep 2018 14:28:48 +0000 (UTC)
Received: (qmail 8748 invoked from network); 7 Sep 2018 14:28:48 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.88])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 7 Sep 2018 14:28:48 -0000
Date:   Fri, 7 Sep 2018 15:28:46 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/numa: Do not move imbalanced load purely on
 the basis of an idle CPU
Message-ID: <20180907142846.GG1719@techsingularity.net>
References: <20180907101139.20760-1-mgorman@techsingularity.net>
 <20180907101139.20760-5-mgorman@techsingularity.net>
 <20180907113309.GU24106@hirez.programming.kicks-ass.net>
 <20180907123739.GE1719@techsingularity.net>
 <20180907124432.GN24082@hirez.programming.kicks-ass.net>
 <20180907134201.GC3995@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180907134201.GC3995@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 07:12:01PM +0530, Srikar Dronamraju wrote:
> > Yeah, I was afraid it would.. Srikar, can you also evaluate, I suspect
> > we'll have to pick one of these two patches.
> 
> I can surely run some benchmarks between the two patches.
> However comparing  Mel's patch with
> http://lkml.kernel.org/r/1533276841-16341-4-git-send-email-srikar@linux.vnet.ibm.com
> 
> Mel's patch
> 
>   	if (!cur) {
>  -		if (maymove || imp > env->best_imp)
>  +		if (maymove)
>   			goto assign;
>   		else
> http://lkml.kernel.org/r/1533276841-16341-4-git-send-email-srikar@linux.vnet.ibm.com
> 
> 
>  	if (!cur) {
> -		if (maymove || imp > env->best_imp)
> +		if (maymove && moveimp >= env->best_imp)
>  			goto assign;
>  		else
> 
> In Mel's fix, if we already found a candidate task to swap and then encounter a
> idle cpu, we are going ahead and overwriting the swap candidate. There is
> always a chance that swap candidate is a better fit than moving to idle cpu.
> 

There is a chance but to find out, the task has to be dequeued and requeued
on a maybe. An idle CPU is less disruptive and the only task affected is
migrating to the preferred node where, based on previous fault behaviour,
should have better locality. It's also a simplier patch but I'm going to
be biased towards my own patch, the tests will decide one way or the other.

-- 
Mel Gorman
SUSE Labs
