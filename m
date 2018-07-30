Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F09A13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F6220881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qjVZ7Prj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F6220881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbeG3LEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:04:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34836 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeG3LEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4Mtj6FBl3NXN0/tkjyoe5svduQp58RO6IseEvxhta/E=; b=qjVZ7Prjgd/QjCeQBr5OILh6P
        9JrXFukfEAClm0CGEJKbcO1/K4jLnj9nZBx8Y8ODtY/cNKEkhuZHCGRTbeNd0sL/HPykW+k8kLdCM
        8xBQEiRBfP9SxO6PjOzA+YSwzIs0DjU+IyRw4PwhaAvOMhEWfrwVB0SDIzbkUBaq11JH1mad0Cd6A
        QmGm/9MQLSWyxcDrr1C9g83kug8XG77RBgtULMUnCtFIH/gAfHl2CvmmYtB4n4Vz7438syLY4Vdy8
        UTzTy+Pcf9U8iARbjspPRuTg0YiX+r6Daxq+XEWzgkEWLFYMrWz9IMmS2NGfwO1uSwLj3ckEWRh5R
        XUk8LXAkA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fk4VX-0002fP-8w; Mon, 30 Jul 2018 09:30:27 +0000
Date:   Mon, 30 Jul 2018 02:30:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
        hch@infradead.org, linuxram@us.ibm.com, haren@linux.vnet.ibm.com,
        paulus@samba.org, srikar@linux.vnet.ibm.com
Subject: Re: [RFC 2/4] virtio: Override device's DMA OPS with
 virtio_direct_dma_ops selectively
Message-ID: <20180730093027.GC26245@infradead.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180720035941.6844-3-khandual@linux.vnet.ibm.com>
 <c443ad8c-fb81-302d-edb2-5521831d38da@linux.vnet.ibm.com>
 <20180729001344-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180729001344-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +
> > +	if (xen_domain())
> > +		goto skip_override;
> > +
> > +	if (virtio_has_iommu_quirk(dev))
> > +		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
> > +
> > + skip_override:
> > +
> 
> I prefer normal if scoping as opposed to goto spaghetti pls.
> Better yet move vring_use_dma_api here and use it.
> Less of a chance something will break.

I agree about avoid pointless gotos here, but we can do things
perfectly well without either gotos or a confusing helper here
if we structure it right. E.g.:

	// suitably detailed comment here
	if (!xen_domain() &&
	    !virtio_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM))
		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);

and while we're at it - modifying dma ops for the parent looks very
dangerous.  I don't think we can do that, as it could break iommu
setup interactions.  IFF we set a specific dma map ops it has to be
on the virtio device itself, of which we have full control.
