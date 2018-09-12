Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66A3C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E37520839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E37520839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeILTLT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:11:19 -0400
Received: from gloria.sntech.de ([185.11.138.130]:58620 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726644AbeILTLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:11:19 -0400
Received: from wd0180.dip.tu-dresden.de ([141.76.108.180] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1g05ml-0006Wx-I3; Wed, 12 Sep 2018 16:06:27 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>, robh+dt@kernel.org,
        vicencb@gmail.com, shawn.lin@rock-chips.com,
        enric.balletbo@collabora.com, pbrobinson@gmail.com, tom@vamrs.com,
        dev@vamrs.com, stephen@vamrs.com, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] arm64: dts: rockchip: Split out common nodes for Rock960 based boards
Date:   Wed, 12 Sep 2018 16:05:28 +0200
Message-ID: <2062942.2GzzSlpOsc@phil>
In-Reply-To: <20180912082244.GA16509@Mani-XPS-13-9360>
References: <20180911023031.4892-1-manivannan.sadhasivam@linaro.org> <11137562.zz0kzkSHxt@diego> <20180912082244.GA16509@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 12. September 2018, 10:22:44 CEST schrieb Manivannan Sadhasivam:
> On Wed, Sep 12, 2018 at 09:26:12AM +0200, Heiko Stübner wrote:
> > Am Mittwoch, 12. September 2018, 05:12:48 CEST schrieb Manivannan Sadhasivam:
> > > Hi Ezequiel,
> > > 
> > > On Tue, Sep 11, 2018 at 04:40:29PM -0300, Ezequiel Garcia wrote:
> > > > On Tue, 2018-09-11 at 08:00 +0530, Manivannan Sadhasivam wrote:
> > > > > Since the same family members of Rock960 boards (Rock960 and Ficus)
> > > > > share the same configuration, split out the common nodes into a common
> > > > > dtsi file for reducing code duplication. The board specific nodes for
> > > > > Ficus boards are then placed in corresponding board DTS file.
> > > > 
> > > > I think it should be possible to move the common USB nodes to the dtsi
> > > > file, and keep the board-specific (phy-supply property) in the dts files:
> > > > 
> > > > &u2phy0_host {
> > > > 
> > > >         phy-supply = <&vcc5v0_host>;
> > > > 
> > > > };
> > > > 
> > > > &u2phy1_host {
> > > > 
> > > >         phy-supply = <&vcc5v0_host>;
> > > > 
> > > > };
> > > 
> > > We can do that but my intention was to entirely partition the nodes
> > > which are not common. So that it would be less confusing when someone
> > > looks at it (please correct me if I'm wrong).
> > 
> > The supply is actually named the same on both boards, so you could move
> > all the usb-nodes to the main dtsi, including the reference to vcc5v0_host
> > which would then get defined itself in the two board dts.
> > 
> > Then again, seeing that the vcc5v0_host also only differs in the actually
> > used gpio another option would be to move the whole regulator node
> > to the dtsi and just define the gpio properties in the board dts files.
> >
> 
> Hmm, if that's the preferred option then I guess this applies to pcie
> nodes also. At the end, usb and pcie nodes will be shrinked to below in
> board dts:
> 
> &pinctrl {
>         pcie {
>                 pcie_drv: pcie-drv {
>                         rockchip,pins =
>                                 <2 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
>                         };
>         };
> 
>         usb2 {
>                 host_vbus_drv: host-vbus-drv {
>                         rockchip,pins =
>                                 <4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
>                 };
>         };
> };
> 
> &pcie0 {
>         ep-gpios = <&gpio2 RK_PA2 GPIO_ACTIVE_HIGH>;
>         status = "okay";
> };
> 
> &vcc3v3_pcie {
>         gpio = <&gpio2 5 GPIO_ACTIVE_HIGH>;
> };
> 
> &vcc5v0_host {
>         gpio = <&gpio4 25 GPIO_ACTIVE_HIGH>;
> };

yep, ideally we could go that way. It's way easier to determine the
actual differences between boards that way as well.


Heiko


