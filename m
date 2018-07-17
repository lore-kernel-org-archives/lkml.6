Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790B6ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A57F20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RB1fUSUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A57F20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbeGQNU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:20:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43394 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731196AbeGQNU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kJU4mzvFgSyDMH0hHFRGGTEcAb8pljtaJg5m9yLMyMA=; b=RB1fUSUUgSA85D/CLNqdD7CwC
        mLZtofW/xI5hlv3i446QD6KaXqFBjQwYMFgRWFAsmDq2pK0z/4EwZkO/5Iy0JtOiy/8tjdVctcYpU
        dTnjNEcoDTg0YB4ygFHZqfV/vThJGed4idV29zzfhMWJ+0+PhfxBiPRoHG2UJhKcFz1M/I54iWEn3
        ZPWJWuJ9ASmsMfBGkhZDPuzckdbdBqES8AQ5WOGXX8Tl/cUavCswvuFbeDo7Y6xwLlMeCR5DCN0aU
        cO8I0BLeoYPQwQKwgdHZJKFrltvEsbIL0KCQnfDaUBy3b8CqSVUMlcs28OHdzesoYeKv3n7N6w9Ms
        SzUsZOoIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffPOs-0006Qr-V7; Tue, 17 Jul 2018 12:48:18 +0000
Date:   Tue, 17 Jul 2018 05:48:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, okaya@codeaurora.org,
        chenhc@lemote.com, Sergey.Semin@t-platforms.ru,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/2] mips: mm: Discard ioremap_uncached_accelerated()
 method
Message-ID: <20180717124818.GC22099@infradead.org>
References: <20180709135713.8083-1-fancer.lancer@gmail.com>
 <20180709135713.8083-2-fancer.lancer@gmail.com>
 <20180711065631.GA21948@infradead.org>
 <20180711135210.GA18730@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711135210.GA18730@mobilestation>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 04:52:10PM +0300, Serge Semin wrote:
> Hello Christoph,
> 
> On Tue, Jul 10, 2018 at 11:56:31PM -0700, Christoph Hellwig <hch@infradead.org> wrote:
> > > + * This is a MIPS specific ioremap variant. ioremap_cacheable_cow
> > > + * requests a cachable mapping with CWB attribute enabled.
> > >   */
> > >  #define ioremap_cacheable_cow(offset, size)				\
> > >  	__ioremap_mode((offset), (size), _CACHE_CACHABLE_COW)
> > 
> > This isn't actually used anywhere in the kernel tree.  Please remove it
> > as well.
> 
> I don't really know whether it is necessary at this point. We discarded the 
> ioremap_uncached_accelerated() method, since the obvious alternative is now
> available: ioremap_wc(). While ioremap_cacheable_cow() hasn't got one.
> So if it was up to me, I'd leave it here. Anyway if the subsystem maintainers
> think otherwise, I won't refuse to submit a patch with this method removal.

The function is entirely unused in the kernel tree, please remove it.
