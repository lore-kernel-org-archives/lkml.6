Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC909C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B011D22419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I5MGIvwA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B011D22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbeKMEM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:12:26 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47802 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeKMEMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 23:12:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9IRJWI2EKydd/p22jhXbWXXqMesqLJXGcHCf+VedH7g=; b=I5MGIvwA7BKDZ4QM21bms6J6n
        dGltIaB2vXqseAe5ncfz5sTDzEL5rhPRRRIdIohVbPpJyOb6iEBFr5tNqxVt8EPiL/vKK6iNrBIqU
        aGGkLqXKlAiKn+kjiLzRC88/1eBjvKSKZ9vX3xfnBCJ8nYwXWz65c2XJn4IBhw6s5WP7drYImJY6w
        LukyqLDgQ0hSFiL5tvNYFRjWYvbTiynbY+U9ggNsPk+UURq3KlwKaXHCO+6lcCeK1pY3VQ5O7g8UL
        fy8TpOXd2Xyki+DhH1Taa+3NWmpil65JHrSBZ4ZcHmwv07gQ2E9Ue6NKNn4ZdnhJpUah395YjMSEp
        65L6gCi3Q==;
Received: from [64.114.255.114] (helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMGmN-0003JO-1y; Mon, 12 Nov 2018 18:17:43 +0000
Received: by worktop (Postfix, from userid 1000)
        id 1F0256E086C; Mon, 12 Nov 2018 19:17:41 +0100 (CET)
Date:   Mon, 12 Nov 2018 19:17:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH tip/core/rcu 23/41] sched: Replace synchronize_sched()
 with synchronize_rcu()
Message-ID: <20181112181741.GA3097@worktop.psav.com>
References: <20181111194104.GA4787@linux.ibm.com>
 <20181111194410.6368-23-paulmck@linux.ibm.com>
 <20181112001233.GC3056@worktop>
 <20181112004528.GA4170@linux.ibm.com>
 <20181112005329.GG3056@worktop>
 <20181112014736.GB4170@linux.ibm.com>
 <20181112020710.GJ3056@worktop>
 <20181112022455.GD4170@linux.ibm.com>
 <20181112090047.GN3056@worktop>
 <20181112132852.GH4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112132852.GH4170@linux.ibm.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 05:28:52AM -0800, Paul E. McKenney wrote:
> On Mon, Nov 12, 2018 at 10:00:47AM +0100, Peter Zijlstra wrote:

> > Still, better safe than sorry. It was a rather big change in behaviour,
> > so it wouldn't have been strange to call that out.
> 
> This guy:
> 
> 45975c7d21a1 ("rcu: Define RCU-sched API in terms of RCU for Tree RCU PREEMPT builds")
> 
> Has a commit log that says:
> 
> 	Now that RCU-preempt knows about preemption disabling, its
> 	implementation of synchronize_rcu() works for synchronize_sched(),
> 	and likewise for the other RCU-sched update-side API members.
> 	This commit therefore confines the RCU-sched update-side code
> 	to CONFIG_PREEMPT=n builds, and defines RCU-sched's update-side
> 	API members in terms of those of RCU-preempt.
> 
> That last phrase seems pretty explicit.  What am I missing here?

That does not explicitly state that because RCU-preempt
synchornize_rcu() can take _much_ longer, the new synchronize_sched()
can now take _much_ longer too.

So when someone bisects a problem to this commit; and he reads the
Changelog, he might get the impression that was unexpected.

> Not that it matters, given that I know of no way to change a mainlined
> commit log.  I suppose I could ask Jon if he would be willing to take
> a 2018 RCU API LWN article, if that would help.

Yes, it is water under the bridge; but Changelogs should be explicit
about behavioural changes.

And while the merged RCU has the semantic behaviour required, the timing
behaviour did change significantly.

> > > > Again, the patch didn't say that.
> > > > 
> > > > If the Changelog would've read something like:
> > > > 
> > > > "Since synchronize_sched() is now equivalent to synchronize_rcu(),
> > > > replace the synchronize_sched() usage such that we can eventually remove
> > > > the interface."
> > > > 
> > > > It would've been clear that the patch is a nop and what the purpose
> > > > was.
> > > 
> > > I can easily make that change.
> > 
> > Please, sufficient doesn't imply necessary etc.. A changelog should
> > always clarify why we do the patch.
> 
> ???  Did you mean to say "necessary doesn't imply sufficient"?  If so,
> what else do you feel is missing?

No, I meant to say that your original Changelog only states that
sync_rcu now covers rcu-sched behaviour.  Which means that the change is
sufficient.

It completely and utterly fails to explain _why_ you're doing the
change. Ie. you do not address why it is necessary.

A Changelog should always explain why the change is needed.

In this case because you want to get rid of the sync_sched() api.
