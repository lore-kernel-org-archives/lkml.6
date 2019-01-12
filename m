Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BE4C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC6A2086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IV8FAVV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfALSbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 13:31:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55532 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfALSby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 13:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PuUKVplxMywk83C+65L18YzmG9i8eJRR6aiIcOBhP2M=; b=IV8FAVV/OKtagL8q+V4Tzo7P0
        xkSoj+L28bSIdKNCJchrgIEdwbAKlz18ZXNqLjRj+ZKpEm1l+6b0/CIap849SdAFzERylSz6O9628
        4ELa3Aza3fNUdDha4B59rCpsGWMKzHbomjncmKIZhNSUZ5ZcnrgMboNYYvHro4FR8ug0Uv2txxZUD
        2R/ktRPz11hn9IHR3qLeNdI9emffEvWO4EbxpunGKzP58Sav2bACsClUBkfZbTlg87LYTcNSvlqwu
        FupDqs+HQ0FezIHaKt9nAxc5K5lRoUgnONxbGSyaJZXwYZoVvfM1m0oEfgxXd2sOoqSLjZ72waV7T
        sEvtiVpIQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giO4X-0002Sl-Vh; Sat, 12 Jan 2019 18:31:53 +0000
Date:   Sat, 12 Jan 2019 10:31:53 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] remove dma_zalloc_coherent
Message-ID: <20190112183153.GA4192@infradead.org>
References: <20190112181355.GA31454@infradead.org>
 <CAHk-=wiYxY9H-XDgawJd+Y4AM4qtK=7RQZ_GhswcUSYWw=eckA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiYxY9H-XDgawJd+Y4AM4qtK=7RQZ_GhswcUSYWw=eckA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 10:27:58AM -0800, Linus Torvalds wrote:
> So I'm still debating this myself, which is why I haven't reacted.
> 
> The reason I'm not entirely sure this makes sense is that not every
> user actually mmaps things into user space.

While that is the security reason for it, we also had quite a few
drivers just plain relying on the fact and breaking on architectures
where it didn't work.

> I'd be happier if there at least was an interface to specify "yes, I
> want zeroing". But there isn't. You did not, for example, just make
> __GFP_ZERO work. No. You just said "GFP_ZERO hasn't worked reliably,
> so we had that other interface, and now we're doing it
> unconditionally, so we can remove the other interface".
> 
> This all *despite* the fact that as far as I can tell, 95% of the
> users don't actually need or care about zeroing and don't really want
> it.

Many users don't need it for security reasons, but given that x86
and arm have dont it forever various drivers started relying on the
behavior.  That combined with the fact that DMA coherent allocation
are a slow path interface it really doesn't make much sense to
micro-optimize it and potentially break users.  If we have a user
that really cares about not zeroing we can just offer a
DMA_ATTR_SKIP_ZEROING flag for dma_alloc_attrs and switch the user
that that cares to it.  But I don't really think it is needed.
