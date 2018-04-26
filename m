Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932228AbeDZR2l (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 13:28:41 -0400
Received: from mail-ot0-f178.google.com ([74.125.82.178]:45982 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756831AbeDZR2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 13:28:37 -0400
X-Google-Smtp-Source: AIpwx49X7gM2mCDmUbMoq9+Mb9OHCklnH3im/IJ9/Ycx/TzqtQVolheeHhmaJUFrjZL54FL8PWT0M0G4a+dYAOT235E=
MIME-Version: 1.0
In-Reply-To: <DB5PR04MB132072FEDCAFEDF6592C6A32F58E0@DB5PR04MB1320.eurprd04.prod.outlook.com>
References: <1524455219-6736-1-git-send-email-Anson.Huang@nxp.com>
 <1524455219-6736-4-git-send-email-Anson.Huang@nxp.com> <CAOMZO5CDAQtw7Q6NgSzKP4ogaqRaGSE0A+st1iqZ=cQsK49moQ@mail.gmail.com>
 <AM3PR04MB131566E1C8033D256686F192F5880@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5Dm=MFRoh=y54Qf2RrncWfQPTUJ2ZNfvYnUD=idp8RPNA@mail.gmail.com>
 <AM3PR04MB1315ED599A20F67BB9FEFEE1F58F0@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <AM3PR04MB1315B04BE46755E3EB82E04CF58F0@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5AS=aH8p1+tmgJ4ooeqExNqOALh7vbPAsQdqdky8CkXyQ@mail.gmail.com> <DB5PR04MB132072FEDCAFEDF6592C6A32F58E0@DB5PR04MB1320.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 26 Apr 2018 14:28:35 -0300
Message-ID: <CAOMZO5Df__UpcLXVUrW0sT24g=Kmu2132QeQSBE9aZrjcyqsCw@mail.gmail.com>
Subject: Re: [PATCH 4/5] ARM: dts: imx6sx-sabreauto: add fec support
To: Anson Huang <anson.huang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 3:57 AM, Anson Huang <anson.huang@nxp.com> wrote:

> The 'phy-supply' is for enabling/disabling phy regulator, but here the MAX7322 IO0 is NOT for
> enabling/disabling PHY regulator, it is for IO voltage switch between 1.5V and 1.8V, our ENET
> IO can work with both 1.5V and 1.8V, so any config is OK for ENET function.

Thanks for the clarification.

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

If there is no consumer for this regulator, the regulator API will disable it.

It seems you need a 'regulator-always-on;'.


> +               };
> +
>
> Anson.
>
