Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99131C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E4626F92
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="f8822QBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E4626F92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753476AbeF1GCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 02:02:35 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44811 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753287AbeF1GCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 02:02:33 -0400
Received: by mail-ed1-f66.google.com with SMTP id c17-v6so4413105eds.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 23:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=H5YZOwcdO8aishI+/wkWK4ZLCdmrPyKvLxRSBs4GQAg=;
        b=f8822QBErQ+Tn/zNjy8Hx8eO9vjUDTdZbxIDXmzq/a7e4D1ZgokhOKvX1oKly/a/oJ
         bPU+SJb5tYruMLeqFdTXIBktBS7iVaKnJg0KaG/mvA1YVYGAMGTuB47sPu5wRX3poIAo
         CRp4pH7T2TRXDfAsjMeT9+Ip9lF7pB5adw1cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=H5YZOwcdO8aishI+/wkWK4ZLCdmrPyKvLxRSBs4GQAg=;
        b=T/Vh5QD4i+3NTIxrGEmPyJRsI5jI399hWOUNIvBgRlGuU6TKbZ/py+9qyy+rf51zUY
         gJlGNZTb5Euci1y7PO/7Fl3y6xTEHSZXTKIsNENtJFRgRjWeynvomWDi5jF2TSVLPw3N
         rcP/fasxth9yUNNiPEylhQL+2QlZ4KAvpFMybfBI8pcImoIp755jQzR31B2kBWTu4DJL
         VTh01r8ipDbMflfQM3hCcJ77/KI3OUulRRaPlrwFYf7n4CFGdM5BKuPlV0QDFDnBh3XK
         V+T99I9KOPnJ606tWb2F0ghG4PV7+nEGxzjyS7qpwxLh6+ORVjVvrVsqmJmBxrxK2Bw0
         66nQ==
X-Gm-Message-State: APt69E1MzLO47b3EAXHu90c/O6uS24uvwBGFNJViV/mekA7af9NAtgEK
        VH4G6wSdXBoAgYc0BpBMnmYKRQ==
X-Google-Smtp-Source: AAOMgpfAhxLp86Qv391RxodQZu4j+g33qeUzCwM9J8tHtpLtuImdYGB/yjM0Q+LnGMMmgc/tbM3uHg==
X-Received: by 2002:a50:89aa:: with SMTP id g39-v6mr7607126edg.25.1530165751829;
        Wed, 27 Jun 2018 23:02:31 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-109.fiber7.init7.net. [212.51.149.109])
        by smtp.gmail.com with ESMTPSA id i6-v6sm2692913edg.58.2018.06.27.23.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 23:02:30 -0700 (PDT)
Date:   Thu, 28 Jun 2018 08:02:28 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Stu Hsieh <stu.hsieh@mediatek.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 00/29] Add support for mediatek SOC MT2712
Message-ID: <20180628060228.GJ13978@phenom.ffwll.local>
Mail-Followup-To: Stu Hsieh <stu.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        srv_heupstream@mediatek.com, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <1529482771-2153-1-git-send-email-stu.hsieh@mediatek.com>
 <20180625084740.GN2958@phenom.ffwll.local>
 <1530157537.11190.53.camel@mtksdccf07>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530157537.11190.53.camel@mtksdccf07>
X-Operating-System: Linux phenom 4.16.0-2-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 11:45:37AM +0800, Stu Hsieh wrote:
> Hi, Daniel Vetter:
> 
> On Mon, 2018-06-25 at 10:47 +0200, Daniel Vetter wrote:
> > On Wed, Jun 20, 2018 at 04:19:02PM +0800, Stu Hsieh wrote:
> > > This patch add support for the Mediatek MT2712 DISP subsystem.
> > > MT2712 is base on MT8173, there are some difference as following:
> > > MT2712 support three disp output(two ovl and one rdma)
> > > 
> > > Change in v6:
> > > - Update commit message for the patch
> > >   "drm/mediatek: Update the definition of connection from RDMA1 to DPI0"
> > 
> > Just a drive-by comment on the mediatek driver:
> > 
> > As far as I can see mtk_drm_gem.c reimplements the cma helpers as a
> > copypaste job. Any reasons why you're not using the normal cma helpers?
> > 
> > Thanks, Daniel
> > > 
> 
> In the beginning, we develop mtk_drm_gem.c by referring other platform.
> We will try to use the normal cma helpers according to your idea.

Sounds great if you can do this as a longer-term refactoring task!

I discussed this also a bit with Philipp on irc, and he said there's
possible a need to support non-contig buffers in mtk. If that can't be
done using cma helpers (usually you have an iommu in such a case, which
again gives you a contig buffer in device-address space, and that can be
used by cma I think), then I think it would still be useful if you use the
cma helpers for the contig buffers. But then wrap them in some mtk code to
switch between the two.

Cheers, Daniel

> 
> Thanks,
> Stu
> 
> > > Stu Hsieh (29):
> > >   drm/mediatek: update dt-bindings for mt2712
> > >   drm/mediatek: support maximum 64 mutex mod
> > >   drm/mediatek: add ddp component AAL1
> > >   drm/mediatek: add ddp component OD1
> > >   drm/mediatek: add ddp component PWM1
> > >   drm/mediatek: add ddp component PWM2
> > >   drm/mediatek: add component DPI1
> > >   drm/mediatek: add component DSI2
> > >   drm/mediatek: add component DSI3
> > >   drm/mediatek: add the DSI1 for component init condition
> > >   drm/mediatek: add connection from OD1 to RDMA1
> > >   drm/mediatek: Update the definition of connection from RDMA1 to DPI0
> > >   drm/mediatek: add connection from RDMA0 to DPI0
> > >   drm/mediatek: add connection from RDMA0 to DSI2
> > >   drm/mediatek: add connection from RDMA0 to DSI3
> > >   drm/mediatek: add connection from RDMA1 to DPI1
> > >   drm/mediatek: add connection from RDMA1 to DSI1
> > >   drm/mediatek: add connection from RDMA1 to DSI2
> > >   drm/mediatek: add connection from RDMA1 to DSI3
> > >   drm/mediatek: add connection from RDMA2 to DPI0
> > >   drm/mediatek: add connection from RDMA2 to DPI1
> > >   drm/mediatek: add connection from RDMA2 to DSI1
> > >   drm/mediatek: add connection from RDMA2 to DSI2
> > >   drm/mediatek: add connection from RDMA2 to DSI3
> > >   drm/mediatek: add DPI1 support for mutex
> > >   drm/mediatek: add DSI2 support for mutex
> > >   drm/mediatek: add DSI3 support for mutex
> > >   drm/mediatek: add third ddp path
> > >   drm/mediatek: Add support for mediatek SOC MT2712
> > > 
> > >  .../bindings/display/mediatek/mediatek,disp.txt    |   2 +-
> > >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |   3 +
> > >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c             | 235 ++++++++++++++++++---
> > >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |  15 +-
> > >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |  10 +-
> > >  drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  47 ++++-
> > >  drivers/gpu/drm/mediatek/mtk_drm_drv.h             |   5 +-
> > >  7 files changed, 274 insertions(+), 43 deletions(-)
> > > 
> > > -- 
> > > 2.12.5
> > > 
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > 
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
