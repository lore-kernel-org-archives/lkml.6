Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72A3C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EA7218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548277477;
	bh=4XZm6kkJrkFGkeMIw0vN9Jlw6P6+8wJJHw9UXxIfz+o=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=MNxivvRuqlN80XU55IvEDgt7w1Vpot2hw1lf0toeC9ZHs2582uLHHf2bGNwNe0L9m
	 Xkxrz24Lg4niE94s+13Oy3fMyy07grzbAb/Douaw93RQTm0eTPl0zAv3EyCKUIOhK0
	 dwH9OuJvFUSqCIPuXvqaxWaMZt182vNeeHa+nifs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfAWVEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 16:04:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfAWVEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 16:04:35 -0500
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1968921855;
        Wed, 23 Jan 2019 21:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548277474;
        bh=4XZm6kkJrkFGkeMIw0vN9Jlw6P6+8wJJHw9UXxIfz+o=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=yenVbHLaOJrzgchso7V+75DEY/6ECu3m2AZzJ1r+wwp1Wx2mtdGonLXdZyGvUbbVS
         AUySSKM+cBM6BQn4eEPZ3yhxgTzy+CUOWi1eFMYSc6HavkclPh5ypCdOgHmo9Q0swN
         iSJk8PcvSel2k787UV96vLnXZVzvmgckXmU59TS8=
Date:   Wed, 23 Jan 2019 13:04:33 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To:     "hch@infradead.org" <hch@infradead.org>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Peng Fan <peng.fan@nxp.com>, "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>, luto@kernel.org,
        jgross@suse.com, boris.ostrovsky@oracle.com
Subject: Re: [Xen-devel] [RFC] virtio_ring: check dma_mem for xen_domain
In-Reply-To: <20190123071232.GA20526@infradead.org>
Message-ID: <alpine.DEB.2.10.1901230935280.17936@sstabellini-ThinkPad-X260>
References: <20190121050056.14325-1-peng.fan@nxp.com> <alpine.DEB.2.10.1901221113410.17936@sstabellini-ThinkPad-X260> <20190123071232.GA20526@infradead.org>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019, hch@infradead.org wrote:
> On Tue, Jan 22, 2019 at 11:59:31AM -0800, Stefano Stabellini wrote:
> > >  	if (!virtio_has_iommu_quirk(vdev))
> > >  		return true;
> > >  
> > > @@ -260,7 +262,7 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> > >  	 * the DMA API if we're a Xen guest, which at least allows
> > >  	 * all of the sensible Xen configurations to work correctly.
> > >  	 */
> > > -	if (xen_domain())
> > > +	if (xen_domain() && !dma_dev->dma_mem)
> > >  		return true;
> > >  
> > >  	return false;
> > 
> > I can see you spotted a real issue, but this is not the right fix. We
> > just need something a bit more flexible than xen_domain(): there are
> > many kinds of Xen domains on different architectures, we basically want
> > to enable this (return true from vring_use_dma_api) only when the xen
> > swiotlb is meant to be used. Does the appended patch fix the issue you
> > have?
> 
> The problem generally is the other way around - if dma_dev->dma_mem
> is set the device decription in the device tree explicitly requires
> using this memory, so we must _always_ use the DMA API.
> 
> The problem is just that that rproc driver absuses the DMA API
> in horrible ways.

If vring_use_dma_api is actually supposed to return true when
dma_dev->dma_mem is set, then both Peng's patch and the patch I wrote
are not fixing the real issue here.

I don't know enough about remoteproc to know where the problem actually
lies though.
