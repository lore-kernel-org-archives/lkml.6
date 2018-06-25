Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9761BC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454CF25628
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LP/w/Lf5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454CF25628
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754488AbeFYIsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:48:17 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41822 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752576AbeFYIsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:48:14 -0400
Received: by mail-ed1-f65.google.com with SMTP id b12-v6so4813099edt.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 01:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0gNDuNyfM7Yu/D6W3ijB/pGO1rsZ30n7E5ZayIIBzuo=;
        b=LP/w/Lf57cyFzIWtuQiS2oXOwk7uotgzPJ1xlUGn4Gy+uStlebTKaG43IFSpFFEu6i
         3nPfo69CK5Kk5SNMha0lqX3Deri2taOf2GrBXe88xGNh/yzToniaYvBVSJC/bcDXTZ/c
         V9IjpJrSLSV0lCe5yNp80sY+lfzODx5xLBXO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=0gNDuNyfM7Yu/D6W3ijB/pGO1rsZ30n7E5ZayIIBzuo=;
        b=BtbntGYXMtVUqgaJC/R4Rjhlvz5WO9Xu+hGqhbJOoUijsXcjj0+OysXlCgnf/ZBqB1
         vP73WhlXp3A0zFkF7PWxwUmYPX4EsEQ7WHsbpVLAGCLjdG3OJ5jEZdVru8NqVIwg14pH
         Nhfa3HbplqffGJHBagPsVEEA5Jlr14aLAoJCG6irZAzOjaQR2AWdIAQ5ivKOnoAyCFi+
         gmXzecPjcYrvf+RkgkcAwwXodT3DbwObwUkQ0oipWDr81j3pd3rEOUMR9KOTRT7RVEHi
         kCAuDpLdvpkHBJ6VwkpNkS7/L/dbEOToLTzXfpkAiHruq/9pDGjWqsRgt4g25lp+51wj
         QJXw==
X-Gm-Message-State: APt69E1EcLPfInITv1xfBSPMMvXQj8ti2AmiGecidIkWvBVA/sVFVpuw
        +X0QKe3VuxkgdkoQlszIDt/P0Q==
X-Google-Smtp-Source: ADUXVKInIHgOWOXnTuY5GMFVMHfFb3lM8YAB4h0rpcP2wx16kiACA6NHNHTbW7Gz0NcW+iUQ35K3mg==
X-Received: by 2002:aa7:d598:: with SMTP id r24-v6mr4730766edq.176.1529916493043;
        Mon, 25 Jun 2018 01:48:13 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-109.fiber7.init7.net. [212.51.149.109])
        by smtp.gmail.com with ESMTPSA id j14-v6sm3491923edr.73.2018.06.25.01.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 01:48:12 -0700 (PDT)
Date:   Mon, 25 Jun 2018 10:47:40 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Stu Hsieh <stu.hsieh@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 00/29] Add support for mediatek SOC MT2712
Message-ID: <20180625084740.GN2958@phenom.ffwll.local>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529482771-2153-1-git-send-email-stu.hsieh@mediatek.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 04:19:02PM +0800, Stu Hsieh wrote:
> This patch add support for the Mediatek MT2712 DISP subsystem.
> MT2712 is base on MT8173, there are some difference as following:
> MT2712 support three disp output(two ovl and one rdma)
> 
> Change in v6:
> - Update commit message for the patch
>   "drm/mediatek: Update the definition of connection from RDMA1 to DPI0"

Just a drive-by comment on the mediatek driver:

As far as I can see mtk_drm_gem.c reimplements the cma helpers as a
copypaste job. Any reasons why you're not using the normal cma helpers?

Thanks, Daniel
> 
> Stu Hsieh (29):
>   drm/mediatek: update dt-bindings for mt2712
>   drm/mediatek: support maximum 64 mutex mod
>   drm/mediatek: add ddp component AAL1
>   drm/mediatek: add ddp component OD1
>   drm/mediatek: add ddp component PWM1
>   drm/mediatek: add ddp component PWM2
>   drm/mediatek: add component DPI1
>   drm/mediatek: add component DSI2
>   drm/mediatek: add component DSI3
>   drm/mediatek: add the DSI1 for component init condition
>   drm/mediatek: add connection from OD1 to RDMA1
>   drm/mediatek: Update the definition of connection from RDMA1 to DPI0
>   drm/mediatek: add connection from RDMA0 to DPI0
>   drm/mediatek: add connection from RDMA0 to DSI2
>   drm/mediatek: add connection from RDMA0 to DSI3
>   drm/mediatek: add connection from RDMA1 to DPI1
>   drm/mediatek: add connection from RDMA1 to DSI1
>   drm/mediatek: add connection from RDMA1 to DSI2
>   drm/mediatek: add connection from RDMA1 to DSI3
>   drm/mediatek: add connection from RDMA2 to DPI0
>   drm/mediatek: add connection from RDMA2 to DPI1
>   drm/mediatek: add connection from RDMA2 to DSI1
>   drm/mediatek: add connection from RDMA2 to DSI2
>   drm/mediatek: add connection from RDMA2 to DSI3
>   drm/mediatek: add DPI1 support for mutex
>   drm/mediatek: add DSI2 support for mutex
>   drm/mediatek: add DSI3 support for mutex
>   drm/mediatek: add third ddp path
>   drm/mediatek: Add support for mediatek SOC MT2712
> 
>  .../bindings/display/mediatek/mediatek,disp.txt    |   2 +-
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |   3 +
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c             | 235 ++++++++++++++++++---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |  15 +-
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |  10 +-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  47 ++++-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h             |   5 +-
>  7 files changed, 274 insertions(+), 43 deletions(-)
> 
> -- 
> 2.12.5
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
