Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E0DC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 11:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F43215B2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 11:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F43215B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbeHOOO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 10:14:28 -0400
Received: from gloria.sntech.de ([185.11.138.130]:57720 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbeHOOO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 10:14:27 -0400
Received: from wd0180.dip.tu-dresden.de ([141.76.108.180] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fptsq-0003pG-GY; Wed, 15 Aug 2018 13:22:36 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, amstan@chromium.org,
        groeck@google.com, kieran.bingham@ideasonboard.com,
        kernel@collabora.com, bleung@chromium.org,
        devicetree@vger.kernel.org, Frank Wang <frank.wang@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] dt-bindings: phy-rockchip-inno-usb2: add documentation for extcon and utmi-avalid properties.
Date:   Wed, 15 Aug 2018 13:22:35 +0200
Message-ID: <4665926.GcjFtTh8TS@phil>
In-Reply-To: <37512ec9-8d9a-6c0c-8808-6351b8501002@collabora.com>
References: <20180815095934.11205-1-enric.balletbo@collabora.com> <2023816.cqyDmH3see@phil> <37512ec9-8d9a-6c0c-8808-6351b8501002@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Am Mittwoch, 15. August 2018, 13:08:00 CEST schrieb Enric Balletbo i Serra:
> On 15/08/18 12:29, Heiko Stuebner wrote:
> > Am Mittwoch, 15. August 2018, 11:59:32 CEST schrieb Enric Balletbo i Serra:
> >> Commit 98898f3bc83c8 ("phy: rockchip-inno-usb2: support otg-port for
> >> rk3399") introduces two new properties. The extcon property is used to
> >> detect the cable-state, and the rockchip,utmi-avalid is used to indicate
> >> which register should be used to detect the vbus state.
> >>
> >> Document these properties in the documentation binding.
> >>
> >> Fixes: 98898f3bc83c8 ("phy: rockchip-inno-usb2: support otg-port for rk3399")
> >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

[...]

> >> @@ -45,6 +46,8 @@ Required properties (port (child) node):
> >>  Optional properties:
> >>   - phy-supply : phandle to a regulator that provides power to VBUS.
> >>  		See ./phy-bindings.txt for details.
> >> + - rockchip,utmi-avalid : boolean, use the avalid register to get vbus status.
> >> +			  Otherwise, use the bvalid register.
> > 
> > Not having looked to deeply into the usb2 phy, this might raise questions
> > on why this is a hardware-description? Is this needed when something is not
> > connected on the board?
> 
> I asked myself the same question and even I thought in just remove that code.
> 
> After some investigation, though, I saw that the UTMI+ specification [1] has two
> signals similar to ID signal (page 11), the AValid signal is used to indicate if
> the session for an A-peripheral is valid and the BValid signal that is used to
> indicate if the session for a B-peripheral is valid. I suppose that use of one
> or the other matters in some cases, but AFAICT this is not used and I didn't see
> any binding using it.
> 
> Maybe someone else can give us more clues on the importance or not of this property?

so I've looked in mainline, chromeos-4.4 and the Rockchip vendor-kernel
and the only board using that property at all is the rk3399-evb-rev1
and -rev2 in the vendor kernel.

The existence of a further -rev3 (which also looks way better cared for
compared rev1+2) indicates that the older ones are probably some sort
of preproduction models, where some wiring (on the soc or board) may
have gone wrong.

So while I would keep all the avalid settings in the driver, we could just
drop reading that property quietly - as Rob wrote some days ago
"it's only an incompatible change if someone notices" [0] and from the
above it doesn't look like it ;-) .

Heiko

[0] https://www.spinics.net/lists/devicetree/msg243978.html


