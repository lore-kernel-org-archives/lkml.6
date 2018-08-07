Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7997EC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2678A21A12
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r7qSOuJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2678A21A12
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733233AbeHGIeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 04:34:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43698 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbeHGIeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 04:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CddoYNQEKiHxwmhVyX8MybXAOC7AoJ/b3h7yx3Pt3ps=; b=r7qSOuJrDzKDx4U+EKvfXUfHp
        aLBXzVFILMAyssWllzY6vhR/9IZe2MBKD2p2mS2cjIZETbDhTDjEzo/FNwWC/Bu1lkdpGgfT3aeX3
        PisF11m0JAeQtK541LorGsvIIkxitIUSJDb9hw4a0l3nGlodo6IrQky2szs62S1JYeBxTCdBWjlys
        YagP7evl06fMO4bWPWe1esS1FL/FYPC3dnjPslLIf8+hGCLG+DE6Q+sS+ChAFmGX28YLJZAB3lBn6
        vOfnDBTRp5WrofsLg/TSZmgE7aRXGPn6KXw1zp6MB8AarUCMCNDIqlwG3vJRUefSctAxKNupSxuRU
        QT+ZhUqYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmvMs-000613-1M; Tue, 07 Aug 2018 06:21:18 +0000
Date:   Mon, 6 Aug 2018 23:21:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
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
        jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180807062117.GD32709@infradead.org>
References: <20180803070507.GA1344@infradead.org>
 <eb1750e90e4bd45da297fa6f78f8ef93671b7c2f.camel@kernel.crashing.org>
 <20180803160246.GA13794@infradead.org>
 <22310f58605169fe9de83abf78b59f593ff7fbb7.camel@kernel.crashing.org>
 <20180804082120.GB4421@infradead.org>
 <a3ec0a454928e880dabc3782ea906e318634abf9.camel@kernel.crashing.org>
 <20180805072930.GB23288@infradead.org>
 <b7e8294e3e70d24072883a7e8e5375719d5af870.camel@kernel.crashing.org>
 <20180806094243.GA16032@infradead.org>
 <6c707d6d33ac25a42265c2e9b521c2416d72c739.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c707d6d33ac25a42265c2e9b521c2416d72c739.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 05:52:12AM +1000, Benjamin Herrenschmidt wrote:
> > It is your job to write a coherent interface specification that does
> > not depend on the used components.  The hypervisor might be PAPR,
> > Linux + qemu, VMware, Hyperv or something so secret that you'd have
> > to shoot me if you had to tell me.  The guest might be Linux, FreeBSD,
> > AIX, OS400 or a Hipster project of the day in Rust.  As long as we
> > properly specify the interface it simplify does not matter.
> 
> That's the point Christoph. The interface is today's interface. It does
> NOT change. That information is not part of the interface.
> 
> It's the VM itself that is stashing away its memory in a secret place,
> and thus needs to do bounce buffering. There is no change to the virtio
> interface per-se.

Any guest that doesn't know about your magic limited adressing is simply
not going to work, so we need to communicate that fact.
