Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbeEDIpa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 04:45:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751106AbeEDIp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 04:45:28 -0400
Date: Fri, 4 May 2018 16:45:09 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Anson Huang <anson.huang@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 4/5] ARM: dts: imx6sx-sabreauto: add fec support
Message-ID: <20180504084508.GD3443@dragon>
References: <1524455219-6736-1-git-send-email-Anson.Huang@nxp.com>
 <1524455219-6736-4-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5CDAQtw7Q6NgSzKP4ogaqRaGSE0A+st1iqZ=cQsK49moQ@mail.gmail.com>
 <AM3PR04MB131566E1C8033D256686F192F5880@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5Dm=MFRoh=y54Qf2RrncWfQPTUJ2ZNfvYnUD=idp8RPNA@mail.gmail.com>
 <AM3PR04MB1315ED599A20F67BB9FEFEE1F58F0@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <AM3PR04MB1315B04BE46755E3EB82E04CF58F0@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5AS=aH8p1+tmgJ4ooeqExNqOALh7vbPAsQdqdky8CkXyQ@mail.gmail.com>
 <DB5PR04MB132072FEDCAFEDF6592C6A32F58E0@DB5PR04MB1320.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB5PR04MB132072FEDCAFEDF6592C6A32F58E0@DB5PR04MB1320.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 06:57:07AM +0000, Anson Huang wrote:
> > > Sorry, I made a mistake here, the MAX7320 IO0 is for adjusting FEC1's
> > > voltage,
> > 
> > In this case you need to pass the 'phy-supply' property inside the fec node and
> > add a regulator that is controlled via MAX7320 IO0 pin.
> 
> The 'phy-supply' is for enabling/disabling phy regulator, but here the MAX7322 IO0 is NOT for
> enabling/disabling PHY regulator, it is for IO voltage switch between 1.5V and 1.8V, our ENET
> IO can work with both 1.5V and 1.8V, so any config is OK for ENET function.
> 
> The 1.5V/1.8V selection is a one time setting thing, that means we only need to
> config it once during boot up, most of i.MX platforms does NOT provide such voltage
> switch function for ENET IO, on this 6SX sabre auto board, it is more like a backup or
> validation purpose. With default settings, ENET's function is NOT impacted at all.
> 
> I think we can add a gpio regulator for it and let the regulator initialization set the GPIO
> Level for fec, such below, with " enable-active-high " present, GPIO will be at LOW and voltage
> is 1.5V, without this property, GPIO will be HIGH and voltage will be 1.8V.
> +               reg_fec: fec_io_supply {
> +                       compatible = "regulator-gpio";
> +                       regulator-name = "1.8V_1.5V_FEC";
> +                       regulator-min-microvolt = <1500000>;
> +                       regulator-max-microvolt = <1800000>;
> +                       states = <1500000 0x0 1800000 0x1>;
> +                       enable-gpio = <&max7322 0 GPIO_ACTIVE_HIGH>;
> +                       vin-supply = <&sw2_reg>;
> +                       enable-active-high;
> +               };

Looking at gpio-regulator bindings doc, I feel that property 'gpios'
rather than 'enable-gpio' should be used to specify the MAX7320 IO0 pin.

- enable-gpio           : GPIO to use to enable/disable the regulator.
- gpios                 : GPIO group used to control voltage.

Shawn
