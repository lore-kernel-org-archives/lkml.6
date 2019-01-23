Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFE2C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DDC21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jxbEv7H6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfAWHMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:12:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfAWHMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jRirieLgRGM56VeJxAWJgEI7+mG7GYr1VreLIKUztis=; b=jxbEv7H6cSLfj3r8Gyo3ZPu6N
        qYvn+ZOuW0zdGGj7p+jdZBVD+Oe1101ue/m12CTnDUtnYZbSCjf3bj18B7xR1bNL1II9bNGg1Q0ui
        K+jTEbFDu/TbG8nPex3RP2INa/WGmBS34GWhk0FWsaFeFgX6CIfovdzgwEp6gsJNMCh4OMyHI5TK+
        QQDoZTXj8ySB91nXJnRhzOYAn5HoZ8FdY0/Cy95+3roClavCwpd/R2vAepIGPJYq7ltUK++MXRp1E
        Dpu/U2JpFXrLmlY/e93JUEUpPQyfXHo8BlvjYTEIYmsp5rAscGG6R8pNe80JZoBWev/modYWMeXL/
        0NrYXL8fg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gmCi8-0005NW-Eq; Wed, 23 Jan 2019 07:12:32 +0000
Date:   Tue, 22 Jan 2019 23:12:32 -0800
From:   "hch@infradead.org" <hch@infradead.org>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Peng Fan <peng.fan@nxp.com>, "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>, luto@kernel.org,
        jgross@suse.com, boris.ostrovsky@oracle.com
Subject: Re: [Xen-devel] [RFC] virtio_ring: check dma_mem for xen_domain
Message-ID: <20190123071232.GA20526@infradead.org>
References: <20190121050056.14325-1-peng.fan@nxp.com>
 <alpine.DEB.2.10.1901221113410.17936@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1901221113410.17936@sstabellini-ThinkPad-X260>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 11:59:31AM -0800, Stefano Stabellini wrote:
> >  	if (!virtio_has_iommu_quirk(vdev))
> >  		return true;
> >  
> > @@ -260,7 +262,7 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> >  	 * the DMA API if we're a Xen guest, which at least allows
> >  	 * all of the sensible Xen configurations to work correctly.
> >  	 */
> > -	if (xen_domain())
> > +	if (xen_domain() && !dma_dev->dma_mem)
> >  		return true;
> >  
> >  	return false;
> 
> I can see you spotted a real issue, but this is not the right fix. We
> just need something a bit more flexible than xen_domain(): there are
> many kinds of Xen domains on different architectures, we basically want
> to enable this (return true from vring_use_dma_api) only when the xen
> swiotlb is meant to be used. Does the appended patch fix the issue you
> have?

The problem generally is the other way around - if dma_dev->dma_mem
is set the device decription in the device tree explicitly requires
using this memory, so we must _always_ use the DMA API.

The problem is just that that rproc driver absuses the DMA API
in horrible ways.
