Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B85C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B949B208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A6eDBPc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B949B208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933652AbeGIPNL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:13:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57638 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933249AbeGIPNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zNxHIEHCCYCOA4AVWDOAFuUAPwthrL8tieeHGwFWXF8=; b=A6eDBPc/kyzZxpgH7NfTivGBk
        xOTBBkbEpcZ5Q5URtYWYObWXsch5GjB0osLtbcRZheZMuDZ2tDM5o4r17a4orhx/u2c37F0fiZKTC
        1a4hAiPbhCk8fGhPsgsM/moUdv1qHp1sycYTLmVC7Bp8Ih8IwbNl0z9ZFiTSLvs9A7NNDBdppgG52
        04PVCVZUXBoJS49Tmt/LzarL5tbxKp0qqkyrLUfPDwIotJBQ1jrHS8aRdyoJvZqKmrgAXgSyJ/yor
        Ge/kjrxhcCD9JdZ0vuDmSEcgnc68eATOus99yzN0tYDV7xKZHgd/cLaN+A7QvMT452OQAT1QRBvth
        7ZBR86CIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcXqX-0002ZM-0G; Mon, 09 Jul 2018 15:13:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 712FA20289CE4; Mon,  9 Jul 2018 17:12:58 +0200 (CEST)
Date:   Mon, 9 Jul 2018 17:12:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 11/12] sched: use for_each_if in topology.h
Message-ID: <20180709151258.GV2476@hirez.programming.kicks-ass.net>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709083650.23549-11-daniel.vetter@ffwll.ch>
 <20180709103656.GH2476@hirez.programming.kicks-ass.net>
 <CAKMK7uEr9PJ0mex5CWdws55OwaLuHCbLJ5vP8KA4ZQXdAVOTYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uEr9PJ0mex5CWdws55OwaLuHCbLJ5vP8KA4ZQXdAVOTYQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 05:00:07PM +0200, Daniel Vetter wrote:
> On Mon, Jul 9, 2018 at 12:36 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Mon, Jul 09, 2018 at 10:36:49AM +0200, Daniel Vetter wrote:

> >>  #define for_each_node_with_cpus(node)                        \
> >>       for_each_online_node(node)                      \
> >> -             if (nr_cpus_node(node))
> >> +             for_each_if (nr_cpus_node(node))
> >
> > Not having gotten any of the other patches, I'm not really sure what
> > this does and such, but improve readability it does not :/
> 
> Patch 1 in this series, which I dumped onto lkml as a whole:
> 
> https://lkml.org/lkml/2018/7/9/179

Right, so while I don't object to being Cc'ed to the whole series, I do
mind not being Cc'ed to at least the generic bits required to understand
the patch I do have to look at.

> Imo it does improve readability for the if (!cond) {} else pattern.
> And (assuming my grep fu isn't too badly wrong) most places in the
> kernel do use this pattern in for_each macros, so I guess its a real
> thing. We've definitely hit it plenty in drm iterators (but we seem to
> like if() checks in iterator macros maybe a bit too much).
> 
> I'm happy to drop this patch tough if you deem it offensive.

I'd just like to understand it better; what compiler complains about
this and is the warning otherwise useful? These things don't seem
mentioned in that initial patch either.

IOW I suppose I'm asking for the justification of this churn. If it's
really needed and useful so be it, but so far I'm not seeing any.

At a while guess I'd say this is something new in gcc-8 (and while I
have that installed on some machines, it doesn't seem to be the default,
and so I've not actually seen its output). But is the warning actually
useful, should we not just kill the warning like we tend to do some
really silly ones.
