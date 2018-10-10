Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291B9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F5621479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJpPWgMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F5621479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeJJO4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:56:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37561 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbeJJO4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:56:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id j23-v6so2191793pfi.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 00:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gig+jd9sCSzj1oTaRnCLhnqSC2IRQRb6M0WyzRBrdLs=;
        b=AJpPWgMwi0FOFFmxxrUtM1wQGJf34IJZOk/hOz8G4xEkkjq6tddOplHMmWsVOzw2Hz
         rs97SEFtudsI49l10G+jJP2uXD5uih51PTGhz11jz1lTEyAtBb0ghw4X3EPIAVkrM63E
         NkXtWy0aLpRp7iARr3yw1Hf7pdXNSBab+TI5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gig+jd9sCSzj1oTaRnCLhnqSC2IRQRb6M0WyzRBrdLs=;
        b=Kj4Gr+f/THKW3HL0pKDKXZviIaNsFjn08skb+Hg0Fbas/ZNJeaEdSRcJxAYimoQYTi
         TYMqxsrAiDGPYNxD8sv8EOYEKqf5TqzTMkbwoM5W+hGTJ96MavMO0GMdXijqmJd3z33k
         iRkGmmsgeF0zCNmECMOsNowyVLlVvOsYB7af6Vvn8OqJUMfC+hyy4Ztrmnrw6HBNDM2/
         P5dchWMChh0ABPJqE43ncBqJvHtoZdbGyrr41bWQO/spnzuVdthw9iVjqwHUSHwAVLAb
         0Z5a2nwZ334dpAulv4nivZlD8GGBDbsIpg2esEOh01EY4lAwAysAHlG5K7eUQvVSe3Qz
         ob1A==
X-Gm-Message-State: ABuFfoiUS5H3JdlHxyOMZDFqtVUazFPygsff9dhu8rBkgPigG9VNz/Q0
        q0cyJDiFebGR+oXoixFxk7GH
X-Google-Smtp-Source: ACcGV61gDFHO9vftl1RaQv/QdoL2TQgvVUHcaEgiGtW7lVIbdn+ZgraPCpq6G8YYBKZO+ZuBZQCLSQ==
X-Received: by 2002:a62:1d16:: with SMTP id d22-v6mr34103089pfd.159.1539156956219;
        Wed, 10 Oct 2018 00:35:56 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id o12-v6sm31817722pfh.20.2018.10.10.00.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 00:35:55 -0700 (PDT)
Date:   Wed, 10 Oct 2018 13:05:46 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     robh+dt@kernel.org, heiko@sntech.de, ezequiel@collabora.com,
        xuwei5@hisilicon.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        koen.kooi@linaro.org
Subject: Re: [PATCH 6/6] arm64: dts: xilinx: ultra96: Standardize LED labels
 and triggers
Message-ID: <20181010073546.GA11462@mani>
References: <20181009140522.6492-1-manivannan.sadhasivam@linaro.org>
 <20181009140522.6492-7-manivannan.sadhasivam@linaro.org>
 <7b94c09d-ecbd-e48e-6583-127566715a76@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b94c09d-ecbd-e48e-6583-127566715a76@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Wed, Oct 10, 2018 at 09:25:24AM +0200, Michal Simek wrote:
> On 9.10.2018 16:05, Manivannan Sadhasivam wrote:
> > For all 96Boards, the following standard is used for onboard LEDs.
> > 
> > device-name:green:user1  default-trigger: heartbeat
> > device-name:green:user2  default-trigger: mmc0/disk-activity
> >                                           (onboard-storage)
> > device-name:green:user3  default-trigger: mmc1 (SD-card)
> > device-name:green:user4  default-trigger: none, panic-indicator
> > device-name:yellow:wlan  default-trigger: phy0tx
> > device-name:blue:bt      default-trigger: hci0-power
> > 
> > So lets adopt the same for Ultra96, which is one of the 96Boards
> > CE and AI platform. Since the WLAN and BT LEDs are hardwired onboard,
> > consolidate only User LEDs.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> > index eb5e8bddb610..565ceb390f99 100644
> > --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> > +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> > @@ -57,29 +57,30 @@
> >  	leds {
> >  		compatible = "gpio-leds";
> >  		ds2 {
> > -			label = "ds2";
> > +			label = "zynqmp-zcu100-revC:green:user1";
> 
> The purpose of this series should be standardize Led labels that's why I
> would expect that leds will be called in the same way on all these
> boards that's why I am not getting why there is board name.
> 
> green:user1 or just user1 should be enough.
> 

Hmm. That's a good point. My proposal to standardize the labels is inspired from
Dragonboard410c dts [1]. They had the device name in label and I decided to
go with that. But as you said, the board name is not needed and just 
`color:led-name` should be fine.

Will modify this in next interation.

Thanks,
Mani

[1] https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi#L294

> Thanks,
> Michal
