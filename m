Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367CBC37122
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0760B20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfAVCgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 21:36:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbfAVCgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 21:36:41 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D130681DFE;
        Tue, 22 Jan 2019 02:36:40 +0000 (UTC)
Received: from redhat.com (ovpn-120-244.rdu2.redhat.com [10.10.120.244])
        by smtp.corp.redhat.com (Postfix) with SMTP id C8AC360C23;
        Tue, 22 Jan 2019 02:36:39 +0000 (UTC)
Date:   Mon, 21 Jan 2019 21:36:39 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "hch@infradead.org" <hch@infradead.org>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>
Subject: Re: [RFC] virtio_ring: check dma_mem for xen_domain
Message-ID: <20190121213617-mutt-send-email-mst@kernel.org>
References: <20190121050056.14325-1-peng.fan@nxp.com>
 <20190121082830.GC12420@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121082830.GC12420@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 22 Jan 2019 02:36:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 12:28:30AM -0800, hch@infradead.org wrote:
> On Mon, Jan 21, 2019 at 04:51:57AM +0000, Peng Fan wrote:
> > on i.MX8QM, M4_1 is communicating with DomU using rpmsg with a fixed
> > address as the dma mem buffer which is predefined.
> > 
> > Without this patch, the flow is:
> > vring_map_one_sg -> vring_use_dma_api
> >                  -> dma_map_page
> > 		       -> __swiotlb_map_page
> > 		                ->swiotlb_map_page
> > 				->__dma_map_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
> > However we are using per device dma area for rpmsg, phys_to_virt
> > could not return a correct virtual address for virtual address in
> > vmalloc area. Then kernel panic.
> 
> And that is the right thing to do.  You must not call dma_map_* on
> memory that was allocated from dma_alloc_*.
> 
> We actually have another thread which appears to be for this same issue.

Sorry, which thread do you refer to?

-- 
MST
