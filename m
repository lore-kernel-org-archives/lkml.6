Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C19C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2927121904
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550086081;
	bh=d4USaxOaZ5zIs0Yd6AYwU7IxGiiMG63YyGPnEEw7QQk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FHEq/f1xiMj0MicBVxcYdDtkLr4hudZ+MpvZaVHx/3JqV+NqBhRhan08nTRC2vNlC
	 8s3TL2f6fKQEaJPfH03kapfKAjZ8Szkd2rmJ3fM05JxcDayh3H8PDpmu1sNun7kDbl
	 UCyTAZfBbdap26ghemXpSsEkrTjKNCgGuLGpHl8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394397AbfBMT2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:28:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:36178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730161AbfBMT17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:27:59 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74928222D0;
        Wed, 13 Feb 2019 19:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550086078;
        bh=d4USaxOaZ5zIs0Yd6AYwU7IxGiiMG63YyGPnEEw7QQk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MRdSBbmokqMe8z+9FVsMJsm648JqGS4TxplBfDvE4kg//D3ih8EgoUzNEvOm+uwxn
         OfG3inpBJ3aRJziIpru75JaWAPGejKP+rW0jT753boDgWR4cniOiayP/gg5vgcXp5C
         PoMWr+zmo30lm/AU8BhVR7120eozOfZ2/B37L/HE=
Received: by mail-qt1-f171.google.com with SMTP id p48so4044960qtk.2;
        Wed, 13 Feb 2019 11:27:58 -0800 (PST)
X-Gm-Message-State: AHQUAuYWvvSaPwJwO5+zbtiZopJxWOw+vFw9/w2RILkJ5UxaFlomM3JV
        DevgBpG74GMtgaUGuX3EkTs6Lrjc+6qu8doW7Q==
X-Google-Smtp-Source: AHgI3Ia7ZzDKkBkWUQYA6sU/9ZdcsVSBsmd/pRgt7FkqYjFxVtDglXsm4TWC21OgiOFhLerCX65ssWFBeBIZC5R9+H0=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr1699437qve.246.1550086077695;
 Wed, 13 Feb 2019 11:27:57 -0800 (PST)
MIME-Version: 1.0
References: <20190211133554.30055-1-hch@lst.de> <20190211133554.30055-7-hch@lst.de>
 <CAL_JsqL+LiJTF5kZz2hXGbQcH+D4U0jAQE376VSUVMQmdg=XFA@mail.gmail.com> <20190213182435.GA19906@lst.de>
In-Reply-To: <20190213182435.GA19906@lst.de>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 13 Feb 2019 13:27:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLCr4Jk_-cWUFGs5zfk+NKksc+bs0bpiBeQHsZFthaM1Q@mail.gmail.com>
Message-ID: <CAL_JsqLCr4Jk_-cWUFGs5zfk+NKksc+bs0bpiBeQHsZFthaM1Q@mail.gmail.com>
Subject: Re: [PATCH 06/12] dma-mapping: improve selection of
 dma_declare_coherent availability
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux IOMMU <iommu@lists.linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, x86@kernel.org,
        arcml <linux-snps-arc@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org,
        SH-Linux <linux-sh@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 12:24 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Feb 12, 2019 at 02:40:23PM -0600, Rob Herring wrote:
> > > diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> > > index 3607fd2810e4..f8c66a9472a4 100644
> > > --- a/drivers/of/Kconfig
> > > +++ b/drivers/of/Kconfig
> > > @@ -43,6 +43,7 @@ config OF_FLATTREE
> > >
> > >  config OF_EARLY_FLATTREE
> > >         bool
> > > +       select DMA_DECLARE_COHERENT
> >
> > Is selecting DMA_DECLARE_COHERENT okay on UML? We run the unittests with UML.
>
> No, that will fail with undefined references to memunmap.
>
> I gues this needs to be
>
>         select DMA_DECLARE_COHERENT if HAS_DMA
>
> > Maybe we should just get rid of OF_RESERVED_MEM. If we support booting
> > from DT, then it should always be enabled anyways.
>
> Fine with me.  Do you want me to respin the series to just remove
> it?

Either now or it can wait. I don't want to hold this up any.

Rob
