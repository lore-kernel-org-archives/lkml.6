Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061E9C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0B02088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tshe+mGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0B02088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388493AbeGYDpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 23:45:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38658 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbeGYDo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 23:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8dGJWau36iCXUQ7lDC4B9t2Eh88n0QzGzwYRcMpDH7A=; b=Tshe+mGU3b21tWzLyfWp0CPvI
        GSpCYOYYPdQgpT2XGD2l9j0vX/yVfcOwIwSWodiDv9OCMOu9D9/+Ia3qN52unYPubrimN+T7fUTTB
        BJMUoAJGq72zu184F+mNlv11LwlX08IESGia0lG03ogB1DfMRgssmUEFjiGjNVV3jn0fCiLyKUa5I
        +S8nuHx24POPNegBX6H4Z1a1s+WYRlAk2ELVA4f3s7FDocNUuCHd/wF3o/SKrpKLtfwolnmCQ05Rs
        oSeFgSTB571jTiY5afG4AQtgWty1IuSRwnO0BW4c/zU782XVAvSYU7hGNsw/xmSUB0aEwOFvKjwhH
        OAR7riZzQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fi9eG-00044T-TF; Wed, 25 Jul 2018 02:35:32 +0000
Date:   Tue, 24 Jul 2018 19:35:32 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Tino Lehnig <tino.lehnig@contabo.de>, ngupta@vflare.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Zram writeback feature unstable with heavy swap utilization -
 BUG: Bad page state in process...
Message-ID: <20180725023532.GB16271@bombadil.infradead.org>
References: <0516ae2d-b0fd-92c5-aa92-112ba7bd32fc@contabo.de>
 <20180724010342.GA195675@rodete-desktop-imager.corp.google.com>
 <d4f4b5a1-9e31-375d-0599-b6d8b0ebc9df@contabo.de>
 <20180725013250.GA66792@rodete-desktop-imager.corp.google.com>
 <20180725015502.GA16271@bombadil.infradead.org>
 <20180725021657.GA87819@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725021657.GA87819@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 11:16:57AM +0900, Minchan Kim wrote:
> On Tue, Jul 24, 2018 at 06:55:02PM -0700, Matthew Wilcox wrote:
> > On Wed, Jul 25, 2018 at 10:32:50AM +0900, Minchan Kim wrote:
> > > Hi Tino,
> > > 
> > > On Tue, Jul 24, 2018 at 09:30:34AM +0200, Tino Lehnig wrote:
> > > > Hi,
> > > > 
> > > > The first build I used was from the master branch of the mainline kernel,
> > > > somewhere between rc5 and rc6. I have just reproduced the bug with 4.17.9
> > > > and 4.18-rc6. Kernel messages below.
> > > > 
> > > > The bug does not appear on 4.14.57. I can test more versions if it helps.
> > > 
> > > Could you try 4.15?
> > > 
> > > I think it's a regression of struct page field reordring and it started from
> > > v4.16. 
> > > 
> > > page->units for zsmalloc is used as offset of first object on the zspage,
> > > However, below patch unified it with page->_refcount.
> > 
> > No it didn't.  It's in a union with _mapcount, which is where it was before
> > my patches.
> > 
> > It's entiely possible that my patches caused this, but the explanation
> > you're offering is wrong.
> 
> Before your patch, _mapcount and _refcount is separated space so we can use
> _mapcount for page->units for non-mapped pages because units is unified with
> _mapcount. However, with your patch, now units is unified with _refcount.

No.  That's completely untrue.

        union {         /* This union is 4 bytes in size. */
                atomic_t _mapcount;
                unsigned int page_type;
                unsigned int active;            /* SLAB */
                int units;                      /* SLOB */
        };

        atomic_t _refcount;

There is NOTHING in a union with _refcount.

