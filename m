Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AACC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 01:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF62F208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 01:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JznFdFVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF62F208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbeKKLRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 06:17:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbeKKLRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 06:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=llNjy+cfCYVvm8F8o8jFCmXqWk9GrLmU9yludmjnSxg=; b=JznFdFVx23u4+Is87BDbfixh2
        32KvvcRWFQNmFjK7djAoGeaX45HCGcPE5HUYMVtIAbtwSDzM0Wt31quttpwg4hjtjcL4rouY6Ps3W
        ECv7lC44GRfL1GC2/ts1OrIac4afhlUVrCuL6mrr6qc+/qMjy+4MgvNKjMoiuDQksKk8N5mr0xTTE
        p10H108V2v3/fOkFnkHq4Acc7GkZ6421/6MVtEp38AsRxAKLBifBF731Hz0iZX0Y99H917vZ/Pwho
        7qyentQPb6rivHqSkKfH92/S3LclR6FWAkEwAPkvXiq6hJkXL9IfG37l0a+CSgtm3qq9SBi9BYeTh
        AUvkwNLcA==;
Received: from [64.114.255.114] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gLeZu-0000h8-21; Sun, 11 Nov 2018 01:30:18 +0000
Received: by worktop (Postfix, from userid 1000)
        id 71AC76E07D5; Sun, 11 Nov 2018 02:30:17 +0100 (CET)
Date:   Sun, 11 Nov 2018 02:30:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 07/12] locking/lockdep: Add support for nested
 terminal locks
Message-ID: <20181111013017.GC12766@worktop.psav.com>
References: <1541709268-3766-1-git-send-email-longman@redhat.com>
 <1541709268-3766-8-git-send-email-longman@redhat.com>
 <20181110142023.GG3339@worktop.programming.kicks-ass.net>
 <f3fc6819-175b-6452-4705-942a82d7e06f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3fc6819-175b-6452-4705-942a82d7e06f@redhat.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 07:30:54PM -0500, Waiman Long wrote:
> On 11/10/2018 09:20 AM, Peter Zijlstra wrote:
> > On Thu, Nov 08, 2018 at 03:34:23PM -0500, Waiman Long wrote:
> >> There are use cases where we want to allow 2-level nesting of one
> >> terminal lock underneath another one. So the terminal lock type is now
> >> extended to support a new nested terminal lock where it can allow the
> >> acquisition of another regular terminal lock underneath it.
> > You're stretching things here... If you're allowing things under it, it
> > is no longer a terminal lock.
> >
> > Why would you want to do such a thing?
> 
> A majority of the gain in debugobjects is to make the hash lock a kind
> of terminal lock. Yes, I may be stretching it a bit here. I will take
> back the nesting patch and consider doing that in a future patch.

Maybe try and write a better changelog? I'm not following, but that
could also be because I've been awake for almost 20 hours :/
