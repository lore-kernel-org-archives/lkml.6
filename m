Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EF5C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC292238E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bg3vhCiP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC292238E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752890AbeGGHen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 03:34:43 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38402 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbeGGHel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 03:34:41 -0400
Received: by mail-pl0-f67.google.com with SMTP id b1-v6so3837737pls.5;
        Sat, 07 Jul 2018 00:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pNfVVRyr21nqrWIw7SM71QicGBqxaKES+kmnpFGgnpE=;
        b=Bg3vhCiPymtjyar1QR6cidcOU0lNwYvpNsyDDUmByiXfT8OCsbg74VOP2X2p82kLpm
         Wbo6k2S9Qua/g4NE/fRU5HnOdeEshey4SNkERDFftuXYtKjnOymx9vlud3qqy0BTxjFA
         lzwjoiPK8e9HiG/LEaNSVsC3UabQeTjVj44RnH1gaCDEiZ1IImo02z/hih28oGwq8Hd1
         sGKuv8teGYMpmp277RD2ybTdz/M4E77iuCRRgVk4nicbx9S8b63t0F7BFJiUPtd51P+V
         QnKQ2K8mQuZFmxuMX6IQ6ucqfVURKkNH3aYRym86UOOh1yMKmIGeFvBitGOjV4wrztF/
         k7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pNfVVRyr21nqrWIw7SM71QicGBqxaKES+kmnpFGgnpE=;
        b=V039GBXPp6yE2kg5FR3JHrXgEfXjiOXByM27M90+q8ceh5VBHZ4fMNqjGJCDCtgcHA
         EHmstbZ+IF3GEhjvxfKeg/o74EFsq/ignY7g/kKhtnyCcxBAAjKIW/IK2vue6yLZVC/M
         E6YU1lKImIuy9y/bCtwVTCiKOaCIV1kaGLyQTHrhr5UTrGpNHy19csU+yR+tRLytfTr6
         SK5sN5Ir9DN3gDSQkm5ssvN0+kHQbzU3FWoSa5r+/qN8EAC23w3C5JDeyRQ1a1JvRymv
         hXGVzgwWxtrBoq8mm4NdBcnrzHoLVxySyLzur1zg+lFGhRHxMt09vGd0noRxOK41TsPO
         a2fA==
X-Gm-Message-State: APt69E1Al/+NyvkGXXoApjyu1sgMjsbK3roUxNwdc6nEspjUha3ehBx5
        VjfuaIOoSE8U6w92W6wVUv92okFHhGzHThCzkb4=
X-Google-Smtp-Source: AAOMgpcy18m5lXq4bJbQhg1F0Hwf9PKYxeFYGLnazOHE+LEMiLWws85rXT5bj/YfyepzNfBlWPGygyExxOmClmlsNxQ=
X-Received: by 2002:a17:902:683:: with SMTP id 3-v6mr13057684plh.291.1530948880932;
 Sat, 07 Jul 2018 00:34:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:2604:0:0:0:0 with HTTP; Sat, 7 Jul 2018 00:34:40
 -0700 (PDT)
In-Reply-To: <1530815198.6642.1@smtp.crapouillou.net>
References: <20180703123214.23090-1-paul@crapouillou.net> <20180703123214.23090-2-paul@crapouillou.net>
 <CANc+2y4ZJDKou4x570zNv82fSAxiOpbZfd3rFNB2M5Ft1C3eiQ@mail.gmail.com> <1530815198.6642.1@smtp.crapouillou.net>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Sat, 7 Jul 2018 13:04:40 +0530
Message-ID: <CANc+2y5wkp2mHb+Z=Rh332uY+ixhUxbM3EM3HEs-fq5efa+msQ@mail.gmail.com>
Subject: Re: [PATCH 01/14] dmaengine: dma-jz4780: Avoid hardcoding number of channels
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 July 2018 at 23:56, Paul Cercueil <paul@crapouillou.net> wrote:
> Hi PrasannaKumar,
>
>
>> Hi Paul,
>>
>> On 3 July 2018 at 18:02, Paul Cercueil <paul@crapouillou.net> wrote:
>>>
>>>  As part of the work to support various other Ingenic JZ47xx SoC
>>> versions,
>>>  which don't feature the same number of DMA channels per core, we now
>>>  deduce the number of DMA channels available from the devicetree
>>>  compatible string.
>>>
>>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>  ---
>>>   drivers/dma/dma-jz4780.c | 53 +++++++++++++++++++++++++++++-----------
>>>   1 file changed, 39 insertions(+), 14 deletions(-)
>>>
>>>  diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
>>>  index 85820a2d69d4..b40f491f0367 100644
>>>  --- a/drivers/dma/dma-jz4780.c
>>>  +++ b/drivers/dma/dma-jz4780.c
>>>  @@ -16,6 +16,7 @@
>>>   #include <linux/interrupt.h>
>>>   #include <linux/module.h>
>>>   #include <linux/of.h>
>>>  +#include <linux/of_device.h>
>>>   #include <linux/of_dma.h>
>>>   #include <linux/platform_device.h>
>>>   #include <linux/slab.h>
>>>  @@ -23,8 +24,6 @@
>>>   #include "dmaengine.h"
>>>   #include "virt-dma.h"
>>>
>>>  -#define JZ_DMA_NR_CHANNELS     32
>>>  -
>>>   /* Global registers. */
>>>   #define JZ_DMA_REG_DMAC                0x1000
>>>   #define JZ_DMA_REG_DIRQP       0x1004
>>>  @@ -135,14 +134,20 @@ struct jz4780_dma_chan {
>>>          unsigned int curr_hwdesc;
>>>   };
>>>
>>>  +enum jz_version {
>>>  +       ID_JZ4780,
>>>  +};
>>>  +
>>>   struct jz4780_dma_dev {
>>>          struct dma_device dma_device;
>>>          void __iomem *base;
>>>          struct clk *clk;
>>>          unsigned int irq;
>>>  +       unsigned int nb_channels;
>>>  +       enum jz_version version;
>>>
>>>          uint32_t chan_reserved;
>>>  -       struct jz4780_dma_chan chan[JZ_DMA_NR_CHANNELS];
>>>  +       struct jz4780_dma_chan chan[];
>>
>>
>> Looks like a variable length array in struct. I think there is some
>> effort to remove the usage of VLA. Can you revisit this? I may be
>> wrong, please feel free to correct.
>
>
> Are you sure? It's the first time I hear about it.
> Could anybody confirm?

Please see [1] for info.

Variable Length Arrays in struct is expressly forbidden in C99, C11.
Clang does not support it. To make kernel compile with Clang few
people are trying to remove/reduce VLAIS usage.

1. https://blog.linuxplumbersconf.org/2013/ocw/system/presentations/1221/original/VLAIS.pdf
