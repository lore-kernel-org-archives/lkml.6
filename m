Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F4DC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 14:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C2F2070D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 14:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xmp+2uMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfAEOIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 09:08:48 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40591 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfAEOIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 09:08:47 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so18724066plq.7
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 06:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3KySC28nfWlC0hiaumhsqZBNZ9EnC636eKKO0rCHHGo=;
        b=Xmp+2uMypAc0YILvajrmB3/cjV0BW5LDL2LGzGkNzimevn+C5rTbos8y+d74QUmS9k
         sJspp7kV5T3gZw4bOxOhHTQlFSjqyAF+I66keZF4TZ1QQ+W+dkbBgBGy7B/2TxLvyAi4
         trWNKo4T56ka5AZUX28RJuk3IRRUvrxq5SfFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3KySC28nfWlC0hiaumhsqZBNZ9EnC636eKKO0rCHHGo=;
        b=oujlMjlIsovlvIhlzKhM2ccLvIDz14gpgHg7b3EZxS7BOdFxK1zDzqJJj6EdNXvY9p
         kMSXeQvR6SM/jQ2Cf/3nQ29PcXh6nOWdEtvRVaQU6Y4utD5LAaU/KWK/rQqWZnFclxvE
         /x/pmda5XNbp5gb+xavBiZLa6inSiJyjORTmXl72UxgJ4WzjtRaD3o03/xZb4kdTRUxI
         qzEJueXMwglyt3yCKNm1SIGhTHrJNhCjT1VkmsEWV+y1ddnrmYrpIKPIP8UZ3OpNnWdJ
         WQFocLzKV//31fX48fxyCZTwh+dsXj2WDOPsciH+jHWi/9qyoVGtbptGlzoF8KKOJ29p
         3HcQ==
X-Gm-Message-State: AJcUukcA8D5ee/SItTBsQ7gW2fWVZV3I0Jl2PnmA8TeamCAa6KWGNSG/
        oU4mjmxwIXFgs1IJHgJHLn6+
X-Google-Smtp-Source: ALg8bN5wuRAwFGcidKj5ny8ydRQflAw0LyWjFkT4D6oMQF5Q/oPjs6X322l0xMPUQz+F4PXdewXhBQ==
X-Received: by 2002:a17:902:ac1:: with SMTP id 59mr53898816plp.36.1546697326411;
        Sat, 05 Jan 2019 06:08:46 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:730c:d904:406c:3ac8:e78f:4779])
        by smtp.gmail.com with ESMTPSA id k24sm92923031pfj.13.2019.01.05.06.08.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 Jan 2019 06:08:45 -0800 (PST)
Date:   Sat, 5 Jan 2019 19:38:26 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>, dmaengine@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/8 v2] Documentation: bindings: k3dma: Add binding for
 dma-avail-chan
Message-ID: <20190105140826.GA28029@Mani-XPS-13-9360>
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
 <1546635388-13795-3-git-send-email-john.stultz@linaro.org>
 <20190105040030.GF2477@Mani-XPS-13-9360>
 <CALAqxLUZ=6_tELtZPEjYwV+BNNBcZj4Z=dq9UyrRXuPhs_uGUw@mail.gmail.com>
 <20190105045320.GA3761@Mani-XPS-13-9360>
 <20190105134610.GX13372@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190105134610.GX13372@vkoul-mobl.Dlink>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Sat, Jan 05, 2019 at 07:16:10PM +0530, Vinod Koul wrote:
> On 05-01-19, 10:23, Manivannan Sadhasivam wrote:
> > On Fri, Jan 04, 2019 at 08:39:34PM -0800, John Stultz wrote:
> > > On Fri, Jan 4, 2019 at 8:00 PM Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > >
> > > > Hi John,
> > > >
> > > > On Fri, Jan 04, 2019 at 12:56:22PM -0800, John Stultz wrote:
> > > > > Some dma channels can be reserved for secure mode or other
> > > > > hardware on the SoC, so provide a binding for a bitmask
> > > > > listing the available channels for the kernel to use.
> > > > >
> > > > > Cc: Vinod Koul <vkoul@kernel.org>
> > > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > > Cc: Tanglei Han <hantanglei@huawei.com>
> > > > > Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
> > > > > Cc: Ryan Grachek <ryan@edited.us>
> > > > > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > Cc: dmaengine@vger.kernel.org
> > > > > Cc: devicetree@vger.kernel.org
> > > > > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/dma/k3dma.txt | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/dma/k3dma.txt b/Documentation/devicetree/bindings/dma/k3dma.txt
> > > > > index 10a2f15..1c466c1 100644
> > > > > --- a/Documentation/devicetree/bindings/dma/k3dma.txt
> > > > > +++ b/Documentation/devicetree/bindings/dma/k3dma.txt
> > > > > @@ -14,6 +14,9 @@ Required properties:
> > > > >               have specific request line
> > > > >  - clocks: clock required
> > > > >
> > > > > +Optional properties:
> > > > > +- dma-avail-chan: Bitmask of available physical channels
> > > > > +
> > > >
> > > > This property looks too generic. Since this is specific to HiSi SoCs,
> > > > this could be "hisi-dma-avail-chan"?
> > > 
> > > I'm fine to change it, but I'm not sure I fully understand the
> > > rational. Can you help me understand?
> > > Are device node-binding names supposed to have global scope? I assumed
> > > the node property names are basically scoped to the entry?
> > 
> > IIUC properties documented in subsystem binding (dma.txt in this case)
> > will have global scope. Those which are not documented in this binding
> > are specific to vendor IPs and should be prefixed with the vendor
> > prefix (hisi in this case).
> > 
> > > Further, having some dma channels be reserved doesn't seem to be too
> > > unique a concept, so I'm not sure what we gain long term by prefixing
> > > it?
> > > 
> > 
> > Right, but this brings up the point of having this functionality in
> > generic DMA engine so that the DMA controller drivers need not handle.
> > So either we should move this available channel check to DMA Engine
> > and document the property in dma.txt so that other IPs can also use it
> > or keep the functionality in K3 driver and use HiSi prefix for the
> > property.
> > 
> > But I'd like to hear Vinod/Rob's opinion on this!
> 
> So there are two parts, first is if this new property of using 'some'
> channels of controller is generic enough, the answer is unfortunately
> yes, so we should move this to dma.txt as a generic property
> 
> But I don't agree the dmaengine core should handle it, we may add
> helpers, but controllers registers N channels and they would do so, core
> should not do filtering
> 

Okay. But won't it create ambiguity? What if a new driver developer
assmes that he can use this property to filter the channels for his own
DMA controller? Since we are _explicitly_ stating that these channels
should be filtered, why the dmaengine core can't handle it?

If the property is generic, then it makes sense to keep the
functionality also generic.

Thanks,
Mani

> -- 
> ~Vinod
