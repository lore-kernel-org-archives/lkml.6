Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33552C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D5A21A0D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lyhqio/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D5A21A0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388620AbeHGIo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 04:44:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbeHGIo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 04:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OjdUrWSwu4kd4mbYjfRpPvSvS1GFlAjg9ccQhQRku2k=; b=lyhqio/Hl02oPna//bnrfFKBO
        ORFUiapWzw/puce1McvK3e8gMycTEa1j2jc4yT+LillNjbn89Ta98kmK9rWVeVlwvxcQpM+TZ+YMn
        4mZsYfnPs9U7RmSBTIidMGTl7qe6gEeTq5sKmAMVACGSJemBY/BtvXv/K1cFKT8HYs3vNWByyzz1A
        9Sir+C/SkJr+BjNK6C2GHSIjMJtUtH7w+QsAlMBIPD4B9QbF04vcrc43PmjleKd0XUHDKyEjgGy4O
        fqclGIf4e0GjFIpCnPPNSV+99Yreecoz7TU/tyMXgLgt1EmIMSDNx/Rm/oZzNS9l4EETeg5yBE92F
        VXLS1lJvA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmvXF-0001kC-SQ; Tue, 07 Aug 2018 06:32:01 +0000
Date:   Mon, 6 Aug 2018 23:32:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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
Message-ID: <20180807063201.GB23159@infradead.org>
References: <051fd78e15595b414839fa8f9d445b9f4d7576c6.camel@kernel.crashing.org>
 <20180805031046-mutt-send-email-mst@kernel.org>
 <fd8fee94cf42e436878f179c7895de3a4dab3355.camel@kernel.crashing.org>
 <20180806164106-mutt-send-email-mst@kernel.org>
 <ef6d5d7c7b812bd797a1c3fd6bc7a26d0074020f.camel@kernel.crashing.org>
 <20180806233024-mutt-send-email-mst@kernel.org>
 <0967fc30001323e6e38ed12c8dba8ee3d1aa13f5.camel@kernel.crashing.org>
 <20180807002857-mutt-send-email-mst@kernel.org>
 <93518075238a07e9f011774d89bdc652c083f1ba.camel@kernel.crashing.org>
 <20180807024503-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807024503-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 02:45:25AM +0300, Michael S. Tsirkin wrote:
> > > I think that's where Christoph might have specific ideas about it.
> > 
> > OK well, assuming Christoph can solve the direct case in a way that
> > also work for the virtio !iommu case, we still want some bit of logic
> > somewhere that will "switch" to swiotlb based ops if the DMA mask is
> > limited.
> > 
> > You mentioned an RFC for that ? Do you happen to have a link ?
> 
> No but Christoph did I think.

Do you mean the direct map retpoline mitigation?  It is here:

https://www.spinics.net/lists/netdev/msg495413.html

https://www.spinics.net/lists/netdev/msg495785.html
