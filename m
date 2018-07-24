Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC72C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BAE20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DykZCpUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BAE20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388362AbeGXK0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:26:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40748 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388222AbeGXK0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fq4UHO4hK4TE5lecoyKu8KB1w1+cpVq9v7bk1UG4vxg=; b=DykZCpUHhGhzyTT+QJFku+Xso
        UZQpymRoZiWF35iob4ZTzlzS2+oGh1hlRBwoxwROW7k0x31oQx+wWEUYILGEsfJcV0JTL+raaTf0n
        56irmD+Z/6CzMBqj28UVLsZ93ulrcybiqvR90hG9sQViu+pZ15qP2OfXQjIszS9sX+xhRUCdrMufl
        ATvq9mFPmRwDNWkC3rMNrMzEMn8Qw3msI9pciEh40UpqGey/U4PKswr6yE+icGxUije9eOi9gNKQU
        cWx21WHITrSp5mmI41nC5giOgtaf+B3gBs7m8W3cJSpjHr2OWAHycAt01JAtv/SfWpVOiHE64Dn2/
        +Ozpb5cIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhtUk-0003Vd-5Y; Tue, 24 Jul 2018 09:20:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A686520275F47; Tue, 24 Jul 2018 11:20:36 +0200 (CEST)
Date:   Tue, 24 Jul 2018 11:20:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, mingo@redhat.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, aryabinin@virtuozzo.com,
        boqun.feng@gmail.com, catalin.marinas@arm.com, dvyukov@google.com,
        glider@google.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        parri.andrea@gmail.com, peter@hurleysoftware.com,
        tglx@linutronix.de, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv4 01/12] atomic/tty: Fix up atomic abuse in ldsem
Message-ID: <20180724092036.GN2494@hirez.programming.kicks-ass.net>
References: <20180716113017.3909-1-mark.rutland@arm.com>
 <20180716113017.3909-2-mark.rutland@arm.com>
 <20180724071518.GA7300@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724071518.GA7300@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 09:15:18AM +0200, Ingo Molnar wrote:
> 
> * Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > Mark found ldsem_cmpxchg() needed an (atomic_long_t *) cast to keep
> > working after making the atomic_long interface type safe.
> > 
> > Needing casts is bad form, which made me look at the code. There are no
> > ld_semaphore::count users outside of these functions so there is no
> > reason why it can not be an atomic_long_t in the first place, obviating
> > the need for this cast.
> > 
> > That also ensures the loads use atomic_long_read(), which implies (at
> > least) READ_ONCE() in order to guarantee single-copy-atomic loads.
> > 
> > When using atomic_long_try_cmpxchg() the ldsem_cmpxchg() wrapper gets
> > very thin (the only difference is not changing *old on success, which
> > most callers don't seem to care about).
> > 
> > So rework the whole thing to use atomic_long_t and its accessors
> > directly.
> > 
> > While there, fixup all the horrible comment styles.
> > 
> > Cc: Peter Hurley <peter@hurleysoftware.com>
> > Acked-by: Will Deacon <will.deacon@arm.com>
> > Reported-by: Mark Rutland <mark.rutland@arm.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > ---
> >  drivers/tty/tty_ldsem.c   | 82 ++++++++++++++++++++---------------------------
> >  include/linux/tty_ldisc.h |  4 +--
> >  2 files changed, 37 insertions(+), 49 deletions(-)
> > 
> > Note: Greg has queued this via the in the tty tree for v4.19, which can be seen at: 
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?h=tty-next&id=5fd691afdf929061c391d897fa627822c3b2fd5a
> 
> Can this patch be skipped, or do the others depend on it?

IIRC it depends on it, without this patch you get build issues due to
atomic_long_cmpxchg() getting picky about it's arguments (type safety
improved).


