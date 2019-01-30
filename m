Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56F8C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8EB21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548865945;
	bh=JYQ76vF3Savn4v6+9BlZsSpCBpFVULac35lmn8Dv9ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Hu9DJnXiVNGsl7UG+gHVQk9Z0Au0g+Ljuoc7lx1616TqKuoiutdK9VNvzXpoATv7q
	 o4Q7P8K1L4mElpNYVBfYpk3XLt2FhwD53lcVQCEALFqHYFWYnBmuFDSKOCyBNq8h/o
	 aJR6rioRXTZ0PG3xgY/2lCNhhxmuR9QTPBa4SctM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbfA3QcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:32:23 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44446 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731623AbfA3QcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:32:21 -0500
Received: by mail-ot1-f66.google.com with SMTP id g16so83417otg.11;
        Wed, 30 Jan 2019 08:32:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CCc7VRu+xIf8LlmE1sgRH/1JKjZPxbmkQ0otpsDVsWU=;
        b=FMcLqmNHNafgH0mGIeAiRQ4PYstWIPZ4SQZXgd8X5IU4diHMeOdlyVqjFAYKZxdqUS
         HDDlyj+spd0sUstFaKW9CleAkr+dSaLFeAcGJWdyQdKvK94HHY73iGvlhuoxfdcfOevR
         UFrr1OiW3f0aIRLLyhbjQ0Q3RqNuyOgUFVNGWuP90k4LQlfrUlnOBtb8PEHvysBIg5jg
         kcdngPpJwveG2q4amzrG/1b4jl2mSUarzCW9hgrjqFrCkFvYBLDNCP6HS75maHMM53t7
         u7COH1/8Rj+WRWg5S+N+l9l7as16rtQkotraot7kLjESa/rvqG2LaR/aU348SzVxd9Pc
         ujMQ==
X-Gm-Message-State: AJcUukduMKkaEMuYlRBlyVbz4R42FJivv6O5c2Wj6lzvVjg+RUs3BP8Y
        H/T/4yj7s6leXC6NZ45GYg==
X-Google-Smtp-Source: ALg8bN6vaGcMZMlDWk7hmFJNxnFLtmAg50rVV1bYGtQAoxAEI1Sgzix7nj6Fmf09sAeBahDUcogVAA==
X-Received: by 2002:a9d:a48:: with SMTP id 66mr23218918otg.308.1548865940392;
        Wed, 30 Jan 2019 08:32:20 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a15sm672572otd.66.2019.01.30.08.32.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 08:32:19 -0800 (PST)
Date:   Wed, 30 Jan 2019 10:32:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Viorel Suman <viorel.suman@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@gmail.com>
Subject: Re: [PATCH v4 2/3] ASoC: add fsl_audmix DT binding documentation
Message-ID: <20190130163218.GA16270@bogus>
References: <1548155654-12985-1-git-send-email-viorel.suman@nxp.com>
 <1548155654-12985-3-git-send-email-viorel.suman@nxp.com>
 <20190125194315.GA21222@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125194315.GA21222@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 11:43:16AM -0800, Nicolin Chen wrote:
> On Tue, Jan 22, 2019 at 11:14:27AM +0000, Viorel Suman wrote:
> > Add the DT binding documentation for NXP Audio Mixer
> > CPU DAI driver.
> > 
> > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > ---
> >  .../devicetree/bindings/sound/fsl,audmix.txt       | 54 ++++++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,audmix.txt b/Documentation/devicetree/bindings/sound/fsl,audmix.txt
> > new file mode 100644
> > index 0000000..45f807e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/fsl,audmix.txt
> > @@ -0,0 +1,54 @@
> > +NXP Audio Mixer (AUDMIX).
> > +
> > +The Audio Mixer is a on-chip functional module that allows mixing of two
> > +audio streams into a single audio stream. Audio Mixer has two input serial
> > +audio interfaces. These are driven by two Synchronous Audio interface
> > +modules (SAI). Each input serial interface carries 8 audio channels in its
> > +frame in TDM manner. Mixer mixes audio samples of corresponding channels
> > +from two interfaces into a single sample. Before mixing, audio samples of
> > +two inputs can be attenuated based on configuration. The output of the
> > +Audio Mixer is also a serial audio interface. Like input interfaces it has
> > +the same TDM frame format. This output is used to drive the serial DAC TDM
> > +interface of audio codec and also sent to the external pins along with the
> > +receive path of normal audio SAI module for readback by the CPU.
> > +
> > +The output of Audio Mixer can be selected from any of the three streams
> > + - serial audio input 1
> > + - serial audio input 2
> > + - mixed audio
> > +
> > +Mixing operation is independent of audio sample rate but the two audio
> > +input streams must have same audio sample rate with same number of channels
> > +in TDM frame to be eligible for mixing.
> > +
> > +Device driver required properties:
> > +=================================
> > +  - compatible		: Compatible list, contains "fsl,imx8qm-audmix"
> > +
> > +  - reg			: Offset and length of the register set for the device.
> > +
> > +  - clocks		: Must contain an entry for each entry in clock-names.
> > +
> > +  - clock-names		: Must include the "ipg" for register access.
> > +
> > +  - power-domains	: Must contain the phandle to AUDMIX power domain node
> > +
> > +  - dais		: Must contain a list of phandles to AUDMIX connected
> > +			  DAIs. The current implementation requires two phandles
> > +			  to SAI interfaces to be provided, the first SAI in the
> > +			  list being used to route the AUDMIX output.
> > +
> > +  - model		: Must contain machine driver name which will configure
> > +			  and instantiate the appropriate audio card.
> 
> I don't feel this is necessary for DT node. The driver should be
> able to figure out a proper name for the machine driver: it could
> use the compatible string to get "imx8qm-audmix" as the name like
> fsl_ssi; Or it could have built-in "imx-audmix" of_device_id data
> corresponding to "fsl,imx8qm-audmix" compatible string -- for any
> non-imx compatible in the future, use something else.

I tend to agree, but either way:

Rob Herring <robh@kernel.org>
