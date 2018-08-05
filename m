Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EB3C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 07:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BF2217B4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 07:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jqPq8aIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2BF2217B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbeHEJxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 05:53:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeHEJxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 05:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mDLJUZVnfGck7/mRN0Qwhj6/jholuzBwu2E3TSEDagc=; b=jqPq8aIQKdOtKUGcgkjWZ+xt/
        /iEAxjrwyDuPzirBqdfqmR/AWyz21RL1eDkOgnL1S75Z9r5TGy+aWqWo3r919xKm7Zc/vb9oymyQ5
        8MwgInmkqjvookN23by44U4ZLIYRDfTlKKWXEZb/8NypjZZ0P3+G5hB94Sm0+HuQstYfzLHVpCnyj
        4swVi8bwSDTzrvrOeJHrT6X2yGVBRDvBiph/asi1J5mUMj8wVWIW1z4Y1amct3HjInRYtQRjuJ7Np
        hbsVlNFGSDLwQzdQTZOFbZEP1aEQZqHYI7w9hwq2LD2Ra65wREQO38BKA+aWY+ciQ0ci20Mx6zzow
        ekHtan/ug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmDnP-00058m-2u; Sun, 05 Aug 2018 07:49:47 +0000
Date:   Sun, 5 Aug 2018 00:49:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Mike Isely <isely@pobox.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Colin King <colin.king@canonical.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        keiichiw@chromium.org
Subject: Re: [PATCH 2/2] media: usb: pwc: Don't use coherent DMA buffers for
 ISO transfer
Message-ID: <20180805074946.GA14119@infradead.org>
References: <CAJs94EZA=o5=4frPhXs3vnr4x-__gSZ2ximvTyugLoaD6KLcUg@mail.gmail.com>
 <Pine.LNX.4.44L0.1808041045060.25853-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1808041045060.25853-100000@netrider.rowland.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 10:46:35AM -0400, Alan Stern wrote:
> > 2) dma_unmap and dma_map in the handler:
> > 2A) dma_unmap_single call: 28.8 +- 1.5 usec
> > 2B) memcpy and the rest: 58 +- 6 usec
> > 2C) dma_map_single call: 22 +- 2 usec
> > Total: 110 +- 7 usec
> > 
> > 3) dma_sync_single_for_cpu
> > 3A) dma_sync_single_for_cpu call: 29.4 +- 1.7 usec
> > 3B) memcpy and the rest: 59 +- 6 usec
> > 3C) noop (trace events overhead): 5 +- 2 usec
> > Total: 93 +- 7 usec
> > 
> > So, now we see that 2A and 3A (as well as 2B and 3B) agree good within
> > error ranges.
> 
> Taken together, those measurements look like a pretty good argument for 
> always using dma_sync_single_for_cpu in the driver.  Provided results 
> on other platforms aren't too far out of line with these results.

Logically speaking on no-mmio no-swiotlb platforms dma_sync_single_for_cpu
and dma_unmap should always be identical.  With the migration towards
everyone using dma-direct and dma-noncoherent this is actually going to
be enforced, and I plan to move that enforcement to common code in the
next merge window or two.
