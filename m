Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E318C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6AE217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nUZjqjWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfBZPFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:05:11 -0500
Received: from merlin.infradead.org ([205.233.59.134]:53506 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfBZPFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sSgYUbHEsqo5tOsVPRM5JrDWmdpu/hrT7g9SHCyevzU=; b=nUZjqjWOp94putRtFVoj0x0BF
        IvZ3SQ9K5Y7Znri4HKnAW4RcinBs2hW3WsxeqobYiEifMKtP+R23reIVA5iLF9kJQPdda9k1b+8yx
        5MFblu2j9bTQ6POBg7O9QUB8ZmlVJDa1GYy3E/iWKHK7AyjS7c/fOhn6k53QM3Klkqy40Phqx3GW9
        zMWUPYFadQSi5gp1lhpclb3sBcVWxA0m/6QbC2oixhfy/BSRbTu1fBccA1UhzmVMWJddCc56oEXvF
        7Gr3czTeGanJtOtcPsoilAVjJHJ8gaLy2SUzSObSCfQ5JBi5S2PQc4pT493lvUvNsD0cCG/8wh3Ar
        pracpCM+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyeHt-0006eS-Dl; Tue, 26 Feb 2019 15:04:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C69D620269AFD; Tue, 26 Feb 2019 16:04:50 +0100 (CET)
Date:   Tue, 26 Feb 2019 16:04:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Message-ID: <20190226150450.GW32477@hirez.programming.kicks-ass.net>
References: <20190222130014.GY32494@hirez.programming.kicks-ass.net>
 <20190225175517.GK4072@linux.ibm.com>
 <20190226093009.GS32477@hirez.programming.kicks-ass.net>
 <20190226104551.GF32534@hirez.programming.kicks-ass.net>
 <20190226112133.GG32534@hirez.programming.kicks-ass.net>
 <20190226112521.GH32534@hirez.programming.kicks-ass.net>
 <20190226113008.GI32534@hirez.programming.kicks-ass.net>
 <20190226113813.GA14753@zn.tnic>
 <20190226134906.GG32494@hirez.programming.kicks-ass.net>
 <20190226142845.GK4072@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226142845.GK4072@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 06:28:45AM -0800, Paul E. McKenney wrote:

> Yes, this all is a bit on the insane side from a kernel viewpoint.
> But the paper you found does not impose this; it has instead been there
> for about 20 years, back before C and C++ admitted to the existence
> of concurrency.  But of course compilers are getting more aggressive,
> and yes, some of the problems show up in single-threaded code.

But that paper is from last year!! It has Peter Sewell on, I'm sure he's
heard of concurrency.

> The usual response is "then cast the pointers to intptr_t!" but of
> course that breaks type checking.

I tried laundering the pointer through intptr_t, but I can't seem to
unbreak it.


root@ivb-ep:~/tmp# gcc-8 -O2 -fno-strict-aliasing  -o ptr ptr.c ; ./ptr
p=0x55aacdc80034 q=0x55aacdc80034
x=1 y=2 *p=11 *q=2
root@ivb-ep:~/tmp# cat ptr.c
#include <stdio.h>
#include <string.h>
#include <stdint.h>
int y = 2, x = 1;
int main (int argc, char **argv) {
	intptr_t P = (intptr_t)&x;
	intptr_t Q = (intptr_t)&y;
	P += sizeof(int);
	int *q = &y;
	printf("p=%p q=%p\n", (int*)P, (int*)Q);
	if (P == Q) {
		int *p = (int *)P;
		*p = 11;
		printf("x=%d y=%d *p=%d *q=%d\n", x, y, *p, *q);
	}
}
