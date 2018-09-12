Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D9EC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428A520880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GzY6r6Kc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 428A520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbeILN0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:26:22 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42308 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbeILN0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:26:22 -0400
Received: by mail-pl1-f196.google.com with SMTP id g23-v6so610044plq.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 01:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Li9H4PXXXUFCs2Dp4CKXup9iVBZotEacx/bMF23WtQ4=;
        b=GzY6r6Kc5qFAy8cdjH4Ni+gi3LP5ph8o1D+zLCYK6kJj5h/gSNuEehx537Eg4DjQVX
         1BW3qY4j1gHq9q9+03fZHCtJ4rULCjGtZ9KR+EQqd1PQl8LOohOFbZzHVSIZZVVdPPcE
         6tJ8nkdxRJWmDRPlMAHGIfuNExLoUergruUus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Li9H4PXXXUFCs2Dp4CKXup9iVBZotEacx/bMF23WtQ4=;
        b=qRjlGFO3xbq3hJ5OsPTzGcbGF1wuo5PJZVboCVXRJoPr8038giYLAbKyJpzC0+V28y
         wi/DTD/9euiyFwUKsf2YK1sysmHyi4QDCbmcyU0vNZHghUlzfE1/rGsEj4EuUNEg1yDN
         rS4mAMh2T9SUujQV8h6+Mww71tKl2AdUtkUS5aQcYnE94FrwOE2d4w0p1msIxtg4pjjV
         GaGZP/L6Cx5ATNstpd/47qF66uW0CrZeBqKbz3NhXdyErtU9HW0TdgIqz/cRsoKkn7+H
         CKLiX0//lhCm3BmTMa2StwaVWQdUUjq1slgOusFez5ST3dRPFolxI4D+fzdbGAbga6UI
         uKOg==
X-Gm-Message-State: APzg51CK3g3iW2xOiXRGmDJtAdl97LKDo7SZEEs9INL66oSo+Ron1e/g
        TkFyCA96hHsL3kwF2ICa3XL3owin/A==
X-Google-Smtp-Source: ANB0VdZk8iWME1gGGRQSjh76l4uXV5IKp96uxNEf3BvErlA7VgN2blbBvKqPggNLBls8yy2hqLtkRA==
X-Received: by 2002:a17:902:1a9:: with SMTP id b38-v6mr856012plb.89.1536740576444;
        Wed, 12 Sep 2018 01:22:56 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:89e:33f6:c566:c752:9b3c:11bf])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1732474pfe.42.2018.09.12.01.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 01:22:55 -0700 (PDT)
Date:   Wed, 12 Sep 2018 13:52:44 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>, robh+dt@kernel.org,
        vicencb@gmail.com, shawn.lin@rock-chips.com,
        enric.balletbo@collabora.com, pbrobinson@gmail.com, tom@vamrs.com,
        dev@vamrs.com, stephen@vamrs.com, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] arm64: dts: rockchip: Split out common nodes for
 Rock960 based boards
Message-ID: <20180912082244.GA16509@Mani-XPS-13-9360>
References: <20180911023031.4892-1-manivannan.sadhasivam@linaro.org>
 <9e1868684ed851dfa19300ac2e648cfea7bf3eb9.camel@collabora.com>
 <20180912031248.GA4880@Mani-XPS-13-9360>
 <11137562.zz0kzkSHxt@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11137562.zz0kzkSHxt@diego>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 09:26:12AM +0200, Heiko Stübner wrote:
> Am Mittwoch, 12. September 2018, 05:12:48 CEST schrieb Manivannan Sadhasivam:
> > Hi Ezequiel,
> > 
> > On Tue, Sep 11, 2018 at 04:40:29PM -0300, Ezequiel Garcia wrote:
> > > On Tue, 2018-09-11 at 08:00 +0530, Manivannan Sadhasivam wrote:
> > > > Since the same family members of Rock960 boards (Rock960 and Ficus)
> > > > share the same configuration, split out the common nodes into a common
> > > > dtsi file for reducing code duplication. The board specific nodes for
> > > > Ficus boards are then placed in corresponding board DTS file.
> > > 
> > > I think it should be possible to move the common USB nodes to the dtsi
> > > file, and keep the board-specific (phy-supply property) in the dts files:
> > > 
> > > &u2phy0_host {
> > > 
> > >         phy-supply = <&vcc5v0_host>;
> > > 
> > > };
> > > 
> > > &u2phy1_host {
> > > 
> > >         phy-supply = <&vcc5v0_host>;
> > > 
> > > };
> > 
> > We can do that but my intention was to entirely partition the nodes
> > which are not common. So that it would be less confusing when someone
> > looks at it (please correct me if I'm wrong).
> 
> The supply is actually named the same on both boards, so you could move
> all the usb-nodes to the main dtsi, including the reference to vcc5v0_host
> which would then get defined itself in the two board dts.
> 
> Then again, seeing that the vcc5v0_host also only differs in the actually
> used gpio another option would be to move the whole regulator node
> to the dtsi and just define the gpio properties in the board dts files.
>

Hmm, if that's the preferred option then I guess this applies to pcie
nodes also. At the end, usb and pcie nodes will be shrinked to below in
board dts:

&pinctrl {
        pcie {
                pcie_drv: pcie-drv {
                        rockchip,pins =
                                <2 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
                        };
        };

        usb2 {
                host_vbus_drv: host-vbus-drv {
                        rockchip,pins =
                                <4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
                };
        };
};

&pcie0 {
        ep-gpios = <&gpio2 RK_PA2 GPIO_ACTIVE_HIGH>;
        status = "okay";
};

&vcc3v3_pcie {
        gpio = <&gpio2 5 GPIO_ACTIVE_HIGH>;
};

&vcc5v0_host {
        gpio = <&gpio4 25 GPIO_ACTIVE_HIGH>;
};

Thanks,
Mani

> 
> Heiko
> 
> 
