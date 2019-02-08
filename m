Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2ADCC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C2D2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="inmGbun8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfBHQvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:51:14 -0500
Received: from merlin.infradead.org ([205.233.59.134]:53766 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfBHQvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:51:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2GBKTeX367KDz3ZEJbZI6yo5mwfc2MDBukhqsoIsXp4=; b=inmGbun8Yn+OhlN29mqeaVZ6H
        oUiBiDh4pYX6WLMP2/K7By6sh1J2Fy0Wi3adgdC2+R3PPsU+u+zuZsjKukXXCAPGeogqL3CEDc6Mp
        mq8db3OggAmSMvkDVMDOP8Cl3FFEuhlA26PIysr7upQ9ndeqg4j89I0ci42xtPandjWnYpfuRrUli
        G85FHvDSBFdO7FDvIz69wu5lbeRjnMXSWpqVnjRFbKCaWLyQKkH7KlCLHfddIrq0VDUlMToFkoTzi
        53sggRcQXFxuwx0RgF09zpUEnlbH2pHpmhD7yYi5lkajGUmxRRVryskq6DJ2HjCeMkh/rSY3qeBVb
        IK4K8JjFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gs9Mk-0005Ji-V1; Fri, 08 Feb 2019 16:51:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89AA521406576; Fri,  8 Feb 2019 17:51:00 +0100 (CET)
Date:   Fri, 8 Feb 2019 17:51:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] sched/fair: optimization of update_blocked_averages()
Message-ID: <20190208165100.GM32511@hirez.programming.kicks-ass.net>
References: <1549469662-13614-1-git-send-email-vincent.guittot@linaro.org>
 <1549469662-13614-2-git-send-email-vincent.guittot@linaro.org>
 <20190208154009.GK32511@hirez.programming.kicks-ass.net>
 <CAKfTPtB9EzuHQ+K56EbDSUV6ifkpj2OR12tXRBN6=NQDwC2OMg@mail.gmail.com>
 <20190208163045.GD32494@hirez.programming.kicks-ass.net>
 <CAKfTPtDjS4sL-ijVgGsN9Z1yEsCi87CZfpYsZCr2n3KTLV=ByA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDjS4sL-ijVgGsN9Z1yEsCi87CZfpYsZCr2n3KTLV=ByA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 05:47:53PM +0100, Vincent Guittot wrote:
> On Fri, 8 Feb 2019 at 17:30, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Fri, Feb 08, 2019 at 04:44:53PM +0100, Vincent Guittot wrote:
> > > On Fri, 8 Feb 2019 at 16:40, Peter Zijlstra <peterz@infradead.org> wrote:

> > > Good point but this should go after the for_each_sched_entity() loop
> >
> > Indeed, but that loop does enqueue and can throttle again, should that
> > not also get that additional list_add_leaf_cfs_rq() loop we added to
> > enqueue_task_fair() to finish the add?
> 
> Initially, I added this additional loop but finally removed it because
> I didn't hit it during my tests. IIRC, we are protected by
> throttle_count in such case, which is not the case when we enqueue a
> task

Fair enough; and the to-be added assert will notify us if we got that
wrong :-)

I'll add the assert, no need to re-send.

Thanks!
