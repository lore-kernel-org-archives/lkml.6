Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E6AECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C5320870
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MscrUBLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C5320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732556AbeGLUgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:36:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41070 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732437AbeGLUgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:36:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id j5-v6so16414398wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 13:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AYAl5xnAYGcJDNAhwvd4tL+Dw8xlM19tgr4bTlGbMOY=;
        b=MscrUBLNXauxzyDx0O423PJAiUBtcbUr6o7lNnu29cRCUbI0Z1e62FNMHvb/IQKKpY
         ffXv9ZKUU4lcJiq3wbNzkBEZBRVq/3Sat83TvdY38NTBkgYhit3rjghioAVE4eUGSvl7
         Ea1lXWF2I7zcrvHVLdK65pTjasxMeLbgJ9pgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AYAl5xnAYGcJDNAhwvd4tL+Dw8xlM19tgr4bTlGbMOY=;
        b=mO4qTYHGWSRlcYYTqo6+7i7skkkGMV3aFSXRgK4mUdkAG85V0ZNB9MmnhKJdXZdP/Y
         izJbKsz8KZwJamLiYbyR1FPmG6Jekvj3mN00lPiqjszlh+CxbMg67PgGOvo3kuVWnCUM
         FP1BEALoPx8tcCjZJCzWA9GSRqOlR3Twd5ztAlvcRgGnzeuPVQSNxlVhS5upa1dIIWXB
         /PFzcMrhxU7DB61U+ew647F7ec0zA8QUCR+9OzBAYnwshWsNyV0/uAVfPVR4tyOVB/l/
         fs6xDzssb0t4SnTxHf2yIqpB+LWGnOT+BLO+Mh8Cmbdb4RfVchLpR2y4/tzxC68RtG9b
         Jztw==
X-Gm-Message-State: AOUpUlEIT3JlHkbcr+mtSdtBnk7wJ2xnbg9p+7hMQ1chbdZ1BED4lnk/
        eJRtS0DWLB0ge4cHQSEDH9XrgA==
X-Google-Smtp-Source: AAOMgpcv/Gx3ntkYQwfx30Tml0h38g2FgkB6DM4+9JZ6N5xpz1GIIGgfU9mTSFZxtOgT/aOYM+yIug==
X-Received: by 2002:adf:8f2e:: with SMTP id p43-v6mr2730859wrb.193.1531427106525;
        Thu, 12 Jul 2018 13:25:06 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id c13-v6sm15911754wrt.24.2018.07.12.13.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 13:25:05 -0700 (PDT)
Date:   Thu, 12 Jul 2018 22:24:57 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nick Piggin <npiggin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180712202457.GA4767@andrea>
References: <20180712134821.GT2494@hirez.programming.kicks-ass.net>
 <Pine.LNX.4.44L0.1807121236470.1306-100000@iolanthe.rowland.org>
 <20180712172838.GU3593@linux.vnet.ibm.com>
 <20180712180511.GP2476@hirez.programming.kicks-ass.net>
 <CA+55aFxwez8zSa2f2GpcaAkFX27Vt-s0nWdd0mZ6yGM8ipCR0A@mail.gmail.com>
 <20180712195242.GA4170@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712195242.GA4170@andrea>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 09:52:42PM +0200, Andrea Parri wrote:
> On Thu, Jul 12, 2018 at 11:10:58AM -0700, Linus Torvalds wrote:
> > On Thu, Jul 12, 2018 at 11:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > The locking pattern is fairly simple and shows where RCpc comes apart
> > > from expectation real nice.
> > 
> > So who does RCpc right now for the unlock-lock sequence? Somebody
> > mentioned powerpc. Anybody else?
> 
> powerpc have RCtso (and RCpc) but not RCsc unlock-lock, according to the
> following indeed original terminology:
> 
>  - RCsc unlock-lock MUST ORDER:
> 
>   a) the WRITE and the READ below:
> 
>       WRITE x=1
>       UNLOCK s
>       LOCK s
>       READ y
> 
>       as in a store-buffering test;
> 
>   b) the two WRITEs below:
> 
>       WRITE x=1
>       UNLOCK s
>       LOCK s
>       WRITE y=1
> 
>       as in a message-passing test;
> 
>   c) the two READs below:
> 
>       READ x
>       UNLOCK s
>       LOCK s
>       READ y
> 
>       as in a message-passing test;
> 
>   d) the READ and the WRITE below:
> 
>       READ x
>       UNLOCK s
>       LOCK s
>       WRITE y
> 
>       as in a load-buffering test;
> 
>  - RCtso unlock-lock MUST ORDER b), c), d) above.
> 
>  - RCpc unlock-lock MUST ORDER none of the above.
> 
> AFAICT, all arch _in_ the current implementation have RCtso unlock-lock.
> 
> 
> > 
> > How nasty would be be to make powerpc conform? I will always advocate
> > tighter locking and ordering rules over looser ones..
> 
> A simple answer is right above (place a sync somewhere in the sequence);
> for benchmark results, I must defer...

Sorry, not sure why but I did intend "conform to RCsc" here.


> 
>   Andrea
> 
> 
> > 
> >            Linus
