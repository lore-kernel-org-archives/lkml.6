Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05000C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE31A208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yG5uDyp7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE31A208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388613AbeG0OkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729568AbeG0OkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:40:11 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0FEB208B9;
        Fri, 27 Jul 2018 13:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532697497;
        bh=8i1yvTmC1huTf78EBqYiGO//lFJmzaBy6PwPOj1jgls=;
        h=In-Reply-To:References:From:Date:Subject:To:From;
        b=yG5uDyp7h1RnqiPHbB0dIUrK6Nry7zRk4PF0rdYdxCSE79inKdFJijrZEVUGUmqGb
         ZPGGBZc2fkVy4iRUAmU2hS8vracHk3oSheLNrlVJpSjEvKahKj2JMbP9NRghtD2SBq
         zvdiYUYEEEu+g4PgE/OCbsqldtFM/ylzGd3DUzMQ=
Received: by mail-wr1-f52.google.com with SMTP id c13-v6so5037319wrt.1;
        Fri, 27 Jul 2018 06:18:16 -0700 (PDT)
X-Gm-Message-State: AOUpUlGLd7B4LRG8luIWC+rLMPQYshA4noCAE9Sd5YEb9ckUoFrVwwkT
        Ko01nmg3GV52cwaXRRshw79x6skDfHfULUpItXo=
X-Google-Smtp-Source: AAOMgpfDiuZTtEQW0hOM3cCrG+G6YwXlkEGlzc7koU8pmdtD7x+f2SJqGcJmsoB3ZExGD2JivRX2cr7B8Hr58RwC6+w=
X-Received: by 2002:adf:f390:: with SMTP id m16-v6mr4584120wro.279.1532697495451;
 Fri, 27 Jul 2018 06:18:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 06:18:14
 -0700 (PDT)
In-Reply-To: <CAJKOXPeaguNxRr7pCArJ5Db4tS6Kr5BDheCxskY+vd0dUN+0GQ@mail.gmail.com>
References: <CAJKOXPeaguNxRr7pCArJ5Db4tS6Kr5BDheCxskY+vd0dUN+0GQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 27 Jul 2018 15:18:14 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfageiBVXddtdJRBS+092O3QfD0yoS_Mk+PoX7+qNYNUA@mail.gmail.com>
Message-ID: <CAJKOXPfageiBVXddtdJRBS+092O3QfD0yoS_Mk+PoX7+qNYNUA@mail.gmail.com>
Subject: Re: [BUG BISECT] Ethernet fail on VF50 (OF: Don't set default
 coherent DMA mask)
To:     Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Christoph Hellwig <hch@lst.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>,
        Fugang Duan <fugang.duan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 July 2018 at 15:11, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Hi,
>
> On today's next, the bisect pointed commit
> ff33d1030a6ca87cea9a41e1a2ea7750a781ab3d as fault for my boot failures
> with NFSv4 root on Toradex Colibri VF50 (Iris carrier board).
>
> Author: Robin Murphy <robin.murphy@arm.com>
> Date:   Mon Jul 23 23:16:12 2018 +0100
>     OF: Don't set default coherent DMA mask
>
> Board: Toradex Colibri VF50 (NXP VF500, Cortex A5, serial configured
> with DMA) on Iris Carrier.
>
> It looks like problem with Freescale Ethernet driver:
> [   15.458477] fsl-edma 40018000.dma-controller: coherent DMA mask is unset
> [   15.465284] fsl-lpuart 40027000.serial: Cannot prepare cyclic DMA
> [   15.472086] Root-NFS: no NFS server address
> [   15.476359] VFS: Unable to mount root fs via NFS, trying floppy.
> [   15.484228] VFS: Cannot open root device "nfs" or
> unknown-block(2,0): error -6
> [   15.491664] Please append a correct "root=" boot option; here are
> the available partitions:
> [   15.500188] 0100           16384 ram0
> [   15.500200]  (driver?)
> [   15.506406] Kernel panic - not syncing: VFS: Unable to mount root
> fs on unknown-block(2,0)
> [   15.514747] ---[ end Kernel panic - not syncing: VFS: Unable to
> mount root fs on unknown-block(2,0) ]---
>
> Attached - defconfig and full boot log.
>
> Any hints?
> Let me know if you need any more information.

My Exynos boards also fail to boot on missing network:
https://krzk.eu/#/builders/21/builds/799/steps/10/logs/serial0

As expected there are plenty of "DMA mask not set" warnings... and
later dwc3 driver fails with:
    dwc3: probe of 12400000.dwc3 failed with error -12
which is probably the answer why LAN attached to USB is not present.

Best regards,
Krzysztof
