Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE28C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 08:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05B1217C5
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 08:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WSmdXWWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C05B1217C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeHDKVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 06:21:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36630 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbeHDKVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 06:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Uml25wGYLkjpg9aNsn/Ka+LDmDT7cUM/OMuByV29RYs=; b=WSmdXWWlCIseVWNwwk0EUy3TC
        2rN/5Qse9Yx3CNip1bdXJqTwrQfVlcm4CpEsA3mjHhMhhKUqk/LROlFAdFjDiBArBQ4siDRTpos3R
        qwwBOSg22EGPSATsDLHxyuLV1lWZWQ0XddHq3yvfWrMkL0DTRMbU7EgbmEqRFN+UISyM3nzb+5e3p
        rttChy9sthceXp63Z74xQqCX7Mj1dXc6c1shguLYwVgzkLE5El/zD4W+9LwWmu85f51s6x2z18y/y
        WOjTUIQtyn8mrgmgQE5Kq6JsVbdhSJeiml6F+Y5Vx3fUZm3mht7PtsSHsOWIrHR7yPbDVfWPdTHfH
        Q9MlvrQ1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flroO-0003YB-Ig; Sat, 04 Aug 2018 08:21:20 +0000
Date:   Sat, 4 Aug 2018 01:21:20 -0700
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
Message-ID: <20180804082120.GB4421@infradead.org>
References: <20180802182959-mutt-send-email-mst@kernel.org>
 <82ccef6ec3d95ee43f3990a4a2d0aea87eb45e89.camel@kernel.crashing.org>
 <20180802200646-mutt-send-email-mst@kernel.org>
 <e9beb6bba5a7d05741e27e85b24a3b23ba7c2762.camel@kernel.crashing.org>
 <20180802225738-mutt-send-email-mst@kernel.org>
 <de4888b6457e220776e16a9c8958ff0886ffc66c.camel@kernel.crashing.org>
 <20180803070507.GA1344@infradead.org>
 <eb1750e90e4bd45da297fa6f78f8ef93671b7c2f.camel@kernel.crashing.org>
 <20180803160246.GA13794@infradead.org>
 <22310f58605169fe9de83abf78b59f593ff7fbb7.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22310f58605169fe9de83abf78b59f593ff7fbb7.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 01:58:46PM -0500, Benjamin Herrenschmidt wrote:
> You are saying something along the lines of "I don't like an
> instruction in your ISA, let's not support your entire CPU architecture
> in Linux".

No.  I'm saying if you can't describe your architecture in the virtio
spec document it is bogus.

> Our setup is not fucked. It makes a LOT of sense and it's a very
> sensible design. It's hitting a problem due to a corner case oddity in
> virtio bypassing the MMU, we've worked around such corner cases many
> times in the past without any problem, I fail to see what the problem
> is here.

No matter if you like it or not (I don't!) virtio is defined to bypass
dma translations, it is very clearly stated in the spec.  It has some
ill-defined bits to bypass it, so if you want the dma mapping API
to be used you'll have to set that bit (in its original form, a refined
form, or an entirely newly defined sane form) and make sure your
hypersivors always sets it.  It's not rocket science, just a little bit
for work to make sure your setup is actually going to work reliably
and portably.

> We aren't going to cancel years of HW and SW development for our

Maybe you should have actually read the specs you are claiming to
implemented before spending all that effort.
