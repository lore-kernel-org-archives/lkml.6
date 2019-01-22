Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5166CC37124
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C78217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YXUtZdpX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfAVBxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 20:53:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32934 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfAVBxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 20:53:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zg/BQpRdW3PmAtNxOdZYa6iolTk1j8u3rMhIqqmkNI4=; b=YXUtZdpXreDgGXcoIE4iU42Mu
        4AN+f0WXh2Q20nxh0ncVPtPeUr9e5nFDbIYYBhK+rEm2DPrkGcI3n53qXbziiiYH0GG/0ouw7ugYu
        dsZJ/2iHTdRJIwe3ELrnO7bWXIubUTKimZ3wjdqd98fpBLGYOR5LDFbrA34QGXdawH0o/caFOFrPy
        e0l9KYDGi5QzlEIp6y1+SV8EknwqvNsp/5Yf5duX99CTJW1bfZAwwXo5xkFbQsUSdPQ1qp+E7J6JT
        u4aPSj82leO16ZvnWGbOn8uQqP4TN1OIoBbWdzO7CM/6QxwlodduuY9up9lGkH0N369ZloHOFvVDD
        Xbewfcw+Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gllFh-0007dY-BQ
        for linux-kernel@vger.kernel.org; Tue, 22 Jan 2019 01:53:21 +0000
Date:   Mon, 21 Jan 2019 17:53:21 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Subject: Re: Design of xa_alloc
Message-ID: <20190122015321.GA18876@bombadil.infradead.org>
References: <20190117200816.GP6310@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117200816.GP6310@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 12:08:17PM -0800, Matthew Wilcox wrote:
> It would, of course, be possible to make the xa_alloc() API identical
> to idr_alloc().  idr_alloc() has been a phenomenal success with around
> 200 callers in the kernel today.  But it could be improved, and this
> seems like a good time to make the API changes.

> Problem 3 is solved by using xa_insert() instead of xa_alloc().  It does
> return a different errno (-EEXIST) instead of -ENOSPC, but most users
> convert the errno to something else anyway because -ENOSPC is a horrible
> errno to return to userspace.

Writing this down and then thinking about it more makes me think that
this is the right time to change the return code of xa_alloc().  I chose
-ENOSPC to be compatible with idr_alloc(), but bugs like
https://bugzilla.kernel.org/show_bug.cgi?id=202297
show that returning an -ENOSPC error to userspace is just confusing:

: # tc filter add dev ipenc0 parent 2:0 handle ::102 protocol ip prio 1 u32 match ip dst 224.44.44.4/32 flowid 2:102
: RTNETLINK answers: No space left on device
: We have an error talking to the kernel

I'm really tempted to make it return -EEXIST instead of -ENOSPC to match
xa_insert().
