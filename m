Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4C6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7982086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnPev4MJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D7982086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeK1Xk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:40:28 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52899 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbeK1Xk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:40:28 -0500
Received: by mail-it1-f194.google.com with SMTP id i7so4074962iti.2;
        Wed, 28 Nov 2018 04:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2LkPlolDCNEbJcPcn0tERISjVQncXnltlFvA9jTLqKA=;
        b=dnPev4MJaiM8UOwrDEHufF5KcCpaxs2nqlUXoW9/xKoj4yKU27txDFT68kOXigHdvg
         0X+zpk//kxpTpAOPpwb7bBTEZ0ntGQboBBtmlV1ctAkTFMkElxyZuOD3AB9WogaYwHxC
         gfnKGCINFC6CkiWS9VI/Eyr8ceEOaRw3/ecnWriLVmldimRgoAzcbhOFCAKWI1+j6Thn
         h2Wuxe/ONFwqWvenQGu+OZrU7DLoGmzbZFIYIfxr6OmIJVBfAZ23yKi4nh5jgTEchI53
         CeIVwyVnlpRMuTRm60oJWiy+MrMlwLOB1KOX7BzGRYZHEfed+Xt06fnrmc05fCUi37d7
         M3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2LkPlolDCNEbJcPcn0tERISjVQncXnltlFvA9jTLqKA=;
        b=g2thbr3+Bsez+UN3IkvQhqyCzXRYSpT9+YJD8HWqywh+8PhBp1wwtEBUzhUPTaCPqz
         kWX+ve9z30yD+9pNWtLdI8EV+ax2WY8wammRdpX+prckdGYgh+/aWnHBt7OLNbuR+SFB
         6gcbVkbzrDGR7alqu0bO15BBK8EJK5ibPJ9S+rD/LE1RirvgF1+SFZNG2VzJxPoTsaKb
         Gzr18Vgvyzwv5H3769KThham2OurOBmkoyrI1tt7UHxjkuId5odvlxfKhMG7i7mKKsw2
         dgy+CoBAmT+aanSwmeZsiZzxitv+SxpsH+c6P/vVZMSFf7j+yH1B9/Myp4K3WllPaIcR
         tYmQ==
X-Gm-Message-State: AA+aEWYBq2xfS/OwsFR3wZBHC9dOYGHz0yep8W1f5uL6BHnV95llcGCM
        tv8EkNLMUtmEeRRjQlLaQP2gxreXd0O6TJc3oWE=
X-Google-Smtp-Source: AFSGD/Wn+ER2VUTvBRSj1i5ym5gWRe4vJsNAXuYmpCCsOjBKHBp3zylxbWKzXsuLOD7qYHfBgPPHXdUxLQqtH2b7tgo=
X-Received: by 2002:a02:242b:: with SMTP id f43mr11004385jaa.144.1543408735977;
 Wed, 28 Nov 2018 04:38:55 -0800 (PST)
MIME-Version: 1.0
References: <20181126213710.3084-1-vivek.gautam@codeaurora.org> <20181128073940.GA13072@infradead.org>
In-Reply-To: <20181128073940.GA13072@infradead.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 28 Nov 2018 07:38:44 -0500
Message-ID: <CAF6AEGuM-R0=KRSmT+bt6SBaZg_ea3A_YFE+xfR_oCH9d9uORA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
To:     hch@infradead.org
Cc:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        Tomasz Figa <tfiga@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 2:39 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +             /*
> > +              * dma_sync_sg_*() flush the physical pages, so point
> > +              * sg->dma_address to the physical ones for the right behavior.
> > +              */
> > +             for_each_sg(msm_obj->sgt->sgl, s, msm_obj->sgt->nents, i)
> > +                     sg_dma_address(s) = sg_phys(s);
> > +
>
> I'm sorry, but this is completely bogus and not acceptable.
>
> The only place that is allowed to initialize sg_dma_address is
> dma_map_sg.  If the default dma ops don't work for your setup we have
> major a problem and need to fix the dma api / iommu integration instead
> of hacking around it.

I agree that the dma/iommu integration is very problematic for drm (in
particular, gpu drivers that use the iommu as an gpu mmu)..  Really we
need a way that a driver can opt-out of this, and access the cpu cache
APIs directly, skipping the dma API entirely.  But as it is, we've had
to hack around the dma API.  I'm not really sure this hack is any
worse than abusing dma_(un)map_sg() for doing cache operations.

I probably should have paid more attention and nak'd the dma/iommu
integration before it landed.  But given that now we are stuck in this
situation, while I'm certainly interested if anyone has some ideas
about how to let drivers opt out of the dma/iommu integration and
bypass the dma API layer, I'm ok with replacing a hack with a less-bad
hack.

BR,
-R
