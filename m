Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2026BC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C313D26614
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X33WAmML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C313D26614
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752700AbeFZHjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:39:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59984 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751982AbeFZHi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rP7Dbil5cHbp6Evf1QAAk8QnMC2uQzQb6aoX4XF05NM=; b=X33WAmML+BusZd/2SQW4Y50c2j
        Djx/G6IZJv5uREOYQKZbjypWK6OIftd2j50Yy+B/BaWRcIVnrZyDBlpQ8ffo9DDOXjnsi1OOj0Fn6
        nkad9ZVYwS4O0nbDjVmM8RTKvyfd6c2lsodUgwtbMvFa3q87skbTiEc8Jf0z1Dl/r7hsLARVVbbkP
        9zDBgOcB0hsuUpSjWLnjO8FvwIF7vG197Z5UNV+gst+l3aQ7LSKNjsyWcN8SzWxYx+W7ii2ctokyl
        /rgWXoIyBFmic+QAIav0ksqhCn6vBmdnOMBM6cv79CM8flzeQsairWHuOy2nszlab8QwUrX9tn3p7
        SZJBOz+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXiYl-0006Hl-Dh; Tue, 26 Jun 2018 07:38:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AF0EA2029FA0E; Tue, 26 Jun 2018 09:38:41 +0200 (CEST)
Date:   Tue, 26 Jun 2018 09:38:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gavin Schenk <g.schenk@eckelmann.de>, kernel@pengutronix.de
Subject: Re: [PATCH] RFC: siox: don't create a thread without starting it
Message-ID: <20180626073841.GY2458@hirez.programming.kicks-ass.net>
References: <20180625102056.28468-1-u.kleine-koenig@pengutronix.de>
 <20180625125105.GZ2494@hirez.programming.kicks-ass.net>
 <20180625192121.k3hx32xbbhqkyfu4@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180625192121.k3hx32xbbhqkyfu4@pengutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 09:21:21PM +0200, Uwe Kleine-König wrote:
> > I don't think so, that patch has an issue with INTERRUPTIBLE, but IDLE
> > very much doesn't allow signals like INTERRUPTIBLE does.
> 
> I don't think I can provide a good commit log for
> s/TASK_UNINTERRUPTIBLE/TASK_IDLE/ in kernel/kthread.c:kthread(). But I
> can confirm that this patch makes the warning go away, so if you want to
> address this, you can add my Tested-by:.

Yeah, it's also a little bit more involved, I'd also have to change all
the kthread_bind() code and audit all kthread users to see if anybody
else actually relies on TASK_UNINTERRUPTIBLE.

So I think I'll leave it as is for now, maybe another day ... :-)
