Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17073C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57FE24687
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gyp2obm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57FE24687
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934484AbeGCSLC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:11:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59780 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934141AbeGCSLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5GpCN1O2T7w7UlC8gaY+fbCc7hcRVDtZAmFMwCst9Xo=; b=Gyp2obm6AuLRLH8H0Ur5ThF6J
        fyg9ZFnBveFe4/QFU1X30F0Qanh1H5EtehaWfFtzPBCIK+Po9ZUuy1rDQRRaewSni/BpipXXHT8h+
        RvhqoxpkerOlLD+e7ak9a+NsYNoCfGw6JJT/6iL+cZIlL/zvSgMuqQo5fLAK20fOxHZKC+Ud97D7W
        NW1LvDTsH5RZTTo99sTCgik5A2hec9dNzpLFD8/mJvdgNRwBL+JdTejLTTre1Rwjr1CHmwjRWedJP
        aERtW0u7+6oNxTD8HK+4VnQErRjgtjYQg2MdNy4pHhDZ5kX6elaKmHnF3p41zI2hzB/+6jNZiS0pk
        Eb5NGQrGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faPl1-0003Jg-4H; Tue, 03 Jul 2018 18:10:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED52B20289CE4; Tue,  3 Jul 2018 20:10:28 +0200 (CEST)
Date:   Tue, 3 Jul 2018 20:10:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andi Kleen <andi@firstfloor.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Christoph Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>, gor@linux.ibm.com
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields,
 validate user inputs
Message-ID: <20180703181028.GA2494@hirez.programming.kicks-ass.net>
References: <20180703082955.GH3704@osiris>
 <20180703084312.GU2494@hirez.programming.kicks-ass.net>
 <20180703085546.GJ3704@osiris>
 <20180703092113.GV2494@hirez.programming.kicks-ass.net>
 <20180703164048.i2te5gjemcafqzwf@two.firstfloor.org>
 <CA+55aFzYEQgEhCnrwtbGuCy36Wh+aiw0_9rgMcjUgbn1JtZAPQ@mail.gmail.com>
 <20180703173451.GX2494@hirez.programming.kicks-ass.net>
 <399697782.11820.1530639539750.JavaMail.zimbra@efficios.com>
 <20180703174833.GZ2494@hirez.programming.kicks-ass.net>
 <CA+55aFxcVbG2DMmmrW-HLTXZE+rcBWc5F48UYoL2heEsEpyO=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxcVbG2DMmmrW-HLTXZE+rcBWc5F48UYoL2heEsEpyO=g@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 10:59:45AM -0700, Linus Torvalds wrote:
> On Tue, Jul 3, 2018 at 10:49 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > I can simply document that loads/stores from/to all struct rseq fields
> > > should be thread-local then ?
> >
> > I'm not sure that covers things sufficiently. You really want the
> > userspace load/stores to be single instructions.
> 
> Actually, I think we should try very hard to limit even that to _just_
> the rseq pointer itself.

> So I'd suggest that the only part we aim to have any "atomic" behavior
> at all is for the individual fields in "struct rseq" itself. So the
> cpu id and the base pointer and the flags. And even they are
> thread-local, so the atomicity is not about the kernel, but about user
> space needing to read and update them in word-sized chunks.
> 
> End result: absolutely nothing is atomic for the kernel.

Yes, agreed, that is what I meant but very poorly expressed. Only the
rseq bits themselves need this single-copy atomic stuff -- for
userspace.

