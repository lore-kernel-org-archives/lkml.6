Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9373CC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 03:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49FFE20879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 03:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FfMIJow9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49FFE20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeLMDNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 22:13:44 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:47008 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbeLMDNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 22:13:43 -0500
Received: by mail-yb1-f195.google.com with SMTP id f9so226364ybm.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 19:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MldMfPal7dPKOr4CmHsfYUHEZUZOt1yez2Jjq7koQXo=;
        b=FfMIJow9xXjJOb9uv+S19WVho/xpoSYdlRYljj8NsdspAOdNL73U6VH+gl/3OTmdRQ
         ynJzdHPThQIJ4l/PQWrQuC36P5q2EnvePsoGDEMF3Fx61d1sy8GUptwnACHS+q112Vbo
         YfbkFbVMptj9BV93h65Mhgrl2Ane1hawHzGIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MldMfPal7dPKOr4CmHsfYUHEZUZOt1yez2Jjq7koQXo=;
        b=R9mJm60EVnrWK9y8++a71m/12x78LH6hTXcp0HQxKWz2nN2eHRy0tTNQHgQFZlk45j
         okqNbHJbdqmJ1ls2zyA6vGwEZAzTCvzeIa5irNPcikKx+n/zQVNE2U8XKYLo/5XKlQnD
         ELly9vUaml5sUr/KQXlS5ozQKkibVReIOICzAgp6RaMFI5kZ9HysUDdivg/vhI4r06bn
         6+Kw4xO+KrlNhPu/VUpJ5887IYfzOMXLfQdCRVPEP37nMGkcxmxaXcImygO0uhgamZds
         cSTf/vk/PSy3yGKhWhsBEqaJ7oFRW3aJl3MhTRZRW4D4DDY7Niqv1+sIuTvk4cviwzKr
         lbmA==
X-Gm-Message-State: AA+aEWbnYtC4X6npEXop3c31qmuJuTXdhKFqz64MEUSzzjiT5DzmcNDo
        mk6Nm6NHG7/W8UdRqO9MZaSi+1HE+NdEEQ==
X-Google-Smtp-Source: AFSGD/U/8uTQSwO/6UlSC7mAVr7LCZVADXKVmO+03gx6zfezVtwAS05GtmHTYAet+9DkSHnWtny/zw==
X-Received: by 2002:a5b:648:: with SMTP id o8mr11325287ybq.504.1544670822354;
        Wed, 12 Dec 2018 19:13:42 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id 136sm229518ywm.28.2018.12.12.19.13.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 19:13:41 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id d187so243518ybb.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 19:13:41 -0800 (PST)
X-Received: by 2002:a25:a44:: with SMTP id 65-v6mr22661413ybk.373.1544670820921;
 Wed, 12 Dec 2018 19:13:40 -0800 (PST)
MIME-Version: 1.0
References: <20180821170629.18408-1-matwey@sai.msu.ru> <20180821170629.18408-3-matwey@sai.msu.ru>
 <2213616.rQm4DhIJ7U@avalon> <20181207152502.GA30455@infradead.org>
 <CAAFQd5C6gUvg8p0+Gtk22Z-dmeMPytdF4HujL9evYAew15bUmA@mail.gmail.com>
 <20181212090917.GA30598@infradead.org> <CAAFQd5DhDOfk_2Dhq4MfJmoxpXP=Bm36HMZ55PSXxwkTAoCXSQ@mail.gmail.com>
 <20181212135440.GA6137@infradead.org>
In-Reply-To: <20181212135440.GA6137@infradead.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 13 Dec 2018 12:13:29 +0900
X-Gmail-Original-Message-ID: <CAAFQd5C4RbMxRP+ox+BDuApMusTD=WUD9Vs6aWL3u=HovuWUig@mail.gmail.com>
Message-ID: <CAAFQd5C4RbMxRP+ox+BDuApMusTD=WUD9Vs6aWL3u=HovuWUig@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] media: usb: pwc: Don't use coherent DMA buffers
 for ISO transfer
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ezequiel Garcia <ezequiel@collabora.com>, hdegoede@redhat.com,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        rostedt@goodmis.org, mingo@redhat.com,
        Mike Isely <isely@pobox.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Colin King <colin.king@canonical.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        keiichiw@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 10:54 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Dec 12, 2018 at 06:34:25PM +0900, Tomasz Figa wrote:
> > The typical DMA-buf import/export flow is as follows:
> > 1) Driver X allocates buffer A using this API for device x and gets a
> > DMA address inside x's DMA (or IOVA) address space.
> > 2) Driver X creates a dma_buf D(A), backed by buffer A and gives the
> > user space process a file descriptor FD(A) referring to it.
> > 3) Driver Y gets FD(A) from the user space and needs to map it into
> > the DMA/IOVA address space of device y. It doe it by calling
> > dma_buf_map_attachment() which returns an sg_table describing the
> > mapping.
>
> And just as I said last time I think we need to fix the dmabuf code
> to not rely on struct scatterlist.  struct scatterlist is an interface
> that is fundamentally page based, while the dma coherent allocator
> only gives your a kernel virtual and dma address (and the option to
> map the buffer into userspace).  So we need to fix to get the interface
> right as we already have DMAable memory withour a struct page and we
> are bound to get more of those.  Nevermind all the caching implications
> even if we have a struct page.

Putting aside the problem of memory without struct page, one thing to
note here that what is a contiguous DMA range for device X, may not be
mappable contiguously for device Y and it would still need something
like a scatter list to fully describe the buffer.

Do we already have a structure that would work for this purposes? I'd
assume that we need something like the existing scatterlist but with
page links replaced with something that doesn't require the memory to
have struct page, possibly just PFN?

>
> It would also be great to use that opportunity to get rid of all the
> code duplication of almost the same dmabug provides backed by the
> DMA API.

Could you sched some more light on this? I'm curious what is the code
duplication you're referring to.

Best regards,
Tomasz
