Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URG_BIZ,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B80ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 00:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC6E20850
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 00:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVHuwNmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC6E20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbeGSBHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 21:07:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbeGSBHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 21:07:08 -0400
Received: from localhost (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B00BE20673;
        Thu, 19 Jul 2018 00:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531960003;
        bh=sY7z2OGobOLQ1d/8OBCGOcKZanQpE4AVmQsyeauoXFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AVHuwNmD+/3y9QxWa9DnMm/JTDjvTZIyOq9GU6bT8pADHHu05zmnBSIOQvtt/YZwn
         g+VPNfoUyTAByBLBBTkh35kEXIqL/C2Y3uuAdxcq6OIOr+7/JYGwzxLUkPT+MrHnLh
         3jRVgMFbUf7UoQWOcaSRmZFDBMmdzcGQFeFhk+i4=
Date:   Thu, 19 Jul 2018 02:26:40 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, mhillenb@amazon.de,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Message-ID: <20180719002639.GA5595@lerouge>
References: <20180712125351.GP3593@linux.vnet.ibm.com>
 <20180712161704.GA20726@linux.vnet.ibm.com>
 <20180716154015.GA21419@linux.vnet.ibm.com>
 <1531815548.19223.23.camel@infradead.org>
 <20180717125653.GH12945@linux.vnet.ibm.com>
 <20180718153628.GA24359@linux.vnet.ibm.com>
 <1531929711.3414.29.camel@infradead.org>
 <20180718163712.GB12945@linux.vnet.ibm.com>
 <1531942865.3414.35.camel@infradead.org>
 <20180718201700.GN12945@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180718201700.GN12945@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 01:17:00PM -0700, Paul E. McKenney wrote:
> On Wed, Jul 18, 2018 at 09:41:05PM +0200, David Woodhouse wrote:
> > 
> > 
> > On Wed, 2018-07-18 at 09:37 -0700, Paul E. McKenney wrote:
> > > On Wed, Jul 18, 2018 at 06:01:51PM +0200, David Woodhouse wrote:
> > > > 
> > > > On Wed, 2018-07-18 at 08:36 -0700, Paul E. McKenney wrote:
> > > > > 
> > > > > And I finally did get some near misses from an earlier commit, so we
> > > > > should consider your patch to be officially off the hook.
> > > >
> > > > Yay, I like it when it's not my fault. I'll redo it with the ifdef
> > > > CONFIG_NO_HZ_FULL.
> > >
> > > Hey, I didn't say it wasn't your fault, only that it -officially- wasn't
> > > your fault.  ;-)
> > 
> > I can live with being innocent until proven guilty.
> > 
> > > > 
> > > > What should it do for the !CONFIG_NO_HZ_FULL case? The existing call in
> > > > guest_enter_irqoff() clearly wasn't actually doing the right thing
> > > > anyway, hence the need for the need_resched() patch in $SUBJECT... so
> > > > should I just leave it doing nothing in guest_enter_irqoff()? 
> > >
> > > One starting point would be the combination of your patch and my
> > > patch, with -rcu commit IDs and diff below.  But yes, it needs to be
> > > !CONFIG_NO_HZ_FULL.  And no, I am not at all confident that I actually
> > > found all the places needing change in the core code, so this needs some
> > > serious review both by the KVM guys and the NO_HZ_FULL guys.
> > 
> > Right, that looks fairly much like the version I'd ended up with. So my
> > question was...
> > 
> > > --- a/include/linux/context_tracking.h
> > > +++ b/include/linux/context_tracking.h
> > > @@ -118,12 +118,12 @@ static inline void guest_enter_irqoff(void)
> > >  	 * one time slice). Lets treat guest mode as quiescent state, just like
> > >  	 * we do with user-mode execution.
> > >  	 */
> > 
> > ...if we change this to something like...
> > 
> > #ifdef CONFIG_NO_HZ_FULL
> > > +	rcu_kvm_enter();
> > #else
> > > 	if (!context_tracking_cpu_is_enabled())
> > > 		rcu_virt_note_context_switch(smp_processor_id());
> > #endif
> > 
> > ... do you actually want me to keep the #else case there? It blatantly
> > wasn't working anyway for us, perhaps because the condition was false?
> > That's why I started fixing need_resched() in the first place, and that
> > fix ought to cover whatever this call to rcu_virt_note_context_switch()
> > was supposed to be doing?
> 
> My thought would be something like this:
> 
> 	if (context_tracking_cpu_is_enabled())
> 		rcu_kvm_enter();
> 	else
> 		rcu_virt_note_context_switch(smp_processor_id());
> 
> The reason I believe that this is the right approach is that even when
> you have CONFIG_NO_HZ_FULL=y, some CPUs will still be nohz_full=n CPUs,
> so you don't want to take the extra overhead on those CPUs.
> 
> But I could easily be confused here, so I am adding Frederic for his
> thoughts.

Hmm, actually rcu_user_enter()/rcu_user_exit() are already called upon guest
entry/exit :-)

Now I must confess the code leading there in __context_tracking_enter/exit is
not very obvious but that part applies to both CONTEXT_USER and CONTEXT_GUEST cases.
I should probably add a few comments to clarify.
