Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF33C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0CA120850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiJexr60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0CA120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeLEEmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 23:42:09 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40675 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeLEEmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 23:42:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so8410198pgp.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 20:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6G2KpmpfCtmqQlw0KlLFcSMUcNS3EWFTLTfjH5tvPWA=;
        b=EiJexr604usee2Xz36cu7qmvYq262sxHpdFxW1/kmiqcvFpbUhbS+sEs4uFrQU1wq5
         wkxR2E2vB8PWm/vaHtZHraB0HKG/1v8JbcOOMdc1cgpQdHrEYGerkflrTqD+xDbqWQEz
         LExpdikPc7hWY4zOC94400OA4AQr2U06LbUb40PaQN9MbdRQfmwRKTRA7032QPRw6v6j
         JjWeNWMROwBW2L4DgS5gPeGPB6sQ1V60wDuiKlyijNcWch3uPK7B2d71T/jtxHvoIXkV
         bIprobZBLZ1KtxFl6uFPpxmCN8yg3G7HzhDmtw4GQuBg6LbK+CYACGhQO3qgs4t5Qrzq
         +Mcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6G2KpmpfCtmqQlw0KlLFcSMUcNS3EWFTLTfjH5tvPWA=;
        b=IjBqRXCvQ+1SxdVAKrKAsaLbrZXLeNxlox2v1Hex7QQcL13e83ryv9eu69atX6Hr//
         8uuNFG9atgeb8AQQ8fHZ2khxopnzpXkAYTesxF4fFS58RNRNkteULshs/cFuKJsJLF9I
         9wNZ48G1upBklFcTJkRGFzDxRcJX6z5yaCIeSxXRG8HlCiXluWxORMGlRqQJNJW+V3MV
         HUsRGKZdJghGhgMzdRuYwfwTOYxQlGNeq+LO1KKykGWgqlFDTCB25p6+/q1Voaz9bO+e
         dk/hABopesxg3Ry1hfcFH8fCzCCzVT/uggC8kGJvmz2C18hw+Oahrc9JlAnKFQ1L4QK0
         ufRQ==
X-Gm-Message-State: AA+aEWbyeizsVWnrHM/o+d5vybWK40NsSK+A09s4ZJNW9R98pUp0g5G6
        ozU73jATSQdTf/vBHcPBwW1PoqEgUBsQJS2Cuoc=
X-Google-Smtp-Source: AFSGD/XdtvLuByabpQA527LtOlvwusHUuKSPq3xzOtaVji+cQ4qW1THHtVQnqm1/Jh1IUcI2fmF4Tg8976oUsLA2qr0=
X-Received: by 2002:a63:4d66:: with SMTP id n38mr19256346pgl.270.1543984928422;
 Tue, 04 Dec 2018 20:42:08 -0800 (PST)
MIME-Version: 1.0
References: <5bdfa97d.1c69fb81.4aef7.c9f7@mx.google.com>
In-Reply-To: <5bdfa97d.1c69fb81.4aef7.c9f7@mx.google.com>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Wed, 5 Dec 2018 10:11:56 +0530
Message-ID: <CAJr6mf3d4vEQBk2HEsxnoX4HKisoBV1ywRhekq_homot_DJemw@mail.gmail.com>
Subject: Re: [PATCH] arch/powerpc: Use dma_zalloc_coherent
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 7:52 AM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Replaced dma_alloc_coherent + memset with dma_zalloc_coherent
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Any comment on this patch?

> ---
>  arch/powerpc/sysdev/fsl_rmu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/fsl_rmu.c b/arch/powerpc/sysdev/fsl_rmu.c
> index 88b35a3d..8b0ebf3 100644
> --- a/arch/powerpc/sysdev/fsl_rmu.c
> +++ b/arch/powerpc/sysdev/fsl_rmu.c
> @@ -756,15 +756,13 @@ fsl_open_outb_mbox(struct rio_mport *mport, void *dev_id, int mbox, int entries)
>         }
>
>         /* Initialize outbound message descriptor ring */
> -       rmu->msg_tx_ring.virt = dma_alloc_coherent(priv->dev,
> +       rmu->msg_tx_ring.virt = dma_zalloc_coherent(priv->dev,
>                                 rmu->msg_tx_ring.size * RIO_MSG_DESC_SIZE,
>                                 &rmu->msg_tx_ring.phys, GFP_KERNEL);
>         if (!rmu->msg_tx_ring.virt) {
>                 rc = -ENOMEM;
>                 goto out_dma;
>         }
> -       memset(rmu->msg_tx_ring.virt, 0,
> -                       rmu->msg_tx_ring.size * RIO_MSG_DESC_SIZE);
>         rmu->msg_tx_ring.tx_slot = 0;
>
>         /* Point dequeue/enqueue pointers at first entry in ring */
> --
> 2.7.4
>
