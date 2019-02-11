Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2494BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92A1222AA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ly3zG10V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfBKNqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:46:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44946 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfBKNqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:46:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cUsHcFdEBB6jsvyKRWmW8QXKBcmV7u18TEUHf7s4yJI=; b=ly3zG10VIzfr4XYvaWCwYEcK2
        3s99Jc09hx8rc5JRvXL8tCKaOOaZnd+LwrswZiGOFyxZXCILYadSzYOwJf4z+vabopDJPeu/oDfOb
        QDZ8GS2wVaU+lJfvCR6Bw5UcxzAeJFvwIOHWz9nt3gj9pugVYYD10/mmetNQFN+FxoZjqoxGlHfr5
        NUqv+dICov/zKJTC26aHV3lID5M4WjjAR3TQ48Eo3tCSeu2AEF77MrjoxiN3PDjTwwyI6/KQwj/3E
        5V986xMZ6JAq/CNqzNyD3jAb3fJ0DZLYzOs7OPGJemALatfUgLHEZctsz68wZYYUH9Yb2/Il9trVY
        kaNxiNJxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtBuU-0007Qi-3a; Mon, 11 Feb 2019 13:46:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89A0C20D0E3CE; Mon, 11 Feb 2019 14:46:07 +0100 (CET)
Date:   Mon, 11 Feb 2019 14:46:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chintan Pandya <chintan.pandya@oneplus.com>
Cc:     Linux Upstream <linux.upstream@oneplus.com>,
        "hughd@google.com" <hughd@google.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "mawilcox@microsoft.com" <mawilcox@microsoft.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RFC 1/2] page-flags: Make page lock operation atomic
Message-ID: <20190211134607.GA32511@hirez.programming.kicks-ass.net>
References: <20190211125337.16099-1-chintan.pandya@oneplus.com>
 <20190211125337.16099-2-chintan.pandya@oneplus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211125337.16099-2-chintan.pandya@oneplus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 12:53:53PM +0000, Chintan Pandya wrote:
> Currently, page lock operation is non-atomic. This is opening
> some scope for race condition. For ex, if 2 threads are accessing
> same page flags, it may happen that our desired thread's page
> lock bit (PG_locked) might get overwritten by other thread
> leaving page unlocked. This can cause issues later when some
> code expects page to be locked but it is not.
> 
> Make page lock/unlock operation use the atomic version of
> set_bit API. There are other flag set operations which still
> uses non-atomic version of set_bit API. Bit, that might be
> the change for the future.
> 
> Change-Id: I13bdbedc2b198af014d885e1925c93b83ed6660e

That doesn't belong in patches.

> Signed-off-by: Chintan Pandya <chintan.pandya@oneplus.com>

NAK.

This is bound to regress some stuff. Now agreed that using non-atomic
ops is tricky, but many are in places where we 'know' there can't be
concurrency.

If you can show any single one is wrong, we can fix that one, but we're
not going to blanket remove all this just because.
