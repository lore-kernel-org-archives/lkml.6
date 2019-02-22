Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC32C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20519207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ULvYD4zv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfBVNAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 08:00:34 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47456 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfBVNAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 08:00:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jNqb+5ogDU6hdyrSD3XHeZAzjYwCD9jvtIUiYjDJ3ds=; b=ULvYD4zviPzbwmv58U1N3bBR2
        +sRr8UpxIynIOeHlya6dBX9z6wHbR+WhSojJb2g9rIIZPFSF54rupEFgUJL/mBfCa+THFpQqfbF6w
        jQfTPMLPdmvFL7j1QC7LgsPbsVuAkkryyRqrR7TZPVcfss6xMf3T3z2le9jJEOSFXJ9CaRUK/1F+v
        qjXL2UF5nIKjzkvz/yck+XThCp2qRTgdRxvd+BwLaRZyLgo4IiVT+XJlUuEDCadQrYZnP1dhVL7iu
        FWrIw+omVa4cE4KemMHWQ0Kk0sa+Q6z0kZUtDTelplgCPP7ELTMPvyJbXhoNgiK95dWe0+AHRwnca
        KjXQ1DROg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gxAR5-0002e5-RF; Fri, 22 Feb 2019 13:00:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9603F22BBEAF4; Fri, 22 Feb 2019 14:00:14 +0100 (CET)
Date:   Fri, 22 Feb 2019 14:00:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Message-ID: <20190222130014.GY32494@hirez.programming.kicks-ass.net>
References: <1550617057-4911-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20190220020117.GD11787@linux.ibm.com>
 <20190220092604.GD32494@hirez.programming.kicks-ass.net>
 <20190220131456.GA3215@andrea>
 <20190220132714.GI32494@hirez.programming.kicks-ass.net>
 <20190222112128.GA7213@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222112128.GA7213@andrea>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 12:21:28PM +0100, Andrea Parri wrote:
> > What I do object to is a model that's weaker than any possible sane
> > hardware.
> 
> Not the first time I hear you calling this out.  And inevitably, every
> time, other slogans come to my mind:  "C is not an assembly language",

But it bloody well should be ;-)
