Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA1113F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FAFC20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lBF9v4+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FAFC20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbeG3LIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:08:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeG3LIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oJ0NUTX86TgKdU19i9RyYhm33mr4nHdA8Q0kxIYlN6E=; b=lBF9v4+bEojlrdIMFsUIndRzG
        2m7L+b72NtFMUxSridq3IdmOxUhFPlnBrDjQXQK7CzpBuGfxci0/injq9ea0yk849FWKgBVrzDpjS
        CbUMYPCrRkR0gnEDGZ5/a9PM49rOTmypzHJvJ7+jeP4oL8g6arWktkjbM47Sju+THnd6XRMtyVXUc
        Wvmio4f06CesPKwMf8qm9fJvzSEyDIh4l00nEsAvhFzziT6b3HhNMvlqaSdPnbMfMuo0njzBSOx76
        SRxucxP6rrv5QIkYIpPco4HtsDN+RiihwArVqal/mebfAehv/6+HaTxXMazwxY8xXulpbTY6d27ja
        tKuA/0dCA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fk4ZC-0003XQ-9Y; Mon, 30 Jul 2018 09:34:14 +0000
Date:   Mon, 30 Jul 2018 02:34:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
        mst@redhat.com, hch@infradead.org, linuxram@us.ibm.com,
        haren@linux.vnet.ibm.com, paulus@samba.org,
        srikar@linux.vnet.ibm.com, robin.murphy@arm.com,
        jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180730093414.GD26245@infradead.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180727095804.GA25592@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727095804.GA25592@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 10:58:05AM +0100, Will Deacon wrote:
> 
> I just wanted to say that this patch series provides a means for us to
> force the coherent DMA ops for legacy virtio devices on arm64, which in turn
> means that we can enable the SMMU with legacy devices in our fastmodel
> emulation platform (which is slowly being upgraded to virtio 1.0) without
> hanging during boot. Patch below.

Yikes, this is a nightmare.  That is exactly where I do not want things
to end up.  We really need to distinguish between legacy virtual crappy
virtio (and that includes v1) that totally ignores the bus it pretends
to be on, and sane virtio (to be defined) that sit on a real (or
properly emulated including iommu and details for dma mapping) bus.

Having a mumble jumble of arch specific undocumented magic as in
the powerpc patch replied to or this arm patch is a complete no-go.

Nacked-by: Christoph Hellwig <hch@lst.de>

for both.
