Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033950AbeCAS0p (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 13:26:45 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:35888 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033879AbeCAS0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 13:26:44 -0500
Date: Thu, 01 Mar 2018 13:26:41 -0500 (EST)
Message-Id: <20180301.132641.1222578145578661853.davem@davemloft.net>
To: richardcochran@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrew@lunn.ch,
        f.fainelli@gmail.com, linux@arm.linux.org.uk
Subject: Re: [PATCH net-next] net: phylink: Remove redundant netdev.phydev
 assignment
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180223152546.13354-1-richardcochran@gmail.com>
References: <20180223152546.13354-1-richardcochran@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Cochran <richardcochran@gmail.com>
Date: Fri, 23 Feb 2018 07:25:46 -0800

> As a part of working on MII time stamping infrastructure, I was trying
> to figure out how netdev->phydev gets assigned, and I stumbled across
> this.  Ever since the new phylink code came in, the field is assigned
> twice.
> 
> The function, phylink_connect_phy(), calls
> 
> 	phy_attach_direct()
> 	phylink_bringup_phy()
> 
> and phy_attach_direct() sets
> 
> 	dev->phydev = phydev;
> 
> but phylink_bringup_phy() then sets the same field again:
> 
> 	pl->netdev->phydev = phy;
> 
> Similarly, the function, phylink_of_phy_connect(), calls
> 
> 	of_phy_attach()
> 		phy_attach_direct()
> 	phylink_bringup_phy()
> 
> The removal code is also duplicated:
> 
> phylink_disconnect_phy()
> 	pl->netdev->phydev = NULL;
> 	phy_disconnect()
> 		phy_detach()
> 			phydev->attached_dev->phydev = NULL;
> 
> This patch removes the redundant assignments, restricting manipulation
> of the netdev.phydev field to phy_attach_direct() and phy_detach().
> 
> Signed-off-by: Richard Cochran <richardcochran@gmail.com>

Applied, thanks Richard.
 
