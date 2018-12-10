Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1AEC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82002082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JLSOLxci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82002082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbeLJOrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:47:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40252 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeLJOrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 09:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nt3c6DgLym1+Yx7KYelrYCgxLKEfXKqYOG3qB1DeNOs=; b=JLSOLxcibEc6zx8pF1imTh8/y
        1ggRRQJlvfbVaHsg/0h7IYkyhCZHl5etVv4qfJrNaLmoeXwJt/gHspDp7fbkVuRjSoU3end9Uluux
        DxoDRtuqxxBLdEC/G9VogtV6WWTm3Q/7vdOOUc7UyH0etQkITefGw0fKHi+NBfHUrJ8885S/xlUTt
        nSPLIqT30CDbknkSyOANePA3DzorfSy3uoZVBaGJ7Hhe9BvJaySGQouREIXlInlC6taUlN6RdV08V
        0Q0V7YgizKLm2xkzC9MkciJdaJxLR9sbs+nU8zYtlIv06x+oP8tnKqYxlKp8h85VQCim9vCwEjPit
        1Bms8cYFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWMq1-0007c1-DK; Mon, 10 Dec 2018 14:47:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C51232075BD0E; Mon, 10 Dec 2018 15:47:11 +0100 (CET)
Date:   Mon, 10 Dec 2018 15:47:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/4] kernel.h: Add non_block_start/end()
Message-ID: <20181210144711.GN5289@hirez.programming.kicks-ass.net>
References: <20181210103641.31259-1-daniel.vetter@ffwll.ch>
 <20181210103641.31259-3-daniel.vetter@ffwll.ch>
 <20181210141337.GQ1286@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210141337.GQ1286@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 03:13:37PM +0100, Michal Hocko wrote:
> I do not see any scheduler guys Cced and it would be really great to get
> their opinion here.
> 
> On Mon 10-12-18 11:36:39, Daniel Vetter wrote:
> > In some special cases we must not block, but there's not a
> > spinlock, preempt-off, irqs-off or similar critical section already
> > that arms the might_sleep() debug checks. Add a non_block_start/end()
> > pair to annotate these.
> > 
> > This will be used in the oom paths of mmu-notifiers, where blocking is
> > not allowed to make sure there's forward progress.
> 
> Considering the only alternative would be to abuse
> preempt_{disable,enable}, and that really has a different semantic, I
> think this makes some sense. The cotext is preemptible but we do not
> want notifier to sleep on any locks, WQ etc.

I'm confused... what is this supposed to do?

And what does 'block' mean here? Without preempt_disable/IRQ-off we're
subject to regular preemption and execution can stall for arbitrary
amounts of time.

The Changelog doesn't yield any clues.
