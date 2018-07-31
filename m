Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4479EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF5420844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZubisQr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF5420844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbeGaTMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 15:12:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50540 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbeGaTMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 15:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o9GptcWU4JkmXqjY1H25x6O+NykVV0mB+ZDq5qkR7M4=; b=ZubisQr8S37aVoRhq2U3gvtfE
        a+cxpXxqbp12o/qeIEsLpdYJxya1GQGJ4zBFdIZBGrmyXca9OnAHiEhpTiA+Iady+Qqkf9M6Aohnf
        kEUcWh6H6UU+1+yIRb4K0abAHXBxYnr3H1/Bw7r1snHNt+2GwsHCBYJl7nIdeRmkxhTxiILLYsWnZ
        5al2yL1tfW23jtVwlIPZA5jp+1r4740mL5hKEP7bpy+WmVo5k9/13N8m+lsGI8Gut5qtzQkZSfOuB
        vgtvgCRJQIRR/K2ZfIHH6zJCvN8NAZ1oC6+cWvVx2hhJp/wgDsG+9MU9j3kLBE6e/yXYodVnjlbLX
        /8PJf5ncw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkYU0-0006EJ-7T; Tue, 31 Jul 2018 17:30:52 +0000
Date:   Tue, 31 Jul 2018 10:30:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
        linuxram@us.ibm.com, haren@linux.vnet.ibm.com, paulus@samba.org,
        srikar@linux.vnet.ibm.com, robin.murphy@arm.com,
        jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180731173052.GA17153@infradead.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180727095804.GA25592@arm.com>
 <20180730093414.GD26245@infradead.org>
 <20180730125100-mutt-send-email-mst@kernel.org>
 <20180730111802.GA9830@infradead.org>
 <20180730155633-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730155633-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 04:26:32PM +0300, Michael S. Tsirkin wrote:
> Real hardware would reuse parts of the interface but by necessity it
> needs to behave slightly differently on some platforms.  However for
> some platforms (such as x86) a PV virtio driver will by luck work with a
> PCI device backend without changes. As these platforms and drivers are
> widely deployed, some people will deploy hardware like that.  Should be
> a non issue as by definition it's transparent to guests.

On some x86.  As soon as you have an iommu or strange PCI root ports
things are going to start breaking apart.

> > And that very much excludes arch-specific (or
> > Xen-specific) overrides.
> 
> We already committed to a xen specific hack but generally I prefer
> devices that describe how they work instead of platforms magically
> guessing, yes.

For legacy reasons I guess we'll have to keep it, but we really need
to avoid adding more junk than this.

> However the question people raise is that DMA API is already full of
> arch-specific tricks the likes of which are outlined in your post linked
> above. How is this one much worse?

None of these warts is visible to the driver, they are all handled in
the architecture (possibly on a per-bus basis).

So for virtio we really need to decide if it has one set of behavior
as specified in the virtio spec, or if it behaves exactly as if it
was on a PCI bus, or in fact probably both as you lined up.  But no
magic arch specific behavior inbetween.
