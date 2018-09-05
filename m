Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B967C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81DE20645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rk8GiiD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E81DE20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbeIFAiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:38:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbeIFAiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:38:19 -0400
Received: from mail-qt0-f174.google.com (mail-qt0-f174.google.com [209.85.216.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90A7D206BA;
        Wed,  5 Sep 2018 20:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536177993;
        bh=Q2aSCbRDsgAd8r8HNE8qL4XiJiHgKQp3b/A4DylxP/s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rk8GiiD6Rza2VvrPSXK0Jjb2yJET8d2aWOYjnC/AC1sLPl8NqU5XAYAoa63ggaLT0
         i+5wCty8kp1NxdL03WVOttQ9km6iNnK1wGSXmQUvTn7VGafx5D5147WLscb9QVrz2Y
         wmtjL7QnD1sJBF2QuxST08laEHOgzcmF2ZSGn/EQ=
Received: by mail-qt0-f174.google.com with SMTP id x7-v6so9650169qtk.5;
        Wed, 05 Sep 2018 13:06:33 -0700 (PDT)
X-Gm-Message-State: APzg51AyXQV3gouvDkU4FDsmQIDXQPc/bnQ2e+bUGc9w12sdRjCfF5Zf
        z5U+xXrq6Bz4Et4Aqoy2q9Y/HAGD4rXnihEn9A==
X-Google-Smtp-Source: ANB0VdZwTS9hGQbEy0M0hZvKzpnhV90lE2Og8h//w9wrwS1CW0cVCr05E1vBRMgonrQjfuJKH6zloNboO/DwWcRxc24=
X-Received: by 2002:ac8:1909:: with SMTP id t9-v6mr35448823qtj.327.1536177992755;
 Wed, 05 Sep 2018 13:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180830190523.31474-1-robh@kernel.org> <20180830190523.31474-2-robh@kernel.org>
 <b86ed9cf-d5fd-09fb-eb82-0143c759f5cf@gmail.com> <CAL_JsqJy0kDYCC35GR5TGLYyYU-UjOys_r2sFMQZuFto5HkExg@mail.gmail.com>
 <5da7b4ab-acd3-977a-6ac2-275911d7c436@gmail.com>
In-Reply-To: <5da7b4ab-acd3-977a-6ac2-275911d7c436@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 5 Sep 2018 15:06:21 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKRsXN-MKdP1ts=QexwuwkXO5tbFkORf4xDyYt04FUuUA@mail.gmail.com>
Message-ID: <CAL_JsqKRsXN-MKdP1ts=QexwuwkXO5tbFkORf4xDyYt04FUuUA@mail.gmail.com>
Subject: Re: [PATCH 1/3] of/fdt: Scan the root node properties earlier
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 1:19 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 09/05/18 04:51, Rob Herring wrote:
> > On Tue, Sep 4, 2018 at 8:49 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >>
> >> On 08/30/18 12:05, Rob Herring wrote:
> >>> Scan the root node properties (#{size,address}-cells) earlier,
> >>
> >>                                                         ^^^^^^^
> >>                              before mdesc->dt_fixup() is called
> >>
> >>> so that
> >>> the dt_root_addr_cells and dt_root_size_cells variables are initialized
> >>> and can be used.
> >>                  by mdesc->dt_fixup()
> >
> > That's an ARM specific detail. Granted, ARM is the only caller.
>
> The dt_root_addr_cells and dt_root_size_cells variables are being
> initialized earlier in this patch series so that of_fdt_limit_memory()
> can use them.  The only caller of of_fdt_limit_memory() is
> exynos_dt_fixup(), which is an mdesc->dt_fixup() function.
>
>
> >
> >>>
> >>> Cc: Frank Rowand <frowand.list@gmail.com>
> >>> Signed-off-by: Rob Herring <robh@kernel.org>
> >>> ---
> >>>  drivers/of/fdt.c | 7 ++++---
> >>>  1 file changed, 4 insertions(+), 3 deletions(-)
> >>>
> >> Moving early_init_dt_scan_root() to inside early_init_dt_verify()
> >> puts something that has nothing to do with verifying the fdt
> >> into a function whose purpose is the verify.  It hides the side
> >> effect of initializing the dt_root_addr_cells and dt_root_size_cells
> >> variables.
> >
> > It already has the side effect of setting initial_boot_params which
> > every subsequent function needs.
>
> And that side effect should probably also be moved.

So 2 functions? One to set the blob and one to verify it. Then we can
just let arches decide if they want to do any verification or not.

Perhaps it should be called fdt_init(blob) and then it is vague enough
I can do whatever I want.

> >> I suggest creating a new function early_init_dt_scan_init_pre_dt_fixup(),
> >> move the chunk of code there instead of to early_init_dt_scan_nodes(),
> >> and call the new function from setup_machine_fdt(), just before
> >> calling  mdesc->dt_fixup().  This would be a little bit more code,
> >> but more clearly showing the intent.
> >
> > I'm trying to reduce the number of functions arches call
>
> I like that goal.
>
>
> > and renaming
> > would need a bunch of arch changes. This change will also let me make
> > early_init_dt_scan_root private as powerpc is the only user. I need to
> > dust off a patch for that.
> >
> > I'd be more inclined to push exynos to remove this altogether. After
>
> Not a bad idea.
>
> > all, if they claim their bindings are unstable, they can't really
> > claim their bootloader is stable/fixed.
>
> It seems that this series is showing us that maybe the three architecture
> specific (arc, arm, arm64) versions of setup_machine_fdt() should be
> consolidated so that we have consistent behavior for FDT.
>
> If we had a single setup_machine_fdt() then some of he hidden side
> effects of functions called by setup_machine_fdt() could instead
> be hoisted into setup_machine_fdt().

Those functions are all quite a bit different. ARM matches the machine
desc while arm64 doesn't have any such thing. How the DTB gets mapped
into virtual space also varies.

Rob
