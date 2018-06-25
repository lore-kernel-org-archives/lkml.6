Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F99C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493132598B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ECd5NlR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 493132598B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755346AbeFYMvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:51:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36788 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752124AbeFYMvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dzU7Pfw81TZ224pAbrf3aoni5cUEEoExpOyR9ny06vs=; b=ECd5NlR34kYzwAR/jpygf932Bh
        L8PHghAxcijEsMc8jvGQb2dfBVl8VsOuWod98695yrFFA6By6psC36DUQGBrfOFS1iEUZS+xYVfpV
        K9jzHGr51LJfdtHAP6bp4xS8T3fTjgwy49u2j7yqb1DQn2ss27qZQP4SC0hphNqD6liJAHHvInWo0
        +QUIP7Pe1fcUgJtlsWQ99doW2/O4AMLQT7VGAgE2VUhBPtoGNdjPEsKfHSff3y4yhXa9AlZ22O9ro
        Wj5L6kCBLiwEgsm69Zp3zd3jzdpBDRqbhoNMNFXbXEU+lZdJWS5ITgNjqgvwOBFRh5A6fOJXsj5tp
        PoduYILw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXQxX-00034D-SV; Mon, 25 Jun 2018 12:51:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B113F2029FA0A; Mon, 25 Jun 2018 14:51:05 +0200 (CEST)
Date:   Mon, 25 Jun 2018 14:51:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gavin Schenk <g.schenk@eckelmann.de>, kernel@pengutronix.de
Subject: Re: [PATCH] RFC: siox: don't create a thread without starting it
Message-ID: <20180625125105.GZ2494@hirez.programming.kicks-ass.net>
References: <20180625102056.28468-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180625102056.28468-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 12:20:56PM +0200, Uwe Kleine-König wrote:
> when I just boot without any other siox-related action. So the kthread (created
> in drivers/siox/siox-core.c:siox_master_register()) is never started.
> 
> While you could argue that there is little reason to not start the
> thread there also is little reason to actually do it.

Well, you really _should_ wake up the thread. That first wakeup really
is part of the whole 'create/setup' kthread pattern.

> peterz in #kernelnewbies said "[...] kernel/kthread.c:kthread() should
> really be using __set_current_state(TASK_IDLE), I suppose". This however
> seems to interfere with problems fixed in a076e4bca2fd ("freezer: fix
> kthread_create vs freezer theoretical race").

I don't think so, that patch has an issue with INTERRUPTIBLE, but IDLE
very much doesn't allow signals like INTERRUPTIBLE does.

> So I wonder where the real problem is and how it can be fixed.

Without the first wakeup, the kthread will not run the provided function
and we can therefore argue the creation is incomplete. I really feel you
should just wake the thing up to land in your own wait-condition-loop.

That said, irrespective of the whole UNINTERRUPTIBLE/IDLE thing, I find
this construct fairly fragile. We rely on not getting any spurious
wakeups without a 'special' state. The only reason this doesn't normally
happen is because it's a new task, but since it is already hashed, it
might well be possible to trick someone into sending a wakeup.


