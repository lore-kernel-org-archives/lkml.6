Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCA3C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95D02075E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95D02075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753000AbeGCLDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:03:30 -0400
Received: from gloria.sntech.de ([185.11.138.130]:42966 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752215AbeGCLD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:03:29 -0400
Received: from ip5f5b7f77.dynamic.kabel-deutschland.de ([95.91.127.119] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1faJ5V-0001Tf-Dw; Tue, 03 Jul 2018 13:03:13 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Damian Kos <dkos@cadence.com>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sandy Huang <hjc@rock-chips.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, ltyrala@cadence.com,
        pgaj@cadence.com, stelford@cadence.com
Subject: Re: [PATCH 12/12] drm/rockchip: add support for CDNS MHDP IP controller.
Date:   Tue, 03 Jul 2018 13:03:11 +0200
Message-ID: <2647490.Uuqs1CuF1U@diego>
In-Reply-To: <1530612152-27555-13-git-send-email-dkos@cadence.com>
References: <1530612152-27555-1-git-send-email-dkos@cadence.com> <1530612152-27555-13-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Damien,

it's very cool to see collaboration from vendors on this.


Am Dienstag, 3. Juli 2018, 12:02:23 CEST schrieb Damian Kos:
>

It would be really nice to explain a bit about the added controller support
in the commit message, so that people reviewing the patch can get a
feeling for it.

> Signed-off-by: Damian Kos <dkos@cadence.com>
> ---
>  drivers/gpu/drm/rockchip/cdn-dp-core.c |  953
> +++++++++++++++++++++++++++++++- drivers/gpu/drm/rockchip/cdn-dp-core.h |  
> 25 +
>  drivers/gpu/drm/rockchip/cdn-dp-reg.c  |    2 +-
>  drivers/gpu/drm/rockchip/cdn-dp-reg.h  |    4 +

From the changes below, it looks that this seems to add support for a
bridge chip based on that IP block. So it seems like the bridge+glue driver
model would be a perfect fit for this, instead of stapling this onto the
Rockchip-specific driver.

So essentially, you could take the Rockchip cdn-dp driver, move the common
parts to drivers/gpu/drm/bridge and then create separate glue drivers for
both Rockchip and your external bridge IP block.

This would prevent code duplication and also allow your bridge driver to
be compiled without the Rockchip drm being present :-) .
And also pave the way for future socs using your DP ip block.


Nowadays we have quite a number of examples you could take as
inspiration for this:
- bridge/analogix/* (shared between Exynos and Rockchip right now)
- bridge/synopsys/dw-hdmi* (shared between a quite big number of users)
- bridge/synopsys/dw-mipi-dsi.c (shared between Rockchip [pending] and stm)


Thanks
Heiko



