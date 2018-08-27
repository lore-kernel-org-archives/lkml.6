Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC09CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DACA21735
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XX07MH7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DACA21735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbeH0Kw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 06:52:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51200 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbeH0Kw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 06:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1panxVtOmSsADN3TGm/0dltLyUD+Zvze1riz4cHooIc=; b=XX07MH7f5iOUsYjhQsrXHXpNv
        oelr+wgqF56EOMMOGycjPxGNOru7ZG8DlPDoZi0wCrqGuaPx2dzOOqfenZ5Z+olHyvt7L6sLPBsbW
        JQny3Sgi4SQQefnpq10t28wvSoMW9gtf8+HMqY8r4cZrfsTLploKwhl/6NhuQ9Ruvm+Efc4PJ+FO2
        KFdjrtUJCuST3heJ5aLKJfSI6MoCsnzKfZo/NgE9EUOce5c1deWT7U8mmuwC95+CyiEDd5oCDb6QZ
        36MGPOerNrt4TmL4dBPyQiXdHnoN2wMsYmNwgD2aBjfkvEomCuDvsvvFDpzLEWY1PlnF8UIO/ZFo7
        iCigk0alw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuBca-0002cp-7N; Mon, 27 Aug 2018 07:07:32 +0000
Date:   Mon, 27 Aug 2018 00:07:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tom Murphy <murphyt7@tcd.ie>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Changing the AMD IOMMU API path to work in an atomic
 context which is necessary for any custom drivers using the IOMMU API while
 holding a spinlock.
Message-ID: <20180827070731.GA8588@infradead.org>
References: <1535120929-5693-1-git-send-email-murphyt7@tcd.ie>
 <20180824145328.GA7996@infradead.org>
 <24d3f04a-e6e2-ed8f-e2bd-b38144f33f26@arm.com>
 <CALQxJuuWqiygrGMVjZ0j-AxBZOskoNHfdYoHEwW4Zgigqjf7kg@mail.gmail.com>
 <CALQxJutCDrg5A6Mhqq9Tkyd3siGrdY03LdmfEtV9v5vjYO+ZZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALQxJutCDrg5A6Mhqq9Tkyd3siGrdY03LdmfEtV9v5vjYO+ZZQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 11:55:53PM +0100, Tom Murphy wrote:
> We were going to do this by using the iommu-dma api and replacing all the
> existing calls to the DMA api functions in the amd driver with their
> iommu-dma equivalent like in this driver:
> https://elixir.bootlin.com/linux/latest/source/arch/arm64/mm/dma-mapping.c#L810

FYI, I have a a wip branch to move the arm64 wrappers for both
swiotlb and dma-iommu here:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-maybe-coherent

Maybe you could try to base on top of that.

> To do this we need the map/unmap callbacks to be spinlock-safe.

You probably want to send the patch together with the one(s) making use
of it.
