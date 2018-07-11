Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB55EC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CDF20875
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91CDF20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388509AbeGKO3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:29:50 -0400
Received: from nautica.notk.org ([91.121.71.147]:39831 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387949AbeGKO3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:29:50 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id DA655C009; Wed, 11 Jul 2018 16:25:12 +0200 (CEST)
Date:   Wed, 11 Jul 2018 16:24:57 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ron Minnich <rminnich@sandia.gov>
Subject: Re: [V9fs-developer] [PATCH 5/6] 9p: Use a slab for allocating
 requests
Message-ID: <20180711142457.GB9691@nautica>
References: <20180628132629.3148-1-willy@infradead.org>
 <20180628132629.3148-6-willy@infradead.org>
 <20180711133313.GC835@nautica>
 <20180711141256.GC23640@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180711141256.GC23640@bombadil.infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote on Wed, Jul 11, 2018:
> On Wed, Jul 11, 2018 at 03:33:13PM +0200, Dominique Martinet wrote:
> > Well this appears to work but P9_NOTAG being '(u16)(~0)' I'm not too
> > confident with P9_NOTAG + 1. . . it doesn't look like it's overflowing
> > before the cast on my laptop but is that guaranteed?
> 
> By my understanding of n1256.pdf ... this falls under 6.3.1.8 ("Usual
> arithmetic conversions").  We have a u16 and an int.  Therefore this
> rule applies:
> 
>     Otherwise, if the type of the operand with signed integer type can
>     represent all of the values of the type of the operand with unsigned
>     integer type, then the operand with unsigned integer type is converted
>     to the type of the operand with signed integer type.

Thanks for checking, that'll work then.

> > I do not see any call to idr_destroy, is that OK?
> 
> Yes, that's fine.  It used to be (back in 2013) that one had to call
> idr_destroy() in order to free the preallocated idr data structures.
> Now it's a no-op if called on an empty IDR, and I would expect that both
> IDRs are empty at the time that it comes to unloading the module (and if
> they aren't, we probably have bigger problems than a small memory leak).
> Some users like to assert that the IDR is empty; most do not go to that
> extent of defensive programming.

Ok, I agree we're not there yet.

Just comments nitpicks, then :)

-- 
Dominique Martinet
