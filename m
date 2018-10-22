Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AE2C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 06:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924CC205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 06:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RsgVim9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924CC205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbeJVPHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 11:07:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46299 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeJVPHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 11:07:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id bb7-v6so1120099plb.13
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 23:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IhIJYuSCsIe+Amj0N6UYunMtP1A8Wvwe/5QIxeRYNaE=;
        b=RsgVim9dKPtZ65SvjizTAIPPwujGVF/HEuJkTZtbCwOldd6Cd4X2ApGDgXY7W4lt0W
         RHzdyJJXI7PQufu1Q2DgGnhSYAQTDUmq+Iszr27NP5ySCcLTgLcQREnA2m9RP0QFVhIR
         5sAtw3FPMi5ia+dbw04+Ez9Kxukoom77l28Zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IhIJYuSCsIe+Amj0N6UYunMtP1A8Wvwe/5QIxeRYNaE=;
        b=ly8lBYSgnZQx//FCPX70IIVIu94GTOeIGgRLWkP1OX/ZhSZzQ/njyamqOS4S3i/3vS
         IVSxi9+t+dHsykHt8peRwx00ZB0HDaD7TxT3UlrQrC21aU+FZ4MDK+XRe7Rx2NI2pwkH
         ehyHBm/ApXVWVQnI2Cr/opKqi0+N4dXu1Y671XEfFpeqOZCAz9+AlNyssX/wdqbjKBx6
         ECN0jCeLVkEXDgduM4EF29AryaVn8e4AnY3bkVGOCA7+PReUH6LNFdkh5DC31BzA2lBt
         ZCG2Wb2d3B21AxDHLIQ/G7xjNDynkF1CPjd/Q/AILSayojTgq+G4wDH+mG26ENCYVEmR
         I4Lw==
X-Gm-Message-State: AGRZ1gK1Q0MjL3YwiHnQTJaGwhX3T9xnE1cXZLtgt/4h7UO+5KFI3gYA
        fzouggNR9ngErFeYxHT5vVz5
X-Google-Smtp-Source: AJdET5d7gBKiUqk+pJoFw1x0rWctm8QLW7K1A1mFlr/PC6LAJGpqUMfLPySUi2W0nLPQXKlGP8Ef5Q==
X-Received: by 2002:a17:902:b412:: with SMTP id x18-v6mr9295774plr.13.1540191017254;
        Sun, 21 Oct 2018 23:50:17 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id 67-v6sm36230157pfw.60.2018.10.21.23.50.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 23:50:16 -0700 (PDT)
Date:   Mon, 22 Oct 2018 12:20:08 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Michal Simek <michal.simek@xilinx.com>, robh+dt@kernel.org,
        heiko@sntech.de, ezequiel@collabora.com, xuwei5@hisilicon.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, koen.kooi@linaro.org
Subject: Re: [PATCH 6/6] arm64: dts: xilinx: ultra96: Standardize LED labels
 and triggers
Message-ID: <20181022065008.GA10999@mani>
References: <20181009140522.6492-1-manivannan.sadhasivam@linaro.org>
 <20181009140522.6492-7-manivannan.sadhasivam@linaro.org>
 <7b94c09d-ecbd-e48e-6583-127566715a76@xilinx.com>
 <20181015185147.GA29649@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015185147.GA29649@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Sorry for the late reply! Not sure why your resonse was filtered by the
Spam filter :\

On Mon, Oct 15, 2018 at 09:56:01PM +0200, Pavel Machek wrote:
> On Wed 2018-10-10 09:25:24, Michal Simek wrote:
> > On 9.10.2018 16:05, Manivannan Sadhasivam wrote:
> > > For all 96Boards, the following standard is used for onboard LEDs.
> > > 
> > > device-name:green:user1  default-trigger: heartbeat
> > > device-name:green:user2  default-trigger: mmc0/disk-activity
> > >                                           (onboard-storage)
> > > device-name:green:user3  default-trigger: mmc1 (SD-card)
> > > device-name:green:user4  default-trigger: none, panic-indicator
> 
> Actually, having one LED as heartbeat and second as panic indicator
> only... Could those be merged and remaining LED used to something
> useful?
>

No. Our intention is to leave one LED as a panic indicator and a dedicated
LED for heartbeat. If user wants to override the defaults, he can always do
with any LEDs.
 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> 
> > > index eb5e8bddb610..565ceb390f99 100644
> > > --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> > > +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> > > @@ -57,29 +57,30 @@
> > >  	leds {
> > >  		compatible = "gpio-leds";
> > >  		ds2 {
> > > -			label = "ds2";
> > > +			label = "zynqmp-zcu100-revC:green:user1";
> > 
> > The purpose of this series should be standardize Led labels that's why I
> > would expect that leds will be called in the same way on all these
> > boards that's why I am not getting why there is board name.
> > 
> > green:user1 or just user1 should be enough.
> 
> green:user1 is better. Also... I guess this should go to the LEDs
> list... and if you want to make names standard, maybe there's better
> naming than user1..user4?
> 

These are user LEDs and that's why the `userN` naming convention comes into
place. Here I agree to move with "green:user1" format and sending it to the
LEDs list.

Thanks,
Mani

> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


