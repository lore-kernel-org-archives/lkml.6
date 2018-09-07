Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A2DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5C92075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JUQAO70o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5C92075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeIGNed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:34:33 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45927 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbeIGNed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:34:33 -0400
Received: by mail-yb1-f193.google.com with SMTP id h22-v6so5180401ybg.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 01:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/TFX0qFDwf8L8mn9QNi9fc0osWsjZ51vPqU2TPZ6/Q=;
        b=JUQAO70oSmnsE2FA0CmNaDi3oHRyTuTPsu/Vd6o2QhQw0OQG5RXmzrUTTBJpQpSt25
         KU6raQ8tHRh7QtWjXiZ/SG4HmpurWgv2rXjJjlfd3jw28PVQcJDNX24lBScI+ASCWCJo
         ur8CN7TDvKaEK20ll7WgE7ybFRKWnr7MNtDb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/TFX0qFDwf8L8mn9QNi9fc0osWsjZ51vPqU2TPZ6/Q=;
        b=IhA3iWRTTMRhdpKQUDmnwTbV5lnWkh0AHrqhHvQLgBeBliouJUiD3TU9ITqAt29bDf
         k5oFzTmJw0s6ehzdOT5aFf29RtzhMt36TAWmwtN1ZPcPV78vxzkQd5G0akc4GvZWv2s2
         LDC0L9ffWr3iDU/lslRqKiUx+Dmi21MfqLcKbhkbfkOmHjX2DCZ8BRfJCf2UnszwthGZ
         b05pGCIH1p0nMvnyyBO0I9+XRA3CmuZtjdQNCWch25UcEqCkJgmqvP3T1DiO74hpWpPU
         LJlIErgF9KNKHSZ4oDuLOKPdgRBxdMahidQkm/UXN3T+utOUq6K5yFmrbtIexzMls2iu
         WADA==
X-Gm-Message-State: APzg51CBNi1mm+N/dMjAz51Hl1e4Yg72KhpgJiMiYzYK820VevxkhfVA
        xVeF+06iL5MBlWhj9LblHgtBzJrIKR3GVw==
X-Google-Smtp-Source: ANB0VdbzBILJjJZi0n74fsHxbRk2lB2+DxeFB+0ImeJGHpb/kNLCtxdDxSbj7EG/nkJNNXlb5dEadg==
X-Received: by 2002:a25:be84:: with SMTP id i4-v6mr3431653ybk.272.1536310475434;
        Fri, 07 Sep 2018 01:54:35 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id b185-v6sm2801288ywf.12.2018.09.07.01.54.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 01:54:34 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id e18-v6so5198129ybq.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 01:54:33 -0700 (PDT)
X-Received: by 2002:a25:a568:: with SMTP id h95-v6mr3425919ybi.303.1536310473465;
 Fri, 07 Sep 2018 01:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180830172030.23344-1-ezequiel@collabora.com>
 <20180830172030.23344-4-ezequiel@collabora.com> <20180830175937.GB11521@infradead.org>
In-Reply-To: <20180830175937.GB11521@infradead.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 7 Sep 2018 17:54:22 +0900
X-Gmail-Original-Message-ID: <CAAFQd5D=tETh0638gR0TP=_FZXzMcy=6EjOLW8n1SRPqR=sCrQ@mail.gmail.com>
Message-ID: <CAAFQd5D=tETh0638gR0TP=_FZXzMcy=6EjOLW8n1SRPqR=sCrQ@mail.gmail.com>
Subject: Re: [RFC 3/3] stk1160: Use non-coherent buffers for USB transfers
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Alan Stern <stern@rowland.harvard.edu>, kernel@collabora.com,
        keiichiw@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 2:59 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +     dma_sync_single_for_cpu(&urb->dev->dev, urb->transfer_dma,
> > +             urb->transfer_buffer_length, DMA_FROM_DEVICE);
>
> You can't ue dma_sync_single_for_cpu on non-coherent dma buffers,
> which is one of the major issues with them.

It's not an issue of DMA API, but just an API mismatch. By design,
memory allocated for device (e.g. by DMA API) doesn't have to be
physically contiguous, while dma_*_single() API expects a _single_,
physically contiguous region of memory.

We need a way to allocate non-coherent memory using DMA API to handle
(on USB example, but applies to virtually any class of devices doing
DMA):
 - DMA address range limitations (e.g. dma_mask) - while a USB HCD
driver is normally aware of those, USB device driver should have no
idea,
 - memory mapping capability === whether contiguous memory or a set of
random pages can be allocated - this is a platform integration detail,
which even a USB HCD driver may not be aware of, if a SoC IOMMU is
just stuffed between the bus and HCD,
 - platform coherency specifics - there are practical scenarios when
on a coherent-by-default system it's more efficient to allocate
non-coherent memory and manage caches explicitly to avoid the costs of
cache snooping.

If DMA_ATTR_NON_CONSISTENT is not the right way to do it, there should
be definitely a new API introduced, coupled closely to DMA API
implementation on given platform, since it's the only place which can
solve all the constraints above.

Best regards,
Tomasz
