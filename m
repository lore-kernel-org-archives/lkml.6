Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3F3C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD9C20861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BHPUeQYn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfAWVOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 16:14:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52148 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfAWVOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 16:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=69YYeuYP9YDr0UyuJDxswdUHpYF1gBVAQ/hr0X6Qomo=; b=BHPUeQYnortvcNJ9j9BiMCJ7xr
        cQ2+RX+moIsETd4/4+uHJEGqpTywZCJwEfTrGbm90QrEKhjIJdc/ADWFk0BgEJftxV3J5H2Vs27lm
        yi2ED1nox5GwL7HV0BgDP9vY8Oh2fY3Zw5vTzTehk8JZaIurqcgXpJetWr4HTJQurVOMWyBukzyV8
        aWm/RwGDRHXEreodr8HJhZFH+u2l91Zy1+aa72kuG/sDeYPUJUMYqJstHMIokg3Yt2wVLqHCiaA3f
        AXz6xtgR2cbpUmqCKyUVzv41st18iOUFXKbCHshZa+96Mx3Lp3HR6DBV7aZfwcwRAysDeJk1oTW5Y
        W572QCPA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gmPqX-0003O9-Uv; Wed, 23 Jan 2019 21:14:05 +0000
Date:   Wed, 23 Jan 2019 13:14:05 -0800
From:   "hch@infradead.org" <hch@infradead.org>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Peng Fan <peng.fan@nxp.com>, "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>, luto@kernel.org,
        jgross@suse.com, boris.ostrovsky@oracle.com
Subject: Re: [Xen-devel] [RFC] virtio_ring: check dma_mem for xen_domain
Message-ID: <20190123211405.GA4971@infradead.org>
References: <20190121050056.14325-1-peng.fan@nxp.com>
 <alpine.DEB.2.10.1901221113410.17936@sstabellini-ThinkPad-X260>
 <20190123071232.GA20526@infradead.org>
 <alpine.DEB.2.10.1901230935280.17936@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.10.1901230935280.17936@sstabellini-ThinkPad-X260>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 01:04:33PM -0800, Stefano Stabellini wrote:
> If vring_use_dma_api is actually supposed to return true when
> dma_dev->dma_mem is set, then both Peng's patch and the patch I wrote
> are not fixing the real issue here.
> 
> I don't know enough about remoteproc to know where the problem actually
> lies though.

The problem is the following:

Devices can declare a specific memory region that they want to use when
the driver calls dma_alloc_coherent for the device, this is done using
the shared-dma-pool DT attribute, which comes in two variants that
would be a little to much to explain here.

remoteproc makes use of that because apparently the device can
only communicate using that region.  But it then feeds back memory
obtained with dma_alloc_coherent into the virtio code.  For that
it calls vmalloc_to_page on the dma_alloc_coherent, which is a huge
no-go for the ĐMA API and only worked accidentally on a few platform,
and apparently arm64 just changed a few internals that made it stop
working for remoteproc.

The right answer is to not use the DMA API to allocate memory from
a device-speficic region, but to tie the driver directly into the
DT reserved memory API in a way that allows it to easilt obtain
a struct device for it.

This is orthogonal to another issue, and that is that hardware
virtio devices really always need to use the DMA API, otherwise
we'll bypass such features as the device specific DMA pools,
DMA offsets, cache flushing, etc, etc.
