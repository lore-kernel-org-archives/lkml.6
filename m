Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7CDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FFF2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QwGJd/WP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2FFF2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbeKSXQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:16:27 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55076 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728818AbeKSXQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:16:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=O9IpEFSYEs2RI8yj3Cm4O1zzyMhTmwKCZ15ewSicOxY=; b=QwGJd/WPcYkBA1YJE03RetVHr
        9llnXdegiSAKfIjqQ1gUSz4hPazFFG4y54s34Hve0yKzbN3+ZfLxWBM3LQy5K+cR9xzRZL8VyLa19
        IVEiNiF21rwDWBtjt+MefhQgUyn0PPsNG6XCHgpEZAAWzAqZLait19sVSPa3KYb3V9u0+rmR473JE
        1VakGPV8r/4cHfXzLT3UZh5jnYm23spdEnSL3d/vpEv5c4d9R8XF5/e5T6kdHxMk1HeAH0vXBur8a
        OWXOzSj1nyRPNTis0oV87aBhCMPkUyrFrmzT5+yBUgX6CKOQ6vL31UCSldKADcUh2ejLwMKos3AR3
        GWy1Ep7AQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOj2g-0007tl-WA; Mon, 19 Nov 2018 12:52:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0C78220298BFC; Mon, 19 Nov 2018 13:52:41 +0100 (CET)
Date:   Mon, 19 Nov 2018 13:52:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+119ba87189432ead09b4@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, x86@kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: WARNING in enqueue_task_dl
Message-ID: <20181119125241.GC9761@hirez.programming.kicks-ass.net>
References: <000000000000b5e346057af4da06@google.com>
 <alpine.DEB.2.21.1811190921190.9459@nanos.tec.linutronix.de>
 <20181119130718.69eddf46@luca64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119130718.69eddf46@luca64>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 01:07:18PM +0100, luca abeni wrote:

> > On Sun, 18 Nov 2018, syzbot wrote:

> > > WARNING: CPU: 1 PID: 6351 at kernel/sched/deadline.c:628
> > > enqueue_task_dl+0x22da/0x38a0 kernel/sched/deadline.c:1504
> 
> Here, it looks like a task is invoking sched_setattr() to become
> SCHED_DEADLINE when dl_boosted is set...
> 
> Is this possible / correct?

Possible, clearly. Correct, only in so far as that it is not a malformed
program, but it is very poor design to actually trigger this (of course
the fuzzer doesn't care about that).

> If this (sched_setattr() with dl_boosted set) should not be possible,
> then we have a bug that we need to investigate...
> 
> Otherwise, I suspect we can just remove the WARN_ON at line 628 of
> deadline.c

I wonder why we put that WARN in there to begin with... git-blame gives
us:

  98b0a8578050 ("sched/deadline: Remove useless parameter from setup_new_dl_entity()")

So the problem seems to be that if we're boosted, we should maybe not be
using our own (newly set) parameters, but those of the donor task.

Specifically, our 'suboptimal' deadline inheritance scheme 'requires' us
to use the inherited deadline, not our own. So in that respect I think
the WARN is valid, although I'm not sure what, apart from actually
finishing that PE patch-set we can do about it just now.
