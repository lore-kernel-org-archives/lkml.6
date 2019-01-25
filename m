Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3435C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48FA218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548443902;
	bh=CkA6N+7hiwe3Ze0vrYUYMz3WhbsnnITc4IzBZ7bnBEY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=HBcsN+WLGohuuHcoESL1/8jNenK+n5hj0S35/lhGNxyVdrtBLdPv5PiS16s1ujnbN
	 MCAnwodSG8m4hxulRwWFzoZ7p4uwMEqYz0ZZ0MX/yF96gws10crmY6e/KmcIe31Clz
	 P1h6HQV+AbaNG7Xy4q96Zg+pyJ7URTuwH5zRnxQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbfAYTSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:18:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:41368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfAYTSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 14:18:20 -0500
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22C252087E;
        Fri, 25 Jan 2019 19:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548443899;
        bh=CkA6N+7hiwe3Ze0vrYUYMz3WhbsnnITc4IzBZ7bnBEY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=HvY7ycY+wD3SORQGb6C5zsiH7qy9c6dK273aTulMPMExn7jqekR+NT8XyFJVahv0C
         OaOF+6qhMA0Yp/YejPTHSKmDSFbGk05Vm+FkRpE1CfrVvesuMpEcfMPNbKVRm4TH5h
         BNZqVEVZR8NhS3abd3tyNGslZ6m27x7Q8wMoGCA0=
Date:   Fri, 25 Jan 2019 11:18:18 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To:     Peng Fan <peng.fan@nxp.com>
cc:     "hch@infradead.org" <hch@infradead.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        Andy Duan <fugang.duan@nxp.com>, bjorn.andersson@linaro.org,
        ohad@wizery.com
Subject: RE: [Xen-devel] [RFC] virtio_ring: check dma_mem for xen_domain
In-Reply-To: <AM0PR04MB4481F3986CFB6D1EF26FA135889B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
Message-ID: <alpine.DEB.2.10.1901251116490.17936@sstabellini-ThinkPad-X260>
References: <20190121050056.14325-1-peng.fan@nxp.com> <alpine.DEB.2.10.1901221113410.17936@sstabellini-ThinkPad-X260> <20190123071232.GA20526@infradead.org> <alpine.DEB.2.10.1901230935280.17936@sstabellini-ThinkPad-X260> <20190123211405.GA4971@infradead.org>
 <AM0PR04MB4481F3986CFB6D1EF26FA135889B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-143402054-1548443899=:17936"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-143402054-1548443899=:17936
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 25 Jan 2019, Peng Fan wrote:
> > On Wed, Jan 23, 2019 at 01:04:33PM -0800, Stefano Stabellini wrote:
> > > If vring_use_dma_api is actually supposed to return true when
> > > dma_dev->dma_mem is set, then both Peng's patch and the patch I wrote
> > > are not fixing the real issue here.
> > >
> > > I don't know enough about remoteproc to know where the problem
> > > actually lies though.
> > 
> > The problem is the following:
> > 
> > Devices can declare a specific memory region that they want to use when the
> > driver calls dma_alloc_coherent for the device, this is done using the
> > shared-dma-pool DT attribute, which comes in two variants that would be a
> > little to much to explain here.
> > 
> > remoteproc makes use of that because apparently the device can only
> > communicate using that region.  But it then feeds back memory obtained
> > with dma_alloc_coherent into the virtio code.  For that it calls
> > vmalloc_to_page on the dma_alloc_coherent, which is a huge no-go for the
> > ĐMA API and only worked accidentally on a few platform, and apparently
> > arm64 just changed a few internals that made it stop working for remoteproc.
> > 
> > The right answer is to not use the DMA API to allocate memory from a
> > device-speficic region, but to tie the driver directly into the DT reserved
> > memory API in a way that allows it to easilt obtain a struct device for it.
> 
> Just have a question, 
> 
> Since vmalloc_to_page is ok for cma area, no need to take cma and per device
> cma into consideration right? 
> 
> we only need to implement a piece code to handle per device specific region
> using RESERVEDMEM_OF_DECLARE, just like:
> RESERVEDMEM_OF_DECLARE(rpmsg-dma, "rpmsg-dma-pool", 
> rmem_rpmsg_dma_setup);
> And implement the device_init call back and build a map between page and phys.
> Then in rpmsg driver, scatter list could use page structure, no need vmalloc_to_page
> for per device dma.
> 
> Is this the right way?

I CC'ed the rpmsg maintainers, you want to keep them in the loop on
this.
--8323329-143402054-1548443899=:17936--
