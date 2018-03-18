Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754380AbeCRSyY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 14:54:24 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:34399 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751061AbeCRSyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 14:54:21 -0400
Date: Sun, 18 Mar 2018 19:54:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: Fix missing register lock
 in serdes_get_stats
Message-ID: <20180318185418.GI1188@lunn.ch>
References: <20180318182305.24952-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180318182305.24952-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 18, 2018 at 11:23:05AM -0700, Florian Fainelli wrote:
> We can hit the register lock not held assertion with the following path:
> 
> [   34.170631] mv88e6085 0.1:00: Switch registers lock not held!
> [   34.176510] CPU: 0 PID: 950 Comm: ethtool Not tainted 4.16.0-rc4 #143
> [   34.182985] Hardware name: Freescale Vybrid VF5xx/VF6xx (Device Tree)
> [   34.189519] Backtrace:
> [   34.192033] [<8010c4b4>] (dump_backtrace) from [<8010c788>] (show_stack+0x20/0x24)
> [   34.199680]  r6:9f5dc010 r5:00000011 r4:9f5dc010 r3:00000000
> [   34.205434] [<8010c768>] (show_stack) from [<80679d38>] (dump_stack+0x24/0x28)
> [   34.212719] [<80679d14>] (dump_stack) from [<804844a8>] (mv88e6xxx_read+0x70/0x7c)
> [   34.220376] [<80484438>] (mv88e6xxx_read) from [<804870dc>] (mv88e6xxx_port_get_cmode+0x34/0x4c)
> [   34.229257]  r5:a09cd128 r4:9ee31d07
> [   34.232880] [<804870a8>] (mv88e6xxx_port_get_cmode) from [<80487e6c>] (mv88e6352_port_has_serdes+0x24/0x64)
> [   34.242690]  r4:9f5dc010
> [   34.245309] [<80487e48>] (mv88e6352_port_has_serdes) from [<804880b8>] (mv88e6352_serdes_get_stats+0x28/0x12c)
> [   34.255389]  r4:00000001
> [   34.257973] [<80488090>] (mv88e6352_serdes_get_stats) from [<804811e8>] (mv88e6xxx_get_ethtool_stats+0xb0/0xc0)
> [   34.268156]  r10:00000000 r9:00000000 r8:00000000 r7:a09cd020 r6:00000001 r5:9f5dc01c
> [   34.276052]  r4:9f5dc010
> [   34.278631] [<80481138>] (mv88e6xxx_get_ethtool_stats) from [<8064f740>] (dsa_slave_get_ethtool_stats+0xbc/0xc4)
> 
> mv88e6xxx_get_ethtool_stats() calls mv88e6xxx_get_stats() which calls both
> chip->info->ops->stats_get_stats(), which holds the register lock, and
> chip->info->ops->serdes_get_stats() which does not. Have
> chip->info->ops->serdes_get_stats() be running with the register lock held to
> avoid such assertions.
> 
> Fixes: 436fe17d273b ("net: dsa: mv88e6xxx: Allow the SERDES interfaces to have statistics")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Yes, i have the same patch in my backlog of patches.

    Andrew
