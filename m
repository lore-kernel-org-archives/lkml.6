Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E3AC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DEDC2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SPrDf8e7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DEDC2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbeGSVQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 17:16:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46984 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbeGSVQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 17:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0j69lDSxJE6g6prtT5F3TYNRStuPMqOk5KNLppvYte4=; b=SPrDf8e7cdkMnTrlxBDtLRzxu
        Y6ToCckFOtPgl4j/NlWqlIydKMm1yu3PjE/Ablc+SlyYMFzBxwvMtZIU7uawOwgUp4ySB/KcqwPpN
        /MeI1pxNuEKljrR89mTFCPYGsgEt5HzVypeInjSGZwyEINMXVCCx1narj+09X8/BZDRrDockerrhu
        Uzopnjgpn8nc18AjMk7k/jodFMVx4jtblDH/GZqGwahOpQacuxAh7ulxc2VJd4r6Jfi5sMAYU7Qdc
        9VT8HHAPW4ZBVz/vZ5MevhUEaT+N/s8pet8H3K+GkNyL8eANOojnr0vyC8TXijg0L7WeX54TnJlqv
        aJfI8P06g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgFa1-0002G6-L0; Thu, 19 Jul 2018 20:31:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 083E420275F38; Thu, 19 Jul 2018 22:31:15 +0200 (CEST)
Date:   Thu, 19 Jul 2018 22:31:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 08/10] psi: pressure stall information for CPU, memory,
 and IO
Message-ID: <20180719203114.GL2494@hirez.programming.kicks-ass.net>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-9-hannes@cmpxchg.org>
 <20180718120318.GC2476@hirez.programming.kicks-ass.net>
 <20180719184740.GA26291@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719184740.GA26291@cmpxchg.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 02:47:40PM -0400, Johannes Weiner wrote:
> On Wed, Jul 18, 2018 at 02:03:18PM +0200, Peter Zijlstra wrote:
> > On Thu, Jul 12, 2018 at 01:29:40PM -0400, Johannes Weiner wrote:
> > > +	/* Update task counts according to the set/clear bitmasks */
> > > +	for (to = 0; (bo = ffs(clear)); to += bo, clear >>= bo) {
> > > +		int idx = to + (bo - 1);
> > > +
> > > +		if (tasks[idx] == 0 && !psi_bug) {
> > > +			printk_deferred(KERN_ERR "psi: task underflow! cpu=%d idx=%d tasks=[%u %u %u] clear=%x set=%x\n",
> > > +					cpu, idx, tasks[0], tasks[1], tasks[2],
> > > +					clear, set);
> > > +			psi_bug = 1;
> > > +		}
> > 
> > 		WARN_ONCE(!tasks[idx], ...);
> 
> It's just open-coded because of the printk_deferred, since this is
> inside the scheduler.

Yeah, meh. There's ton of WARNs in the scheduler, WARNs should not
trigger anyway. But yeah printk is crap, which is why I don't use printk
anymore:

  https://lkml.kernel.org/r/20170928121823.430053219@infradead.org


