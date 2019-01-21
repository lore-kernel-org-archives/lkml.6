Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B1CC2F3D5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C0820879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbfAUOhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:37:11 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35586 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729185AbfAUOhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:37:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB3C2EBD;
        Mon, 21 Jan 2019 06:37:09 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E66563F5C1;
        Mon, 21 Jan 2019 06:37:06 -0800 (PST)
Date:   Mon, 21 Jan 2019 14:37:04 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
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
Subject: Re: kmemleak panic
Message-ID: <20190121143704.GE29504@arrakis.emea.arm.com>
References: <f6fbf528-8213-e3b8-6990-9fcf9dec04d6@free.fr>
 <20190118143434.GE118707@arrakis.emea.arm.com>
 <b7629ecf-757c-f8b5-df83-ba83d7036b2f@free.fr>
 <20190119132832.GA29881@MBP.local>
 <6579db26-10ac-3fbf-1998-5b937a38f202@free.fr>
 <d4facdc2-0581-929f-caa2-b9efa9bd8f97@arm.com>
 <CAL_JsqKFT8J6g02gxeBiTfBb_XHhp2-ZNB6DgaLPK85kNZGRig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKFT8J6g02gxeBiTfBb_XHhp2-ZNB6DgaLPK85kNZGRig@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 07:35:11AM -0600, Rob Herring wrote:
> On Mon, Jan 21, 2019 at 6:19 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 21/01/2019 11:57, Marc Gonzalez wrote:
> > [...]
> > > # echo dump=0xffffffc021e00000 > /sys/kernel/debug/kmemleak
> > > kmemleak: Object 0xffffffc021e00000 (size 2097152):
> > > kmemleak:   comm "swapper/0", pid 0, jiffies 4294892296
> > > kmemleak:   min_count = 0
> > > kmemleak:   count = 0
> > > kmemleak:   flags = 0x1
> > > kmemleak:   checksum = 0
> > > kmemleak:   backtrace:
> > >       kmemleak_alloc_phys+0x48/0x60
> > >       memblock_alloc_range_nid+0x8c/0xa4
> > >       memblock_alloc_base_nid+0x4c/0x60
> > >       __memblock_alloc_base+0x3c/0x4c
> > >       early_init_dt_alloc_reserved_memory_arch+0x54/0xa4
> > >       fdt_init_reserved_mem+0x308/0x3ec
> > >       early_init_fdt_scan_reserved_mem+0x88/0xb0
> > >       arm64_memblock_init+0x1dc/0x254
> > >       setup_arch+0x1c8/0x4ec
> > >       start_kernel+0x84/0x44c
> > >       0xffffffffffffffff
> >
> > OK, so via the __va(phys) call in kmemleak_alloc_phys(), you end up with
> > the linear map address of a no-map reservation, which unsurprisingly
> > turns out not to be mapped. Is there a way to tell kmemleak that it
> > can't scan within a particular object?
> 
> There was this patch posted[1]. I never got a reply, so it hasn't been applied.
> 
> https://patchwork.ozlabs.org/patch/995367/

Thanks Rob, I wasn't aware of this patch (or I just missed it at the
time).

I wonder whether kmemleak should simply remove ranges passed to
memblock_remove(), or at least mark them as no-scan.

-- 
Catalin
