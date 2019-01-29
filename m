Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14180C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61E22175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HWpFlsVH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfA2Hko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:40:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfA2Hkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 02:40:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=z+1YMnRd1oSYpHpBKruEe6jjcgdmba0NtCej0IypoBU=; b=HWpFlsVH4k9fZ1Ny44+3legUD
        EPAw5c16JRyQFTBOL050o5VnYWV39bgakbSkEmvpLyz8f80zvu0lOTXqBtf7x+1a9n5gPokVGv+WX
        mDGqwXPTxMBaGf/PmQ10DSv6Vif7lZuDgz5IOUFOp1vpVqKWBG4A3klH+jyMj5OV2CLsF/sfdJEYK
        iubk7/IB6w4prcHMjtMVG4INt0zlGFSr9RIvPvU4k+R4Br30gwhVjtQo3AxFVqHp/UhBfwsje2PrI
        EImjAtbx0R1V8o21mc9Qo1xrypACPXGeG3iwOXryYFM3vu8rD9ymDUKjhTQnta39LyyCc8bdMohxI
        FAOGg9DxA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1goO0g-0007NK-SP; Tue, 29 Jan 2019 07:40:42 +0000
Date:   Mon, 28 Jan 2019 23:40:42 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>, Jiri Kosina <trivial@kernel.org>
Subject: Re: [PATCH trivial] kernel.h: Make container_of_safe type safe
Message-ID: <20190129074042.GA15290@infradead.org>
References: <20190124205451.GA19634@ziepe.ca>
 <20190128134242.GA10951@infradead.org>
 <20190128184417.GM25120@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128184417.GM25120@mellanox.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 06:44:24PM +0000, Jason Gunthorpe wrote:
> On Mon, Jan 28, 2019 at 05:42:42AM -0800, Christoph Hellwig wrote:
> > On Thu, Jan 24, 2019 at 08:55:05PM +0000, Jason Gunthorpe wrote:
> > > The final ternary expression is given void * and type * as arguments, so
> > > the resulting type of the macro ends up being void *.
> > > 
> > > container_of returns a type which maches the argument, this provides type
> > > safety and allows the expression to be immediately used as the target
> > > type.
> > > 
> > > Explicitly cast ERR_CAST() to get the correct type.
> > 
> > I think we should just kill off container_of_safe - it has no user
> > in the tree, is grossly misnamed and not really all that useful to start
> > with.
> 
> I see it open coded from time to time, here someone sent a patch
> open-coding it yesterday (with the same bug even):
> 
> https://patchwork.kernel.org/patch/10783535/
> 
> I noticed it didn't work right because I had a use for it..

And the patch is a good example for an anti-pattern to avoid, I'll
chime in there..
