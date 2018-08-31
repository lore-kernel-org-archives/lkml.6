Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B74C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 06:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDED20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 06:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EeuGXnoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDED20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbeHaK6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 06:58:08 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:35312 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeHaK6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 06:58:08 -0400
Received: by mail-yb1-f193.google.com with SMTP id o17-v6so513180yba.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 23:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZ/5ZVsKF6hpzEfu+yWQmFbyBRzNosTVXBr10CImg44=;
        b=EeuGXnoFznVrYjNfnF5WTaykrX56m4WBd2foQBvzPTJF0Xmi0kYkDXvLlixdz/MSMB
         Su2JxDeG/egZcvuWi8QyT44wD+UUHCg/DSnxgZm3VaAZXfWtLlOyMhcYMNxBT2Qv3JPs
         PV964yFRSDqSJIH2qfZ9pxETQysm2/Dh/vECM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZ/5ZVsKF6hpzEfu+yWQmFbyBRzNosTVXBr10CImg44=;
        b=HkB4g0Kv1oL0ED1r9BgVBtB4y5ozR5kDeA9JQD77hMHFZIFlHSW/H/69SnmYWlPz02
         c1T9OsBYtffqLxXobLabdRTmHRn0XTFqDbHm4xjPkhf/WYZ184h89yhGCk5GhCFV1192
         OFnODGTAM7fJ7YqMvrcvPTvTQbiix4aQE+PE2bJoLXXsCGLerYFmTqUeLIzymVnzFob9
         NUntvqt6P311H4wgc4wBTimIKlE0ihaBbO4fj7yhMnrDFIVi7BVZnsSBCB0mKbyhCN3C
         +CKg2Sep/R+5H5j1/6BWieK2uEdNOZupLxoQ313fzivKHSZwHXKN6pvYCZbT+NtHB7cx
         qdiw==
X-Gm-Message-State: APzg51BIRf+FJ4l7l1YfqcjIaFWD7X0n6U/zlOfhF9T61VykCXEGPcIt
        HJiOqUDzB4/tMdc0M9mmZ3aPrkwyqXRYkg==
X-Google-Smtp-Source: ANB0VdY7GIvbGX3LQuu1aw4QYeStRnpkQj7zoNmjcfPeeiKrHu29jmBM707Eac5VkHTMDaIpHQudjw==
X-Received: by 2002:a25:690e:: with SMTP id e14-v6mr7826160ybc.468.1535698328344;
        Thu, 30 Aug 2018 23:52:08 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id m82-v6sm3987724ywc.29.2018.08.30.23.52.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 23:52:07 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id f145-v6so513600ybg.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 23:52:06 -0700 (PDT)
X-Received: by 2002:a25:348a:: with SMTP id b132-v6mr7857994yba.373.1535698325907;
 Thu, 30 Aug 2018 23:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180830172030.23344-1-ezequiel@collabora.com>
 <20180830172030.23344-3-ezequiel@collabora.com> <20180830175850.GA11521@infradead.org>
 <4fc5107f93871599ead017af7ad50f22535a7683.camel@collabora.com> <20180831055047.GA9140@infradead.org>
In-Reply-To: <20180831055047.GA9140@infradead.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 31 Aug 2018 15:51:54 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DhFr8ywjc41oK9q+zZXH9zsOKh_7DxWmjzcE0+5Q3hGA@mail.gmail.com>
Message-ID: <CAAFQd5DhFr8ywjc41oK9q+zZXH9zsOKh_7DxWmjzcE0+5Q3hGA@mail.gmail.com>
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

On Fri, Aug 31, 2018 at 2:50 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Aug 30, 2018 at 07:11:35PM -0300, Ezequiel Garcia wrote:
> > On Thu, 2018-08-30 at 10:58 -0700, Christoph Hellwig wrote:
> > > Please don't introduce new DMA_ATTR_NON_CONSISTENT users, it is
> > > a rather horrible interface, and I plan to kill it off rather sooner
> > > than later.  I plan to post some patches for a better interface
> > > that can reuse the normal dma_sync_single_* interfaces for ownership
> > > transfers.  I can happily include usb in that initial patch set based
> > > on your work here if that helps.
> >
> > Please do. Until we have proper allocators that go thru the DMA API,
> > drivers will have to kmalloc the USB transfer buffers, and have
> > streaming mappings. Which in turns mean not using IOMMU or CMA.
>
> dma_map_page will of course use the iommu.

Sure, dma_map*() will, but using kmalloc() defeats (half of) the
purpose of it, since contiguous memory would be allocated
unnecessarily, risking failures due to fragmentation.

Best regards,
Tomasz
