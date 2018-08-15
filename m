Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08EEC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5F421521
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5F421521
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbeHONJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 09:09:45 -0400
Received: from gloria.sntech.de ([185.11.138.130]:57132 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbeHONJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 09:09:45 -0400
Received: from wd0180.dip.tu-dresden.de ([141.76.108.180] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fpssT-0003a5-CF; Wed, 15 Aug 2018 12:18:09 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, amstan@chromium.org,
        groeck@google.com, kieran.bingham@ideasonboard.com,
        kernel@collabora.com, bleung@chromium.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] phy: rockchip-inno-usb2: allow to force the B-Device Session Valid bit.
Date:   Wed, 15 Aug 2018 12:18:08 +0200
Message-ID: <2209969.yNeHebgXRl@phil>
In-Reply-To: <20180815095934.11205-4-enric.balletbo@collabora.com>
References: <20180815095934.11205-1-enric.balletbo@collabora.com> <20180815095934.11205-4-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Am Mittwoch, 15. August 2018, 11:59:33 CEST schrieb Enric Balletbo i Serra:
> The OTG disconnection event is generated after the presence/abscense of
> an ID connection, but some platforms doesn't have the ID pin connected, so
> the event is not generated. In such case, for detecting the disconnection
> event, we can get the cable state from an extcon driver. We need, though,
> to force to set the B-Device Session Valid bit on the PHY to have the
> device respond to setup address. Otherwise, the following error is
> shown:
> 
>     usb 2-2: Device not responding to setup address.
>     usb 2-2: device not accepting address 14, error -71
>     usb usb2-port2: unable to enumerate USB device
> 
> The patch allows to tell the PHY to force the B-Device Session Valid bit
> when the OTG role is device and clear that bit if the OTG role is host.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> @@ -1024,6 +1051,12 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
>  	INIT_DELAYED_WORK(&rport->chg_work, rockchip_chg_detect_work);
>  	INIT_DELAYED_WORK(&rport->otg_sm_work, rockchip_usb2phy_otg_sm_work);
>  
> +	rport->force_bvalid = false;
> +	if (of_device_is_compatible(rphy->dev->of_node,
> +				    "rockchip,rk3399-usb2phy"))
> +		rport->force_bvalid = of_property_read_bool(child_np,
> +						"rockchip,force-bvalid");

That feels a bit clumsy, especially as the rk3399 seems to have the id
connection in general ... maybe you could just make that conditional
on the presence of the extcon?

Or alternatively if needed put that in the soc-specific data struct we
have already instead open-coding soc compatible checks.

Heiko


