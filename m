Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753000AbeBTQ0L (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:26:11 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:37149 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752969AbeBTQ0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:26:07 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: arm@kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ARM: orion: mark orion_ge00_mvmdio_bus_name as const
Date: Tue, 20 Feb 2018 17:24:51 +0100
Message-Id: <20180220162519.1498223-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220162519.1498223-1-arnd@arndb.de>
References: <20180220162519.1498223-1-arnd@arndb.de>
X-Provags-ID: V03:K0:y6y0pFvKhmcpMzBWGo5aUobC/UXYRncYa2LJLwxocd2iLzciV+r
 Xt3q9ejrOyjfxAOpkvvkhCvbiLNTx1Cw/51UcYYb18jUjwwEl1zYg76on6bATgXrVlmszIZ
 5JLx349tv1C/1bCEznJteLb9hvy7+KiUxtptiuHjv5OHAEdJyh026cOxITjMOxYzmq5gLTH
 xWFZHjfoL1CoxKBscteCg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z+TE90QItLg=:RVlJOrF6vWp9zIcftvg6Qx
 nv5K7fAC5Rtn68UURW2ddUoaIB8NsLxHu6cYgfBDSeA/XOjiebCsG/SSMIM7f6yDqPPAHL4W1
 7hYTaLouND8Awgu4Bn/q1y46w1rCl1xTDWM4rg5v9s8D1nyAad6gBmfP0IGOlumU7+frYfJ3D
 S3wuAEjxjDlTcei4+1wFgcdkRYpBMXb4xTYxB7Ajibcbo5oDElahuAqaTIh7sDxyCd2Kh9onr
 wZVN1xi87eyXpys/6OR/njja34YkdxLiF2agT3dczx6xrzO1aDaMJNOq3tdf4TgEZ0WFzdOdN
 01Iun9522XW09sKtvhdGaiWYCo5AT+WVdkiBcf/kLt0qjnBRPUEoxxMSYDdRZ6mWGZQPaKt7L
 4Cp9V3pO9ZlKcuy50zQPH1ZlpmKSBPgZKuV/XbmsfDgOSVDig+aAO8BWKsh23Vwq5sYxHEhzA
 RAUxz6BsIsK9OGV93GyqxvLH5kci60qfOb9YYoobnjksgsPxcIuBFs6rqUKZta30aSevcsmSF
 i+XqyG3opWcRKXXbtd/5rH5M7x4BTVG9SG9Ebu5RRhGABGiJQFEkvaM+rdeCIHYQWudwA5eTi
 Nqu8IZhMwteof7BjOKe05IYzgL3LKJoP+I5IMh0XbLrDVAmJwdMmuuhSDwJnrgVVxMy6Kxrs4
 JjxwAOBZcqDGFFNwPete3CAgAxZ3BN6GIHkGXyWVtZUx9BpvHyg4XCsBDj9VIN1Ux9B0D26sb
 JmaoOj70OgwLIVOdOtD6ZBt5Y/xNsbbdAe0Luw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A section type mismatch warning shows up when building with LTO,
since orion_ge00_mvmdio_bus_name was put in __initconst but not marked
const itself:

include/linux/of.h: In function 'spear_setup_of_timer':
arch/arm/mach-spear/time.c:207:34: error: 'timer_of_match' causes a section type conflict with 'orion_ge00_mvmdio_bus_name'
 static const struct of_device_id timer_of_match[] __initconst = {
                                  ^
arch/arm/plat-orion/common.c:475:32: note: 'orion_ge00_mvmdio_bus_name' was declared here
 static __initconst const char *orion_ge00_mvmdio_bus_name = "orion-mii";
                                ^

This marks it const as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/plat-orion/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index aff6994950ba..4e1d8270537c 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -472,7 +472,7 @@ void __init orion_ge11_init(struct mv643xx_eth_platform_data *eth_data,
 /*****************************************************************************
  * Ethernet switch
  ****************************************************************************/
-static __initconst const char *orion_ge00_mvmdio_bus_name = "orion-mii";
+static __initconst const char *const orion_ge00_mvmdio_bus_name = "orion-mii";
 static __initdata struct mdio_board_info
 		  orion_ge00_switch_board_info;
 
-- 
2.9.0
