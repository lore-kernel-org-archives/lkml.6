Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E01CC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64EB206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ILAgWc4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D64EB206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeILAjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 20:39:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36296 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeILAjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 20:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kJYhv21CnZKsfBNNf+sS/5xKXuLQo3CAA080Yftlf5M=; b=ILAgWc4jpLoHOB6N8FuboCFZz
        ax08LVw8T2wmgQ6vDuW0d+sQC/bvMfC+aDsjZTxew+cFLprToZ6s2f4ftLEIXgoXhuXBM9NR7otsV
        7t5PaGjghOB7o0Yf8bq+hFJ2MkhJt2zh62Lx9dSgDGM4vyTnETka7mSmXs0ttduswxO+tJrIPBrmc
        AZE6wEwEtflab8l36oG9MkwfmU1TaOXxTXSFwej2jocvmBcZgkLL2Iwrp8DVqnwy8heZ6tSAE43Jk
        72IEw1gdTAD+nio5G2jYTERIQ2YtIKMshd5bXx0iAgxNOUhhrEcu5UyY8hEqG6ITYl7zc6T15EhH2
        Nt7WAhzIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzoUU-00038X-Qb; Tue, 11 Sep 2018 19:38:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B16C202C1A00; Tue, 11 Sep 2018 21:38:24 +0200 (CEST)
Date:   Tue, 11 Sep 2018 21:38:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/rwsem: Make owner store task pointer of last
 owning reader
Message-ID: <20180911193824.GW24106@hirez.programming.kicks-ass.net>
References: <1536265114-10842-1-git-send-email-longman@redhat.com>
 <20180910093156.GS24082@hirez.programming.kicks-ass.net>
 <20180911192122.GD3902@linux-r8p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911192122.GD3902@linux-r8p5>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 12:21:22PM -0700, Davidlohr Bueso wrote:
> On Mon, 10 Sep 2018, Peter Zijlstra wrote:
> 
> > [ RT has something along those lines, and I have half a patch that
> >  starts doing that too, but I never found enough time to really work on
> >  it :-( ]
> 
> But don't rt rwsems act pretty much like a regular mutex in that it only
> allows readers to nest, not share the lock because of priority inversion
> scenarios.
> 
> Also, wrt rtmutex, will that top-spinner thing ever make it in?

Nah, tglx rewrote that a while ago. It's something semi clever now.
Lemme see if I can find the patch.

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/kernel/locking/rwsem-rt.c?h=linux-4.18.y-rt&id=1a42d0b3c3f34895cb5d63e1cd2be02f6077919b
