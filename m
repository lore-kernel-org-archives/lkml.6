Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BBBC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036292661F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p9P8YPUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036292661F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752686AbeFZHhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:37:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58330 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751965AbeFZHhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=70o/HiBNRNbTRwkhWgdrQLPYiG4JnwjdJdvVA33ckIs=; b=p9P8YPULxdzWMNAjCEjDY50cv8
        ZStiKiWdfsYb/NJ0SUwwAfLE+MxFV2szumEkdtlt/CJWDIsUVHqtJV2X2ofW/6H0GRr6J1BNM8van
        N2i4lj7mcptfAjdbKqtfvesdjqJtm2j+sFjOy9ZpP8QqHlKtpCgYP6OfGKIEiUYE69Ox1zrlcwby+
        awBFOuJ4q8YWi+6TDVlMJaBpY0/a9xLPf4E3ZcnkNbfpk9ZYEX/Tam+FnOwJWdu+YtI1CRQ6tNNpE
        xPay72CQ8Gp3ij96I7UCnJo1JiHFNQFbPgMC26ani0ssDkROr1X4hjk62VW9RnCDd2iDl3fhbZJ1B
        N5Ypq+7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXiXX-0005u8-CI; Tue, 26 Jun 2018 07:37:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E20E62029FA0E; Tue, 26 Jun 2018 09:37:22 +0200 (CEST)
Date:   Tue, 26 Jun 2018 09:37:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gavin Schenk <g.schenk@eckelmann.de>, kernel@pengutronix.de
Subject: Re: [PATCH] RFC: siox: don't create a thread without starting it
Message-ID: <20180626073722.GX2458@hirez.programming.kicks-ass.net>
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
> > That said, irrespective of the whole UNINTERRUPTIBLE/IDLE thing, I find
> > this construct fairly fragile. We rely on not getting any spurious
> > wakeups without a 'special' state.
> 
> Well, if the thread is woken up unintentionally nothing happens (apart

In your case sure. But people rely on the task being 'idle/blocked'
after kthread_create() to call things like kthread_bind() on it.

If it were to be woken early because dodgy games, the kthread_bind()
would fail, which in turn can lead to all sorts of 'fun' problems.

That is the whole point of this intermediate blocked state, it allows
you to muck with the kthread before it starts running custom code.
Arguably one could do it differently, but this is what it is.
