Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE3EC6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0DE20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PLwQTHFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0DE20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbeJaKvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 06:51:32 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41689 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbeJaKvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 06:51:32 -0400
Received: by mail-yb1-f196.google.com with SMTP id e16-v6so5943964ybk.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 18:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dANn4BAtzoKkFNbKfn+sdmraBQiu6PinfiQ2zd82Nq8=;
        b=PLwQTHFHp3R3kjqFtLsPrlokMscSQ6YnAmv+4xHgg9d5vqURS2QoNAD3/tP9jqB24j
         ENTzRXr+Y9bluGHDSrEa97c5UWnR18/2UXeaev5zGfWujwAEZvvPgT99m/C5qRycMrCE
         jPfVpsTtbWjIZ3L+GK2iIktCqci4ltMDNeMxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dANn4BAtzoKkFNbKfn+sdmraBQiu6PinfiQ2zd82Nq8=;
        b=Bh0MT6Mw6o48nyPo27ts/1awgCdSS1WSOG3aazZvZ0hrfQN5laFX1J8K5uQb6RP5st
         P+XaMpT5ilX8lu69KPM2VAU43ILrBmRaZaHAFm9PV+GZLbJz4V3O8gd9RATkAYpk3xBv
         qZ8nBw9M3+7d+TOvybWbCPY4Nt0pqkkAba9QyoiZ4XVAoz8MmNd2+gWGKm7v5Uxgl8AW
         u9YocCr02iNhrJM2V+gn4aDUwcKWbU8BNSmKDrOknpxXNsw2jZrt1ni/8pdA453IxvgX
         og8UiTIOF4sGFc3VyyXtynMkwaxAWsG1yX/Et5wwWEX4dXkgBWnVGWNRd2gsoHH/culB
         bofw==
X-Gm-Message-State: AGRZ1gIQi500pYCDLuUzrqVYhc1aY3uahhwFU4V9PYxcsacsATsR3E6w
        1HcRQUKyxN+KKyFD2Kctc153s2HvBEA=
X-Google-Smtp-Source: AJdET5emX/zNJEq29fmF97SZ50aKRy8tEZgKS3HoXvpdWznMhwFmQ2vOi6PT8Fxd6kPyimjEBcyF5Q==
X-Received: by 2002:a25:308a:: with SMTP id w132-v6mr1197476ybw.106.1540950937073;
        Tue, 30 Oct 2018 18:55:37 -0700 (PDT)
Received: from mail-yw1-f46.google.com (mail-yw1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id c128-v6sm7537307ywb.68.2018.10.30.18.55.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 18:55:35 -0700 (PDT)
Received: by mail-yw1-f46.google.com with SMTP id v77-v6so5809868ywc.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 18:55:35 -0700 (PDT)
X-Received: by 2002:a81:350c:: with SMTP id c12-v6mr1185701ywa.342.1540950934970;
 Tue, 30 Oct 2018 18:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180830172030.23344-1-ezequiel@collabora.com>
 <20180830172030.23344-3-ezequiel@collabora.com> <20180830175850.GA11521@infradead.org>
 <4fc5107f93871599ead017af7ad50f22535a7683.camel@collabora.com>
 <20180831055047.GA9140@infradead.org> <CAAFQd5DhFr8ywjc41oK9q+zZXH9zsOKh_7DxWmjzcE0+5Q3hGA@mail.gmail.com>
In-Reply-To: <CAAFQd5DhFr8ywjc41oK9q+zZXH9zsOKh_7DxWmjzcE0+5Q3hGA@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 31 Oct 2018 10:55:23 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BjGkJf-Yz3ixiCjCaoeQJKKXbF41JyEvrm1DQ6uNnBrQ@mail.gmail.com>
Message-ID: <CAAFQd5BjGkJf-Yz3ixiCjCaoeQJKKXbF41JyEvrm1DQ6uNnBrQ@mail.gmail.com>
Subject: Re: [RFC 2/3] USB: core: Add non-coherent buffer allocation helpers
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

Hi Christoph and everyone,

On Fri, Aug 31, 2018 at 3:51 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> On Fri, Aug 31, 2018 at 2:50 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Thu, Aug 30, 2018 at 07:11:35PM -0300, Ezequiel Garcia wrote:
> > > On Thu, 2018-08-30 at 10:58 -0700, Christoph Hellwig wrote:
> > > > Please don't introduce new DMA_ATTR_NON_CONSISTENT users, it is
> > > > a rather horrible interface, and I plan to kill it off rather sooner
> > > > than later.  I plan to post some patches for a better interface
> > > > that can reuse the normal dma_sync_single_* interfaces for ownership
> > > > transfers.  I can happily include usb in that initial patch set based
> > > > on your work here if that helps.
> > >
> > > Please do. Until we have proper allocators that go thru the DMA API,
> > > drivers will have to kmalloc the USB transfer buffers, and have
> > > streaming mappings. Which in turns mean not using IOMMU or CMA.
> >
> > dma_map_page will of course use the iommu.
>
> Sure, dma_map*() will, but using kmalloc() defeats (half of) the
> purpose of it, since contiguous memory would be allocated
> unnecessarily, risking failures due to fragmentation.

Have we reached a conclusion here?

It sounds like it's a quite significant problem, at least for some of
the camera (media) devices over there and there are people interested
in solving it, so all we need here is a conclusion on how to do it. :)

Best regards,
Tomasz
