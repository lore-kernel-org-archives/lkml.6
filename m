Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE85C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC02421855
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XOxp3L2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbeLRLUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:20:55 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36700 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeLRLUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=av9GRHNyktN/rrRPxyVr1ZPAQkB0SrO0NwsExGjEb1M=; b=XOxp3L2Jih+52yxhkkiASWGJY
        cNpAW2m1FLK7hlDfd40yRp97q5zubZXoQkqN1UbDHwcoU3TapvKtYuw+CVU3lxDZ1MLd5WZAG5Uv5
        syjVFAEiaqmqrsoxrk4M4e1RFa8SI3d1PlEW4Lg/FHPSfJOwrZ0pwpa87MU0FCsr/WSmYBNQ/tfP2
        3BjzmVVWxgWtP8rsjIYLz2EaWVdzitQjjou5pBBDEO5ol4qPUTtJVNRbULiJdUgVvU20TOlPpJ0b9
        7o6sFk47TrtR/H7IDtrVQSoctQb7bw5Q9A6rFVC6CoEl+mu59NILELjgdcrc42dCkmYbSUZtqYFAL
        hJkmDrlFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZDQV-0007dB-7Z; Tue, 18 Dec 2018 11:20:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 958722027DA91; Tue, 18 Dec 2018 12:20:37 +0100 (CET)
Date:   Tue, 18 Dec 2018 12:20:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, lizefan@huawei.com,
        Johannes Weiner <hannes@cmpxchg.org>, axboe@kernel.dk,
        dennis@kernel.org, Dennis Zhou <dennisszhou@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Subject: Re: [PATCH 6/6] psi: introduce psi monitor
Message-ID: <20181218112037.GB16284@hirez.programming.kicks-ass.net>
References: <20181214171508.7791-1-surenb@google.com>
 <20181214171508.7791-7-surenb@google.com>
 <20181217162223.GD2218@hirez.programming.kicks-ass.net>
 <CAJuCfpHGsDnE-eAHY1QnX949stA3cvNA=078q1swqVnz95aJfg@mail.gmail.com>
 <20181218104622.GB15430@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218104622.GB15430@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 11:46:22AM +0100, Peter Zijlstra wrote:
> On Mon, Dec 17, 2018 at 05:21:05PM -0800, Suren Baghdasaryan wrote:
> > On Mon, Dec 17, 2018 at 8:22 AM Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > How well has this thing been fuzzed? Custom string parser, yay!
> > 
> > Honestly, not much. Normal cases and some obvious corner cases. Will
> > check if I can use some fuzzer to get more coverage or will write a
> > script.
> > I'm not thrilled about writing a custom parser, so if there is a
> > better way to handle this please advise.
> 
> The grammar seems fairly simple, something like:
> 
>   some-full = "some" | "full" ;
>   threshold-abs = integer ;
>   threshold-pct = integer, { "%" } ;

Sorry, no {} there obviously. That '%' isn't optional.

>   threshold = threshold-abs | threshold-pct ;
>   window = integer ;
>   trigger = some-full, space, threshold, space, window ;

Clearly it's been a fair while since I wrote BNF like stuff ;-)
