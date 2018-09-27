Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF576C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CAEC21547
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CAEC21547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeI0VG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:06:27 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52170 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbeI0VG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:06:27 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g5Xa0-0005TK-E1; Thu, 27 Sep 2018 16:47:48 +0200
Date:   Thu, 27 Sep 2018 16:47:47 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
cc:     Will Deacon <will.deacon@arm.com>,
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
In-Reply-To: <20180927144127.qdkem4juhztxdkdb@linutronix.de>
Message-ID: <alpine.DEB.2.21.1809271644120.8118@nanos.tec.linutronix.de>
References: <20180921120226.6xjgr4oiho22ex75@linutronix.de> <20180926125301.GE2979@brain-police> <20180927142547.ucgh5elb7pxs46dq@linutronix.de> <20180927144127.qdkem4juhztxdkdb@linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2018, Kurt Kanzenbach wrote:
> On Thu, Sep 27, 2018 at 04:25:47PM +0200, Kurt Kanzenbach wrote:
> > However, the issue still triggers fine. With stress-ng we're able to
> > generate latency in millisecond range. The only workaround we've found
> > so far is to add a "delay" in cpu_relax().
> 
> It might interesting for you, how we added the delay. We've used:
> 
> static inline void cpu_relax(void)
> {
> 	volatile int i = 0;
> 
> 	asm volatile("yield" ::: "memory");
> 	while (i++ <= 1000);
> }
> 
> Of course it's not efficient, but it works.

I wonder if it's just the store on the stack which makes it work. I've seen
that when instrumenting x86. When the careful instrumentation just stayed
in registers it failed. Once it was too much and stack got involved it
vanished away.

Thanks,

	tglx
