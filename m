Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbeCTObH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 10:31:07 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:36815 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751093AbeCTObF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 10:31:05 -0400
Date: Tue, 20 Mar 2018 15:30:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>
Cc: f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        davem@davemloft.net, marcel@holtmann.org, devicetree@vger.kernel.org,
        madalin.bucur@nxp.com, alexandru.marginean@nxp.com
Subject: Re: [RFC PATCH] net: phy: Added device tree binding for dev-addr and
 dev-addr code check-up and usage
Message-ID: <20180320143056.GA22128@lunn.ch>
References: <20180320134615.17817-1-vicentiu.galanopulo@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320134615.17817-1-vicentiu.galanopulo@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 08:46:15AM -0500, Vicentiu Galanopulo wrote:
> Reason for this patch is that the Inphi PHY
> has a vendor specific address space for accessing
> the C45 MDIO registers - starting from 0x1e.
> 
> A new function has been added, get_phy_c45_dev_addr,
> which loops through all the PHY device nodes under
> a MDIO bus node and looks for the <dev-addr> property. If
> it's not set/found, the get_phy_c45_devs_in_pkg,
> will be called with the value 0 as dev_addr parameter,
> else it will be called with the dev-addr property
> value from the device tree.

This seems like the wrong way to implement this. How about:

of_mdiobus_register(), when it loops over the children, looks for the
new property. If found, it passed dev-id to of_mdiobus_register_phy().
That passes it to get_phy_device(). I think get_phy_device() can then
set the ID in c45_ids, before passing it to
get_phy_id(). get_phy_c45_ids() will first look at devices in package
and can add further devices to c45_ids. It will then probe both those
found, and the static one you added.

       Andrew
