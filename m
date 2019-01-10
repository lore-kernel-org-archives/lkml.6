Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87833C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487982173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hg+VzPBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfAJMod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:44:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60484 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfAJMoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1PRahedlOsql+wuU2s4Rc98OxLxk+oXeq1xkgxPu4TY=; b=hg+VzPBOqiYmCiXjPoaO7i1HD
        vbL9U7P4Vt11ytLuDi91S8jOW5RRvTTEC0f+kpmjhAKL1MLworl0VycLaZrK2Vj5PY5k+S+mp9zns
        u8QNsx/fzmVSCRgTgzXj+Ia/3y8k0trVkxNFkjyAn/u7w5Wf+GwmJKgMTXQA1Gf4Ky5wUalCz9xHt
        2ti3x3SLwX+cwLHAkosiTGQyt88MqazNrk25uFLK/ztdCPZtA2mBjQq0tXKZL0UHTe2KFKYt3hI6f
        l7HbleAW/wBl07GsEX7wotoWP3XaIv5VcpkTEe8ywTvUueP+vLXVFuMrjBzMUXVZNcnsP7iEAUCf9
        Src/hUz5A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghZhE-0003B4-UQ; Thu, 10 Jan 2019 12:44:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C2942081518D; Thu, 10 Jan 2019 13:44:27 +0100 (CET)
Date:   Thu, 10 Jan 2019 13:44:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anatol Pomozov <anatol.pomozov@gmail.com>
Cc:     fw@strlen.de, Dmitry Vyukov <dvyukov@google.com>,
        paulmck@linux.ibm.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: seqcount usage in xt_replace_table()
Message-ID: <20190110124427.GB21224@hirez.programming.kicks-ass.net>
References: <CAOMFOmU=t9YbE68YpoQn0Ug0XN1F+0iuJp9J=htCRRrbdaPSVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMFOmU=t9YbE68YpoQn0Ug0XN1F+0iuJp9J=htCRRrbdaPSVA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 11:33:39AM -0800, Anatol Pomozov wrote:
> Hello folks,
> 
> A bit of context what I am doing. I am trying to port KTSAN (Kernel
> Thread Sanitizer) tool to v4.20. That tool tracks shared data usage
> and makes sure it is accessed in a thread-safe manner.
> 
> seqlock is a synchronization primitive used by Linux kernel. KTSAN
> annotates read_seqbegin()/read_seqretry() and tracks what data been
> accessed in its critical section.
> 
> During KTSAN port I found and interesting seqcount usage introduced in
> commit 80055dab5de0c8677bc148c4717ddfc753a9148e
> 
> If I read this commit correctly xt_replace_table() does not use
> seqlock in a canonical way to specify a critical section. Instead the
> code reads the counter and waits until it gets to a specific value.

(gets away from)

> Now I want KTSAN to play with this code nicely. I need to tell KTSAN
> something like "this raw_read_seqcount() does not start a critical
> section, just ignore it". So temporary I introduced
> raw_read_seqcount_nocritical() function that is ignored by KTSAN. Is
> it a good solution?

This code is special enough to just do: READ_ONCE(->sequence) and be
done with it. It doesn't need the smp_rmb() or anything else.
