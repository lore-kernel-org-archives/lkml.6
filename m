Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F10C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 04:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240D921874
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 04:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RHPjbDii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfAEExc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 23:53:32 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45803 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfAEExb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 23:53:31 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so18304719pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 20:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2osYVWt+JIkdPaSyZ2ITOSzDCJlR6M9tonDWn/3T+44=;
        b=RHPjbDii5Y+2bcbaPzOLgLe8nz7QpwrOtoD3xibM4BA4PY4YaR2fPDTpf6QZKn0cAb
         91Kf29PvxrlyZcY52vHxnOa/ZSxV5Ot40i+sHYT6t7Mq38OxkGtnFGkBRMzMAlQoVYR9
         m87aKPa9jhCB5HxP/9eMXMu3R0EnyC93edyoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2osYVWt+JIkdPaSyZ2ITOSzDCJlR6M9tonDWn/3T+44=;
        b=GPmtSdLUESzQuDYO5yjfy4uhAB//Ef7tg95sBy2N2feSRd2HRc5oNp5C3m4RM97tBM
         MOEAIw+9EzsZ51fiS4b7fX8fh1PfP/Y9lSa405trEGZDooHiMaDAKrS9fUrmcc8zU5r6
         6CeViBOugbBkQri/jcu5KN2h+gvRzZUSLlwxoJXbcJi3WrUCKcXPVcq/KQfhzf1t29Ty
         8qK7tejk8GId7/MRM05xGdtwuGtluw2ZCLVJHTZ3g3CcNCbWfxQQ1KcNsgVZddTg2qJG
         96QmVBlhWdNtpPUYyb7vymu65mIJ1bWWTUtBMkDTPxMCijyDMGbUTX2g6sfU+9woQoxO
         eNAA==
X-Gm-Message-State: AJcUukdo7weGZbduIvgKwQZFLlCVjuA1IwKenzj9HqRAX8jkR4nllp0t
        SHx+14kY3cbhzm6ldbm1/pvZ
X-Google-Smtp-Source: ALg8bN5jQ9SFeO6MTzkQQnElXG2wHR1tc9vg3DP6qbqM4/x4smYVaKoELxYfzhSh+ulLJJuBzbUGjA==
X-Received: by 2002:a63:4948:: with SMTP id y8mr3866500pgk.32.1546664009373;
        Fri, 04 Jan 2019 20:53:29 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:72cb:a88d:406c:3ac8:e78f:4779])
        by smtp.gmail.com with ESMTPSA id k63sm118688142pfc.76.2019.01.04.20.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 20:53:28 -0800 (PST)
Date:   Sat, 5 Jan 2019 10:23:20 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>, dmaengine@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/8 v2] Documentation: bindings: k3dma: Add binding for
 dma-avail-chan
Message-ID: <20190105045320.GA3761@Mani-XPS-13-9360>
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
 <1546635388-13795-3-git-send-email-john.stultz@linaro.org>
 <20190105040030.GF2477@Mani-XPS-13-9360>
 <CALAqxLUZ=6_tELtZPEjYwV+BNNBcZj4Z=dq9UyrRXuPhs_uGUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLUZ=6_tELtZPEjYwV+BNNBcZj4Z=dq9UyrRXuPhs_uGUw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 08:39:34PM -0800, John Stultz wrote:
> On Fri, Jan 4, 2019 at 8:00 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > Hi John,
> >
> > On Fri, Jan 04, 2019 at 12:56:22PM -0800, John Stultz wrote:
> > > Some dma channels can be reserved for secure mode or other
> > > hardware on the SoC, so provide a binding for a bitmask
> > > listing the available channels for the kernel to use.
> > >
> > > Cc: Vinod Koul <vkoul@kernel.org>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Tanglei Han <hantanglei@huawei.com>
> > > Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
> > > Cc: Ryan Grachek <ryan@edited.us>
> > > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Cc: dmaengine@vger.kernel.org
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/dma/k3dma.txt | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/dma/k3dma.txt b/Documentation/devicetree/bindings/dma/k3dma.txt
> > > index 10a2f15..1c466c1 100644
> > > --- a/Documentation/devicetree/bindings/dma/k3dma.txt
> > > +++ b/Documentation/devicetree/bindings/dma/k3dma.txt
> > > @@ -14,6 +14,9 @@ Required properties:
> > >               have specific request line
> > >  - clocks: clock required
> > >
> > > +Optional properties:
> > > +- dma-avail-chan: Bitmask of available physical channels
> > > +
> >
> > This property looks too generic. Since this is specific to HiSi SoCs,
> > this could be "hisi-dma-avail-chan"?
> 
> I'm fine to change it, but I'm not sure I fully understand the
> rational. Can you help me understand?
> Are device node-binding names supposed to have global scope? I assumed
> the node property names are basically scoped to the entry?

IIUC properties documented in subsystem binding (dma.txt in this case)
will have global scope. Those which are not documented in this binding
are specific to vendor IPs and should be prefixed with the vendor
prefix (hisi in this case).

> Further, having some dma channels be reserved doesn't seem to be too
> unique a concept, so I'm not sure what we gain long term by prefixing
> it?
> 

Right, but this brings up the point of having this functionality in
generic DMA engine so that the DMA controller drivers need not handle.
So either we should move this available channel check to DMA Engine
and document the property in dma.txt so that other IPs can also use it
or keep the functionality in K3 driver and use HiSi prefix for the
property.

But I'd like to hear Vinod/Rob's opinion on this!

Thanks,
Mani

> thanks
> -john
