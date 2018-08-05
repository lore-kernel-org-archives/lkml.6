Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17469C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 07:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BB0217BB
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 07:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K4CHapuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BB0217BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbeHEJ2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 05:28:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725728AbeHEJ2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 05:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ri+29J9p4gLMOc9NfYcmEQhkEfqoA1R8nFnH3283OFY=; b=K4CHapuh7rZ9YgFTM14dSazs4
        Dz5jGT3+AZ4CAs/J5mpy+ZaQ+LLSE4giUDW+CjLrOBJJSRE6U6YblHrwlI5yifhpE7tS77Kdsod9B
        Nw5afR7ieEIY8OmnnOfLAWKjT5xAzC2e9F/EUypYQfIWKcW/cQ2rpWrt+fGIigHEoNQ+XX2Fl4K9c
        sQj5SLDws9s7gBFvVp4KBbSche3VQDoo40iJqO+29/Vr3DIIHy/qmYzfzoadZ1sq6/jb/cSOk3H1C
        cmXWMJs6EbwTiLzlLw7C0h3UQOrNVcz7ZEPgqwCw93Hn037aMhPuREYvq6/22VI/NpkLxj6vASn9d
        ttLvf/AYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmDPW-0006xn-Jb; Sun, 05 Aug 2018 07:25:06 +0000
Date:   Sun, 5 Aug 2018 00:25:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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
Message-ID: <20180805072506.GA23288@infradead.org>
References: <20180802182959-mutt-send-email-mst@kernel.org>
 <82ccef6ec3d95ee43f3990a4a2d0aea87eb45e89.camel@kernel.crashing.org>
 <20180802200646-mutt-send-email-mst@kernel.org>
 <e9beb6bba5a7d05741e27e85b24a3b23ba7c2762.camel@kernel.crashing.org>
 <20180802225738-mutt-send-email-mst@kernel.org>
 <de4888b6457e220776e16a9c8958ff0886ffc66c.camel@kernel.crashing.org>
 <20180803070507.GA1344@infradead.org>
 <20180803221634-mutt-send-email-mst@kernel.org>
 <20180804081500.GA1455@infradead.org>
 <20180805030326-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180805030326-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 05, 2018 at 03:09:55AM +0300, Michael S. Tsirkin wrote:
> So in this case however I'm not sure what exactly do we want to add. It
> seems that from point of view of the device, there is nothing special -
> it just gets a PA and writes there.  It also seems that guest does not
> need to get any info from the device either. Instead guest itself needs
> device to DMA into specific addresses, for its own reasons.
> 
> It seems that the fact that within guest it's implemented using a bounce
> buffer and that it's easiest to do by switching virtio to use the DMA API
> isn't something virtio spec concerns itself with.

And that is exactly what we added bus_dma_mask for - the case where
the device itself has not limitation (or a bigger limitation), but
the platform limits the accessible dma ranges.  One typical case is
a PCIe root port that is only connected to the CPU through an
interconnect that is limited to 32 address bits for example.
