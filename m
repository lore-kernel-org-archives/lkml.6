Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB2CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769802077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aat3Hg2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769802077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbeIEQV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:21:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbeIEQV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:21:27 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 532BD20857;
        Wed,  5 Sep 2018 11:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536148293;
        bh=HHEfYWgEJ5vmpfBSBprIk9vCLvaZcerqqe6tadM0IzM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Aat3Hg2q/GFAgfYSlzcRGiXHq6F5JsUrA+emTHjK0vAosO+lC4ogTNlh85ILLEAL9
         sGARBSqzbH3HzezeWIf0SV5t9Yhx9lciTIhGLQ85FulRWybcUGB7hRtfkmxeUZo0BL
         FJjbpaMJbpvWsWw16oefxxuBHycVFGjdI2KLqomI=
Received: by mail-qk1-f172.google.com with SMTP id j7-v6so4585660qkd.13;
        Wed, 05 Sep 2018 04:51:33 -0700 (PDT)
X-Gm-Message-State: APzg51DDyh7ux1FrzdCALnYa97skV6I1Q8iQIxTHWBCEmLRZtRhQzuIB
        cSrz8lRZwAINne6tUsXYwiDD3WqhF9JJlXbjdw==
X-Google-Smtp-Source: ANB0VdbATx8yMVFQ/OqAtUNT+kgsUw9G5iZ1P7m2+Mb6hvelv5dA9u6/87xsnPCSdvAplHV2BN+Q6FVkEwoz4De7ZwY=
X-Received: by 2002:a37:169c:: with SMTP id 28-v6mr31650649qkw.184.1536148292502;
 Wed, 05 Sep 2018 04:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180830190523.31474-1-robh@kernel.org> <20180830190523.31474-2-robh@kernel.org>
 <b86ed9cf-d5fd-09fb-eb82-0143c759f5cf@gmail.com>
In-Reply-To: <b86ed9cf-d5fd-09fb-eb82-0143c759f5cf@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 5 Sep 2018 06:51:20 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJy0kDYCC35GR5TGLYyYU-UjOys_r2sFMQZuFto5HkExg@mail.gmail.com>
Message-ID: <CAL_JsqJy0kDYCC35GR5TGLYyYU-UjOys_r2sFMQZuFto5HkExg@mail.gmail.com>
Subject: Re: [PATCH 1/3] of/fdt: Scan the root node properties earlier
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 8:49 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 08/30/18 12:05, Rob Herring wrote:
> > Scan the root node properties (#{size,address}-cells) earlier,
>
>                                                         ^^^^^^^
>                              before mdesc->dt_fixup() is called
>
> > so that
> > the dt_root_addr_cells and dt_root_size_cells variables are initialized
> > and can be used.
>                  by mdesc->dt_fixup()

That's an ARM specific detail. Granted, ARM is the only caller.

> >
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/of/fdt.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> Moving early_init_dt_scan_root() to inside early_init_dt_verify()
> puts something that has nothing to do with verifying the fdt
> into a function whose purpose is the verify.  It hides the side
> effect of initializing the dt_root_addr_cells and dt_root_size_cells
> variables.

It already has the side effect of setting initial_boot_params which
every subsequent function needs.

> I suggest creating a new function early_init_dt_scan_init_pre_dt_fixup(),
> move the chunk of code there instead of to early_init_dt_scan_nodes(),
> and call the new function from setup_machine_fdt(), just before
> calling  mdesc->dt_fixup().  This would be a little bit more code,
> but more clearly showing the intent.

I'm trying to reduce the number of functions arches call and renaming
would need a bunch of arch changes. This change will also let me make
early_init_dt_scan_root private as powerpc is the only user. I need to
dust off a patch for that.

I'd be more inclined to push exynos to remove this altogether. After
all, if they claim their bindings are unstable, they can't really
claim their bootloader is stable/fixed.

Rob
