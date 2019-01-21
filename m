Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E78C37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B9220861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SyFvu6eT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfAUV3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 16:29:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbfAUV3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 16:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9iIaPQrmUoxImEoqMmApMU/TQ6QplGJaZRBlEZeaw1w=; b=SyFvu6eTFI7hrB2JROBDfean3
        /qfWXZFG/pQJrOObQr8Mf4HsLPMOqO26YjxB0kjWE+Nw4u2EwC/oqZU7HvtLjcNmXVFsGSqu70c2q
        HGDDdLAORY80a5uz9TimVUYwWtkyU4hoBRG0SI9J0DiC78p1P49KZMZvLGix7BcDwYoNQhxQR+2qP
        Q9oGTGwXbNiFSJIAoGjrvclcGkrODPIObiBKgy40Fgr3nBhKXGd1rVooJNtfG/hLcawW+911JcVWV
        dBHxFJxKEtKP3DsZNEe5r94uGKGFL1fF5XiBPhz28dy1pJR+gYa9yt359BIV/dd3twYqZEnrsmJU8
        cLw4yoyDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glh8d-0007Si-I2; Mon, 21 Jan 2019 21:29:47 +0000
Date:   Mon, 21 Jan 2019 13:29:47 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Liam Mark <lmark@codeaurora.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Laura Abbott <labbott@redhat.com>, sumit.semwal@linaro.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        afd@ti.com, john.stultz@linaro.org
Subject: Re: [PATCH 3/4] dma-buf: add support for mapping with dma mapping
 attributes
Message-ID: <20190121212947.GA28620@infradead.org>
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org>
 <1547836667-13695-4-git-send-email-lmark@codeaurora.org>
 <20190119102527.GA17723@infradead.org>
 <7ae73c39-9049-bcf6-775f-b0817ba0ec5f@redhat.com>
 <20190121083046.GD12420@infradead.org>
 <alpine.DEB.2.10.1901211142560.9631@lmark-linux.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1901211142560.9631@lmark-linux.qualcomm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 11:44:10AM -0800, Liam Mark wrote:
> The main use case is for allowing clients to pass in 
> DMA_ATTR_SKIP_CPU_SYNC in order to skip the default cache maintenance 
> which happens in dma_buf_map_attachment and dma_buf_unmap_attachment. In 
> ION the buffers aren't usually accessed from the CPU so this allows 
> clients to often avoid doing unnecessary cache maintenance.

This can't work.  The cpu can still easily speculate into this area.
Moreover in general these operations should be cheap if the addresses
aren't cached.
