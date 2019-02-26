Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E8FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F4621848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PwllWiFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfBZOro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:47:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52506 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfBZOro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:47:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dBmTsD/iWmRm9SKRntsMzsXzHDIaIgs+NsNUTTSuX5U=; b=PwllWiFBR33EyXy4hvpE7o9CY
        8oTC6oGMNaYSoE58dH+9XhEaOu4WWtGZukuwHr1bk+/zu5G8r6JP+4ZRJb+YxkN8n5BY8Yd7JloCr
        eRCgs5s9Pu52JCR7RgcKkrQgn1e/S/6izfmjTIZwtsNMpJu6qIyWC14JBfNNj5Vxdg1yffS7M8PJI
        sQ/Jh+5Tx7PCwIRjIqzaYmOvw63e4qM1gUgYZf969FVyWFpugpxhi/ZmpXc6pkUIJYP0JJ/Gz0cy6
        UYZfwcSp1GtnuM0aet7vbSyyhN3Kdlu7dK58/HN1oG5uq4TvVCr+8AayPddElDYtcGAtsyibi6SBx
        aiv59rdkQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gye17-0003pS-4F; Tue, 26 Feb 2019 14:47:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C7F0C23CB753C; Tue, 26 Feb 2019 15:47:30 +0100 (CET)
Date:   Tue, 26 Feb 2019 15:47:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
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
Message-ID: <20190226144730.GV32477@hirez.programming.kicks-ass.net>
References: <20190222130014.GY32494@hirez.programming.kicks-ass.net>
 <20190225175517.GK4072@linux.ibm.com>
 <20190226093009.GS32477@hirez.programming.kicks-ass.net>
 <20190226104551.GF32534@hirez.programming.kicks-ass.net>
 <20190226112133.GG32534@hirez.programming.kicks-ass.net>
 <20190226112521.GH32534@hirez.programming.kicks-ass.net>
 <20190226113008.GI32534@hirez.programming.kicks-ass.net>
 <20190226113813.GA14753@zn.tnic>
 <20190226134906.GG32494@hirez.programming.kicks-ass.net>
 <20190226142845.GK4072@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226142845.GK4072@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 06:28:45AM -0800, Paul E. McKenney wrote:
> I must confess to not being all that sympathetic to code that takes
> advantage of happenstance stack-frame layout.  Is there some reason
> we need that?

Not that I'm aware; but if it gets this 'obvious' case wrong, I worry
what else it gets wrong.

At the very least we should get this fixed and compile a kernel with the
fixed compiler to see what (if anything) changes in the generated code
and analyse the changes (if any) to make sure we were ok (or not).

I mean; yes that example is UB, but the result is also clearly batshit
insane.
