Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A8BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F34426E0D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TtbxufXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F34426E0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932205AbeFZTsU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:48:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42142 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752109AbeFZTsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=e9Yzis0G53lJlIZsDwZNWfZ2kQOZic6NEoa4ZcabL18=; b=TtbxufXJlZelO9q4QrXHIoChS
        xcbMdBwkM8+TTIA75AcbEsyRxMYEblJCZ7doapwNMhezXHzumaxDmC+prgBoU8qVT67c1HyeYTwBg
        +iqZx2qo42znwHXZNlUFBZhbjtV4i+A92pZhsDQCJLgcLum0WTe+5p46YpkhGa9+o+NmIZiFQnD/i
        SBH3l51ai7M2yiA10V519JTG8g56kcFERNO3vsUIyxWSAx1QTfHWlrjxoJjk0FSZa2TxHWiXXLwev
        QUZ8uSIuQp6f/9+KmvKMKFGkA/NQeUlkMHx8nD+KBDgfbeHjY4OHgpKeYnu37JV+yjeiRHA3ivLL2
        GxQ/XY4vQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXtwf-0004wG-3s; Tue, 26 Jun 2018 19:48:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8EAFE2029FA0A; Tue, 26 Jun 2018 21:48:07 +0200 (CEST)
Date:   Tue, 26 Jun 2018 21:48:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 13/22] rcu: Fix grace-period hangs due to
 race with CPU offline
Message-ID: <20180626194807.GQ2494@hirez.programming.kicks-ass.net>
References: <20180626002052.GA24146@linux.vnet.ibm.com>
 <20180626171048.2181-13-paulmck@linux.vnet.ibm.com>
 <20180626174424.GK2494@hirez.programming.kicks-ass.net>
 <20180626181937.GG3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626181937.GG3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 11:19:37AM -0700, Paul E. McKenney wrote:
> The initial reason for ____cacheline_internodealigned_in_smp was that
> some of the fields can be accessed by random CPUs, while others are
> used more locally, give or take our usual contention over the handling
> of CPU numbers.  ;-)

So that whole internode thing only matters for the insane VSMP case,
where they take node to mean a cluster node, not a numa node.

VSMP is a networked shared memory machine where, by necessity, the MESI
protocol operates on page granularity.

In general I tend to completely and utterly ignore that and let the VSMP
people worry about things.
