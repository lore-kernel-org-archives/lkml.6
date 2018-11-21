Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3403DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74C62146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c8Q7fCU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74C62146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbeKUT3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:29:46 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58752 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeKUT3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 14:29:46 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAL8tEq0076197;
        Wed, 21 Nov 2018 02:55:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542790514;
        bh=RaYLBY3C9MifiQMpPdFmMCEqSCg9MCBNo4xS+LD2sRw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=c8Q7fCU/lQagzbQQo2+ffO2GwBd+o2nPHcMNx6+qDdvaxykMVmOKk0Pl3aH5Q30Hl
         gRWHR2LQz4GBD0DNI0AUhE4+yUNFaYjob+V6Isl+M0YCAT3yX+0kEoevFvQYlPboX/
         TPYHc8ypFcKHnv1NIoCFsZp00F+2lSstpi3rKU2A=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAL8tEMX050548
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Nov 2018 02:55:14 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 21
 Nov 2018 02:55:14 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 21 Nov 2018 02:55:14 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAL8t863019198;
        Wed, 21 Nov 2018 02:55:08 -0600
Subject: Re: [PATCH v3 0/5] phy: core: rework phy_set_mode to accept phy mode
 and submode
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
CC:     <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Carlo Caione <carlo@caione.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Manu Gautam <mgautam@codeaurora.org>
References: <20181120012424.11802-1-grygorii.strashko@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <6418b7c3-7345-76e8-90c0-9a77769f6f87@ti.com>
Date:   Wed, 21 Nov 2018 14:25:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181120012424.11802-1-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/11/18 6:54 AM, Grygorii Strashko wrote:
> Hi Kishon, All,
> 
> Thank you for your review.
> I've not added "Tested-by"/"Acked-by" tags due to code changes in v3.

merged after adding the required ACKs.

Thanks
Kishon
> 
> As was discussed in [1] I'm posting series which introduces rework of
> phy_set_mode to accept phy mode and submode. I've dropped TI specific patches as
> this change is pretty big by itself.
> 
> Patch 1 is cumulative change which refactors PHY framework code to
> support dual level PHYs mode configuration - PHY mode and PHY submode. It
> extends .set_mode() callback to support additional parameter "int submode"
> and converts all corresponding PHY drivers to support new .set_mode()
> callback declaration.
> The new extended PHY API
>  int phy_set_mode_ext(struct phy *phy, enum phy_mode mode, int submode)
> is introduced to support dual level PHYs mode configuration and existing
> phy_set_mode() API is converted to macros, so PHY framework consumers do
> not need to be changed (~21 matches).
> 
> Patches 2-4: Add new PHY's mode to be used by Ethernet PHY interface drivers or
> multipurpose PHYs like serdes and convert ocelot-serdes and mvebu-cp110-comphy
> PHY drivers to use recently introduced PHY_MODE_ETHERNET and phy_set_mode_ext().
> 
> Patch 5 - removes unused, ethernet specific phy modes from enum phy_mode.
> 
> Testing:
>  - series tested on TI am335x/am437x/am5(dra7) paltforms.
>  - other driver build tested.
> 
> changes in v3:
> - mux tables for PHY ocelot-serdes driver updated to store PHY mode and submode
> - mux tables for PHY mvebu-cp110-comphy driver updated to store PHY mode
>   and submode
> changes in v2:
> - marvell PHY and net drivers updated as recommended by Russell King
> 
> v2: https://lkml.org/lkml/2018/11/10/220
> v1: https://lkml.org/lkml/2018/11/8/260
> 
> [1] https://lkml.org/lkml/2018/10/25/366
> 
> Grygorii Strashko (5):
>   phy: core: rework phy_set_mode to accept phy mode and submode
>   phy: core: add PHY_MODE_ETHERNET
>   phy: ocelot-serdes: convert to use eth phy mode and submode
>   phy: mvebu-cp110-comphy: convert to use eth phy mode and submode
>   phy: core: clean up unused ethernet specific phy modes
> 
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 19 +----
>  drivers/net/ethernet/mscc/ocelot.c              |  9 +--
>  drivers/phy/allwinner/phy-sun4i-usb.c           |  3 +-
>  drivers/phy/amlogic/phy-meson-gxl-usb2.c        |  5 +-
>  drivers/phy/amlogic/phy-meson-gxl-usb3.c        |  5 +-
>  drivers/phy/marvell/phy-mvebu-cp110-comphy.c    | 93 ++++++++++++++-----------
>  drivers/phy/mediatek/phy-mtk-tphy.c             |  2 +-
>  drivers/phy/mediatek/phy-mtk-xsphy.c            |  2 +-
>  drivers/phy/mscc/phy-ocelot-serdes.c            | 24 +++++--
>  drivers/phy/phy-core.c                          |  6 +-
>  drivers/phy/qualcomm/phy-qcom-qmp.c             |  3 +-
>  drivers/phy/qualcomm/phy-qcom-qusb2.c           |  3 +-
>  drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c    |  3 +-
>  drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c    |  3 +-
>  drivers/phy/qualcomm/phy-qcom-usb-hs.c          |  3 +-
>  drivers/phy/ti/phy-da8xx-usb.c                  |  3 +-
>  drivers/phy/ti/phy-tusb1210.c                   |  2 +-
>  include/linux/phy/phy.h                         | 18 +++--
>  18 files changed, 111 insertions(+), 95 deletions(-)
> 
