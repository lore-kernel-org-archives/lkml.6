Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B7CC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBE32184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JwXuBWM8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfAXJNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:13:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45758 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfAXJNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:13:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4oZOCBYRvT1RVFg0dLVQyb/Ep/hGeeiQ4onlLwzY23E=; b=JwXuBWM8854siwreMXujTG5Kt
        IV9AVVpLbgwgzXiWON3ENNMPkpXK5xEQ9dH1U6LoP1ia1jWgiM8TlcisUwnA5h0NZDd1frRxAxeLH
        mRi9abOpGg/Yy5MuZcRk/sEfFEuPLW34O86K8MjDIUoEAL/69TUHsszhw8w0aHjpLE0NNSgXBMA/4
        ymEfdhF5LBHcxxhPI7+saYhro42jRlv3JGx4Agb1JIhzzx9U6RTU7Za6RQz/O4e7wQ7JJ6nPJd44Q
        IypBY1gIbxdIMGWF7jIEeIVMShH0uUkun9b0BmlGULwS8/S8oOSlxSWTynn4909NN/3okiqHhb6uw
        /0reUxUZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gmb4W-0000HG-CO; Thu, 24 Jan 2019 09:13:16 +0000
Date:   Thu, 24 Jan 2019 01:13:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alex Deucher <alexdeucher@gmail.com>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sean Paul <sean@poorly.run>,
        Christian Koenig <christian.koenig@amd.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Message-ID: <20190124091316.GA22796@infradead.org>
References: <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
 <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net>
 <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
 <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
 <20190123071521.GB20526@infradead.org>
 <CAKv+Gu8+77uZHJ6ZYjGNcKQL8C3cT5Ree+TcTVmkQXAHV-ADyg@mail.gmail.com>
 <20190123164428.GA9367@infradead.org>
 <CAKv+Gu-9vEKu8mG-o+-4M1ZcgZmTTJVfEdNS9R27AFX8P5sqyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-9vEKu8mG-o+-4M1ZcgZmTTJVfEdNS9R27AFX8P5sqyQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 05:52:50PM +0100, Ard Biesheuvel wrote:
> But my concern is that it seems likely that non-cache coherent
> implementations are relying on this hack as well. There must be a
> reason that this hack is only disabled for PowerPC platforms if they
> are cache coherent, for instance, and I suspect that that reason is
> that the hack is the only thing ensuring that the CPU mapping
> attributes match the device ones used for these buffers (the vmap()ed
> ones), whereas the rings and other consistent data structures are
> using the DMA API as intended, and thus getting uncached attributes in
> the correct way.

Dave, who added that commit is on Cc together with just about everyone
involved in the review chain.  Based on the previous explanation
that idea what we might want an uncached mapping for some non-coherent
architectures for this to work at all makes sense, but then again
the way to create those mappings is entirely architecture specific,
and also need a cache flushing before creating the mapping to work
properly.  So my working theory is that this code never properly
worked on architectures without DMA coherent for PCIe at all, but
I'd love to be corrected by concrete examples including an explanation
of how it actually ends up working.
