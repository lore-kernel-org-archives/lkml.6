Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1808EC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 17:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF7827754
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 17:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BDjiTO1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF7827754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935203AbeF1Ra4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 13:30:56 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51367 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934931AbeF1Ray (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 13:30:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id w137-v6so10625447wmw.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 10:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A0QHU8mL+6CDYRZhCz74GYSF4Kf0iPJGJzoqxFNfZlw=;
        b=BDjiTO1b2tBcu4jRtIm4VSmC817Y24sAlw1sNJYeV6hmm1wMHuS3QAKD2prIayS9VF
         xfcQn30TnJR8xvCc9eHLZzZ2QaYw/fDH0uXq5S8CPevH1UP1Jlk2d/reV6qt0VwHZGGF
         Ck3aUnliC6nytjxNDL9MCZJf6/VUHxpPy6EMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A0QHU8mL+6CDYRZhCz74GYSF4Kf0iPJGJzoqxFNfZlw=;
        b=gHTz+mm8WTY/Ey0KmOPbiQOqsjOPZuZXN7aqBkv/f+yD9R2i2+IPnKuqTYWvON7MQO
         l01Ip7oXumna7iN2PsBhAI/6CsAXC+b4zYqy51bpo/6ZQdXh1WxStX6dSvaK9vUhTlCO
         XYPNB4c4zc1sZZ6tcHhppkrM7JXulMV3+QuHKS8kD207FuM5pQrudt2hMODnyVl6HR9M
         H2uceSRO6h3wHDGWVH9PbuK9oKHHQHgEHSpI6pT8gXSnSTdFzspxOqa91L5kuJg63ZYy
         LmZnyLAcOplmkJToljfynff1jhKbR3Imvb7A0DIUzfAhxgCBzngS6KcQ1yQgp4ZMluBH
         B8Ug==
X-Gm-Message-State: APt69E3xG5PvlAY2T9qvsG5hgruBGdXfDm5lkCRXieZUdZ0oJF+6bvY/
        SvRcuXbj5rGc+kdFyNIt9ZDy9Q==
X-Google-Smtp-Source: AAOMgpc0RiyUfXMmQSBttFY3RRx79fGE5aFCTRShoXgxnxH6gtalxH/jNOk3SZDYBtMGF10gVJ15ig==
X-Received: by 2002:a7b:c058:: with SMTP id u24-v6mr9036613wmc.136.1530207052957;
        Thu, 28 Jun 2018 10:30:52 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id h3-v6sm5335306wro.87.2018.06.28.10.30.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 10:30:52 -0700 (PDT)
Date:   Thu, 28 Jun 2018 19:30:45 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 2/3] locking: Clarify requirements for
 smp_mb__after_spinlock()
Message-ID: <20180628173045.GA4975@andrea>
References: <1530182480-13205-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1530182480-13205-3-git-send-email-andrea.parri@amarulasolutions.com>
 <20180628150550.GI2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628150550.GI2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 05:05:50PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 28, 2018 at 12:41:19PM +0200, Andrea Parri wrote:
> > - * This barrier must provide two things:
> > - *
> > - *   - it must guarantee a STORE before the spin_lock() is ordered against a
> > - *     LOAD after it, see the comments at its two usage sites.
> > - *
> > - *   - it must ensure the critical section is RCsc.
> > - *
> > - * The latter is important for cases where we observe values written by other
> > - * CPUs in spin-loops, without barriers, while being subject to scheduling.
> > - *
> > - * CPU0			CPU1			CPU2
> > - *
> > - *			for (;;) {
> > - *			  if (READ_ONCE(X))
> > - *			    break;
> > - *			}
> > - * X=1
> > - *			<sched-out>
> > - *						<sched-in>
> > - *						r = X;
> > - *
> > - * without transitivity it could be that CPU1 observes X!=0 breaks the loop,
> > - * we get migrated and CPU2 sees X==0.
> 
> Please don't remove that; that explains _why_ we need a full memory
> barrier here.

Peter:

Both you and Boqun stated that the above snippet is "bad":

  http://lkml.kernel.org/r/20180312085646.GE4064@hirez.programming.kicks-ass.net

and I do agree with your assessment! ;-)

I've no objection to keep that comment (together with the
"clarification" suggested in this patch) _once_ replaced
that snippet with something else (say, with the snippet
Boqun suggested in:

  http://lkml.kernel.org/r/20180312085600.aczjkpn73axzs2sb@tardis ):

is this what you mean?

  Andrea
