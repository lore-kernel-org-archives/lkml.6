Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682D4C46465
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317712081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317712081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbeKGSMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 13:12:00 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46200 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbeKGSL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 13:11:59 -0500
Received: by mail-ua1-f67.google.com with SMTP id v24so5560371uap.13;
        Wed, 07 Nov 2018 00:42:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nz4IB2h1WYh14zbg9kl2gKtvqMP2UQKTqCpKSezvQbA=;
        b=bjYLZCk8G/Pc30Yvzdj80iuJiJOsowx0LeowanLEvWZ8L9AVfGuAGT/IbmkfSAErrR
         2ODsp4BPWvPOAKpLT2lwdDfUi4vKFd6eLj0i9U4fDtLBix3BNxHNWNMxwrsNTRkRpoI6
         mGla5RWhOi6IfAHBjcQIAhxXM3Dzo1kbJMA31DLUZTdVZZ+X6hERrMgyP+RkaaKtZADh
         Ir9VYRGZA1F/FPu99SgNTdRKvlC74kw7sm5d03rxH0och97sPMJa4SvqhNQJrt2MtumU
         Kd3CGjaEBQlSivQwWFWwLP2+0O3OAXbAiWbk6I8f0iKcX+0via26m7G5j/3feEAsZrDh
         1iHA==
X-Gm-Message-State: AGRZ1gJ099IKfR9hrDqga2zdIgP6+jn6jVK4h652CC4ZJIkoRo+QAPDm
        wmjERB6w47ftJnOucrrxJllFwxKHgJCPaYdfP/I=
X-Google-Smtp-Source: AJdET5cYPC34Qj4Gmc0DK/0DmMypotov7dKE/VQlW8VkrK+/JA/9TzFOgIO3n85gq3uBb170SlttlwZd/5gm8BltTBg=
X-Received: by 2002:ab0:465:: with SMTP id 92mr420321uav.28.1541580157669;
 Wed, 07 Nov 2018 00:42:37 -0800 (PST)
MIME-Version: 1.0
References: <git-mailbomb-linux-master-b4ebe6063204da58e48600b810a97c29ae9e5d12@kernel.org>
 <CAMuHMdUosqWTn5yDjGMWrLpWEyZfxtGWYfqmenYVqE8g7HEt7Q@mail.gmail.com> <44b77976-0efe-02d0-3c4e-4e54f91c4fe7@arm.com>
In-Reply-To: <44b77976-0efe-02d0-3c4e-4e54f91c4fe7@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 7 Nov 2018 09:42:26 +0100
Message-ID: <CAMuHMdWTe+B8=a5yz+VjJU9G+mss7+61U3jT7i_WgMCYD7ppCw@mail.gmail.com>
Subject: Re: IOMMU breakage on arm64
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Tue, Nov 6, 2018 at 9:20 PM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2018-11-06 7:44 pm, Geert Uytterhoeven wrote:
> > On Tue, Oct 23, 2018 at 1:40 AM Linux Kernel Mailing List
> > <linux-kernel@vger.kernel.org> wrote:
> >> Commit:     b4ebe6063204da58e48600b810a97c29ae9e5d12
> >> Parent:     7d21ee4c719f00896767ce19c4c01a56374c2ced
> >> Refname:    refs/heads/master
> >> Web:        https://git.kernel.org/torvalds/c/b4ebe6063204da58e48600b810a97c29ae9e5d12
> >> Author:     Christoph Hellwig <hch@lst.de>
> >> AuthorDate: Thu Sep 20 14:04:08 2018 +0200
> >> Committer:  Christoph Hellwig <hch@lst.de>
> >> CommitDate: Mon Oct 1 07:28:03 2018 -0700
> >>
> >>      dma-direct: implement complete bus_dma_mask handling
> >>
> >>      Instead of rejecting devices with a too small bus_dma_mask we can handle
> >>      by taking the bus dma_mask into account for allocations and bounce
> >>      buffering decisions.
> >>
> >>      Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > I  have bisected the following crash to the above commit:
>
> I think that commit mostly just changes the presentation of my
> underlying cockup - see here for what should fix it:
> https://patchwork.kernel.org/patch/10670177/

Thanks, that fixed the issue.

> I have a feeling we've ironed out crash-on-early-domain-free bugs in the
> SMMU drivers already - arm-smmu certainly has an early return in
> arm_smmu_destroy_domain_context() which should behave exactly like your
> diff below, while I think arm-smmu-v3 gets away with it by virtue of
> smmu_domain->cfg being unset, but I'll double-check that when I'm fresh
> tomorrow (Jean-Philippe reported SMMUv3 hitting the DMA thing to me
> internally, but didn't mention any crash).

OK, I'll send a proper patch for the ipmmu-vmsa driver.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
