Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBE1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB862082B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="i6mVugUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB862082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbeH1A5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 20:57:42 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:44459 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbeH1A5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 20:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=elaJPyOcRR77Yh5uKXj05WEatBXR0n45Ub2Q6nvOqmk=;
        b=i6mVugUj9RxM2mdG1TIHEhY/1ekvjrUqvn7egDJ+hrvexUvgtA5CPwii0zZoOGyivk1n/qIdPfL1g5H0vCFktklmmeY5g/6o20G9FxjGl/gJqcrmT/GBt5ecmqRN5rnaZ5k9J0oFMNABwLn9hYo1ZYSvf2/S6a+ijXP/tevUj1Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fuOlA-0006lZ-5e; Mon, 27 Aug 2018 23:09:16 +0200
Date:   Mon, 27 Aug 2018 23:09:16 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        rmk+kernel@armlinux.org.uk
Subject: Re: [PATCH 1/3] ARM: dts: NSP: Enable SFP on bcm958625hr
Message-ID: <20180827210916.GP27483@lunn.ch>
References: <20180827200344.16158-1-f.fainelli@gmail.com>
 <20180827200344.16158-2-f.fainelli@gmail.com>
 <20180827203500.GN27483@lunn.ch>
 <4a0e7b46-f7b6-3e9a-5f67-8160537482c8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a0e7b46-f7b6-3e9a-5f67-8160537482c8@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 01:52:42PM -0700, Florian Fainelli wrote:
> On 08/27/2018 01:35 PM, Andrew Lunn wrote:
> >> @@ -210,6 +228,17 @@
> >>  			reg = <4>;
> >>  		};
> >>  
> >> +		port@5 {
> >> +			label = "sfp";
> >> +			phy-mode = "sgmii";
> >> +			reg = <5>;
> >> +			sfp = <&sfp>;
> >> +			fixed-link {
> >> +				speed = <1000>;
> >> +				full-duplex;
> >> +			};
> > 
> > Hi Florian
> > 
> > You might want to add a comment about why you are using fixed-link and
> > sgmii, which seems very odd. Is it even correct?
> 
> Probably not, this is kind of left over from before adding the sfp
> phandle, but if I do remove it, and I can see the DSA slave network
> device fail to initialize, likely because we destroy the PHYLINK instance.
> 
> AFAIR, when we talked about this with Russell, I did not see why we had
> to comment out the following:
> 
> diff --git a/net/dsa/slave.c b/net/dsa/slave.c
> index 962c4fd338ba..f3ae16dbf8d8 100644
> --- a/net/dsa/slave.c
> +++ b/net/dsa/slave.c
> @@ -1227,7 +1227,7 @@ static int dsa_slave_phy_setup(struct net_device
> *slave_dev)
>                         netdev_err(slave_dev,
>                                    "failed to connect to port %d: %d\n",
>                                    dp->index, ret);
> -                       phylink_destroy(dp->pl);
> +                       //phylink_destroy(dp->pl);
>                         return ret;
>                 }
>         }
> 
> maybe you know?

Hi Florian

I didn't need anything like this for the mv88e6xxx. I had patches
merged in -rc1 to make SFF work connected to the mv88e6390. The DT
change was not merged, but it is here:

https://patchwork.ozlabs.org/patch/955635/

+					port@9 {
+						reg = <9>;
+						label = "sff2";
+						phy-mode = "sgmii";
+						managed = "in-band-status";
+						sfp = <&sff2>;
+					};

	Andrew
