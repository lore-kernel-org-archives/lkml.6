Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158E4C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBA22083A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qZdMNRfZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBA22083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeIYWkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:40:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33830 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbeIYWkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1aJKla+L1kBPjVxzmAfXOuMr0UkwaWkJhUsCqk0LSko=; b=qZdMNRfZacMAshe1gb+pHzjqV
        1MB5sWzpkOya/zldxGhMWQ2GGMAvmL5DRztuDf1BQXvzmqCKy8g/aSHMpnOaDSbNWaTI0uLZlkCHo
        mh4xbg5ezACF3yJQe1juy8SrtyqSXtcFbEoDu0dwhRs7dZGizZkKmTJ/JikyE5q9RFlMy1xA+z7PZ
        x8DmU70yQnz/MOtHcT8+CDlp2nV30nophO00CbpnjJ8hmaXF0Rh2avVEGHzHwyv41GdzFuJA1PApA
        uFfVofKH6EnDNMA7WXe7a9B39yteKcJGP36lEkkr5iEzvYLSCguJZ1+ymTYwjXjPMuBcTBQ1C4oH1
        Pqi0XnXFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g4qFb-0002ZW-Lt; Tue, 25 Sep 2018 16:32:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 34DE020289D15; Tue, 25 Sep 2018 18:31:50 +0200 (CEST)
Date:   Tue, 25 Sep 2018 18:31:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, chuhu@redhat.com
Subject: Re: [PATCH v2 2/2] debugobjects: Disable lockdep tracking of
 debugobjects internal locks
Message-ID: <20180925163150.GE29985@hirez.programming.kicks-ass.net>
References: <1537886469-18227-1-git-send-email-longman@redhat.com>
 <1537886469-18227-3-git-send-email-longman@redhat.com>
 <20180925153241.GD29985@hirez.programming.kicks-ass.net>
 <e3275861-6fbe-70c6-c005-2bfe80cbba0b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3275861-6fbe-70c6-c005-2bfe80cbba0b@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 12:20:05PM -0400, Waiman Long wrote:
> On 09/25/2018 11:32 AM, Peter Zijlstra wrote:
> > On Tue, Sep 25, 2018 at 10:41:09AM -0400, Waiman Long wrote:
> >> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> >> index 70935ed91125..68d72ed9ca22 100644
> >> --- a/lib/debugobjects.c
> >> +++ b/lib/debugobjects.c
> >> @@ -1106,8 +1106,15 @@ void __init debug_objects_early_init(void)
> >>  {
> >>  	int i;
> >>  
> >> -	for (i = 0; i < ODEBUG_HASH_SIZE; i++)
> >> +	/*
> >> +	 * We don't need lockdep to verify correctness of debugobjects
> >> +	 * internal locks.
> >> +	 */
> >> +	lockdep_set_novalidate_class(&pool_lock);
> >> +	for (i = 0; i < ODEBUG_HASH_SIZE; i++) {
> >>  		raw_spin_lock_init(&obj_hash[i].lock);
> >> +		lockdep_set_novalidate_class(&obj_hash[i].lock);
> >> +	}
> >>  
> >>  	for (i = 0; i < ODEBUG_POOL_SIZE; i++)
> >>  		hlist_add_head(&obj_static_pool[i].node, &obj_pool);
> > NAK, we do not _EVER_ set novalidate if it can at all be avoided.
> >
> > If there is a severe performance problem with lockdep, try and cure
> > that. But really, who runs lockdep kernels on 8 sockets?
> 
> We do. It is part of our testing process to run both production and
> debug kernels on a variety of different machines to see if anything
> breaks. Some of them just happen to be 8-socket systems.
> 
> The internal locks in the debugobjects code don't interact with other
> locks at all as memory allocation isn't called with those lock held. So
> disabling lockdep for those locks won't materially affect the accuracy
> of the lockdep code.
> 
> How about the ability to declare a class of locks as terminal in the
> sense that no further lock acquisition is allowed while holding a
> terminal lock? That will allow the the lockdep code to fast track the
> handling of those locks and hopefully prevent hard lockup problem like that.

Who guarantees they stay leaf locks? What if someone mucks up the
debugobject locking because its Monday morning and they haven't had
their coffee yet. You want lockdep to catch all that.

Also, where is the performance benefit here. The normal lock_acquire
path doesn't change gobal state (it will not see new lock ordering in
99%+ of the cases).

Typically we only push the lock on the task local lock stack, compute
the new hash, and do the hash lookup, find it already exists and return.

So what is the expensive part, and can we do something about that?
