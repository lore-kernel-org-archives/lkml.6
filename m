Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeCNPiD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:38:03 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:55847 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751957AbeCNPiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:38:01 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Finn Thain <fthain@telegraphics.com.au>, netdev@vger.kernel.org
Subject: [PATCH 04/47] net: 8390: remove m32r specific bits
Date: Wed, 14 Mar 2018 16:35:17 +0100
Message-Id: <20180314153603.3127932-5-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:cpwVa9Y972fUrVjb87RJxgBs2ifw4ZQkPpC1qSGpIBCb2JSPaT3
 5UxKUKZYS+NangidrG0dZH+OHcBdW6YhYAozar91HsXT1UQFllXho1H+iw6W+DKzn1YFiab
 wCnUdLbeM9bkvJQfsudzZ3HVmVuApc6dSK9hrehuC0QJCdvJhm0PpSqgYARdIOJM8qvku+b
 Hdkd/nuRnG1ZZ/JT9SHxA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7fH30maxmlA=:RWOIj8ULHow4R7TUP6Vzll
 lR436CSyzil/scq1xUliWZv+u/dwFjIPGJzjXjh6XzkomnUyfNkuEaEQ7qhMppYA8VNGeqK5l
 khsRAnhE7cuawaeR9RBgw1/J20C+peEN+mJcEqSdTldZADWEQP0RzcwJK0kYfnWldQgEbekV/
 75MseZYKBKTUVxj3JJ27mMNveb8ymMtF7IMJVqO0+vGzl9mD9ohbREmDYdUF8dArMTgO37nkx
 2LCr+Bqh+LuNw79O9SIRYZSuowWx4jkemV5tiy0KXVqdltTm2JNsJ5rJ5hUcXbnyq/GWDivPn
 z7E1Di6bSMxgg3b+K5mQ+1cCCb9BkKtBd9VPXN2jEq1cpGxvDKluEgZNmugYA/T4S3wIi0UY9
 yBfevp9NMH9Lv7HmLeQdB6vtcv8N7BHgcn95D4uLsyZ8VWybWR9tFWZcPcM7KKHpBjUTv9WJN
 vUI0rWLFLZXB9PewNdRWu/LqAnSb+MDlGwz8aqjFMSmjBRBccuNAWwLrIfWd+rbxD5F714A4h
 WwTfbcrPXSFKeX7i4/rstWztxEzxlX156oVfFSTkXgM8gZ9OhMg4hFeV40tdty+zYBACmdhY5
 dY1VaPCiA3kVCH8Cfm2r3pP0yaHmJyfqpzXm3mo/iLuOrf8CIGizfqt2Vv1YW9hfqhWcpf9Kv
 ZSzRzjcZDheIphi/AXi5R2ZgrKfXFcCDf3Ivc00XM2uCLyOE/CxymsHYeFH5q62FyATWo7E8U
 B8L8uiqp39z4hwrSlex+W/6e4u4KwgGrsdgkEg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The m32r architecture is getting removed, so we can kill off the
architecture specific hacks in this driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/8390/Kconfig |  3 +--
 drivers/net/ethernet/8390/ne.c    | 23 ++---------------------
 2 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/8390/Kconfig b/drivers/net/ethernet/8390/Kconfig
index fdc673484add..9fee7c83ef9f 100644
--- a/drivers/net/ethernet/8390/Kconfig
+++ b/drivers/net/ethernet/8390/Kconfig
@@ -87,8 +87,7 @@ config MCF8390
 
 config NE2000
 	tristate "NE2000/NE1000 support"
-	depends on (ISA || (Q40 && m) || M32R || MACH_TX49XX || \
-		    ATARI_ETHERNEC)
+	depends on (ISA || (Q40 && m) || MACH_TX49XX || ATARI_ETHERNEC)
 	select CRC32
 	---help---
 	  If you have a network (Ethernet) card of this type, say Y here.
diff --git a/drivers/net/ethernet/8390/ne.c b/drivers/net/ethernet/8390/ne.c
index 4cdff6e6af89..44a084b41bf0 100644
--- a/drivers/net/ethernet/8390/ne.c
+++ b/drivers/net/ethernet/8390/ne.c
@@ -99,7 +99,7 @@ MODULE_LICENSE("GPL");
 that the ne2k probe is the last 8390 based probe to take place (as it
 is at boot) and so the probe will get confused by any other 8390 cards.
 ISA device autoprobes on a running machine are not recommended anyway. */
-#if !defined(MODULE) && (defined(CONFIG_ISA) || defined(CONFIG_M32R))
+#if !defined(MODULE) && defined(CONFIG_ISA)
 /* Do we need a portlist for the ISA auto-probe ? */
 #define NEEDS_PORTLIST
 #endif
@@ -164,12 +164,7 @@ bad_clone_list[] __initdata = {
 #define NESM_START_PG	0x40	/* First page of TX buffer */
 #define NESM_STOP_PG	0x80	/* Last page +1 of RX ring */
 
-#if defined(CONFIG_PLAT_MAPPI)
-#  define DCR_VAL 0x4b
-#elif defined(CONFIG_PLAT_OAKS32R)  || \
-   defined(CONFIG_MACH_TX49XX)
-#  define DCR_VAL 0x48		/* 8-bit mode */
-#elif defined(CONFIG_ATARI)	/* 8-bit mode on Atari, normal on Q40 */
+#if defined(CONFIG_ATARI)	/* 8-bit mode on Atari, normal on Q40 */
 #  define DCR_VAL (MACH_IS_ATARI ? 0x48 : 0x49)
 #else
 #  define DCR_VAL 0x49
@@ -422,12 +417,7 @@ static int __init ne_probe1(struct net_device *dev, unsigned long ioaddr)
 		stop_page  = NE1SM_STOP_PG;
 	}
 
-#if  defined(CONFIG_PLAT_MAPPI) || defined(CONFIG_PLAT_OAKS32R)
-	neX000 = ((SA_prom[14] == 0x57  &&  SA_prom[15] == 0x57)
-		|| (SA_prom[14] == 0x42 && SA_prom[15] == 0x42));
-#else
 	neX000 = (SA_prom[14] == 0x57  &&  SA_prom[15] == 0x57);
-#endif
 	ctron =  (SA_prom[0] == 0x00 && SA_prom[1] == 0x00 && SA_prom[2] == 0x1d);
 	copam =  (SA_prom[14] == 0x49 && SA_prom[15] == 0x00);
 
@@ -508,18 +498,9 @@ static int __init ne_probe1(struct net_device *dev, unsigned long ioaddr)
 
 	dev->base_addr = ioaddr;
 
-#ifdef CONFIG_PLAT_MAPPI
-	outb_p(E8390_NODMA + E8390_PAGE1 + E8390_STOP,
-		ioaddr + E8390_CMD); /* 0x61 */
-	for (i = 0; i < ETH_ALEN; i++) {
-		dev->dev_addr[i] = SA_prom[i]
-			= inb_p(ioaddr + EN1_PHYS_SHIFT(i));
-	}
-#else
 	for (i = 0; i < ETH_ALEN; i++) {
 		dev->dev_addr[i] = SA_prom[i];
 	}
-#endif
 
 	pr_cont("%pM\n", dev->dev_addr);
 
-- 
2.9.0
