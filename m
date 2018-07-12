Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C8AEA0866
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A7A2124D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Qzi5g/jo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A7A2124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeGLR4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:56:10 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52346 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbeGLR4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:56:10 -0400
Received: by mail-wm0-f66.google.com with SMTP id o11-v6so493060wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 10:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EjVcH7YLw8ZdGHtJ/psVQSXscAxtrdV2QAzG4MbyvqQ=;
        b=Qzi5g/jol+J6qUk4SPrLAn3LjJ3eYUo8FmDgf95sdN/FrdqfZVkmBKPDNYZfLZQFUe
         iVTwPDAY+sklYArH5OA4erxRiYL8XSzV182bfzuPPiSjDHioRlPkpnULemnuR/BwJsoa
         VvUePaqy5V6L8I4OCCJLmd1r0ovfdxp+6YKqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EjVcH7YLw8ZdGHtJ/psVQSXscAxtrdV2QAzG4MbyvqQ=;
        b=ZmcI3CBv5vfnhy2DL28TZSWouybSWRwiSbCZJoReEP5cpxncf8GuftaK25CyYn34ke
         WCiNQ0/Fml9ZBbKeYpc+EBWmWHYFqqORm7TJf8ByrdyYt0DW5RZ8m7hB+ciKm+Htzrld
         nxxJFDwpQukipeJH2fJ74lx0apHk5k4TCmPfV0grITTlTxHfAhDr3J9K5bBHVtiTqBeB
         89o2pABjVB54Px8GH2G9+gl9sLy1+fhzvoXwFzPz+h2ne4c8TP8lF7uiGElQNGIlrsnD
         T5bvoI+JsBJm/LocaJLBUzR4A1h3QyNebf46S5OHATn+gPNWlGLaKxcXtuBJFUP6WHrq
         v0nA==
X-Gm-Message-State: AOUpUlGZWE0A1ex2OmUi5aeJO6AXCDGLHNMcfHtGUcYtXByxAdD+y+xI
        WI5Yuyd1HF/eQN8YcgtLaYh8Lg==
X-Google-Smtp-Source: AAOMgpc0s5RuVskOFpjoCzGdXbNNFrJmS2IOX2el00Sg6yxzLry9TXmV+9Yo3G8kHn61scHIKWWNlw==
X-Received: by 2002:a1c:dc89:: with SMTP id t131-v6mr2084955wmg.50.1531417533953;
        Thu, 12 Jul 2018 10:45:33 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id w21-v6sm5846052wmw.29.2018.07.12.10.45.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 10:45:33 -0700 (PDT)
Date:   Thu, 12 Jul 2018 19:45:27 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180712174527.GA3533@andrea>
References: <Pine.LNX.4.44L0.1807091519180.2462-100000@iolanthe.rowland.org>
 <20180710093821.GA5414@andrea>
 <20180711094310.GA13963@arm.com>
 <20180711123421.GA9673@andrea>
 <20180712074040.GA4920@worktop.programming.kicks-ass.net>
 <20180712115249.GA6201@andrea>
 <20180712134821.GT2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712134821.GT2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Anyway, back to the problem of being able to use the memory model to
> describe locks. This is I think a useful property.
> 
> My earlier reasoning was that:
> 
>   - smp_store_release() + smp_load_acquire() := RCpc
> 
>   - we use smp_store_release() as unlock()
> 
> Therefore, if we want unlock+lock to imply at least TSO (ideally
> smp_mb()) we need lock to make up for whatever unlock lacks.
> 
> Hence my proposal to strenghten rmw-acquire, because that is the basic
> primitive used to implement lock.
> 
> But as you (and Will) point out, we don't so much care about rmw-acquire
> semantics as much as that we care about unlock+lock behaviour. Another
> way to look at this is to define:
> 
>   smp-store-release + rmw-acquire := TSO (ideally smp_mb)
> 
> But then we also have to look at:
> 
>   rmw-release + smp-load-acquire
>   rmw-release + rmw-acquire
> 
> for completeness sake, and I would suggest they result in (at least) the
> same (TSO) ordering as the one we really care about.

Indeed (unless I'm not seeing something...  ;-).


> 
> One alternative is to no longer use smp_store_release() for unlock(),
> and say define atomic_set_release() to be in the rmw-release class
> instead of being a simple smp_store_release().
> 
> Another, and I like this proposal least, is to introduce a new barrier
> to make this all work.

An smp_tso__after_unlock_lock()?  (In a certain sense, the solution
adopted by RCU aligns to this approach: live with powerpc's RCpc and
introduce smp_mb__after_unlock_lock().)  Or did you have something
else in mind?

But I wouldn't hasten to introduce such a barrier, given that:  (1)
this would be a "do { } while (0)" for all the supported arch. _if_
we sticked to the current implementations, and  (2) even if these
implementations changed or some new arch. required a non-trivial
definition, we still would have to find a "pure/TSO" case  ;-).

  Andrea
