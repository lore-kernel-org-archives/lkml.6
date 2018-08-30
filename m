Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84C3C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4705020661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gzcvMtK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4705020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeH3HEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 03:04:23 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47108 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbeH3HEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 03:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=WcXLsm+jiLyHyisc+QVEb1HKqN6ECWPEaaC/NY3Kd+4=;
        b=gzcvMtK4uTjm8lnG6Q9vBy2BbYXFPWU1xmsGij3eSANvPsYhcG1I0FY2Me2eZYi2C30GT4Ge+UBrzHk7MfiiQGUdmoE0K1St2+G7oPgRd0OXbnXuxWOkKuV7nAL5HMtOhXeLB/i5bXuzpil1qywWx3ZYJ4OM0X5fB2Vpqo7Vkws=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fvDFs-0004nL-SK; Thu, 30 Aug 2018 05:04:20 +0200
Date:   Thu, 30 Aug 2018 05:04:20 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     davem@davemloft.net, keescook@chromium.org, f.fainelli@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        alex.williams@ni.com
Subject: Re: [PATCH net-next 1/3] net: nixge: Add support for fixed-link
 subnodes
Message-ID: <20180830030420.GB16896@lunn.ch>
References: <20180830004046.9417-1-mdf@kernel.org>
 <20180830004046.9417-2-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830004046.9417-2-mdf@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 05:40:44PM -0700, Moritz Fischer wrote:
> Add support for fixed-link cases where no MDIO is
> actually required to run the device.
> In that case no MDIO bus is instantiated since the
> actual registers are not available in hardware.

Hi Moritz

There are a few different use cases here:

The hardware is missing MDIO - You need fixed-link.

The hardware has MDIO, but you don't have a PHY connected on it, and
use fixed link.

The hardware has MDIO, and it is used e.g. for an Ethernet switch, or
a PHY for another Ethernet interface. Plus you need fixed link.

The binding typically looks like:

&fec1 {
        phy-mode = "rmii";
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_fec1>;
        status = "okay";

        fixed-link {
                speed = <100>;
                full-duplex;
        };

        mdio1: mdio {
                #address-cells = <1>;
                #size-cells = <0>;
                status = "okay";

                switch0: switch0@0 {
                        compatible = "marvell,mv88e6085";
                        pinctrl-names = "default";
                        pinctrl-0 = <&pinctrl_switch>;
                        reg = <0>;
                        eeprom-length = <512>;
                        interrupt-parent = <&gpio3>;

It is important you have the mdio subnode, with PHYs and switches as
children. The driver currently gets this wrong, it uses
pdev->dev.of_node.

So the first patch should be to extend this behaviour. Look for a
child node called mdio. If it exists, call nixge_mdio_setup() passing
that child. Otherwise continue using pdev->dev.of_node, so you don't
break backwards compatibility.

Then a patch adding support for fixed-link. If the mdio child node
exists, you still need to register the MDIO bus. If there is no child
node, but there is a fixed-link, skip registering the mdio bus with
pdev->dev.of_node.

	Andrew
