Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF093ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBCE20693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jYTZdJzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CBCE20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbeGRI6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:58:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59388 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbeGRI6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dbgDn3PSQe48X9A3mPrDWhWWYcFvjmCn89di1uk8KMg=; b=jYTZdJzAzqcGuPJfbI8vU1DoL
        mrmwEE3Ov5cqM59j27dg9e38lqUhjf3npNToZiNpp1fbi1gy/FmZ/4vWbXtytNP7Lz2oh4YcYwtIh
        FK2NdQXITvwHax4dPTBR6YsMgy87MXFDbVnmWnj9tm0v1ViVIzA0Kftfw8e6Sch8qbckMhlSReQzm
        5ZPCcidx9w9yCLBGhIQezsfovaJYuaYeNwqmRYoP5zoyhF78N7R1R1WqVC77vkM+zetzxOH1Sb87o
        Y7vGZRiM8hu7TjsFZ3pkD66qtHhkqjEPR1Iul9Yzh/fhDdU5sdA0vG7DO0pzOScEcqwFb7+GDqrNj
        ag83z7tyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffhiT-0002VR-NG; Wed, 18 Jul 2018 08:21:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3139420289330; Wed, 18 Jul 2018 10:21:44 +0200 (CEST)
Date:   Wed, 18 Jul 2018 10:21:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v10 2/3] tracepoint: Make rcuidle tracepoint callers use
 SRCU
Message-ID: <20180718082144.GP2494@hirez.programming.kicks-ass.net>
References: <20180713215547.255620-1-joel@joelfernandes.org>
 <20180713215547.255620-3-joel@joelfernandes.org>
 <20180717182528.GK2494@hirez.programming.kicks-ass.net>
 <20180718001625.GA154046@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718001625.GA154046@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 05:16:25PM -0700, Joel Fernandes wrote:

> Steve, Peter,
> 
> Is it Ok with you to take the below patch ontop of this series? I avoided
> resending the 3-patch series since this is the only change, but let me know
> what you prefer or makes it easy for you.

Yeah, whatever Steve wants really. But I think we'll have to wait for
that a bit, I got one of those humorous vacation notices from him
again.
