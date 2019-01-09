Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DCEC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6EE21841
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pRDLhDvj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfAIQuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:50:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfAIQuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ETngWk8bFl869vpKnbrNqNk9X0Z5yXpd3HneLST4RvU=; b=pRDLhDvjcileXGVBKYB8uTKxe
        IxXzRpOmIdUlW1XPp6moJHJkf5vC3Scjg7Z+4ppbZt2375YW/Sc0T9qUYjD53zF3Jx6DByLgQC4aP
        YfJeOSXUGGzH6m9acPZJPb0ZnZcQcvHiSybmqfKpYBXy4XeQRd/3lwpnKpjhaRuCzfxU70tq63oS9
        hP4ZUq1fXFPp7Q/PpTl9Kgrc2BT3MkUTnlf1LpKxvmMzInjgY/3P1dinGCNsbXw4SNsn+YFqhBPdT
        v+yW0msrOWySwVv2SoC2N9Y9bFCJtaRGWTcbluIDGs6UoNQX3Iy0QQHkStnJJD280weJc3npLSjHv
        Ex/xKbbwQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghH3R-0003Xh-G0; Wed, 09 Jan 2019 16:50:09 +0000
Date:   Wed, 9 Jan 2019 08:50:09 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Joe Perches <joe@perches.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 03/15] mm/vmalloc: introduce new vrealloc() call and
 its subsidiary reach analog
Message-ID: <20190109165009.GM6310@bombadil.infradead.org>
References: <20190109164025.24554-1-rpenyaev@suse.de>
 <20190109164025.24554-4-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109164025.24554-4-rpenyaev@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 05:40:13PM +0100, Roman Penyaev wrote:
> Basically vrealloc() repeats glibc realloc() with only one big difference:
> old area is not freed, i.e. caller is responsible for calling vfree() in
> case of successfull reallocation.

Ouch.  Don't call it the same thing when you're providing such different
semantics.  I agree with you that the new semantics are useful ones,
I just want it called something else.  Maybe vcopy()?  vclone()?

> + *	Do not forget to call vfree() passing old address.  But careful,
> + *	calling vfree() from interrupt will cause vfree_deferred() call,
> + *	which in its turn uses freed address as a temporal pointer for a

"temporary", not temporal.

> + *	llist element, i.e. memory will be corrupted.
