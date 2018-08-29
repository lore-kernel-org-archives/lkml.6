Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AF3C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E5A2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K6TbJKu3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E5A2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeH2L6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:58:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56952 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeH2L6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5S3eaG06txbu1EjRwS19yJixzQzXDZgHsT4vZS72HfE=; b=K6TbJKu3wS3zW0CQeHNR324DD
        gecm9yTThm2FFvUEV2KF9kSsOeh+EKwTKZtpjYAWyTix77Ni5oyTMrcMsy/Z1vs+xX9P1/luBC+NH
        tjhH/t8thwQDtXF4mAfYgXg/yki8rtP6XCEDc08OvUBB4imkdIH4BysREXAN21uPWmTusP5nyylAQ
        2z3qZ4sIwJFUyBiVmZZRMWN55sPoqDhz+S6yGuyZH++aDoI1FahmDUjpbE1QSLndBOwjK2c0Ya8H0
        1GtFrEWgUD2yLReYJGyLTTDcOPEOhViaULg9suItg4rs5z9BnzOvoVfbdAAXupLlwTp3kKhRS051H
        OT2/NRZxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuvQj-0008Sz-Ld; Wed, 29 Aug 2018 08:02:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D1DD2024EB1E; Wed, 29 Aug 2018 10:02:19 +0200 (CEST)
Date:   Wed, 29 Aug 2018 10:02:19 +0200
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
Subject: Re: [PATCH 2/2] sched/topology: Expose numa_mask set/clear functions
 to arch
Message-ID: <20180829080219.GN24124@hirez.programming.kicks-ass.net>
References: <20180808081942.GA37418@linux.vnet.ibm.com>
 <1533920419-17410-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1533920419-17410-2-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533920419-17410-2-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 10:30:19PM +0530, Srikar Dronamraju wrote:
> With commit 051f3ca02e46 ("sched/topology: Introduce NUMA identity node
> sched domain") scheduler introduces an new numa level. However on shared
> lpars like powerpc, this extra sched domain creation can lead to
> repeated rcu stalls, sometimes even causing unresponsive systems on
> boot. On such stalls, it was noticed that init_sched_groups_capacity()
> (sg != sd->groups is always true).
> 
> INFO: rcu_sched self-detected stall on CPU
>  1-....: (240039 ticks this GP) idle=c32/1/4611686018427387906 softirq=782/782 fqs=80012
>   (t=240039 jiffies g=6272 c=6271 q=263040)
> NMI backtrace for cpu 1

> --- interrupt: 901 at __bitmap_weight+0x70/0x100
>     LR = __bitmap_weight+0x78/0x100
> [c00000832132f9b0] [c0000000009bb738] __func__.61127+0x0/0x20 (unreliable)
> [c00000832132fa00] [c00000000016c178] build_sched_domains+0xf98/0x13f0
> [c00000832132fb30] [c00000000016d73c] partition_sched_domains+0x26c/0x440
> [c00000832132fc20] [c0000000001ee284] rebuild_sched_domains_locked+0x64/0x80
> [c00000832132fc50] [c0000000001f11ec] rebuild_sched_domains+0x3c/0x60
> [c00000832132fc80] [c00000000007e1c4] topology_work_fn+0x24/0x40
> [c00000832132fca0] [c000000000126704] process_one_work+0x1a4/0x470
> [c00000832132fd30] [c000000000126a68] worker_thread+0x98/0x540
> [c00000832132fdc0] [c00000000012f078] kthread+0x168/0x1b0
> [c00000832132fe30] [c00000000000b65c]
> ret_from_kernel_thread+0x5c/0x80
> 
> Similar problem was earlier also reported at
> https://lwn.net/ml/linux-kernel/20180512100233.GB3738@osiris/
> 
> Allow arch to set and clear masks corresponding to numa sched domain.

What this Changelog fails to do is explain the problem and motivate why
this is the right solution.

As-is, this reads like, something's buggered, I changed this random thing
and it now works.

So what is causing that domain construction error?
