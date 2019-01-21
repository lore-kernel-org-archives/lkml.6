Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052C6C2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9BF20844
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mxq+R22z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbfAUP7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:59:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34468 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbfAUP7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6NEmVVeGQF+RW2yW3iE9OtImz5GMuIym5FZr9nYwJD8=; b=Mxq+R22zqGsivEjJBXctu91nt
        WeV/YbLGvri3McijBKcc8ujykesL9THu5sIny+R2UeJ4ZU4sE/si9E5ImVQdwDqsauHtjX8ljYCLb
        VcpMUkvbaifYB95QFw4bRNLLd13CipTKbyTQ/xVp6IfDLvMotkQceBMwYYVbBysBcq/S50Cx5JoaU
        mi0P5t+0QnTM0DfRe7MiN7Px6A7Y8hmNH1XS31VlrE/Hzhbvwju3vZRgzgni57p6HW9a+aT1AMwTO
        5AezjK7WFp9IWrmC7qo18jH+9YY1JKkVnohyrK3eBS24H3gjNtoQ2ngJQjEshyES7OzGyNAh663aM
        gaHBNgI4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glbye-00030K-Hw; Mon, 21 Jan 2019 15:59:08 +0000
Date:   Mon, 21 Jan 2019 07:59:08 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org,
        Christian Koenig <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Michel Daenzer <michel.daenzer@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Message-ID: <20190121155908.GA8084@infradead.org>
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org>
 <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 04:33:27PM +0100, Ard Biesheuvel wrote:
> On Mon, 21 Jan 2019 at 16:07, Christoph Hellwig <hch@infradead.org> wrote:
> >
> > > +#include <linux/dma-noncoherent.h>
> >
> > This header is not for usage in device drivers, but purely for
> > dma-mapping implementations!
> >
> 
> Is that documented anywhere?

I'll add big fat comments.  But the fact that nothing is exported
there should be a fairly big hint.

> > And even if something like this was valid to do, it would have to be
> > a core function with an arch hook, and not hidden in a random driver.
> 
> Why would it not be valid to do? Is it wrong for a driver to be aware
> of whether a device is cache coherent or not?
> 
> And in case it isn't, do you have an alternative suggestion on how to
> fix this mess?

For the write combine mappings we need a proper core API how instances
can advertise the support.  One thing I want to do fairly soon is
error checking of the attrs argument to dma_alloc_attrs - so if you
pass in something unsupported it will give you back an error.

It seems that isn't quite enough for the drm use case, so we might
also need a way to query these features, but that really has to go
through the usual dma layer abstraction as well and not hacked together
in a driver based on an eduacted guestimate.
