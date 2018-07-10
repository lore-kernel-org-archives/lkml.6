Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9689CC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6FD20883
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DB3aX1aG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6FD20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732375AbeGJXQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 19:16:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40686 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732253AbeGJXQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 19:16:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id t6-v6so16237702wrn.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 16:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JYCGqiZ3uAwHQvmuujK6SBF6j+DebRK1K3+Q2l9lEdw=;
        b=DB3aX1aGz3LyMJUfKFv3GYe6spILoRSk6+CH5Gzfwjeb6nLHD9wcsZJIsvzPhUywL2
         Vd7dMIfEWFoVRfV2f4ap41tVZKo60ZvL9ZDQdzn3eBnEx6nrabLErgkYt5XyctnTG/Ep
         NAQ5nLHkqlkUd+Z2cXIIEKUcHj+syk0euZdOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JYCGqiZ3uAwHQvmuujK6SBF6j+DebRK1K3+Q2l9lEdw=;
        b=KFzI5bKBfBFjmeKwosQrkE2q3Rv/0nFiM/dymOGMBL2vrWS7OjGoq4ukjjwNF7dDQT
         0gNyML94kBwdF3Cty8F37durqJunMrivsiHzvZryevc73jJqb87vZrkPsZVix0TEFyHZ
         JW4tS6pkH5BzfO/YvocYUbVh3Z3mUtRXq2zkSQ1xRLSwWpC2KsVgwZ2+ybrE/qhZNXd+
         1xObN+vDgB1jTbe7S2aEqAkeX6yGDJysyndLYKfB4UjGAZrX1kiqei6HJmVzIPBU8iIU
         ktCQ4UFXeg0EssQr6r4yRBjucDyCuhZ7wNtB3aikzBW1l/3sXhfGT7OJ+JAuu4IaGhji
         hx8g==
X-Gm-Message-State: APt69E25xuhhRPvQcp2jto2v0WgyWOO6UTT1inuUrozRNxK5FrTYCbu4
        7tIf9ygKwXAWFiqUAUZ/ws71YA==
X-Google-Smtp-Source: AAOMgpfbcqu2U6x+u74z9tEamnh90WsWd/YXIFLEpgDg3ofhTwO8sed0NdcgmelWrVnn/cTPyDKXLQ==
X-Received: by 2002:adf:a094:: with SMTP id m20-v6mr18624319wrm.125.1531264501721;
        Tue, 10 Jul 2018 16:15:01 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id h4-v6sm19086404wre.89.2018.07.10.16.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 16:15:01 -0700 (PDT)
Date:   Wed, 11 Jul 2018 01:14:55 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180710231455.GA11372@andrea>
References: <20180710152404.GA11437@andrea>
 <Pine.LNX.4.44L0.1807101127320.1449-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1807101127320.1449-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 11:34:45AM -0400, Alan Stern wrote:
> On Tue, 10 Jul 2018, Andrea Parri wrote:
> 
> > > >   ACQUIRE operations include LOCK operations and both smp_load_acquire()
> > > >   and smp_cond_acquire() operations.  [BTW, the latter was replaced by
> > > >   smp_cond_load_acquire() in 1f03e8d2919270 ...]
> > > > 
> > > >   RELEASE operations include UNLOCK operations and smp_store_release()
> > > >   operations. [...]
> > > > 
> > > >   [...] after an ACQUIRE on a given variable, all memory accesses
> > > >   preceding any prior RELEASE on that same variable are guaranteed
> > > >   to be visible.
> > > 
> > > As far as I can see, these statements remain valid.
> > 
> > Interesting; ;-)  What does these statement tells you ;-)  when applied
> > to a: and b: below?
> > 
> >   a: WRITE_ONCE(x, 1); // "preceding any prior RELEASE..."
> >   smp_store_release(&s, 1);
> >   smp_load_acquire(&s);
> >   b: WRITE_ONCE(y, 1); // "after an ACQUIRE..."
> 
> The first statement tells me that b: follows an ACQUIRE.
> 
> The second tells me that a: precedes a RELEASE.
> 
> And the third tells me that any READ_ONCE(x) statements coming po-after 
> b: would see x = 1 or a later value of x.  (Of course, they would have 
> to see that anyway because of the cache coherency rules.)

Mmh, something like "visible from the same CPU of the ACQUIRE" probably
could have helped me to reach the same conclusion.


> 
> More to the point, given:
> 
> P0()
> {
> 	WRITE_ONCE(x, 1);
> 	a: smp_store_release(&s, 1);
> }
> 
> P1()
> {
> 	b: r1 = smp_load_acquire(&s);
> 	r2 = READ_ONCE(x);
> }
> 
> the third statement tells me that if r1 = 1 (that is, if a: is prior to
> b:) then r2 must be 1.

Indeed; the "prior" is ambiguous, but yes.

  Andrea


> 
> Alan
> 
