Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D11C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C19D20844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rcjmHLCY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C19D20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbeIFS2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:28:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57390 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730062AbeIFS2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+Bu1lZ7JjIOjtWdrVZlCnpNdoxLMHZvPtNpklYr+DOc=; b=rcjmHLCY+IopZ4AStGSwKr3Al
        L1YzoxASn6VnKvc4RjPEFQvfYyF+xA5BUCq3VOgOsxSAMmlU4gGDmZwlL1tk8WQm5mxBcRsttaTbZ
        Tj2OOTQBLSFswIMgYTQYPUMtA7n5FZmIZC6UYe6f/dmbRi8rxT25WLIoaZCJ/fW35oBdAIsEgSt4b
        acrMhf7Npq1t8pnjuVgVOz5Qv7J9nhcSAJrlccXiC4qj9ILBdaH1nMt13u1YfDFFjBVAIz+6VIm/J
        s2lTQ1huplTnlI1ZYgRFs+hvwWX/jguJLHjvhelKNlClIcT71qASAJdtq01mB1pNswrclSN11MX4t
        ljWPWqJZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxuiT-0005Yi-AC; Thu, 06 Sep 2018 13:53:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DFA86201F9C46; Thu,  6 Sep 2018 15:52:58 +0200 (CEST)
Date:   Thu, 6 Sep 2018 15:52:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] lockdep: Have assert functions test for actual
 interrupts disabled
Message-ID: <20180906135258.GE24106@hirez.programming.kicks-ass.net>
References: <20180806214107.110626d0@gandalf.local.home>
 <20180905112031.540aa81b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905112031.540aa81b@gandalf.local.home>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 11:20:31AM -0400, Steven Rostedt wrote:
> 
> Peter, you OK with this patch? I'm currently triggering a bug (in rc2)
> where this patch is telling me that lockdep is getting it wrong. It
> would be good to have this upstream such that we know if it is really a
> bug in the code itself, or if lockdep didn't keep up properly.

I thought we had something for that under CONFIG_DEBUG_LOCKDEP.

/me checks and finds:

  kernel/locking/lockdep.c:check_flags()

Doesn't that work?
