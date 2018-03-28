Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753844AbeC1OcM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:32:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753416AbeC1Obm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:31:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE0B21838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AIpwx4/NtWHm8R0SRaDFGbJgNLVrsjQFfxaWHqmDQbGy7dFxZacayLRdm/7CaTd9fUmX8hj8X3Ww3/I4DQ7g3EpckJM=
MIME-Version: 1.0
In-Reply-To: <20180327142408.GL5862@lunn.ch>
References: <20180323150522.9603-1-vicentiu.galanopulo@nxp.com>
 <20180326222509.ppt5aqzqdarhm44d@rob-hp-laptop> <HE1PR0402MB3578B3D33160EBE59C2FD7D7EEAC0@HE1PR0402MB3578.eurprd04.prod.outlook.com>
 <20180327142408.GL5862@lunn.ch>
From: Rob Herring <robh@kernel.org>
Date: Wed, 28 Mar 2018 09:31:20 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJGaGdEgSnnMG8C7P6=gELnuxa-oNgBgK2Yk94HcA=LFg@mail.gmail.com>
Message-ID: <CAL_JsqJGaGdEgSnnMG8C7P6=gELnuxa-oNgBgK2Yk94HcA=LFg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] net: phy: Added device tree binding for dev-addr
 and dev-addr code check-up
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?UTF-8?Q?Vicen=C5=A3iu_Galanopulo?= <vicentiu.galanopulo@nxp.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Alexandru Marginean <alexandru.marginean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 9:24 AM, Andrew Lunn <andrew@lunn.ch> wrote:
>> > This is a 2nd MDIO address, right? Can't you just append this to reg property?
>
> Hi Rob
>
> It is a sub address.
>
> There are two different MDIO addressing schemes. Clause 22 allowed for
> 32 different addresses on an MDIO bus. Clause 45 extended that. You
> have the existing 32 addresses for a package. However, within a
> package, you can have 32 devices.

Sounds similar to functions in PCI land (which are part of reg address).

> You are supposed to be able to look are registers inside the package,
> and it will tell you which devices in the packages are in use. You can
> then look at those devices and figure out what they are using ID
> registers.
>
> However some vendors get this wrong, they don't fill in the devices in
> package information. So the generic probe code never finds them. We
> need to pass it a hint, go looking at this specific device in the
> package.

If this is a rare case and something future devices should get right,
then I'm more inclined to use 'dev-addr' rather than extending reg.

> You can mix Clause 22 and Clause 45 on the same bus. Does DT allow two
> different reg formats to be used at once? Can we have some reg
> properties with a single value, and some with two values? I thought
> #address-cells = <1> means there should be a single address in reg.

#address-cells is how many cells (aka u32) it takes to store an
address, not how many addresses you have. The number of addresses is
(sizeof(reg) / 4) / (#address-cells + #size-cells). So yes, you can
have different number of addresses for each device, but you can't have
different sizes of addresses (e.g. 32-bit and 64-bit) in one bus. But
I think in this case it would logically be 1 address with 2 cells
because it is the port and device together that make up the address.
If you did that, you'd have to define how to express a clause 22
device with 2 cells. You could either set a high bit in the first cell
to indicate clause 45 address or use an illegal device address in the
2nd cell.

However, the MDIO core would need to handle 2 address cells. If more
than 1 address cell is an error currently, that causes a compatibility
problem with new dtb and older kernels (but could be addressed with
stable updates).

Rob
