Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62265C2F441
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304C020870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KSxutnfc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbfAUQfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:35:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44752 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbfAUQfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 11:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tOHDEz9q6gqXsjj0uepjRw5AoTGfkvEJhWu3MBjXYlo=; b=KSxutnfcgC+8Zu5vCpHXu2Y0z
        bJZ2hw9yoW+YQ0/C1dDs7pctogNabXKm/RHUKrq3WgekwclTelXfnQb1IsMXdGf+ICAI91xi31HeE
        /OsU2BMhXpLwgibgDVyssdaf34GWrrC0/ocQ1xZLUkJ/fWBCv+Q3VQF5CrPHaaADi2wEXpImUIGLr
        TF1f1PSAA3lRbpi/xwgD0+VTzh6/xrjwGAD8dWdTqv5QdhyNdLXv+xrr5HDQ3XbXMIA74YcXvQbWZ
        O9RodSA1NsOEwJdeDkmB/5AMHrsTnvrJSfmgl1NFSnb0f1Uj4gf8T91Cyp2MRnZHeatEywkMWqk8Y
        h8JFgmC/A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glcXz-0007Ee-RH; Mon, 21 Jan 2019 16:35:39 +0000
Date:   Mon, 21 Jan 2019 08:35:39 -0800
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
Message-ID: <20190121163539.GA18070@infradead.org>
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org>
 <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
 <20190121155908.GA8084@infradead.org>
 <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
 <20190121162238.GA17651@infradead.org>
 <CAKv+Gu-5V-UjP_YzZBCEsa+o_G6BRSVw2ZimYGNEfRGf-aRPNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-5V-UjP_YzZBCEsa+o_G6BRSVw2ZimYGNEfRGf-aRPNg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 05:30:00PM +0100, Ard Biesheuvel wrote:
> > Until that happens we should just change the driver ifdefs to default
> > the hacks to off and only enable them on setups where we 100%
> > positively know that they actually work.  And document that fact
> > in big fat comments.
> 
> Well, as I mentioned in my commit log as well, if we default to off
> unless CONFIG_X86, we may break working setups on MIPS and Power where
> the device is in fact non-cache coherent, and relies on this
> 'optimization' to get things working. The same could be true for
> non-coherent ARM systems, hence my approach to disable this hack for
> cache coherent devices on non-X86 only.

Do we break existing setups or just reduce performance due to the lack
of WC mappings?  I thought it was the latter.  The point is that
even your check won't do what you actually said.  At lot of non-loongson
mips platforms are not cache coherent.  As are a lot of arm setups
and all sparc64 ones for example.  And chances that someone will
hacks this file out in a random subsystem when adding news ports also
is rather slim, so we'll remaing broken by default.

That is why I want at very least:  a whitelist instead of a blacklist
and some very big comments explaining what is going on here.  And in
the mid to long term even drm really needs to learn to use the
proper APIs :(
