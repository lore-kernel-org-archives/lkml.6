Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751555AbeEBPIp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:08:45 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:32912 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbeEBPIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:08:43 -0400
Date: Wed, 02 May 2018 11:08:41 -0400 (EDT)
Message-Id: <20180502.110841.378324128079268584.davem@davemloft.net>
To: grygorii.strashko@ti.com
Cc: netdev@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ti: cpsw: fix packet leaking in
 dual_mac mode
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180501174122.11323-1-grygorii.strashko@ti.com>
References: <20180501174122.11323-1-grygorii.strashko@ti.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Tue, 1 May 2018 12:41:22 -0500

> In dual_mac mode packets arrived on one port should not be forwarded by
> switch hw to another port. Only Linux Host can forward packets between
> ports. The below test case (reported in [1]) shows that packet arrived on
> one port can be leaked to anoter (reproducible with dual port evms):
>  - connect port 1 (eth0) to linux Host 0 and run tcpdump or Wireshark
>  - connect port 2 (eth1) to linux Host 1 with vlan 1 configured
>  - ping <IPx> from Host 1 through vlan 1 interface.
> ARP packets will be seen on Host 0.
> 
> Issue happens because dual_mac mode is implemnted using two vlans: 1 (Port
> 1+Port 0) and 2 (Port 2+Port 0), so there are vlan records created for for
> each vlan. By default, the ALE will find valid vlan record in its table
> when vlan 1 tagged packet arrived on Port 2 and so forwards packet to all
> ports which are vlan 1 members (like Port.
> 
> To avoid such behaviorr the ALE VLAN ID Ingress Check need to be enabled
> for each external CPSW port (ALE_PORTCTLn.VID_INGRESS_CHECK) so ALE will
> drop ingress packets if Rx port is not VLAN member.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Applied and queued up for -stable, thank you.
