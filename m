Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6984FC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1510C20854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WjPidrZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1510C20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeIKNQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:16:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59014 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbeIKNQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kZv+heeb6T98P7ifVW9qK+gjgOGtkSdqkItcdvZjRTc=; b=WjPidrZCKpJKA3mPfdF2PymFB
        +wXcMYaYif4YX3rbDgajKmeisS+KqHzAEdKc64JguH7dmfDKefCRjA1SNCBCiYeECF3VeBx8baC27
        vwktfzfeI3SVr2Qp+Ab8CHUBNGhrb8GZj/EEOrBCC+26iupihkNFIDGFAtvjynjnx3Zb4y1efDPnn
        dj8d11kodYqZRf2h/rd6d2f5wZKijKg2cLvCrnYhK7nBQpZFvVGziyqIJI5ipcIGPmjyox/NyEYpl
        +kK/lv/DW92eYxKvCe5NSLA8JlYTuA79QXkus5WZVOnUoYiZZLupVag4eJ2PJUcODKLVuzCSFZuLk
        VUPkAkwTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzdrx-0004Zf-V5; Tue, 11 Sep 2018 08:17:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 53E3920163EFC; Tue, 11 Sep 2018 10:17:55 +0200 (CEST)
Date:   Tue, 11 Sep 2018 10:17:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/rwsem: Make owner store task pointer of last
 owning reader
Message-ID: <20180911081755.GO24106@hirez.programming.kicks-ass.net>
References: <1536265114-10842-1-git-send-email-longman@redhat.com>
 <20180910093156.GS24082@hirez.programming.kicks-ass.net>
 <83b333ea-8ef2-84ea-6810-4ab1a67eef88@redhat.com>
 <20180910171550.GA3902@linux-r8p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910171550.GA3902@linux-r8p5>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 10:15:50AM -0700, Davidlohr Bueso wrote:
> On Mon, 10 Sep 2018, Waiman Long wrote:
> 
> > One major issue with a combined count/owner is that we may have to use
> > cmpxchg for reader lock which will certainly impact reader-heavy
> > workloads. I have also thought about ways to compress the task pointer
> > address so that it can use fewer bits and leave the rests for reader
> > count. It is probably doable on 64-bit systems, but likely not on 32-bit
> > system given that there are less bits to play around.
> 
> Yeah we've discussed this before. As a cleanup it would obviously be good,
> but I fear about raw performance loss when using cmpxchg instead of xadd.

Does it really matter though? Last time I looked at something similar
(refcount_t) the "LOCK INCL" vs "LOCK CMPXCHG" was something like 15 vs
23 cycles (and that was with the cmpxchg loop actually doing a lot
more).

Do we really care about the down_read() path _that_ much? I thought that
with the main pain point, pagefaults, the problem was mostly the line
bouncing, not a few extra cycles.
