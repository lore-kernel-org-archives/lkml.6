Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeBUDtv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 22:49:51 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:60772 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750829AbeBUDtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 22:49:50 -0500
Date: Wed, 21 Feb 2018 04:49:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Arnd Bergmann <arnd@arndb.de>
Cc: arm@kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 2/3] ARM: orion: mark orion_ge00_mvmdio_bus_name as const
Message-ID: <20180221034938.GE14844@lunn.ch>
References: <20180220162519.1498223-1-arnd@arndb.de>
 <20180220162519.1498223-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220162519.1498223-2-arnd@arndb.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 05:24:51PM +0100, Arnd Bergmann wrote:
> A section type mismatch warning shows up when building with LTO,
> since orion_ge00_mvmdio_bus_name was put in __initconst but not marked
> const itself:
> 
> include/linux/of.h: In function 'spear_setup_of_timer':
> arch/arm/mach-spear/time.c:207:34: error: 'timer_of_match' causes a section type conflict with 'orion_ge00_mvmdio_bus_name'
>  static const struct of_device_id timer_of_match[] __initconst = {
>                                   ^
> arch/arm/plat-orion/common.c:475:32: note: 'orion_ge00_mvmdio_bus_name' was declared here
>  static __initconst const char *orion_ge00_mvmdio_bus_name = "orion-mii";
>
> This marks it const as well.

Hi Arnd

I'm not sure this is the correct fix. orion_ge00_mvmdio_bus_name is
assigned to orion_ge00_switch_board_info->bus_id. This is then passed
to mdiobus_register_board_info() which makes a copy of
orion_ge00_switch_board_info and adds it to its linked list. The
original orion_ge00_switch_board_info will get freed since it is
__initdata, but the copy still has a pointer to
orion_ge00_mvmdio_bus_name, which also gets freed.

I think the correct fix is to remove the __initconst from
orion_ge00_mvmdio_bus_name. Marking it const is however valid.

	Andrew
