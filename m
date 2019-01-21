Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEA4C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB932084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i97PveTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfAUI2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:28:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45568 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbfAUI2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fCoGQM1JMNeKC9RxqPi2EysR5pQSJP0jB0mOgBL7qSE=; b=i97PveTH70c7385c1ATzPG7EL
        FkGVX1vaixpcDXhFLfAP13hdHJ5BB5UmaiOYJSk2nx8OIAf8dWiJ/SsxwTlgW9IFvV/v9WwLg2lJ4
        lc81GKb/BzV/j7JAr02Y4fytwW5dmEOo5kbior1QQvlQoNq5wysuSXCaHC0nuCvx0aVUt3EnWiReJ
        cnl3s3AKw+lfA3ecvonJ55aSyy+pDAKca1HPpvcRvp5BMZWd60qEXIQiDc/njqDstHv+XVNjrTsDz
        KQKbqZ8bXAt6b+84aq3p/s4cB+3nic+oEEfsivLCif4e9SRw0Kx9psmwHXG1TcdznTHjt+1d45tk5
        nFUFYhiQA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glUwZ-0003c6-8c; Mon, 21 Jan 2019 08:28:31 +0000
Date:   Mon, 21 Jan 2019 00:28:30 -0800
From:   "hch@infradead.org" <hch@infradead.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>
Subject: Re: [RFC] virtio_ring: check dma_mem for xen_domain
Message-ID: <20190121082830.GC12420@infradead.org>
References: <20190121050056.14325-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121050056.14325-1-peng.fan@nxp.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 04:51:57AM +0000, Peng Fan wrote:
> on i.MX8QM, M4_1 is communicating with DomU using rpmsg with a fixed
> address as the dma mem buffer which is predefined.
> 
> Without this patch, the flow is:
> vring_map_one_sg -> vring_use_dma_api
>                  -> dma_map_page
> 		       -> __swiotlb_map_page
> 		                ->swiotlb_map_page
> 				->__dma_map_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
> However we are using per device dma area for rpmsg, phys_to_virt
> could not return a correct virtual address for virtual address in
> vmalloc area. Then kernel panic.

And that is the right thing to do.  You must not call dma_map_* on
memory that was allocated from dma_alloc_*.

We actually have another thread which appears to be for this same issue.
