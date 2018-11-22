Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4F6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E628F20824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fc1OQpSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E628F20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438138AbeKWEq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:46:29 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:45939 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732278AbeKWEq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=sc5XOR9l4ihjwLdmF+curJFC8RaqW61CoS//MToFAJM=;
        b=fc1OQpSdITrgcy1tx56C7Yu4fGq7+ZZCkpjusonuagl7i7k6STAr/A7ZdExfVny/p7vgpx1maogSa9lcyD3aedA2R61NxKHvlUGCDOQx6gtlzKOIMU3QEOzWFz+rQ5M7Op4yrsEggzbrs8rEWRzNYpOa3gGAx39zG6hfSo8SluM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gPtMT-00025W-RT; Thu, 22 Nov 2018 19:05:57 +0100
Date:   Thu, 22 Nov 2018 19:05:57 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Claudiu Manoil <claudiu.manoil@nxp.com>
Cc:     David Miller <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandru Marginean <alexandru.marginean@nxp.com>,
        Catalin Horghidan <catalin.horghidan@nxp.com>
Subject: Re: [PATCH net-next v2 1/4] enetc: Introduce basic PF and VF ENETC
 ethernet drivers
Message-ID: <20181122180557.GC10697@lunn.ch>
References: <1542737734-21756-1-git-send-email-claudiu.manoil@nxp.com>
 <1542737734-21756-2-git-send-email-claudiu.manoil@nxp.com>
 <20181121.162118.2250773796794960530.davem@davemloft.net>
 <VI1PR04MB48803D4A3D8D331046CFC63196DB0@VI1PR04MB4880.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB48803D4A3D8D331046CFC63196DB0@VI1PR04MB4880.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 01:06:01PM +0000, Claudiu Manoil wrote:
> >-----Original Message-----
> >From: David Miller <davem@davemloft.net>
> >Sent: Thursday, November 22, 2018 2:21 AM
> >To: Claudiu Manoil <claudiu.manoil@nxp.com>
> >Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Alexandru
> >Marginean <alexandru.marginean@nxp.com>; Catalin Horghidan
> ><catalin.horghidan@nxp.com>
> >Subject: Re: [PATCH net-next v2 1/4] enetc: Introduce basic PF and VF ENETC
> >ethernet drivers
> >
> >From: Claudiu Manoil <claudiu.manoil@nxp.com>
> >Date: Tue, 20 Nov 2018 20:15:31 +0200
> >
> >> diff --git a/drivers/net/ethernet/freescale/Makefile
> >b/drivers/net/ethernet/freescale/Makefile
> >> index 3b4ff08..20e5c2f9 100644
> >> --- a/drivers/net/ethernet/freescale/Makefile
> >> +++ b/drivers/net/ethernet/freescale/Makefile
> >> @@ -23,3 +23,4 @@ obj-$(CONFIG_FSL_FMAN) += fman/
> >>  obj-$(CONFIG_FSL_DPAA_ETH) += dpaa/
> >>
> >>  obj-$(CONFIG_FSL_DPAA2_ETH) += dpaa2/
> >> +obj-$(CONFIG_NET_VENDOR_FREESCALE) += enetc/
> >
> >The driver enable Kconfig option should guard traversing into the
> >driver subdirectory, not the vendor enable Kconfig knob.
> 
> The enetc/ dir contains 2 drivers, that share a lot of common code.
> Would you agree if I change the vendor enable with the two configs
> (one for each driver) as below?
> 
> -obj-$(CONFIG_NET_VENDOR_FREESCALE) += enetc/
> +obj-$(CONFIG_FSL_ENETC) += enetc/
> +obj-$(CONFIG_FSL_ENETC_VF) += enetc/

CONFIG_NET_VENDOR_FREESCALE should hide/show all Freescale drivers.

Once you show all Freescale drivers, there should be an option to
enable each individual driver.

Does the ENETC_VF driver depend on the ENETC driver? If so, when
CONFIG_FSL_ENETC is enabled, the CONFIG_FSL_ENETC_VF should be
unhidden.

	Andrew
