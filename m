Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AC9C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 05:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5738720857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 05:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FrNtm902"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5738720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeIEKOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 06:14:18 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:40408 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeIEKOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 06:14:18 -0400
Received: by mail-yb1-f194.google.com with SMTP id t71-v6so2236012ybi.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 22:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TgQyjPv/UmUM12f+rlO6RT5g3LA/kxu/v8HXfz4yg+8=;
        b=FrNtm902tE4M8COQEhMdNs5XKXyHK27Q6P8+t9Xx4MMKUY4kyoouxdc5AqPf/zePNk
         HFL6WhEOjpblPVHHUADRdLSXg00jld+CtqG7D3GlfHMZsFv5OH6dpyJ5rJyrgSRaq+O+
         70AJ6TUyL8118StEybY1AxpqqRFue1Xamd894=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TgQyjPv/UmUM12f+rlO6RT5g3LA/kxu/v8HXfz4yg+8=;
        b=bGCP+TqG8P/529r2g0LVjckW2DnrKnIcPCpFlKlyikdQqtulo1SU63Ilx/6WHGLvsI
         vgZ21ZLs2rx/GYqOnSTWCYdzSeeVFqp0TIBWwLkg+4bgeklwfxOFMb8MGUnemDBlQiga
         6xgu9EB/PYLaLOi9zYKK4lbVk/U5M1FG44k2yjik5+8KnL9UsJn0MpLB+bO5/54bHQXw
         eEK5LW0J4ChMTN78r9VI9TvmGHs0NN+IfyleehY2WG3LxguhbjIFuJP2uJImiHD6PnSS
         iJUtYH/eAwFctJsLeTdtlvba/mm3GxczG9ltDDraWMEPw+fzEgwMkGw11uv+Ajkv+7jb
         g3tA==
X-Gm-Message-State: APzg51BqOUmW5NwMVE7/Si0VdzT6/64Ve5c6XohDVJfVu/2EAjD3sTOc
        /rAZNHsWE2+shlshkiTiQmy2Et39INY=
X-Google-Smtp-Source: ANB0Vdb6Zt/yr6tZ4SjkdiabbRoqm6GYppw/pWGneDMb7jrbRux2lRXjKI1UzEun66k1WIdHFdFszw==
X-Received: by 2002:a5b:811:: with SMTP id x17-v6mr19858738ybp.382.1536126348826;
        Tue, 04 Sep 2018 22:45:48 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id y144-v6sm387234ywy.79.2018.09.04.22.45.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 22:45:47 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id f145-v6so2238942ybg.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 22:45:47 -0700 (PDT)
X-Received: by 2002:a25:18c2:: with SMTP id 185-v6mr20005408yby.204.1536126346844;
 Tue, 04 Sep 2018 22:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180724140621.59624-1-tfiga@chromium.org> <20180724140621.59624-2-tfiga@chromium.org>
 <CAPBb6MXT4jiQXfgzq8fpXSQTsdcF0UZLB=RQ6itH5-JZx-27FA@mail.gmail.com>
In-Reply-To: <CAPBb6MXT4jiQXfgzq8fpXSQTsdcF0UZLB=RQ6itH5-JZx-27FA@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 5 Sep 2018 14:45:35 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CALOiC1-8XSrnZxevBmHa=tTM8t37joGz6Fqu_GqgeAg@mail.gmail.com>
Message-ID: <CAAFQd5CALOiC1-8XSrnZxevBmHa=tTM8t37joGz6Fqu_GqgeAg@mail.gmail.com>
Subject: Re: [PATCH 1/2] media: docs-rst: Document memory-to-memory video
 decoder interface
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Pawel Osciak <posciak@chromium.org>, kamil@wypas.org,
        a.hajda@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        jtp.park@samsung.com, Philipp Zabel <p.zabel@pengutronix.de>,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <andrew-ct.chen@mediatek.com>, todor.tomov@linaro.org,
        nicolas@ndufresne.ca,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 5:27 PM Alexandre Courbot <acourbot@chromium.org> wrote:
>
> Hi Tomasz, just a few thoughts I came across while writing the
> stateless codec document:
>
> On Tue, Jul 24, 2018 at 11:06 PM Tomasz Figa <tfiga@chromium.org> wrote:
> [snip]
> > +****************************************
> > +Memory-to-memory Video Decoder Interface
> > +****************************************
>
> Since we have a m2m stateless decoder interface, can we call this the
> m2m video *stateful* decoder interface? :)

I guess it could make sense indeed. Let's wait for some other opinions, if any.

>
> > +Conventions and notation used in this document
> > +==============================================
> [snip]
> > +Glossary
> > +========
>
> I think these sections apply to both stateless and stateful. How about
> moving then into dev-codec.rst and mentioning that they apply to the
> two following sections?

Or maybe we could put them into separate rst files and source them at
the top of each interface documentation? Personally, I'm okay with
either. On a related note, I'd love to see some kind of glossary
lookup on mouse hoover, so that I don't have to scroll back and forth.
:)

Best regards,
Tomasz
