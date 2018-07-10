Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URG_BIZ,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CDCC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A2B208E2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="boWYqj3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A2B208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933036AbeGJJYc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:24:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59072 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751248AbeGJJYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DLcQcDFGDQuX3H8AmFWYDXJPfN50snm1IqxIOj4T8yI=; b=boWYqj3cUZaf9Ft+iexxUiJXxl
        /6z2tDENNBqhoUd0BAmjMMNHLdtHIlY2oKsxq9etehCZNc9RhsjJ/rFToSQl8eTWXmg6ZouWfzIht
        kfiUEer+Kzh1HjLuCDgW+dd+fY8fxFYbs4JIyZE2WfqQ1r0gQ5CJHt2IlGNIZBMicyAckSTwvlfr/
        geGygjiTe79dlWmFEtrzrlL6sPVXe43+YeRrZHoabrnl8mefosAiLKZ1r6+X8L55fLnsloI1giaT+
        ljmOdC3MzxGHqts95Z3uPgK/AP9krA03m9APpqvKfINbbS/rhEoQCgk7brBD4s2nwnIJ3xHr3mZpA
        2lfOPZ1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcosm-0007Gb-Sy; Tue, 10 Jul 2018 09:24:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4AE78203E575C; Tue, 10 Jul 2018 11:24:26 +0200 (CEST)
Date:   Tue, 10 Jul 2018 11:24:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, mhillenb@amazon.de,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Message-ID: <20180710092426.GC2476@hirez.programming.kicks-ass.net>
References: <20180709123457.GM3593@linux.vnet.ibm.com>
 <20180709125516.GO2476@hirez.programming.kicks-ass.net>
 <20180709130227.GQ2512@hirez.programming.kicks-ass.net>
 <20180709142932.GO3593@linux.vnet.ibm.com>
 <20180709152632.GX2476@hirez.programming.kicks-ass.net>
 <20180709163432.GV3593@linux.vnet.ibm.com>
 <1531162254.26547.3.camel@infradead.org>
 <20180709203441.GE3593@linux.vnet.ibm.com>
 <1531168538.26547.5.camel@infradead.org>
 <20180709204248.GF3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180709204248.GF3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 01:42:48PM -0700, Paul E. McKenney wrote:
> On Mon, Jul 09, 2018 at 09:35:38PM +0100, David Woodhouse wrote:
> > 
> > 
> > On Mon, 2018-07-09 at 13:34 -0700, Paul E. McKenney wrote:
> > > 
> > > So here are the possible code paths when .rcu_urgent_qs is set to true:
> > > 
> > > 1.      A context switch will record the quiescent state and clear
> > >         .rcu_urgent_qs.  (The failure to do the clearing in current -rcu
> > >         for PREEMPT builds is a performance bug that I need to fix.)
> > 
> > What if there's nothing else runnable and there is no actual context
> > switch?
> 
> The scheduler invokes rcu_note_context_switch() before looking to see
> if there really will or won't be a context switch.

Correct. Just getting to __schedule() means we can schedule and thus is
a valid point for RCU to progress. Even if we then end up selecting the
very same task and not switching at all.
