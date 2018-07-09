Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URG_BIZ,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88EFC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A7B20873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qI/LG7cF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A7B20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932961AbeGIMz0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:55:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53444 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932666AbeGIMzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o6pYBm3HtnzrcyTM38kpva+yAqtgi1TBFOcgim/FqAk=; b=qI/LG7cFIjF23mLPkkTF1dOlP
        d+yeB8wPqptg4J4rN78a9xeBh+EMMfOwIL/sdovLG3FekOnrBPAA8z2O+FTtGYiujsPTeEnoKqUrB
        2NpIGby3OH+U/i/rHeoPUc7VkK1d8JvuXYW65oX024iua77tvP/merfnjy06K5cxUWcXQvsp2MrkU
        fswlHuAqQaU95x2i4hTt5u5Zo6F3eHsIfdLZJiC6o5BsqLVq+6emoHiUrTb3T0Rg9FvdCI73ZCfef
        Snxk/zZ19hRIcLVaolLUmA5pQ7/bmX5EGWjL9S47hELpdzqznrFhnaK4JNbTuXOMzWLB6jFVXiOzP
        KTEloYwCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcVhG-0000be-8U; Mon, 09 Jul 2018 12:55:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AFD5820289331; Mon,  9 Jul 2018 14:55:16 +0200 (CEST)
Date:   Mon, 9 Jul 2018 14:55:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, mhillenb@amazon.de,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Message-ID: <20180709125516.GO2476@hirez.programming.kicks-ass.net>
References: <bb77e730a5ada3689650b636e1dd03ac5cc87256.camel@infradead.org>
 <20180706162905.GZ2476@hirez.programming.kicks-ass.net>
 <20180706171150.GI3593@linux.vnet.ibm.com>
 <20180709085351.GC2476@hirez.programming.kicks-ass.net>
 <1531127935.18697.57.camel@infradead.org>
 <20180709104429.GI2476@hirez.programming.kicks-ass.net>
 <1531133801.18697.73.camel@infradead.org>
 <20180709110657.GL2476@hirez.programming.kicks-ass.net>
 <20180709123457.GM3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709123457.GM3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 05:34:57AM -0700, Paul E. McKenney wrote:
> But KVM defeats this by checking need_resched() before invoking
> cond_resched().

That's not wrong or even uncommon I think.
