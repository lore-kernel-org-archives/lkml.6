Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54411C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0271421581
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0271421581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbeHON2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 09:28:39 -0400
Received: from gloria.sntech.de ([185.11.138.130]:57458 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbeHON2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 09:28:39 -0400
Received: from wd0180.dip.tu-dresden.de ([141.76.108.180] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fptAh-0003gF-W1; Wed, 15 Aug 2018 12:37:00 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, amstan@chromium.org,
        groeck@google.com, kieran.bingham@ideasonboard.com,
        kernel@collabora.com, bleung@chromium.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] phy: rockchip-inno-usb2: allow to force the B-Device Session Valid bit.
Date:   Wed, 15 Aug 2018 12:36:59 +0200
Message-ID: <2399692.mpX5uTAn2d@phil>
In-Reply-To: <72ca2b54-785c-8fe3-b472-5b8837afe00a@collabora.com>
References: <20180815095934.11205-1-enric.balletbo@collabora.com> <2209969.yNeHebgXRl@phil> <72ca2b54-785c-8fe3-b472-5b8837afe00a@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 15. August 2018, 12:34:42 CEST schrieb Enric Balletbo i Serra:
> Hi Heiko,
> 
> On 15/08/18 12:18, Heiko Stuebner wrote:
> > Hi Enric,
> > 
> > Am Mittwoch, 15. August 2018, 11:59:33 CEST schrieb Enric Balletbo i Serra:
> >> The OTG disconnection event is generated after the presence/abscense of
> >> an ID connection, but some platforms doesn't have the ID pin connected, so
> >> the event is not generated. In such case, for detecting the disconnection
> >> event, we can get the cable state from an extcon driver. We need, though,
> >> to force to set the B-Device Session Valid bit on the PHY to have the
> >> device respond to setup address. Otherwise, the following error is
> >> shown:
> >>
> >>     usb 2-2: Device not responding to setup address.
> >>     usb 2-2: device not accepting address 14, error -71
> >>     usb usb2-port2: unable to enumerate USB device
> >>
> >> The patch allows to tell the PHY to force the B-Device Session Valid bit
> >> when the OTG role is device and clear that bit if the OTG role is host.
> >>
> >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > 
> >> @@ -1024,6 +1051,12 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
> >>  	INIT_DELAYED_WORK(&rport->chg_work, rockchip_chg_detect_work);
> >>  	INIT_DELAYED_WORK(&rport->otg_sm_work, rockchip_usb2phy_otg_sm_work);
> >>  
> >> +	rport->force_bvalid = false;
> >> +	if (of_device_is_compatible(rphy->dev->of_node,
> >> +				    "rockchip,rk3399-usb2phy"))
> >> +		rport->force_bvalid = of_property_read_bool(child_np,
> >> +						"rockchip,force-bvalid");
> > 
> > That feels a bit clumsy, especially as the rk3399 seems to have the id
> 
> Agree, It is, let me explain :)
> 
> Ideally we shouldn't have this check, to get rid of this check I only need the
> offsets for bvalid_session register for all the compatibles and fill in phy
> configuration data (rk3228_phy_cfgs, &rk3328_phy_cfgs, rk3366_phy_cfgs,
> rv1108_phy_cfgs)
> 
> To be honest I didn't look if all the datasheets are public available, let me do
> some research. Or, if anyone has the datasheet and can tell where the
> bvalid_session bit is I can fill all the data.

Or just always check for the presence of the property and just make the
driver warn if that bvalid_session setting is not available for that soc yet.

From the TRMs I have your rk3399 bvalid_session settings seems to live
in the depths of the undocumented inno-phy regs, so that will probably
be the same for other socs using that phy.


Heiko


