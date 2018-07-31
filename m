Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722BFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCCE20862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j4BVfX+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCCE20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbeGaHpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 03:45:34 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:42569 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbeGaHpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 03:45:33 -0400
Received: by mail-yb0-f195.google.com with SMTP id c10-v6so5716945ybf.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 23:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e5caXUogE0rfXz6bwSVzTjVit3uhCHDvkJZvyD1/m7M=;
        b=j4BVfX+nwa6N73KBg1YAiZfOyWojL23a4xTgaiRmUsMNn75WAsFIIXhQv1W4j1PNsm
         UqHB9mC2yj8xDqXyeaoTT5/swidkFT3va5ig/WsN2xo053ZjLeyeNa3bLcJmYgyVcx2n
         qumlYtr92Ws4pUDzCDo0Ktss7LIDnB6Ixkd5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e5caXUogE0rfXz6bwSVzTjVit3uhCHDvkJZvyD1/m7M=;
        b=eU6HDDiNae66oW3zgHhEFlbVJZQADlxgr+kL8AtIELhh6e/vFUnexbm/nLT89hMCvn
         5mbliMdfsc60bBliSNfn41CITio1SSnA8CvqDUPAaJ03La6nECgtD52ahAK6Kgd+eNLK
         u+mh0e4b+0EavbYkoYVDATCu8AyCuwcwI/Xxl4PAKi34wvs/WvHaoBpHWw8zWohvR69Q
         XTcrHCt8x/zK0itPe4QrwZQeNA/y9RGFcBnnWPZFsNcJEnKvAc2IcKTJNt904wYcWcZn
         i4GpBczvlqx/pTvRnaOVGYmMnuOFoYKjl3/h60V1UeJKRndecfZwG6Z7zsO2/PjXjEvP
         +bXQ==
X-Gm-Message-State: AOUpUlF6FcFZA/H1jbBdA0iiZgLdAPra0fqZOAynDn+aHrF4ngK5O6id
        t9UoUFo8+hez6x+AsrxM1+FXtvD2EtI=
X-Google-Smtp-Source: AAOMgpfAXCpPDFR7c7z7VHprskoQPTzXeTO7QAkk2qLMUEfAyNmedZzDBttbBUvOqFzBnf9wv+KrZw==
X-Received: by 2002:a25:aea5:: with SMTP id b37-v6mr10631644ybj.303.1533017217116;
        Mon, 30 Jul 2018 23:06:57 -0700 (PDT)
Received: from mail-yw0-f180.google.com (mail-yw0-f180.google.com. [209.85.161.180])
        by smtp.gmail.com with ESMTPSA id w143-v6sm21865975yww.49.2018.07.30.23.06.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 23:06:56 -0700 (PDT)
Received: by mail-yw0-f180.google.com with SMTP id c135-v6so5338192ywa.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 23:06:56 -0700 (PDT)
X-Received: by 2002:a0d:dcc3:: with SMTP id f186-v6mr10001707ywe.66.1533017216195;
 Mon, 30 Jul 2018 23:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180617143625.32133-1-matwey@sai.msu.ru> <20180617143625.32133-2-matwey@sai.msu.ru>
 <c02f92a8998fc62d3e3d48aa154fbaa7e223dd10.camel@collabora.com>
 <CAJs94EavBDcFHpd0KcCZJTgWf0JC=AEDY=X8b3P2nZvt8mBCPA@mail.gmail.com>
 <eb2b495fe7e8bbeaf3f9e2814be4923583482852.camel@collabora.com> <20180730130702.27664d15@coco.lan>
In-Reply-To: <20180730130702.27664d15@coco.lan>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 31 Jul 2018 15:06:45 +0900
X-Gmail-Original-Message-ID: <CAAFQd5A6hDdPR87r5mq=-JxeSGGwaiTjHFBH04q7tEcd3oZJdQ@mail.gmail.com>
Message-ID: <CAAFQd5A6hDdPR87r5mq=-JxeSGGwaiTjHFBH04q7tEcd3oZJdQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: usb: pwc: Don't use coherent DMA buffers for
 ISO transfer
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Alan Stern <stern@rowland.harvard.edu>, hdegoede@redhat.com,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        rostedt@goodmis.org, mingo@redhat.com,
        Mike Isely <isely@pobox.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Colin King <colin.king@canonical.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 1:07 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> Em Tue, 17 Jul 2018 17:10:22 -0300
> Ezequiel Garcia <ezequiel@collabora.com> escreveu:
>
> > Yeah, and not setting URB_NO_TRANSFER_DMA_MAP makes the USB core
> > create DMA mappings and use the streaming API. Which makes more
> > sense in hardware without hardware coherency.
> >
> > The only thing that bothers me with this patch is that it's not
> > really something specific to this driver. If this fix is valid
> > for pwc, then it's valid for all the drivers allocating coherent
> > memory.
>
> We're actually doing this change on other drivers:
>         https://git.linuxtv.org/media_tree.git/commit/?id=d571b592c6206
>
> I suspect that the reason why all USB media drivers were using
> URB_NO_TRANSFER_DMA_MAP is just because the first media USB driver
> upstream used it.
>
> On that time, I remember I tried once to not use this flag, but there
> was something that broke (perhaps I just didn't know enough about the
> USB layer - or perhaps some fixes happened at USB core - allowing it
> to be used with ISOC transfers).
>
> Anyway, nowadays, I fail to see a reason why not let the USB core
> do the DMA maps. On my tests after this patch, at the boards I tested
> (arm and x86), I was unable to see any regressions.

I can see one reason:

usb_alloc_coherent() would use dma_pool_alloc() with a fallback to
dma_alloc_coherent() to do the allocation. I'm not sure what a typical
size for an URB buffer is, but I assume that it's definitely more than
1 page. Order >0 allocations with page allocator (and SLAB, which
eventually just falls back to page allocator for such large
allocations) are generally considered costly. With allocation through
DMA API, mechanisms such as CMA or IOMMU can be used (if available),
making it much more likely to have the allocation satisfied on heavy
load / long uptime systems.

Best regards,
Tomasz
