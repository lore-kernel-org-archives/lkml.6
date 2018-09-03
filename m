Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE93BC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642D120779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642D120779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbeICV0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:26:38 -0400
Received: from foss.arm.com ([217.140.101.70]:59256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbeICV0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:26:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4E5118A;
        Mon,  3 Sep 2018 10:05:36 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A6F033F5BC;
        Mon,  3 Sep 2018 10:05:36 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 69EC21AE3046; Mon,  3 Sep 2018 18:05:50 +0100 (BST)
Date:   Mon, 3 Sep 2018 18:05:50 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <20180903170550.GM6954@arm.com>
References: <20180831091641.GA3634@andrea>
 <Pine.LNX.4.44L0.1808311042340.4901-100000@netrider.rowland.org>
 <20180831160640.GG30626@arm.com>
 <20180831182845.GA4673@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831182845.GA4673@andrea>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 08:28:46PM +0200, Andrea Parri wrote:
> > > Yes, it's true that implementing locks with atomic_cmpxchg_acquire 
> > > should be correct on all existing architectures.  And Paul has invited 
> > > a patch to modify the LKMM accordingly.  If you feel that such a change 
> > > would be a useful enhancement to the LKMM's applicability, please write 
> > > it.
> > 
> > Yes, please! That would be the "RmW" discussion which Andrea partially
> > quoted earlier on, so getting that going independently from this patch
> > sounds like a great idea to me.
> 
> That was indeed one of the proposal we discussed.  As you recalled, that
> proposal only covered RmWs load-acquire (and ordinary store-release); in
> particular, I realized that comments such as:
> 
>   "The atomic_cond_read_acquire() call above has provided the
>    necessary acquire semantics required for locking."
> 
>    [from kernel/locking/qspinlock.c]
> 
> (for example)  would still _not have "generic validity" _if we added the
> above po-unlock-rf-lock-po term... (which, again, makes me somehow uncon-
> fortable);  Would to have _all_ the acquire be admissible for you?

I think you've missed some words here, but if you're asking if I'd be
ok strengthening all acquire operations, then the answer is no. See the
huge amount of previous discussion.

Will
