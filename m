Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C3DC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE42621A12
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hlC2N5Gw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE42621A12
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388268AbeHGIkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 04:40:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48204 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbeHGIkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 04:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=F4rh7HgXnyQJR3oXwJCjaVNEhZH0MovozoosbP4eIVw=; b=hlC2N5GwLk+Z4nJI8+XGyJk3s
        lkfhMktmcYPHQRQEcNCha/S8njMhvGTH02HKOJNxsJUjL0jGzOUhI8RU5STrq7+k6dqBQc17Zx7Om
        XGPi28W2aZMQsH+oARkUcGlOVjzBtMWdP+aWEEKkTRaN1aDdv3zfmFoPUI3K46w6tpXavVg/gmP1T
        BePqd0mqmbxHhVQGNhYpUkS6qW3UpfLWOT94r6dNveGhwOQKDBtM0WgP7K+HdCNqSJipXRRVC7zHl
        ixLUxnkwIzFjPPRz7DWekwHI3TLQRLYbwBk6jeO7rfVYcKccbAe+z+QKrYYyK+Of5WKTxI0PmkGZT
        wk+TRgmEQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmvSt-0008Ku-KW; Tue, 07 Aug 2018 06:27:31 +0000
Date:   Mon, 6 Aug 2018 23:27:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
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
Message-ID: <20180807062731.GA23159@infradead.org>
References: <20180803220443-mutt-send-email-mst@kernel.org>
 <051fd78e15595b414839fa8f9d445b9f4d7576c6.camel@kernel.crashing.org>
 <20180805031046-mutt-send-email-mst@kernel.org>
 <fd8fee94cf42e436878f179c7895de3a4dab3355.camel@kernel.crashing.org>
 <20180806164106-mutt-send-email-mst@kernel.org>
 <ef6d5d7c7b812bd797a1c3fd6bc7a26d0074020f.camel@kernel.crashing.org>
 <20180806233024-mutt-send-email-mst@kernel.org>
 <0967fc30001323e6e38ed12c8dba8ee3d1aa13f5.camel@kernel.crashing.org>
 <20180807002857-mutt-send-email-mst@kernel.org>
 <93518075238a07e9f011774d89bdc652c083f1ba.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93518075238a07e9f011774d89bdc652c083f1ba.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 08:13:56AM +1000, Benjamin Herrenschmidt wrote:
> It would be indeed ideal if all we had to do was setup some kind of
> bus_dma_mask on all PCI devices and have virtio automagically insert
> swiotlb when necessary.

For 4.20 I plan to remove the swiotlb ops and instead do the bounce
buffering in the common code, including a direct call to the direct
ops to avoid retpoline overhead.  For that you still need a flag
in virtio that instead of blindly working physical addresses it needs
to be treated like a real device in terms of DMA.

And for powerpc to make use of that I need to get the dma series I
posted last week reviewed and included, otherwise powerpc will have
to be excepted (like arm, where rmk didn't like the way the code
was factored, everything else has already been taken care of).

https://lists.linuxfoundation.org/pipermail/iommu/2018-July/028989.html
