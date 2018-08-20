Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C582C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC0121722
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UsoCs1S4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC0121722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbeHTTGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:06:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54470 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeHTTGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UZtMeaY5b5A/z8zEXK4fazcyf3leylNu6R2YW++GABM=; b=UsoCs1S4RX5tVgxXmPC3wefAR
        RAAypr5lLM99WfVpnbh/NcXK2fMW/ZaqMbOE1ooAV7qjPxoidIsHTjAKlhjTw7psM9BueJwC6MpEC
        Z/XKMahniNH/oNf7ZrKahqz4bOXSG//o1KAaqWjToM4+PijTsn9Zuw37F+oBHhO/iC2ejajtHRojY
        1cBLjkv4wklGzy7qDzOj5zIopPSfvfo/GNJUuvO7AUxz2ezoE3IlFeO2wiN2cIGsm+6+134Ni6gAm
        Z3tjswh3MD2bTrfU1rVZKYNxhI43Rv5fwtrvmyoUYuvcrBEQEeIIbCC6bw5LkpRzSAU/KH0jGuJHD
        bTmabw6RQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1frmRO-0008GX-G6; Mon, 20 Aug 2018 15:50:02 +0000
Date:   Mon, 20 Aug 2018 08:50:02 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] locking: Remove an insn from spin and write locks
Message-ID: <20180820155002.GB25153@bombadil.infradead.org>
References: <20180820150652.29482-1-willy@infradead.org>
 <f24a32be-6a4f-0df8-4289-14adc1046f50@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f24a32be-6a4f-0df8-4289-14adc1046f50@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 11:14:04AM -0400, Waiman Long wrote:
> On 08/20/2018 11:06 AM, Matthew Wilcox wrote:
> > Both spin locks and write locks currently do:
> >
> >  f0 0f b1 17             lock cmpxchg %edx,(%rdi)
> >  85 c0                   test   %eax,%eax
> >  75 05                   jne    [slowpath]
> >
> > This 'test' insn is superfluous; the cmpxchg insn sets the Z flag
> > appropriately.  Peter pointed out that using atomic_try_cmpxchg()
> > will let the compiler know this is true.  Comparing before/after
> > disassemblies show the only effect is to remove this insn.
...
> >  static __always_inline int queued_spin_trylock(struct qspinlock *lock)
> >  {
> > +	u32 val = 0;
> > +
> >  	if (!atomic_read(&lock->val) &&
> > -	   (atomic_cmpxchg_acquire(&lock->val, 0, _Q_LOCKED_VAL) == 0))
> > +	    (atomic_try_cmpxchg(&lock->val, &val, _Q_LOCKED_VAL)))
> 
> Should you keep the _acquire suffix?

I don't know ;-)  Probably.  Peter didn't include it as part of his
suggested fix, but on reviewing the documentation, it seems likely that
it should be retained.  I put them back in and (as expected) it changes
nothing on x86-64.

> BTW, qspinlock and qrwlock are now also used by AArch64, mips and sparc.
> Have you tried to see what the effect will be for those architecture?

Nope!  That's why I cc'd linux-arch, because I don't know who (other
than arm64 and x86) is using q-locks these days.
