Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C933C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42BCF2064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EHFfW63s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42BCF2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733096AbeJBU1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:27:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42710 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbeJBU1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z+1DHCMtT1rpDk0wVDBVGbwYd6IFZBoKrS8mEskjcpM=; b=EHFfW63sbg6RE44XCx9/mN5cE
        uR5+Bw2qu2r8KjMyp4TL+UQO7WRwhzVtLzZGL/eUv+MQBh/UfDMG1aOIjV38t9OP7CarkHzpt7bvx
        EPfdGjpMPBUhwCdizkWro+cE/Afp37Ba3r6xMtVzVrqzQ8V+irqmIZ2uvP8A4drm2vgWD/UGeVxkN
        VeqV1Mwia0RMiYxPNQXgFPk0kCu2tiB3866sjUYKmiG6m97Lltg4/zLs7Uv+ET0MwMjYfKmPKyJFc
        hTWdseCUJzYjYzuc7jN0m2pYzy/wbC5unF+HQFOe5toxYDSpnAzBmpN6dkJGdZBq/4KQiy/9rKQRL
        shJP7JLGQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7Ky1-0006ab-1a; Tue, 02 Oct 2018 13:44:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A3128202B9CBA; Tue,  2 Oct 2018 15:43:58 +0200 (CEST)
Date:   Tue, 2 Oct 2018 15:43:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, longman@redhat.com,
        andrea.parri@amarulasolutions.com, tglx@linutronix.de
Subject: Re: [RFC][PATCH 2/3] locking/qspinlock: Rework some comments
Message-ID: <20181002134358.GD26858@hirez.programming.kicks-ass.net>
References: <20180926110117.405325143@infradead.org>
 <20180926111307.457488877@infradead.org>
 <20181001171707.GE13918@arm.com>
 <20181001191022.GN3439@hirez.programming.kicks-ass.net>
 <20181002132005.GE16422@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002132005.GE16422@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 02:20:05PM +0100, Will Deacon wrote:
> > Ah, so the reason I write it like so is because when we get here,
> > val.locked_pending == 0, per the atomic_cond_read_acquire() condition.
> 
> Ah, and I vaguely remember discussing this before. The way I read these
> transition diagrams, I find it most useful if they correspond to the lock
> word in memory. That way, it makes it clear about exactly which fields are
> stable, and which can be concurrently modified. So in the comment above,
> saying:
> 
> 	 *,*,0 -> *,*,1 : lock, contended
> 
> is really helpful, because it clearly says "we're taking the lock, but the
> rest of the lock word could be modified by others at the same time", whereas
> saying:
> 
> 	 *,0,0 -> *,0,1 : lock, contended
> 
> implies to me that pending is stable and cannot be set concurrently.

Fair enough, will restore.
