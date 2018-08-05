Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52D9C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 08:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94757217BB
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 08:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oxCO8Kk0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94757217BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbeHEKpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 06:45:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54638 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeHEKpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 06:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+orMi4qCFgED+6EWil9fQSIZZQQWkxG8t37kIoAhnwA=; b=oxCO8Kk0cO18i8cKi3HC8CrL3
        TE+Ewf8S952ZHNw/lA7IhGl9K7gJWnyIBwy0lNTTdeyGZ8mPSU/be6i1OjKWoG09a3eCX1L3VrEk2
        7cvyvWiqI4AYGKv6AXc+yNh1Mn1mQu1JW4/MXBByCgpZM6vF9nH+lecYWFrNtb9NXrhCByathe0Jn
        LUXscSZGSU1rAQqeN6jYab8w46VpYLCYGwWNS2xEapB8Jc6lQqDDoNh0N/G+2GwI9XPD1Ue7lnAdx
        3nSstoG3t6J46aHVDp3+t/yTBBbQq0fOXF+7mtCUkkJzS15hBLjzKvCXFPdyZtSvjAWM442/zmhiX
        fluxJ4YyA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmEbE-0005J9-Ay; Sun, 05 Aug 2018 08:41:16 +0000
Date:   Sun, 5 Aug 2018 01:41:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <20180805084116.GA15482@infradead.org>
References: <CAJs94EZA=o5=4frPhXs3vnr4x-__gSZ2ximvTyugLoaD6KLcUg@mail.gmail.com>
 <Pine.LNX.4.44L0.1808041045060.25853-100000@netrider.rowland.org>
 <20180805074946.GA14119@infradead.org>
 <CAJs94Eb_Mzxk6a+_b8ZnutdkBjrk5=UWg0F1X0-iRZK1do5uLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJs94Eb_Mzxk6a+_b8ZnutdkBjrk5=UWg0F1X0-iRZK1do5uLg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 05, 2018 at 11:33:38AM +0300, Matwey V. Kornilov wrote:
> >> Taken together, those measurements look like a pretty good argument for
> >> always using dma_sync_single_for_cpu in the driver.  Provided results
> >> on other platforms aren't too far out of line with these results.
> >
> > Logically speaking on no-mmio no-swiotlb platforms dma_sync_single_for_cpu
> > and dma_unmap should always be identical.  With the migration towards
> > everyone using dma-direct and dma-noncoherent this is actually going to
> > be enforced, and I plan to move that enforcement to common code in the
> > next merge window or two.
> >
> 
> I think that Alan means that using dma_sync_single_for_cpu() we save
> time required for subsequent dma_map() call (which is required when we
> do dma_unmap()).

The point still stands.  By definition for a correct DMA API
implementation a dma_sync_single_for_cpu/dma_sync_single_for_device
pair is always going to be cheaper than a dma_unmap/dma_map pair,
although for many cases the difference might be so small that it is
not measureable.

If you reuse a buffer using dma_sync_single* is always the right thing
to do vs unmapping and remapping it.
