Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD794C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A725B2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l2OIngQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A725B2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbeLGJrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:47:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42688 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbeLGJrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ReuZJ0UlOCFauWz5vpiZjgd5RBDLLVJAcZZjA9IIKJI=; b=l2OIngQ1ZY2OYq4HJaWofMK6p
        sy0bG3eXahf9Kp5d9ksUgRBBDyMal1l3iRtg4hiKcAB5DynDMQBFXWhfKgp/7RC78Ja35VCuNpQVZ
        HMSirs+pP9/zw+C5WCAqG2vGgbi+N2dCPHUZyOZxuGhWUbCmoR/3Pck8MKusZ930ZSp15F2lR3eC+
        Dob2dOMUqSsnGP7BCPKgvfWW6vNzM/ycDPqK8JfpitNRxEuCJLN+W5CEkMpqgnB2Er9OUlCbdXRzS
        QSUldjbmar1SU4sFNU0vHbhCC+97/ebYNoCGeCqYXvrtSO3IlP5dE8z0r7nOegCnU0i7JCyRqls8y
        sRN3tvbqg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVCjW-0001mM-6P; Fri, 07 Dec 2018 09:47:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DE73D2072614B; Fri,  7 Dec 2018 10:47:39 +0100 (CET)
Date:   Fri, 7 Dec 2018 10:47:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 09/17] debugobjects: Make object hash locks nestable
 terminal locks
Message-ID: <20181207094739.GG2237@hirez.programming.kicks-ass.net>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
 <1542653726-5655-10-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542653726-5655-10-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 01:55:18PM -0500, Waiman Long wrote:
> By making the object hash locks nestable terminal locks, we can avoid
> a bunch of unnecessary lockdep validations as well as saving space
> in the lockdep tables.

So the 'problem'; which you've again not explained; is that debugobjects
has the following lock order:

	&db->lock
	  &pool_lock

And you seem to want to tag '&db->lock' as terminal, which is obviuosly
a big fat lie.

You've also not explained why it is safe to do this (I think it actually
is, but you really should've spelled it out).

Furthermore; you've not justified any of this 'insanity' with numbers.
What do we gain with this nestable madness that justifies the crazy?


