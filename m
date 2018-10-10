Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6E4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3529821479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LKQlVvhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3529821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeJJTWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:22:34 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:46897 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeJJTWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:22:34 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w9AC0cj6024971;
        Wed, 10 Oct 2018 21:00:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w9AC0cj6024971
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539172839;
        bh=s+KR6rLoN3XgxTfk5VFrNqQ7a3XclIFRTAYgFzRtxzc=;
        h=From:Date:Subject:To:Cc:From;
        b=LKQlVvhccFAkk7nUriHD+f+whKC6I7F9LLj3Pr8z3yOlpX5+UoLu570ATUnXNu/w7
         GWYpmdyH6ZhCjNrS4NmKNSQxjzQpKL8Gpy7vccPqQaCbYJZ1YMa3AiToJ8z+LutJfN
         y0B3dRu5PrQzKgZqgwqp8DQ2os3bLt6bMxo1uQWEGhpT9dwYVV7vY9Z24HfnYwHn5W
         S5Lfmq8FwZi2Qq95qkyQYjjijbbGXpTzrUDQNeAtV2NTHk6jAr0D1mpcZLXmLzAF85
         nv89f0py8slg4cy/wmPnXj5HFXaqUlOIfyhYnjaTt/YfTioWwOJC7tFZHSbrITQd+8
         VjvQ3/HenAQXQ==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id m5so4728274vsk.6;
        Wed, 10 Oct 2018 05:00:38 -0700 (PDT)
X-Gm-Message-State: ABuFfojkDYx8zJbWlNMzv4nN90Qv95iCSve5di2Kulj+nol3/JGNURcS
        49Pm4SsULQPUHTo+/Ko9hXNqirGn0nhh8wyX9D0=
X-Google-Smtp-Source: ACcGV636peRwGSFeaf2RlGuVMiMm/jpmqTmeK3C0Ymc7TzA5AKHi1G2ilsWj/ZPU6xlz5UgUC6jeMJrDRrzGhlKMg/Q=
X-Received: by 2002:a67:f1d2:: with SMTP id v18mr12045816vsm.181.1539172837645;
 Wed, 10 Oct 2018 05:00:37 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 10 Oct 2018 21:00:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNARcDO34uCLou0dHhnHj46XFwB5jT-AmT=ySZZgxoWV6LQ@mail.gmail.com>
Message-ID: <CAK7LNARcDO34uCLou0dHhnHj46XFwB5jT-AmT=ySZZgxoWV6LQ@mail.gmail.com>
Subject: [DMA-engine Question] inconsistent policy of src_addr_widths, dst_addr_widths
To:     "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>
Cc:     Vinod <vkoul@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


When I wrote my DMA engine driver,
I had difficulty in understanding
what to set to the struct dma_device members.


For example, src_addr_widths.
I see two driver groups regarding this.



[A] BIT(DMA_SLAVE_BUSWIDTH_*_BYTES) are OR'ed

For example, st_fdma.c

https://github.com/torvalds/linux/blob/v4.19-rc4/drivers/dma/st_fdma.c#L729



[B] DMA_SLAVE_BUSWIDTH_*_BYTES are directly OR'ed without BIT()

For example, sh/rcar-dmac.c

https://github.com/torvalds/linux/blob/v4.19-rc4/drivers/dma/sh/rcar-dmac.c#L1778



Which is correct?



If we go with [A],
BIT(DMA_SLAVE_BUSWIDTH_64_BYTES) i.e. BIT(64)
would not fit in ddevice->src_addr_widths whose type is u32.


If we go with [B], the following formula is met.
DMA_SLAVE_BUSWIDTH_3_BYTES ==
DMA_SLAVE_BUSWIDTH_1_BYTE | DMA_SLAVE_BUSWIDTH_2_BYTES

We never know whether 3_BYTES is supported,
or it is just a combination of 1_BYTE and 2_BYTES.



-- 
Best Regards
Masahiro Yamada
