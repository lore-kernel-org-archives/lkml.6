Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37697C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007432080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007432080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeLLP1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:27:30 -0500
Received: from muru.com ([72.249.23.125]:57734 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbeLLP13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 10:27:29 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A9649809F;
        Wed, 12 Dec 2018 15:27:31 +0000 (UTC)
Date:   Wed, 12 Dec 2018 07:27:25 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [alsa-devel] [PATCH 0/2] Graph fixes for using multiple
        endpoints per port
Message-ID: <20181212152725.GE6707@atomide.com>
References: <8736r4bvf3.wl-kuninori.morimoto.gx@renesas.com>
 <20181211045220.GI6707@atomide.com>
 <871s6obqkb.wl-kuninori.morimoto.gx@renesas.com>
 <20181211053536.GJ6707@atomide.com>
 <87wooga9an.wl-kuninori.morimoto.gx@renesas.com>
 <20181211141649.GL6707@atomide.com>
 <87ftv33bpg.wl-kuninori.morimoto.gx@renesas.com>
 <20181212001950.GX6707@atomide.com>
 <877egf33m9.wl-kuninori.morimoto.gx@renesas.com>
 <87k1kfs0u5.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1kfs0u5.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> [181212 06:52]:
> 
> Hi Tony, again
> 
> > > > 	https://patchwork.kernel.org/patch/10712877/
> > > 
> > > Hmm, so do you have multiple separate ports at the "&sound" node
> > > hardware? If so then yeah multiple ports make sense.
> > >
> > > But if you only a single physical (I2S?) port at the
> > > "&sound" node hardware, then IMO you should only have one
> > > port and multiple endpoints there according to the graph.txt
> > > binding doc.
> > > 
> > > In my McBSP case there is only a single physical I2S port
> > > that can be TDM split into timeslots.
> > 
> > Mine has 4 DAIs. Each DAI can output 2ch.
> > These will be merged and wil be 8ch TDM and goes to Codec.
> > But hmm.. it is 4 DAIs, but 1 "physical" interface...
> > 
> > So, your patch seems correct, but will breaks DPCM...
> > I will confirm it.
> 
> I thought "port" = "DAI", but yeah, "port" = "physical interface".

OK good to hear :)

> Then, my issue is that we can't judge DAI size from DT.
> For example, MIXer case, 2 CPU DAIs are connected to 1 Codec.
> 
> 	DAI0 --- CPU --- Codec
> 	DAI1 /
> 
> In this case, CPU side needs 2 DAIs,
> Codec side needs 1 DAI only.

Oh so the other way around compared to my use case. Hmm.

> For both CPU/Codec case, OF graph will be like below,
> and we can't judge DAIs size from this.
> 
> 	port {
> 		ep0: endpint@0 {
> 			remote-endpoint = <xxx>;
> 		};
> 		ep1: endpint@1 {
> 			remote-endpoint = <xxx>;
> 		};
> 	}

Hmm I too need to add secondary DAIs for McBSP in addition to the
primary DAI controlling the McBSP hardware resources.

> To solve this issue, we need to use "reg" for it.
> Then, we can get correct DAI ID.

Hmm yeah maybe. Just to think of other options, maybe also the
#size-cells could be used?

As the binding allows adding #address-cells and #size-cells to
the port node.. Usually if you refer a subnode of a device you
just use #address=cells = <2> where the second field would be for
the offset. So maybe this could be used for 1 DAI this way:

 	/* Codec has 1 DAI */
 	Codec {
 		port {
			#address-cells = <2>;
			#size-cells = <1>;

 			ep: endpoint {
 				remote-endpoint = <xxx>;
 			};
 		};
 	}

Where this codec would then need to be referenced with just an
additional instance number:

foo = <&ep 0>;
bar = <&ep 1>;
...

And then for a codec with 2 DAIs the usual #size-cells = <1>
would be used with numbered endpoints for each DAI the way
you already described:

 	port {
 		ep0: endpint@0 {
 			remote-endpoint = <xxx>;
 		};
 		ep1: endpint@1 {
 			remote-endpoint = <xxx>;
 		};
 	}

Do you think that would work?

> Can you agree this ? we need extra patch,
> but it can solve your / my problem.

Yes it's starting to make sense :)

> Now I'm posting patches to merging
> "audio-graph-card" and "DPCM ver audio-graph-card".
> If you are OK, I will include above solution patch
> to this patch-set.

Sure, maybe please first check if the #size-cells = <2>
option would work though?

> Current audio-graph doesn't expect your use-case,
> and I want to avoid conflict.
> 
> So, "merged" audio-graph should solve your use-case.
> If you can agree about this, I will post patch-set.

Yeah I agree, just still wondering what might be the best
way to represent 1 DAI vs 2 DAIs.

Regards,

Tony
