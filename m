Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbeCZWpF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:45:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38538 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752299AbeCZWpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:45:02 -0400
X-Google-Smtp-Source: AG47ELv1i2UCP8aRXiZ/BbzEtbAIy5rL2rZ0MkY76Wzaw02zcupoJhe5bKHeK4v7icW/7JDuvLMc1Q==
Subject: Re: [RFC PATCH v2] net: phy: Added device tree binding for dev-addr
 and dev-addr code check-up
To: vicentiu.galanopulo@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        davem@davemloft.net, marcel@holtmann.org, devicetree@vger.kernel.org
Cc: madalin.bucur@nxp.com, alexandru.marginean@nxp.com
References: <20180323150522.9603-1-vicentiu.galanopulo@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5726f7e4-49eb-e87e-8548-82fac6aa0452@gmail.com>
Date: Mon, 26 Mar 2018 15:44:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323150522.9603-1-vicentiu.galanopulo@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/2018 08:05 AM, Vicentiu Galanopulo wrote:
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

Correct me if I am completely misunderstanding  the problem, but have
you considered doing the following:

- if all you need to is to replace instances of loops that do:

        if (phydev->is_c45) {
                for (i = 1; i < num_ids; i++) {
                        if (!(phydev->c45_ids.devices_in_package & (1 <<
i)))
                                continue;

with one that starts at dev-addr, as specified by Device Tree, then I
suspect there is an easier way to do what you want rather than your
fairly intrusive patch to do that:

- patch of_mdiobus_register_phy() to lookup both the c45 compatible
string as well as fetch the "dev-addr" property

- provide a PHY Device Tree node that has its OUI as a compatible string
(see of_get_phy_id() for details), or if it has a specified 'dev-addr'
property, use that in lieu of the default get_phy_device() logic

- pass both to phy_device_create() and eventually introduce a helper
function that lets you populate the c45_ids structure

Then for each function that does the loop above, as long as you have a
phydev reference, you can have phydev->dev_addr = 0x1e be where to start
from, if it is 0, then start at 1 (like it currently is). If you don't
have a phy device reference, which would be get_phy_c45_ids() then just
make sure you don't call that function :)

>  struct phy_c45_device_ids {
>  	u32 devices_in_package;
> -	u32 device_ids[8];
> +	u32 device_ids[32];
> +	u32 devices_addrs[32];
>  };

This looks like a fix in itself, so it is worth a separate patch.
-- 
Florian
