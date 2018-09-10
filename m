Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74D2C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72AD92086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uY0vZ/0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72AD92086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeIJLMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:12:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52470 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbeIJLMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RAbHkhG9Px6mb5lOwRoead8HKOmogAz/S/SMhK2BOvQ=; b=uY0vZ/0eGhgp2Em0vXCgAnJqq
        s5fJbpzBtmxItmjYu/avv+3SFcuKjzvESiXXCG67xCNJDQfRiLy3mxBxAPFAksuaMG8m9WtOrWMIo
        0Y5wKYV/ON4G0KGPFKkH+GwAxdpbBmZ8X31q30aiPfMKlIKsTfT8zPVVRPq7ex5wGc4R4B/NqTVFf
        ExAdOASPssXsp8FlfzqoYpi3DuW1U679Y7OcfrFU+9vh/P9M2T/PyJCqeQGnw0tjgZ7dgFYSAay6r
        5ahQizkC4khmah4L9ScR/b9O20sbSk8ruPTkjzsyxHn6Xbawg7ReqTy86/f/2n0qlALB06P8lstxm
        nHzf1KGag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzFY3-0004MK-7d; Mon, 10 Sep 2018 06:19:47 +0000
Date:   Sun, 9 Sep 2018 23:19:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jiandi An <jiandi@amd.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, mpe@ellerman.id.au, linuxram@us.ibm.com,
        haren@linux.vnet.ibm.com, paulus@samba.org,
        srikar@linux.vnet.ibm.com, robin.murphy@arm.com,
        jean-philippe.brucker@arm.com, marc.zyngier@arm.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, jiandi.an@amd.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180910061947.GA30666@infradead.org>
References: <20180807135505.GA29034@infradead.org>
 <2103ecfe52d23cec03f185d08a87bfad9c9d82b5.camel@kernel.crashing.org>
 <20180808063158.GA2474@infradead.org>
 <4b596883892b5cb5560bef26fcd249e7107173ac.camel@kernel.crashing.org>
 <20180808123036.GA2525@infradead.org>
 <b8b9150a747453c070ad3b0e4c92d2b1b052ad06.camel@kernel.crashing.org>
 <20180808232210-mutt-send-email-mst@kernel.org>
 <98eb367ce322ad84baa31e3c7beffc4a42be8458.camel@kernel.crashing.org>
 <20180809054013.GA20507@infradead.org>
 <f1eeb994-ea13-d0f1-dc55-7c5049e70670@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1eeb994-ea13-d0f1-dc55-7c5049e70670@amd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 07:09:09PM -0500, Jiandi An wrote:
> For virtio device we have to pass in iommu_platform=true flag for
> this to set the VIRTIO_F_IOMMU_PLATFORM flag. But for example
> QEMU has the use of iommu_platform attribute disabled for virtio-gpu
> device.  So would also like to move towards not having to specify
> the VIRTIO_F_IOMMU_PLATFORM flag.

Specifying VIRTIO_F_IOMMU_PLATFORM is the right thing for your 
platform given that you can't directly use physical addresses.
Please fix qemu so that virtio-gpu works with VIRTIO_F_IOMMU_PLATFORM.

Also just as I said for the power folks: you should really work with
the qemu folks that VIRTIO_F_IOMMU_PLATFORM (or whatever we call the
properly documented flag) can be set by default, and no pointless
performance overhead is implied by having a sane and simple
implementation.
