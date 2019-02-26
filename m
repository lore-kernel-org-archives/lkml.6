Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65335C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C61206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RWUgnebv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfBZLZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:25:40 -0500
Received: from merlin.infradead.org ([205.233.59.134]:50238 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfBZLZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:25:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qLZDyuxEqHHZxgWif0G+gtirBnXXdyU1+gqVsC36lHE=; b=RWUgnebv7xFFCnS/jfw+vyjei
        kCtJlT1dwh8hPZylVMJOK9dHZmMdr30glrp2VaxLrzKbnB7lGWN9E8SuJ4Zs8gFTBepvxDD1tAwzQ
        hkjwqrWsZxRE9fqnQOJr1TYcKTa2SBUcVaJPU1umco+wj7nANMyjtQuu/zFTGaOeS8YV0nX7WVa+9
        3G6s2rKIKQJ1ZGR2lmC1l01hpWQWLUP1xYLLgSrHFxJ43tuzJoBveILmmXfrHjYzow4RJdAzsdlTb
        yccXRXiT6SetUPXRkknY9BkUiNLzYGcci47QwwSIwqWZc4fuCZRGrgOCNSKnBn4lfEW5i9uDs5w9U
        fPLZtMGXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyarT-00057q-FS; Tue, 26 Feb 2019 11:25:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 01E9B20269AFC; Tue, 26 Feb 2019 12:25:21 +0100 (CET)
Date:   Tue, 26 Feb 2019 12:25:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
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
Message-ID: <20190226112521.GH32534@hirez.programming.kicks-ass.net>
References: <20190220020117.GD11787@linux.ibm.com>
 <20190220092604.GD32494@hirez.programming.kicks-ass.net>
 <20190220131456.GA3215@andrea>
 <20190220132714.GI32494@hirez.programming.kicks-ass.net>
 <20190222112128.GA7213@andrea>
 <20190222130014.GY32494@hirez.programming.kicks-ass.net>
 <20190225175517.GK4072@linux.ibm.com>
 <20190226093009.GS32477@hirez.programming.kicks-ass.net>
 <20190226104551.GF32534@hirez.programming.kicks-ass.net>
 <20190226112133.GG32534@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226112133.GG32534@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 12:21:33PM +0100, Peter Zijlstra wrote:

> Also; we need to find a GCC person to find/give us a knob to kill this
> entire class of nonsense. This is just horrible broken shit:
> 
> 
> ~/tmp# gcc -O2 -fno-strict-aliasing  -o ptr ptr.c ; ./ptr
> p=0x5635dd3d5034 q=0x5635dd3d5034
> x=1 y=2 *p=11 *q=2
> ~/tmp# cat ptr.c
> #include <stdio.h>
> #include <string.h>
> int y = 2, x = 1;
> int main (int argc, char **argv) {
> 	int *p = &x + argc;

damn; wrong version; that should've been: s/argc/1/
same result though.

> 	int *q = &y;
> 	printf("p=%p q=%p\n", p, q);
> 	if (!memcmp(&p, &q, sizeof(p))) {
> 		*p = 11;
> 		printf("x=%d y=%d *p=%d *q=%d\n", x, y, *p, *q);
> 	}
> }
