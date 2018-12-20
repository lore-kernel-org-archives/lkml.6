Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86ECC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A85620811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GAuPK3M3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389461AbeLTSiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:38:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50346 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731280AbeLTSiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:38:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=n7kHmUd9NWsVcSQjDie0de8H/6KifCjV/t7SEMIprHM=; b=GAuPK3M3GhPbWSmQD9yxlNrAV
        atVUsYHU1uG8HtVBEt5FIk9fUImoviog1al6vwFl2Ag+CnqsGQFgOQ5X9CwShCeCxffYpKkXQ7HQn
        nUL+zhQ5k7UWXPYlizVd9PtXmgNepfJudD5komJn4qI97s/9qbusrvVilzhpki3Ba7wiCyRpKsgs5
        jpuPZe9cY4zgq1CR3Z7HX/hUA8xd1vIBFB1uiiqslYlccKLBxLnGjfLPBuRvlC21Bnbs96rYyFvd2
        BdwHCrvKHgMHeqNWshdlh9mweE9pn1C0oziMW/MUz8T/vdjyrDXy9ru8ozooyEjyy0LxYXD/Y6RZi
        T0onVamLA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ga3Df-0007D9-KH; Thu, 20 Dec 2018 18:38:51 +0000
Date:   Thu, 20 Dec 2018 10:38:51 -0800
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
Message-ID: <20181220183851.GA27025@infradead.org>
References: <20181127103252.20994-1-andr2000@gmail.com>
 <17640791-5306-f7e4-8588-dd39c14e975b@tronnes.org>
 <20181220153646.GA22997@infradead.org>
 <f2cfadc7-2e0b-b63d-d094-d5339b0c85fe@gmail.com>
 <20181220173950.GA19641@infradead.org>
 <CAKMK7uF8hmO=z4jy+1b1z5ELLWpjcZpqmLoRiP2BJvwnNpOFeg@mail.gmail.com>
 <20181220183311.GA30801@infradead.org>
 <CAKMK7uFxU9Q5u9TxxHqAgFZuQFCFDvxWHDtRLiQf+3hu_4jPcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uFxU9Q5u9TxxHqAgFZuQFCFDvxWHDtRLiQf+3hu_4jPcQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 07:35:15PM +0100, Daniel Vetter wrote:
> > Err, with streaming DMA buffer sharing is trivial.  The coherent DMA
> > allocator is what causes all kinds of horrible hacks that can't actually
> > work on various platforms.
> 
> Hm, I thought the streaming dma api is the one that causes bounce
> buffers and all that fun. If you're unlucky at least.

Yes it may.  But even if that happens everything will actually work,
just slower.  While the dma coherent API is simply broken.

But if you don't want bounce buffering you need to use the dma
noncoherent allocator as proposed here:

	https://lists.linuxfoundation.org/pipermail/iommu/2018-December/031982.html

which combines allocating memory that doesn't need to be bounce
buffered with a sharing scheme that can actually work.
