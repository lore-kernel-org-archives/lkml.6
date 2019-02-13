Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E38C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0130222B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YZVh/XcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404345AbfBMQNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:13:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43648 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404331AbfBMQM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:12:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uTRgEeEdhm0wcpIo1IAgXhU8CUSaovZo07Rkj8+fcgg=; b=YZVh/XcBQgbmagSejHOgjmBTx
        B9yKu1TY7uHcFQ2sMFMbZtzUhXg8uzeF4F0QI2HiAHwMsci1IA4Qax07Cy/fpRYJ3o48A1/EzjMeI
        PUE4tofsMHmjdad95EQqv1dZQgU4dYczxBvfOylsVlG0tc6ECQlSemXR1zJyG1akUuPDtaWdum4ru
        x1YiNra9qQs1eYESGG3rHNVavYbgwOSZMjLuTdpAXDg/zJSpoEed2GhxB2LI7Nhnrafq1/ib1UfuN
        hfDO6J8PKFtV0kChsiQw+YCREoZcY/kHoYpjQkmqNL0RIIJ3xsyvx83gpvZDLnPubBb8ewa4Ou3XN
        DHDUUXwpw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtx9e-00020l-MD; Wed, 13 Feb 2019 16:12:58 +0000
Date:   Wed, 13 Feb 2019 08:12:58 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xarray: Document erasing entries during iteration
Message-ID: <20190213161258.GS12668@bombadil.infradead.org>
References: <20190212072958.17373-1-tobin@kernel.org>
 <20190212135129.GL12668@bombadil.infradead.org>
 <20190213144744.ifejzbxrbaltivwc@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213144744.ifejzbxrbaltivwc@master>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 02:47:44PM +0000, Wei Yang wrote:
> On Tue, Feb 12, 2019 at 05:51:29AM -0800, Matthew Wilcox wrote:
> >That is _fine_.  As you know I hope to get rid of the radix tree soon ;-)
> 
> You mean replace radix tree in whole kernel? That would be a big effort.

Already mostly done.

http://git.infradead.org/users/willy/linux-dax.git/shortlog/refs/heads/xarray-conv

The only remaining user of the radix tree in that tree is the IDR.  So
now I'm converting the IDR users over to the XArray as well.


But that isn't what I was talking about.  At the moment, the radix
tree and the XArray use the same data structure.  It has good best-case
performance, but shockingly bad worst-case performance.  So we're looking
at replacing the data structure, which won't require changing any of the
users (maybe the page cache ... that has some pretty intimate knowledge
of exactly how the radix tree works).

> BTW, have we compared the performance difference?

It's in the noise.  Sometimes the XArray does a little better because
the APIs encourage the user to do things in a more efficient way.
Some of the users are improved just because the original author didn't
know about a more efficient way of doing what they wanted to do.


