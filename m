Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B4FC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2804D21A68
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q2Uq8jOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2804D21A68
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754296AbeFUTIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 15:08:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47670 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753970AbeFUTIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 15:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SBnbcaSmmWqvz09WaNXyTe0vpdHSzS0j+dCXrsxsdXA=; b=Q2Uq8jOmbFMEjLe+dg/19Qx4R
        TSFDv12x1HVXm0bVtTiVA6z9fhWpFnFJykiRTbBL5ICxO4n+CnkEYe5WoIhBBMrfD2mhQ8dnX6ibi
        Nd6QKQJLj/QmxA7wvu0NjNzz3NH16qmD5hdked3tIzzmyEp1l5a8bJz6IroPiipQjzGXhrPAvElUW
        vr8RMIqCxsqNTyhJQuF/jdbxED/4SrFzXpNavgTnM/QBfcmJJoc5H5MAEcmY0OilmKrATKqQ6GG6k
        AP0ADGo5vWv00DFXL4zFJA67q43qiwmfPTJp/pyKbltkVeK69TfbLZTFJFGCZwBjfQrojnLAXoRe6
        xI0cc7XjA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW4wh-0004oT-Db; Thu, 21 Jun 2018 19:08:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7FFE82029FA0A; Thu, 21 Jun 2018 21:08:32 +0200 (CEST)
Date:   Thu, 21 Jun 2018 21:08:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/util_est: fix util_est_dequeue() for throttled cfs
 rq
Message-ID: <20180621190832.GD27616@hirez.programming.kicks-ass.net>
References: <1528972380-16268-1-git-send-email-vincent.guittot@linaro.org>
 <20180614113232.GG32302@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614113232.GG32302@e110439-lin>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 12:32:32PM +0100, Patrick Bellasi wrote:
> On 14-Jun 12:33, Vincent Guittot wrote:
> > When a cfs_rq is throttled, parent cfs_rq->nr_running is decreased and
> > everything happens at cfs_rq level. Currently util_est stays unchanged
> > in such case and it keeps accounting the utilization of throttled tasks.
> > This can somewhat make sense as we don't dequeue tasks but only throttled
> > cfs_rq.

> > If a task of another group is enqueued/dequeued and root cfs_rq becomes
> > idle during the dequeue, util_est will be cleared whereas it was
> > accounting util_est of throttled tasks before.

> > So the behavior of util_est
> > is not always the same regarding throttled tasks and depends of side
> > activity. Furthermore, util_est will not be updated when the cfs_rq is
> > unthrottled

> > as everything happens at cfs rq level. Main results is that
> > util_est will stay null whereas we now have running tasks. We have to wait
> > for the next dequeue/enqueue of the previously throttled tasks to get an
> > up to date util_est.
> > 
> > Remove the assumption that cfs_rq's estimated utilization of a CPU is 0
> > if there is no running task so the util_est of a task remains until the
> > latter is dequeued even if its cfs_rq has been throttled.

> > Fixes: 7f65ea42eb00 ("sched/fair: Add util_est on top of PELT")
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

> LGTM:
> 
> Reviewed-by: Patrick Bellasi <patrick.bellasi@arm.com>

Thanks guys!
