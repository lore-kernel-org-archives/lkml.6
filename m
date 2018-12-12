Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AE3C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6500F2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FQHFkOAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6500F2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbeLLSPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:15:49 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35344 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbeLLSPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:15:48 -0500
Received: by mail-yw1-f66.google.com with SMTP id h32so7355622ywk.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 10:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ngkr6G/hl19Sj13Zj9QNMWN2EVzwYXvhHfOeT6gw8Z4=;
        b=FQHFkOApPoRn1IVfb5rBQg3yZZCTcDX2Gx0DiU1nJPYNGK47eYma7KbHAsBnIA6Eti
         rn0i4inpeZRHpsYYULgcH5gxVKZzpo4OODYcnttcrSXR8jAFK6W+iHfK15DMR4UeDiG0
         V/o8LBiODS84lnnQFdCCs1QgRvKPXovvWGcYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ngkr6G/hl19Sj13Zj9QNMWN2EVzwYXvhHfOeT6gw8Z4=;
        b=MDjeX0bHgJX0Do/NTv5UBdhUvlMrFs4qSXzd69czhkSTc9fFWoDONyej6BaN7ppk54
         Soyx0iqB4pHKjjWNmU/zxQ46BEuVZgSBsnTFMZqr6YWaNFbip5G4vk2WiB9Tx86a3ius
         4BXePZxcJXpfmTQR/oI9d61eo4mVSQeXvK0RXOtka1Q64bY37Let1L17J5qWOskQnRQo
         9RDZpd1SagXjEgl29Gd5FgxKc3DxrhFK4N7h+j5+Q03mgsNafe9qMqkV4BcueKSj02W4
         3Ln2YZS5nFLu9B31BsdM4Bd123PsW48/lNjuNU8h5RLTEpVZB/Ghv1sJOdr4Hmfw8r6C
         uflQ==
X-Gm-Message-State: AA+aEWZFt3jjoTWL6+29xlljBMdkyNeKfb/rPpG4fmAuZw1ylPK3Phzd
        if0rfdWIjV09kxqG8ztkWO9AhaCzQrDUtcNAXfSy9Q==
X-Google-Smtp-Source: AFSGD/UZk5PLoR/l+THvMA/BuoeqZomjNcBPboMFjLPJBADC8U1x1nPtoN1AmDGqBhgXaUrT8Lo+gXOOdUkmD3yrpn0=
X-Received: by 2002:a81:2bc2:: with SMTP id r185mr13475141ywr.425.1544638547427;
 Wed, 12 Dec 2018 10:15:47 -0800 (PST)
MIME-Version: 1.0
References: <20181211103616.22137-1-anders.roxell@linaro.org> <613667c4-f850-d88c-7a2e-76dda5d966f5@arm.com>
In-Reply-To: <613667c4-f850-d88c-7a2e-76dda5d966f5@arm.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Wed, 12 Dec 2018 19:15:36 +0100
Message-ID: <CADYN=9+FpcMUqtLgkvWQnf2uQOgS3VhwCLHmcriD_5LSVBZFKQ@mail.gmail.com>
Subject: Re: [PATCH] dma-debug: fix soft lockup when a lot of debug are enabled
To:     robin.murphy@arm.com
Cc:     hch@lst.de, Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 at 12:51, Robin Murphy <robin.murphy@arm.com> wrote:
>
> Hi Anders,

Hi Robin,

>
> On 11/12/2018 10:36, Anders Roxell wrote:
> > When running a kernel in qemu with enough debugging options (slub-debug,
> > ftrace, kcov, kasan, ubsan, ...) enabled together, that results in a
> > slow initcall. So a 'watchdog: BUG: soft lockup' happens:
> >
> > [   44.105619] Call trace:
> > [   44.106709]  __slab_alloc+0x70/0x88
> > [   44.107757]  kmem_cache_alloc_trace+0x13c/0x590
> > [   44.108764]  prealloc_memory+0xb8/0x240
> > [   44.109768]  dma_debug_init+0x174/0x1f0
> > [   44.110725]  do_one_initcall+0x430/0x8b0
> > [   44.111719]  do_initcall_level+0x548/0x5b4
> > [   44.112672]  do_initcalls+0x28/0x4c
> > [   44.113628]  do_basic_setup+0x34/0x3c
> > [   44.114559]  kernel_init_freeable+0x194/0x24c
> > [   44.115570]  kernel_init+0x24/0x18c
> > [   44.116498]  ret_from_fork+0x10/0x18
> >
> > Rework to call cond_resched(), in the function prealloc_memory()'s
> > for-loop.
>
> Funnily enough I've just done a bit of work in this area which should
> make allocation a lot more efficient - would you mind giving this series
> a spin on the same setup to see how much it helps the performance?
>
> https://lore.kernel.org/lkml/cover.1544447601.git.robin.murphy@arm.com/

I tried it on todays next tag and couldn't reproduce the soft lockup.

Cheers,
Anders

>
> Thanks,
> Robin.
>
> >
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >   kernel/dma/debug.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> > index 231ca4628062..2abdc265aec4 100644
> > --- a/kernel/dma/debug.c
> > +++ b/kernel/dma/debug.c
> > @@ -767,6 +767,7 @@ static int prealloc_memory(u32 num_entries)
> >       int i;
> >
> >       for (i = 0; i < num_entries; ++i) {
> > +             cond_resched();
> >               entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> >               if (!entry)
> >                       goto out_err;
> >
