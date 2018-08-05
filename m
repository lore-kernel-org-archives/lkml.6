Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B2DC46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 07:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3647E217BB
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 07:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lZeolvhp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3647E217BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbeHEJdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 05:33:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52330 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbeHEJdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 05:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cNw/bKY0gGFoxKOa/lesQrQ8CdWQZhAvmvIVzpFNoJE=; b=lZeolvhpRJCRag7GhKX0/KIRA
        725688s0WCA0Q+YLeHf0KfZJO2ukLODxIW7yUIFvylwjrPB/2ejJPunNY0YihVdUIf12CwuaVVagU
        yyEFpxf0nCE4BeLq0c7J35VC+4YVj4A8TxZ+ZqWFnxWChQd9yI9Fx3PViGw1UW6pLXRksQW1WNBkW
        FkopJHlukJfaJsVgzr8W0vIshbHjGMCLGtBirjbbWFooduo5aqKwNkeHUJlcNHOvvkpRqB1GppF1J
        humDjniMIGoIrxe/tUfQYt9GlDWuLVufz+MPkGiePLdjzM/owUM7pVAs5cjadgJqJ4Nz6/lUt2baH
        Z8NyKe8ig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmDTn-0007Yn-1y; Sun, 05 Aug 2018 07:29:31 +0000
Date:   Sun, 5 Aug 2018 00:29:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, mpe@ellerman.id.au, linuxram@us.ibm.com,
        haren@linux.vnet.ibm.com, paulus@samba.org,
        srikar@linux.vnet.ibm.com, robin.murphy@arm.com,
        jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180805072930.GB23288@infradead.org>
References: <20180802200646-mutt-send-email-mst@kernel.org>
 <e9beb6bba5a7d05741e27e85b24a3b23ba7c2762.camel@kernel.crashing.org>
 <20180802225738-mutt-send-email-mst@kernel.org>
 <de4888b6457e220776e16a9c8958ff0886ffc66c.camel@kernel.crashing.org>
 <20180803070507.GA1344@infradead.org>
 <eb1750e90e4bd45da297fa6f78f8ef93671b7c2f.camel@kernel.crashing.org>
 <20180803160246.GA13794@infradead.org>
 <22310f58605169fe9de83abf78b59f593ff7fbb7.camel@kernel.crashing.org>
 <20180804082120.GB4421@infradead.org>
 <a3ec0a454928e880dabc3782ea906e318634abf9.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3ec0a454928e880dabc3782ea906e318634abf9.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 05, 2018 at 11:10:15AM +1000, Benjamin Herrenschmidt wrote:
>  - One you have rejected, which is to have a way for "no-iommu" virtio
> (which still doesn't use an iommu on the qemu side and doesn't need
> to), to be forced to use some custom DMA ops on the VM side.
> 
>  - One, which sadly has more overhead and will require modifying more
> pieces of the puzzle, which is to make qemu uses an emulated iommu.
> Once we make qemu do that, we can then layer swiotlb on top of the
> emulated iommu on the guest side, and pass that as dma_ops to virtio.

Or number three:  have a a virtio feature bit that tells the VM
to use whatever dma ops the platform thinks are appropinquate for
the bus it pretends to be on.  Then set a dma-range that is limited
to your secure memory range (if you really need it to be runtime
enabled only after a device reset that rescans) and use the normal
dma mapping code to bounce buffer.
