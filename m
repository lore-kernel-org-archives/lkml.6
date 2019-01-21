Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171D6C2F3A6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8EF2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548077726;
	bh=1dWunOA+vGZNvIl3JTgepZja1oWzemnosglZGJpT3Zg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QuojmLU2rNXFeSGMMcDbopoOYePYZow8CMJedmfaYKSO8RrD41PMV9X7MIULLBhCR
	 AGoter7nHpCPLvw8GPAs0lgRLOqKwxK+/m4YLH4M0jBDD//oFLbSxSpXMgiElhCno0
	 jXLk64mH1QEwygrdUKeO0nX3LNkLcZB5jsAN+SWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbfAUNfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:35:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:51512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728648AbfAUNfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:35:25 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FAE220879
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 13:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548077724;
        bh=1dWunOA+vGZNvIl3JTgepZja1oWzemnosglZGJpT3Zg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A5jSDmBccIsRUnEYoq2iabrlDy3HGaem/53EBsOE6E6bWKvavNsS5cYRR+olJrf5q
         B4GJcKlxOvqPtB1L/zFbVq7AqOQHNghXtsZmebd50p0/MU4F9/pzeIrX4/JPsWVH6/
         8XYkjaqtm8U//78rQaXsXCzTg/XPQMk0Yj5BBkrY=
Received: by mail-qt1-f173.google.com with SMTP id y20so23472103qtm.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 05:35:24 -0800 (PST)
X-Gm-Message-State: AJcUukc9sLv+s3gA1emK/OorZ1yW3lK1tg66mdOMOltbOi9LA8QLE4IC
        XVINa25DRmaWv1quWd428P+kWVyJ7y4gZOQXsQ==
X-Google-Smtp-Source: ALg8bN7FIg+bmTpYGNg37Bv4drsQ6bNV5GlhMrSB4hX0RnzEzkQnutDhHJW9k5+StGByH6N6vBJIHR2jLVGbw+2hack=
X-Received: by 2002:ac8:1712:: with SMTP id w18mr26513808qtj.76.1548077723365;
 Mon, 21 Jan 2019 05:35:23 -0800 (PST)
MIME-Version: 1.0
References: <f6fbf528-8213-e3b8-6990-9fcf9dec04d6@free.fr> <20190118143434.GE118707@arrakis.emea.arm.com>
 <b7629ecf-757c-f8b5-df83-ba83d7036b2f@free.fr> <20190119132832.GA29881@MBP.local>
 <6579db26-10ac-3fbf-1998-5b937a38f202@free.fr> <d4facdc2-0581-929f-caa2-b9efa9bd8f97@arm.com>
In-Reply-To: <d4facdc2-0581-929f-caa2-b9efa9bd8f97@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 21 Jan 2019 07:35:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKFT8J6g02gxeBiTfBb_XHhp2-ZNB6DgaLPK85kNZGRig@mail.gmail.com>
Message-ID: <CAL_JsqKFT8J6g02gxeBiTfBb_XHhp2-ZNB6DgaLPK85kNZGRig@mail.gmail.com>
Subject: Re: kmemleak panic
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Qian Cai <cai@lca.pw>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 6:19 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 21/01/2019 11:57, Marc Gonzalez wrote:
> [...]
> > # echo dump=0xffffffc021e00000 > /sys/kernel/debug/kmemleak
> > kmemleak: Object 0xffffffc021e00000 (size 2097152):
> > kmemleak:   comm "swapper/0", pid 0, jiffies 4294892296
> > kmemleak:   min_count = 0
> > kmemleak:   count = 0
> > kmemleak:   flags = 0x1
> > kmemleak:   checksum = 0
> > kmemleak:   backtrace:
> >       kmemleak_alloc_phys+0x48/0x60
> >       memblock_alloc_range_nid+0x8c/0xa4
> >       memblock_alloc_base_nid+0x4c/0x60
> >       __memblock_alloc_base+0x3c/0x4c
> >       early_init_dt_alloc_reserved_memory_arch+0x54/0xa4
> >       fdt_init_reserved_mem+0x308/0x3ec
> >       early_init_fdt_scan_reserved_mem+0x88/0xb0
> >       arm64_memblock_init+0x1dc/0x254
> >       setup_arch+0x1c8/0x4ec
> >       start_kernel+0x84/0x44c
> >       0xffffffffffffffff
>
> OK, so via the __va(phys) call in kmemleak_alloc_phys(), you end up with
> the linear map address of a no-map reservation, which unsurprisingly
> turns out not to be mapped. Is there a way to tell kmemleak that it
> can't scan within a particular object?

There was this patch posted[1]. I never got a reply, so it hasn't been applied.

Rob

https://patchwork.ozlabs.org/patch/995367/
