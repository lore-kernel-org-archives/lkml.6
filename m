Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB91C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 09:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B707A2172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 09:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B707A2172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbeI1P2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:28:14 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54029 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbeI1P2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:28:14 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt.kanzenbach@linutronix.de>)
        id 1g5oiA-00049Y-Fl; Fri, 28 Sep 2018 11:05:22 +0200
Date:   Fri, 28 Sep 2018 11:05:22 +0200
From:   Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [Problem] Cache line starvation
Message-ID: <20180928090521.mj5elgqnla6qcz2r@linutronix.de>
References: <20180921120226.6xjgr4oiho22ex75@linutronix.de>
 <20180926125301.GE2979@brain-police>
 <20180927142547.ucgh5elb7pxs46dq@linutronix.de>
 <20180927144127.qdkem4juhztxdkdb@linutronix.de>
 <alpine.DEB.2.21.1809271644120.8118@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809271644120.8118@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Thu, Sep 27, 2018 at 04:47:47PM +0200, Thomas Gleixner wrote:
> On Thu, 27 Sep 2018, Kurt Kanzenbach wrote:
> > On Thu, Sep 27, 2018 at 04:25:47PM +0200, Kurt Kanzenbach wrote:
> > > However, the issue still triggers fine. With stress-ng we're able to
> > > generate latency in millisecond range. The only workaround we've found
> > > so far is to add a "delay" in cpu_relax().
> >
> > It might interesting for you, how we added the delay. We've used:
> >
> > static inline void cpu_relax(void)
> > {
> > 	volatile int i = 0;
> >
> > 	asm volatile("yield" ::: "memory");
> > 	while (i++ <= 1000);
> > }
> >
> > Of course it's not efficient, but it works.
>
> I wonder if it's just the store on the stack which makes it work. I've seen
> that when instrumenting x86. When the careful instrumentation just stayed
> in registers it failed. Once it was too much and stack got involved it
> vanished away.

I've performed more tests: Adding a store to a global variable just
before calling cpu_relax() doesn't help. Furthermore, adding up to 20
yield instructions (just like you did on x86) didn't work either.

Thanks,
Kurt
