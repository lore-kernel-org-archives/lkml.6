Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD3BC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286C720878
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286C720878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbeLCMaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:30:25 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:37348 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeLCMaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:30:24 -0500
Received: by mail-vk1-f196.google.com with SMTP id 197so2837376vkf.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 04:29:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yUZHky2r/cBF6ZIEq3biORoGyFuDOtLgbKSPVwAirg0=;
        b=Q1Zb2cq2N/RWfE4AqSbaxhxcnH8NZoREYBpYF+zlKel+pLYRSrTi2dIV/wgLkTYWga
         KeNgeT8BGu6QArBqxNSU243/JE0/s7k2km1wMw0IBkY4Oje7OogY7YVXA1fwkZz9Hh+x
         0f/mK+kNv9F9f7zlL6HrYFCqJYbqkvSYwSX7UF2wo1rR95YdCMZO6hjhbHhupUR+2FHj
         syPtUOb3nAMAdxCQS95itAj6MDAcsvF9tl8rFIDfDx8wc/hqcjwNAqFwOd0XQydP/dr3
         ZgUTutyb9/9352MTYss3dCg1AjIHScZTzp3RhNknK0n+UDJsZA+MkNT0Y89RByl1h6oH
         RuFQ==
X-Gm-Message-State: AA+aEWYpRimlesRet6cYn99WCh/fKqs9lRBZ7dmhRnl6PWsV/vEM9QPi
        js1dmLVuf6JZb/MVNFRh/Nnu4+WzViFpjzLbhqw=
X-Google-Smtp-Source: AFSGD/XWrQ+yfrmrpuMP65NsPutHt2d5yY2dCPZz+mFNvS51R0EG5ZJ5iAODXv9MtgxvV4b7KaVNTHSYxktlHVdgw5A=
X-Received: by 2002:a1f:2ed7:: with SMTP id u206mr6616364vku.72.1543840171983;
 Mon, 03 Dec 2018 04:29:31 -0800 (PST)
MIME-Version: 1.0
References: <17b745712a31927fda2d5d93571884122d7c4727.1539391675.git.fthain@telegraphics.com.au>
In-Reply-To: <17b745712a31927fda2d5d93571884122d7c4727.1539391675.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Dec 2018 13:29:19 +0100
Message-ID: <CAMuHMdX3U8ck2sUTK9qm7=tORbzjad-OaMiqFp1vY1W-zQgYqA@mail.gmail.com>
Subject: Re: [PATCH] m68k: Unroll raw_outsb() loop
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 3:10 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> Unroll the raw_outsb() loop using the optimized assembler code from
> raw_outsw(). That code is copied and pasted, with movew changed to moveb.
>
> This improves the performance of sequential write transfers using mac_esp
> in PIO mode by 5% or 10%. (The DMA controller on the 840av/660av models is
> still unsupported so PIO transfers are used.)
>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
I.e., applied and queued for v4.21.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
