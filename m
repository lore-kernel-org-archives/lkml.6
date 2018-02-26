Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbeBZJmV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:42:21 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:43637 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752007AbeBZJmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:42:16 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: "David S. Miller" <davem@davemloft.net>,
        Matteo Croce <mcroce@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [net-next] ipvlan: fix building with modular IPV6
Date: Mon, 26 Feb 2018 10:41:30 +0100
Message-Id: <20180226094159.2519438-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:kGAAr4EFWQ6FiOFgacok7AINiGQp+EsVhFhkoDskgqyYLPHv9WF
 Vt80cS8GNtChJ4LALrDmsrgE5uoePBoYQCLg+Uvis83bFlzneYZHJItkaESF70l7tUN8Nxk
 3f3DHu/LIxh1WWy86ZNAA2iSbC/fCWFEIgiRXOrf5xcqOTh+HHt/Gt6KOhrTvJ9wKPKBgLR
 L/NSEwFFJMOY2Za/WSu6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QCNYtCZmCn4=:kbuOJR43I4/2Lu6t69/WM+
 IcnCm0QnycOowya9g/+gSttgn9hxCMoZGYw2pQQ6XpZRl6roibyCvFEP/oXMJ4/djyPIlH8be
 iS+eSwW6/5Eh9dqgrCmfJVv4gq/0tnJQFp0jB7hHsD1CDqVL0y2fO6na8XXLhfm2SKcZVKjot
 FkYg5ot9JN9l0y/BRW+WK1c1Tcdm56M+A8vlvLRaNIZc+U6lkWkoPWH6/rB92YswsCSUnxrou
 NpIFXAJx7u3HjrkKoCb43KGJWxKUSGfRyxFjwN0Qmz4waOf4oT/3h2HCJP9ZnZRJMXc4DWuSm
 c2z42yHxxNwq0o+Tgf2AeNITO0F6U8pqVS1NxE8z27Su+bNBm+sPxYeDVqtINWd0AzoHQXSAN
 PUVIpiakd+XY+TexomSMF/bUDIiCGNIDAeje7uALiqRZn+v1ogNlqwx3e0PKx9I0es1rv8l57
 8bNS1r1kJBJAZUwE8lLZfRJroUFUeppX7A2+MdBJnIN6G1BxxW9AGfhZc5defNJzbPT6FxtN4
 9UmVqv5FRI8dhs3lmen/06Xrg/sslC+9EEdmXJBB0HFzxpoAk5F/ddgtlsJZ7w3DLiyBiJmt7
 aA+A9mKEdNIyPQaHeYReRFkHaaOChbZHS8BO5p6e/NNdMGb1I3cpwt2DrfKWUvK3Vd43DKysx
 wCIUBR73P86VxHe0ZdZZn3Km4kvX5APYQ0k0c5F7RVHOAkXCX9V/KHlBfmd4McYkSjVFGq38T
 AnAv/KFvgdXyMGjVjslH7AdjwmhbRTmoCOtbyQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We no longer depend on IPV6, but that now causes a link error with
CONFIG_IPV6=m and CONFIG_IPVLAN=y:

drivers/net/ipvlan/ipvlan_core.o: In function `ipvlan_queue_xmit':
ipvlan_core.c:(.text+0x1440): undefined reference to `ip6_route_output_flags'
drivers/net/ipvlan/ipvlan_core.o: In function `ipvlan_l3_rcv':
ipvlan_core.c:(.text+0x1818): undefined reference to `ip6_route_input_lookup'

This adds back the dependency on IPV6, with the option of building without
IPV6, but forcing IPVLAN to be a module when IPV6 is a module.

Fixes: 94333fac44d1 ("ipvlan: drop ipv6 dependency")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index d88b78a17440..08b85215c2be 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -149,6 +149,7 @@ config MACVTAP
 config IPVLAN
     tristate "IP-VLAN support"
     depends on INET
+    depends on IPV6 || !IPV6
     depends on NETFILTER
     select NET_L3_MASTER_DEV
     ---help---
-- 
2.9.0
