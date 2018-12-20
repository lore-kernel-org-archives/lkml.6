Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8437AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59081218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iVTpVsWN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389257AbeLTSdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:33:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49996 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730556AbeLTSdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:33:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zWmImtXqeGkHvkoyDwKHxzBwzs1ZAXYh07e9ywdlueU=; b=iVTpVsWNGKhInzhT4FZQZfSxM
        r8e8WfaFO9H2N5Qu+9zsmvgvsKCzPRuzJR19wWQmV8jUgzVyYTYb/b+VEklSZdUj/lhq+j8J4iDkd
        jzvG2vmovGtxgZMPq2ArT1O6o1HUipsbNJrPHcL1fTk9m3TLWWgx8f9TfdMMPf4Hnaij+PplHSX8Z
        HvZ/2EbOZrkPsAw11IuMbQ8zlOtrHF5bcnOLBv7SPzDLyeOOoqkm1WQWUhPcVgUldipKFNWMXCCBZ
        BV3A67K/16dhdiIfHvyXmZ2RCMymyoRoCgj8cHDLGM26EeuWyR9DeNzd1vX2G9L1A3HazlaQlYQ1H
        nBPnrWPRg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ga38C-0005OU-2z; Thu, 20 Dec 2018 18:33:12 +0000
Date:   Thu, 20 Dec 2018 10:33:11 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Subject: Re: [PATCH] drm/xen-front: Make shmem backed display buffer coherent
Message-ID: <20181220183311.GA30801@infradead.org>
References: <20181127103252.20994-1-andr2000@gmail.com>
 <17640791-5306-f7e4-8588-dd39c14e975b@tronnes.org>
 <20181220153646.GA22997@infradead.org>
 <f2cfadc7-2e0b-b63d-d094-d5339b0c85fe@gmail.com>
 <20181220173950.GA19641@infradead.org>
 <CAKMK7uF8hmO=z4jy+1b1z5ELLWpjcZpqmLoRiP2BJvwnNpOFeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uF8hmO=z4jy+1b1z5ELLWpjcZpqmLoRiP2BJvwnNpOFeg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 07:29:37PM +0100, Daniel Vetter wrote:
> What we most definitely not want to end up with though is actually
> streaming dma, because with that all the zero copy buffer sharing
> tricks become pointless. There's pretty epic amounts of hacks to work
> around this, I have no idea what's supposed to give here.

Err, with streaming DMA buffer sharing is trivial.  The coherent DMA
allocator is what causes all kinds of horrible hacks that can't actually
work on various platforms.
