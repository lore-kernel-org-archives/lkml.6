Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289A1C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B040F20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZZF4kkSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B040F20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbeGYQgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 12:36:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44489 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728436AbeGYQgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 12:36:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so5542196pgp.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 08:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w4E0uoWuynu86iV51IRGnbTN/Oh8yztFdpQim45NOfM=;
        b=ZZF4kkSAhnnS82/I7gZapivOcM5gquzl8JpBJlW8t0rT/OoAf2ySt39k7G8fVOZb8s
         gWCUpYY47wmFYub59uK/lzK2EX+r4FAyZ/aKWhHlX37gbhiU+55acRxv15HlxpLTpbUO
         n3p1GBClGYGFPRgT06FCNk8zW1xoO5+ttO4zI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w4E0uoWuynu86iV51IRGnbTN/Oh8yztFdpQim45NOfM=;
        b=JUz06q6BA6WLqJT955G72i+1BWTouHQBjON2QKUAjGKcKufnAp8/pjhjC+4ugwq1Pu
         FkRrwm9kJzzMwRF3DRIdbU0WI2QxcYCumG48KEe/Ooum6qkHkOZNT42wr2NLomhS3SYm
         JJ0T4c8ClQRES19SeLQbxTy73tptMuN5D80ZnxkCoZzphcMs9axvJzHkQIbbW9vI1G/1
         bYceKdLPYkOG5G06D9Go0+vEFwhqvtx/ywjT2qVfsN/O2z2srG608R7O2fC6udvRUht4
         r5E7YF9nVWcf/2VgwzwnrvsqcsLJw/Pr0ob4qw0H5WviV/6q5PVATzAhh4J7Cx7BxGia
         MX3A==
X-Gm-Message-State: AOUpUlHlCimHMH1BzBJPIRPQ5Q2YfO1R15A1XAzba2Q+sfnN6C6f0b6d
        f3s51b7lOyjgNBKz7k70yh06
X-Google-Smtp-Source: AAOMgpd+DxAM64TBM2Lpl7qLbGE3Lf3zia0jMwqTCXOQTG+AzAM5IEPsZgPCKvQBHB0BUQqJDvpVkA==
X-Received: by 2002:a63:68c1:: with SMTP id d184-v6mr20958206pgc.239.1532532251576;
        Wed, 25 Jul 2018 08:24:11 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:812:8aba:a8cb:6394:3bdf:2b97])
        by smtp.gmail.com with ESMTPSA id 87-v6sm31162186pfn.103.2018.07.25.08.24.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 08:24:11 -0700 (PDT)
Date:   Wed, 25 Jul 2018 20:53:58 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Vinod <vkoul@kernel.org>
Cc:     dan.j.williams@intel.com, afaerber@suse.de, robh+dt@kernel.org,
        dmaengine@vger.kernel.org, liuwei@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com, pn@denx.de, edgar.righi@lsitec.org.br
Subject: Re: [PATCH v2 1/4] dt-bindings: dma: Add binding for Actions Semi
 Owl SoCs
Message-ID: <20180725152358.GA14686@Mani-XPS-13-9360>
References: <20180723041743.32024-1-manivannan.sadhasivam@linaro.org>
 <20180723041743.32024-2-manivannan.sadhasivam@linaro.org>
 <20180724121604.GA2587@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724121604.GA2587@vkoul-mobl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Tue, Jul 24, 2018 at 05:46:04PM +0530, Vinod wrote:
> Hi Mani,
> 
> Patch title should be dmaengine: ... Please always use the apt tags and
> one can find them using git log <subsystem>
> 

Did you mean, dt-bindings: dmaengine? If yes, then I will use it for the
future patches.

> On 23-07-18, 09:47, Manivannan Sadhasivam wrote:
> > Add devicetree binding for Actions Semi Owl SoCs DMA controller.
> 
> 
> It would help for review to describe the controller here
> 

Okay.

> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../devicetree/bindings/dma/owl-dma.txt       | 46 +++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/owl-dma.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/owl-dma.txt b/Documentation/devicetree/bindings/dma/owl-dma.txt
> > new file mode 100644
> > index 000000000000..dd6ce237b216
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/owl-dma.txt
> > @@ -0,0 +1,46 @@
> > +* Actions Semi Owl SoCs DMA controller
> > +
> > +This binding follows the generic DMA bindings defined in dma.txt.
> > +
> > +Required properties:
> > +- compatible: Should be "actions,s900-dma".
> > +- reg: Should contain DMA registers location and length.
> > +- interrupts: Should contain 4 interrupts shared by all channel.
> > +- #dma-cells: Must be <1>. Used to represent the number of integer
> > +              cells in the dmas property of client device.
> > +- dma-channels: Physical channels supported.
> > +- dma-requests: Virtual channels supported.
> 
> not really, virtual channel is a software concepts. On the other hand
> you may have request lines in hw and you can describe that, if not skip
> this one
> 

Okay. Will change the property description to request signals.

Thanks,
Mani

> > +- clocks: Phandle and Specifier of the clock feeding the DMA controller.
> > +
> > +Example:
> > +
> > +Controller:
> > +                dma: dma-controller@e0260000 {
> > +                        compatible = "actions,s900-dma";
> > +                        reg = <0x0 0xe0260000 0x0 0x1000>;
> > +                        interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> > +                                     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
> > +                                     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
> > +                                     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> > +                        #dma-cells = <1>;
> > +                        dma-channels = <12>;
> > +                        dma-requests = <46>;
> > +                        clocks = <&clock CLK_DMAC>;
> > +                };
> > +
> > +Client:
> > +
> > +DMA clients connected to the Actions Semi Owl SoCs DMA controller must
> > +use the format described in the dma.txt file, using a two-cell specifier
> > +for each channel.
> > +
> > +The two cells in order are:
> > +1. A phandle pointing to the DMA controller.
> > +2. The channel id.
> > +
> > +uart5: serial@e012a000 {
> > +        ...
> > +        dma-names = "tx", "rx";
> > +        dmas = <&dma 26>, <&dma 27>;
> > +        ...
> > +};
> > -- 
> > 2.17.1
> 
> -- 
> ~Vinod
