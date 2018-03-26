Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752858AbeCZWZR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:25:17 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35335 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752799AbeCZWZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:25:10 -0400
X-Google-Smtp-Source: AG47ELszQ8i5DRexVLBXPiNinNbv6bVNszmWyDRDVdnyyLb3D+ggqnAKr3z15DWO7edqa/q5XdR7FA==
Date: Mon, 26 Mar 2018 17:25:09 -0500
From: Rob Herring <robh@kernel.org>
To: Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, marcel@holtmann.org,
        devicetree@vger.kernel.org, madalin.bucur@nxp.com,
        alexandru.marginean@nxp.com
Subject: Re: [RFC PATCH v2] net: phy: Added device tree binding for dev-addr
 and dev-addr code check-up
Message-ID: <20180326222509.ppt5aqzqdarhm44d@rob-hp-laptop>
References: <20180323150522.9603-1-vicentiu.galanopulo@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323150522.9603-1-vicentiu.galanopulo@nxp.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 10:05:22AM -0500, Vicentiu Galanopulo wrote:
> Reason for this patch is that the Inphi PHY has a
> vendor specific address space for accessing the
> C45 MDIO registers - starting from 0x1e.
> 
> A search of the dev-addr property is done in of_mdiobus_register.
> If the property is found in the PHY node,
> of_mdiobus_register_static_phy is called. This is a
> wrapper function for of_mdiobus_register_phy which finds the
> device in package based on dev-addr and fills devices_addrs:
> devices_addrs is a new field added to phy_c45_device_ids.
> This new field will store the dev-addr property on the same
> index where the device in package has been found.
> In order to have dev-addr in get_phy_c45_ids(), mdio_c45_ids is
> passed from of_mdio.c to phy_device.c as an external variable.
> In get_phy_device a copy of the mdio_c45_ids is done over the
> local c45_ids (wich are empty). After the copying, the c45_ids
> will also contain the static device found from dev-addr.
> Having dev-addr stored in devices_addrs, in get_phy_c45_ids(),
> when probing the identifiers, dev-addr can be extracted from
> devices_addrs and probed if devices_addrs[current_identifier]
> is not 0.
> This way changing the kernel API is avoided completely.
> 
> As a plus to this patch, num_ids in get_phy_c45_ids,
> has the value 8 (ARRAY_SIZE(c45_ids->device_ids)),
> but the u32 *devs can store 32 devices in the bitfield.
> If a device is stored in *devs, in bits 32 to 9, it
> will not be found. This is the reason for changing
> in phy.h, the size of device_ids array.
> 
> Signed-off-by: Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/phy.txt |  6 ++

Please split bindings to separate patch.

>  drivers/net/phy/phy_device.c                  | 22 +++++-
>  drivers/of/of_mdio.c                          | 98 ++++++++++++++++++++++++++-
>  include/linux/phy.h                           |  5 +-
>  4 files changed, 125 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/phy.txt b/Documentation/devicetree/bindings/net/phy.txt
> index d2169a5..82692e2 100644
> --- a/Documentation/devicetree/bindings/net/phy.txt
> +++ b/Documentation/devicetree/bindings/net/phy.txt
> @@ -61,6 +61,11 @@ Optional Properties:
>  - reset-deassert-us: Delay after the reset was deasserted in microseconds.
>    If this property is missing the delay will be skipped.
>  
> +- dev-addr: If set, it indicates the device address of the PHY to be used
> +  when accessing the C45 PHY registers over MDIO. It is used for vendor specific
> +  register space addresses that do no conform to standard address for the MDIO
> +  registers (e.g. MMD30)

This is a 2nd MDIO address, right? Can't you just append this to reg 
property?

Rob
