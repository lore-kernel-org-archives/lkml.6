Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD23C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76439219C5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JEGU8Azw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76439219C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754104AbeFUSEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:04:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59896 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751048AbeFUSEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R3mKvH41WUz6gS/cyZlPOLo01d+3dLVHCkCIKucK9Qg=; b=JEGU8AzwRL7AmUwF6TPAVg3XR
        7u+FcOLWahIcjzJd9HgoRp6LohCyT6dqJyC7PlLJv3aNCaHwivq5t1cnOHYwtuUeezAzgxitoqYIN
        k5HlEtw4XBAll7mkGy0Kv5ynMyUtcQmmALFcZDwqXtARQahjqDze9MkTJIJ4UyD2oQlKjJg6VbmR0
        gGLk3rJ79gYLD8bNKLvofhdGbYMMKNDSN0T78CzzKmVrrztNfJJ+fLHBBmqPL2vG1XkGXKrbsVhdg
        24gJ/3EWLB1c1JVIqBXiP7c43ukkvjDf9/Z9BKz+tNzAqqpEw3CHaWoBq8zuuwtK02wsFKjmLWXZZ
        JIT6aoYNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW3wX-0000i1-N5; Thu, 21 Jun 2018 18:04:25 +0000
Received: by worktop (Postfix, from userid 1000)
        id 442866E093A; Thu, 21 Jun 2018 20:04:22 +0200 (CEST)
Date:   Thu, 21 Jun 2018 20:04:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Message-ID: <20180621180422.GF3452@worktop.programming.kicks-ass.net>
References: <Pine.LNX.4.44L0.1806211322160.2381-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1806211322160.2381-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 01:27:12PM -0400, Alan Stern wrote:
> More than one kernel developer has expressed the opinion that the LKMM
> should enforce ordering of writes by release-acquire chains and by
> locking.  In other words, given the following code:
> 
> 	WRITE_ONCE(x, 1);
> 	spin_unlock(&s):
> 	spin_lock(&s);
> 	WRITE_ONCE(y, 1);
> 
> or the following:
> 
> 	smp_store_release(&x, 1);
> 	r1 = smp_load_acquire(&x);	// r1 = 1
> 	WRITE_ONCE(y, 1);
> 
> the stores to x and y should be propagated in order to all other CPUs,
> even though those other CPUs might not access the lock s or be part of
> the release-acquire chain.  In terms of the memory model, this means
> that rel-rf-acq-po should be part of the cumul-fence relation.
> 
> All the architectures supported by the Linux kernel (including RISC-V)
> do behave this way, albeit for varying reasons.  Therefore this patch
> changes the model in accordance with the developers' wishes.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Thanks for that Alan!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
