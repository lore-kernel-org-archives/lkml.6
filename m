Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C457DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897E7217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b5Kbrb2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbeLRKRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:17:49 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36202 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeLRKRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=npocvrWTM5VM1Ou07JEzt+r0Ck5x6NKw6E5HKl5iEQ4=; b=b5Kbrb2JdSoQQyVzmq+c1RngP
        6TsFwi3SpZsjXqufi7bz6U1e8Ebb4Ck5zaQ+Bq35klosTTnCC3/GzLjztkiwiVOySROu6PIgaNeRl
        +Zljrzmwp4WvwheBPlaJQpUSJRN3xB0RGuvOWMShYxSQQuPiw01nsMgxSBjQGcpnvB3xDYWQr3tb+
        kYXL01lDr0QRJsC4iC5BfVfjNPt2TvEqNqeqIo4w6daB7+u6SKJq34wOEcJeKqZlhN1zb+OtMqoZS
        EsP45cujoQ1C7cG8R+97Zp1VNiQjg/7YJtZPfRJvHbRMwIzAXATYfRbq4tiUgBnjyHBO1ePBwVk5e
        TsIZgzKGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZCRM-0007Lm-OR; Tue, 18 Dec 2018 10:17:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 850D92027DA8E; Tue, 18 Dec 2018 11:17:27 +0100 (CET)
Date:   Tue, 18 Dec 2018 11:17:27 +0100
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
Subject: Re: [PATCH 4/6] psi: introduce state_mask to represent stalled psi
 states
Message-ID: <20181218101727.GA15430@hirez.programming.kicks-ass.net>
References: <20181214171508.7791-1-surenb@google.com>
 <20181214171508.7791-5-surenb@google.com>
 <20181217155525.GC2218@hirez.programming.kicks-ass.net>
 <CAJuCfpHrQB7OtEC535=s4iJqwan17nAc-mbycV1aJ3RUQTWCPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHrQB7OtEC535=s4iJqwan17nAc-mbycV1aJ3RUQTWCPA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 05:14:53PM -0800, Suren Baghdasaryan wrote:
> On Mon, Dec 17, 2018 at 7:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > +             if (state_mask & (1 << s))
> >
> > We have the BIT() macro, but I'm honestly not sure that will improve
> > things.
> 
> I was mimicking the rest of the code in psi.c that uses this kind of
> bit masking. Can change if you think that would be better.

Yeah, I really don't know.. keep it as is I suppose.
