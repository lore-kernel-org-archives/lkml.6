Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC2FECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C7320852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kgbQ2U1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C7320852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388229AbeGWO6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:58:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36804 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387954AbeGWO6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RXI1qPbRNfq/RBLIwzBiXgrO31Z8fk3mEWxpZfz8IkA=; b=kgbQ2U1OVOfEMJizsF4wl0ZWI
        xtqOTdymKuskfT+1dGCFaUPyamnW+SVfzwh4xdURaTM58WUh1vghlKYJeV9JJ3Qw1QrhIEMXwSTAc
        90JUrhe+gEP1Iw/QiccrXAmT6OYc+znB//8A1YAeHrcV+9y9GQdFM2cBo3PG75x3ikycsuQAfXTM0
        CTdJViaGILowyMld1BEMxwxT8FXJxeg8SN4pTjRePg/RQW5Sdp1nnK0+rULIwYP66qTGzoQnnafdU
        AwdPzcUKhOuYeTqmPbkX0l3qEdfIJe/Dq/sZA6N2y7NKQCNbGRf6Py2VOPctF488CWMOPJ02fOwiP
        ucgV2bgCw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhbKg-0004sr-S6; Mon, 23 Jul 2018 13:57:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 686D92027585C; Mon, 23 Jul 2018 15:57:00 +0200 (CEST)
Date:   Mon, 23 Jul 2018 15:57:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 00/19]  Fixes for sched/numa_balancing
Message-ID: <20180723135700.GX2458@hirez.programming.kicks-ass.net>
References: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 10:32:41PM +0530, Srikar Dronamraju wrote:
> Srikar Dronamraju (19):
>   sched/numa: Remove redundant field.
>   sched/numa: Evaluate move once per node
>   sched/numa: Simplify load_too_imbalanced
>   sched/numa: Set preferred_node based on best_cpu
>   sched/numa: Use task faults only if numa_group is not yet setup
>   sched/debug: Reverse the order of printing faults
>   sched/numa: Skip nodes that are at hoplimit
>   sched/numa: Remove unused task_capacity from numa_stats
>   sched/numa: Modify migrate_swap to accept additional params
>   sched/numa: Restrict migrating in parallel to the same node.
>   sched/numa: Remove numa_has_capacity
>   sched/numa: Use group_weights to identify if migration degrades locality
>   sched/numa: Move task_placement closer to numa_migrate_preferred

I took the above, but left the below for next time.

>   sched/numa: Stop multiple tasks from moving to the cpu at the same time
>   mm/migrate: Use xchg instead of spinlock
>   sched/numa: Updation of scan period need not be in lock
>   sched/numa: Detect if node actively handling migration
>   sched/numa: Pass destination cpu as a parameter to migrate_task_rq
>   sched/numa: Reset scan rate whenever task moves across nodes
