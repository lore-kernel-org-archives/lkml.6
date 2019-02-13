Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9A9C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F5621934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ta1+v11L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392842AbfBMRBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:01:08 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33434 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733155AbfBMRBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:01:07 -0500
Received: by mail-pg1-f196.google.com with SMTP id z11so1418519pgu.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 09:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CsGa6xrCqoqf0+VNg/zr8QUSD2calqzCdb+HFhflSIg=;
        b=Ta1+v11LXRHE/m6bXl5bYCsrBWRz/5QZ7KpLJx/oTBx/nbCuz6bWAvfekWwrVt3Ki1
         0VVTcz9dXsYVNRrA3o3AX381GM9U3qYYxYNYeHIN8DM45K+g9Umf5zS1fvlJyuLd8BM7
         d7Wb9hT5ZOUss5/hrhMHbjTZpBhs13i/WevDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CsGa6xrCqoqf0+VNg/zr8QUSD2calqzCdb+HFhflSIg=;
        b=IdVi67S9m/0t2ai68sQGexa3ptoSJgRqBr0CG9KXVbjnnRy6Fj8pG+CpsUAdngKyqk
         /dkJJB56nNvxuADRYzeNTQHtD71O3x4TjAZ8EoNRmxLGdmM1JsVA3/Vz98nRKTMUrKc0
         rfkA6gdLVizix9Ek6tr/rk0oUzd9pnbwoZnjx2T1Oz3URWzG34KC2Ep9dax3o5wvRmgB
         gTQ4fx9efewaiYiKfg4bLJL5QIZXRceQHmyAO6A1SbtAlrHmLYkxENLuR8am2DifcPa/
         z0xhMcpk2pfXjcVAJKiG5CirljMqJiiJgL9g/eas3zdG6CptSHFlQ0njXhzsH1/pcEd/
         zXjg==
X-Gm-Message-State: AHQUAubUyayJlwJ36yYFUt98k4sVBKOT14BbAKgXAlq657tcvUgZGKvq
        EpCEnPE09GX2eFKGp0M/m8OoKw==
X-Google-Smtp-Source: AHgI3IbLTH8zTax3udBIg0vtWgutmzVS9f7NPA1eVw8b7yj25dnkT5eQqLtSZJNS2N0blTJn4eCqtg==
X-Received: by 2002:a63:9501:: with SMTP id p1mr1302223pgd.149.1550077266604;
        Wed, 13 Feb 2019 09:01:06 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id b15sm14524523pfj.44.2019.02.13.09.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 09:01:05 -0800 (PST)
Date:   Wed, 13 Feb 2019 09:01:05 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Erin Lo <erin.lo@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v4 2/6] remoteproc/mediatek: add SCP support for mt8183
Message-ID: <20190213170105.GX117604@google.com>
References: <20190131093131.245531-1-pihsun@chromium.org>
 <20190131093131.245531-3-pihsun@chromium.org>
 <20190202001749.GT81583@google.com>
 <CANdKZ0ds2s46h-Rs-4aJSuVFkoaeEzXi96m2zbx5XjBhhsc3Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANdKZ0ds2s46h-Rs-4aJSuVFkoaeEzXi96m2zbx5XjBhhsc3Xw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 11:20:18AM +0800, Pi-Hsun Shih wrote:
> Hi,
> 
> Thanks for the review, would address most comments in next version of patch.
> 
> On Sat, Feb 2, 2019 at 8:17 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Hi Pi-Hsun,
> >
> > a few comments inline.
> >
> > It's the first time I dabble into remoteproc, I don't claim to have a
> > complete understanding of the driver at this point ;-)
> >
> > On Thu, Jan 31, 2019 at 05:31:27PM +0800, Pi-Hsun Shih wrote:
> > > diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> > > new file mode 100644
> > > index 00000000000000..920c81c3525c2a
> > > --- /dev/null
> > > +++ b/drivers/remoteproc/mtk_scp.c
> > > +             return ret;
> > > +     }
> > > +
> > > +     writel(0x0, scp->reg_base + MT8183_SCP_SRAM_PDN);
> >
> > what is the purpose of this write?
> >
> 
> Answer from Erin:
> The code needs to execute on scp’s SRAM.
> We need to turn on the power of SRAM before using it.

Please add a brief comment since this is not evident from the code.

Thanks

Matthias
