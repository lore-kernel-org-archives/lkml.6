Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F16EC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59562151B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KIdOzOSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C59562151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbeHIID1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 04:03:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53528 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbeHIID0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 04:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JHuzEj/vmN5K9Oinof0ZJOoO3v2RYE9gL6dUiPJQJvE=; b=KIdOzOSbvSUef1e8zrvEuQrbN
        XwphSm8OOeu3PXa9wx8OYSnF1LH2ILpnz5SzTb+NfSgpxpVI5UVu+Jowi2SIWc+UPDJAcDEqQavQe
        wHxf4h6hjA55p/Hqb3s6rQnJOdaWa7ERst2su8KhCJTS6wVljxE08ibsPmur0S4cTcjT8iRNoyTfW
        dGBngf3SB2rwnG5E85DwfrvLmdSngGJK+po8DrVCFO0QTbB4LwgX17bcm/et5DQ7ZDy25+fHOWsru
        Srp73O15DFWCl5FkhqzaVyWk5rT0J3wKArSretEk2CgzxAB/FCcETMwYsHB7ZR846PHuA0tFgo3gH
        PUcdSQV2Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fndgD-0008Ce-Dy; Thu, 09 Aug 2018 05:40:13 +0000
Date:   Wed, 8 Aug 2018 22:40:13 -0700
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
Message-ID: <20180809054013.GA20507@infradead.org>
References: <20180807062117.GD32709@infradead.org>
 <aa59c7f8556bd4b332394a1dcf2d4a8faf3dc4a2.camel@kernel.crashing.org>
 <20180807135505.GA29034@infradead.org>
 <2103ecfe52d23cec03f185d08a87bfad9c9d82b5.camel@kernel.crashing.org>
 <20180808063158.GA2474@infradead.org>
 <4b596883892b5cb5560bef26fcd249e7107173ac.camel@kernel.crashing.org>
 <20180808123036.GA2525@infradead.org>
 <b8b9150a747453c070ad3b0e4c92d2b1b052ad06.camel@kernel.crashing.org>
 <20180808232210-mutt-send-email-mst@kernel.org>
 <98eb367ce322ad84baa31e3c7beffc4a42be8458.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98eb367ce322ad84baa31e3c7beffc4a42be8458.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 08:13:32AM +1000, Benjamin Herrenschmidt wrote:
> > > -	if (xen_domain())
> > > +	if (xen_domain() || pseries_secure_vm())
> > > 		return true;
> > 
> > I don't think it's pseries specific actually. E.g. I suspect AMD SEV
> > might benefit from the same kind of hack.
> 
> As long as they can provide the same guarantee that the DMA ops are
> completely equivalent between virtio and other PCI devices, at least on
> the same bus, ie, we don't have to go hack special DMA ops.
> 
> I think the latter is really what Christoph wants to avoid for good
> reasons.

Yes.  I also generally want to avoid too much arch specific magic.

FYI, I'm off to a week-long vacation today, don't expect quick replies.
