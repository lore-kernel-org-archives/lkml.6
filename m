Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC32C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F5021571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F5021571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeI0QVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:21:03 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:53569 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbeI0QVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 12:21:03 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MCJzI-1fxBPO3AGo-009OVO; Thu, 27 Sep 2018 12:02:48 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: b53: Fix build with B53_SRAB enabled and B53_SERDES=m
Date:   Thu, 27 Sep 2018 12:02:38 +0200
Message-Id: <20180927100244.692546-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:UYHFbW7zQ7Is2ixgHOUkbqFpu2QSseoUsKjoB69Pm7Zb8FWvuWY
 c1Gi2aiHZxncIvUbh/je6HdnSou2AAVMHgT6QuDTnMnatWTj+UEmKUnplouXaJ89ikYIdw0
 1Je+e8XDlHI4Suhz+j68/gd0zxJw56qoN5U2VoVE4sxNiKVnlqmLiELtkrRjvhUhAekiL/6
 r9q+agZEDgwp13YvcGiFg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gyEh4GGfObw=:95/gavPNslR+zQ5CS/jG5R
 ZLc2+MxplGzG4rzSuzjYl2QtTbKM+Qree4WLpGBbeV8lYi5cVEWwmgTy/StzGDtuqMacuYO9R
 XgtTihTw6JVheTjWMHzztv0oq+Xaf/kIMHbdhRQMzZWTjAp0D5vHJwrTW5stG4WGwCON2+TBn
 gKFi3Ssex4mUKU9Y+mksvBM2DZ0yzuz3WNYUl0Fe0rjpHpAqfJTjq2WPNARJa9VvLjrRl+Hau
 rKmpqq+TK//t36bLvqYiMRrtBGnILRYM+8u/dY1dZCWOhhpyL/q2TIpBonmW+YNjH1aUXYJGR
 AHf78F/T3uDSjNUtWXPBteU29eyi2yyOZQm5BibKEsvGWDPTLuKYBjriwYZE5ti9v58T/2zQb
 l3iqEeML026pskdclP0tx78XUOE+J49l9SqLQmlXFe38Ak3F5ylX8iCFSUq+YG/9ksXu46eFa
 aRKLHaSy54mFhkMPAb4wQAVTbmgWZGFqpiNldCxTAIsppYLOFtHZf0Vu6sqRzpoJjmcWnO1Sv
 0l2VIdmlBAHfDxx138BFLU/1CVdQTDqymjr86y9vnkcG3g2kADsZMyVB4Syxz1pZJpH2TfvVD
 B+onqPu5KekMMCz7yheRCIodZhSu+qojt3U39s80Mc0ADP4LEWTLI2BDZNkHe/ssILV1/nBIq
 B8MKTuCqLtt5i5nFrs1mgx5reLJaHxYcCAaLKK+Qgpek/7XjpvPhZXtMAuWwvksaEIPk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When B53_SERDES is a loadable module, a built-in srab driver still
cannot reach it, so the previous fix is incomplete:

b53_srab.c:(.text+0x3f4): undefined reference to `b53_serdes_init'
drivers/net/dsa/b53/b53_srab.o:(.rodata+0xe64): undefined reference to `b53_serdes_link_state'
drivers/net/dsa/b53/b53_srab.o:(.rodata+0xe74): undefined reference to `b53_serdes_link_set'
drivers/net/dsa/b53/b53_srab.o:(.rodata+0xe88): undefined reference to `b53_serdes_an_restart'
drivers/net/dsa/b53/b53_srab.o:(.rodata+0xea0): undefined reference to `b53_serdes_phylink_validate'
drivers/net/dsa/b53/b53_srab.o:(.rodata+0xea4): undefined reference to `b53_serdes_config'

Add a Kconfig dependency that forces srab to also be a module
in this case, but allow it to be built-in when serdes is
disabled or built-in.

Fixes: 7a8c7f5c30f9 ("net: dsa: b53: Fix build with B53_SRAB enabled and not B53_SERDES")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/dsa/b53/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/b53/Kconfig b/drivers/net/dsa/b53/Kconfig
index e83ebfafd881..d32469283f97 100644
--- a/drivers/net/dsa/b53/Kconfig
+++ b/drivers/net/dsa/b53/Kconfig
@@ -31,6 +31,7 @@ config B53_MMAP_DRIVER
 config B53_SRAB_DRIVER
 	tristate "B53 SRAB connected switch driver"
 	depends on B53 && HAS_IOMEM
+	depends on B53_SERDES || !B53_SERDES
 	default ARCH_BCM_IPROC
 	help
 	  Select to enable support for memory-mapped Switch Register Access
-- 
2.18.0

