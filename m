Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B802CFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CCD20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ifd3foQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CCD20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbeG3K76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:59:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57840 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeG3K75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hB9RLO8TwQobN0cDVKm8FjHrhB3t7O6ReqxEdWua+GY=; b=Ifd3foQ7xBZ2JoeFnBbh3y6Kr
        FTBVU5kpP9L2VXsxowoJatP/Xd6hbl42K+bRVTF9SZL0s/K16Z0qcSoJou1pbJ1+sbmt1hhbI7hwY
        inPcviATi6T9KlH4fJfDrXqKq8YhwFWio/0XwqcfcPkVGCsfNvWYShCLd/NXRxICPDqoCZARY7dd2
        csUQSuFA5pHTISyfd4H3iYakBOIFcUCJGOj7XgqjqhsNe/PJq3CJVVhluok0Ovl0rULZ8/bDTFDY/
        EtkGHpkaklz/rjor3FM6mCmyTQCPh6dtwasz6rOwkt/76zaAass30gOhROv+Z90DGi3etle0NZHcA
        fExy+5ygg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fk4R6-0000Mr-0R; Mon, 30 Jul 2018 09:25:52 +0000
Date:   Mon, 30 Jul 2018 02:25:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
        mst@redhat.com, hch@infradead.org, linuxram@us.ibm.com,
        haren@linux.vnet.ibm.com, paulus@samba.org,
        srikar@linux.vnet.ibm.com
Subject: Re: [RFC 2/4] virtio: Override device's DMA OPS with
 virtio_direct_dma_ops selectively
Message-ID: <20180730092551.GB26245@infradead.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180720035941.6844-3-khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720035941.6844-3-khandual@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +const struct dma_map_ops virtio_direct_dma_ops;

This belongs into a header if it is non-static.  If you only
use it in this file anyway please mark it static and avoid a forward
declaration.

> +
>  int virtio_finalize_features(struct virtio_device *dev)
>  {
>  	int ret = dev->config->finalize_features(dev);
> @@ -174,6 +176,9 @@ int virtio_finalize_features(struct virtio_device *dev)
>  	if (ret)
>  		return ret;
>  
> +	if (virtio_has_iommu_quirk(dev))
> +		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);

This needs a big fat comment explaining what is going on here.

Also not new, but I find the existance of virtio_has_iommu_quirk and its
name horribly confusing.  It might be better to open code it here once
only a single caller is left.
