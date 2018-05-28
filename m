Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163316AbeE1KsM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:48:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163303AbeE1KsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:48:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 156/496] ARM: orion5x: Revert commit 4904dbda41c8.
Date: Mon, 28 May 2018 11:59:01 +0200
Message-Id: <20180528100326.460858360@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "David S. Miller" <davem@davemloft.net>

[ Upstream commit 13a55372b64e00e564a08d785ca87bd9d454ba30 ]

It is not valid for orion5x to use mac_pton().

First of all, the orion5x buffer is not NULL terminated.  mac_pton()
has no business operating on non-NULL terminated buffers because
only the caller can know that this is valid and in what manner it
is ok to parse this NULL'less buffer.

Second of all, orion5x operates on an __iomem pointer, which cannot
be dereferenced using normal C pointer operations.  Accesses to
such areas much be performed with the proper iomem accessors.

Fixes: 4904dbda41c8 ("ARM: orion5x: use mac_pton() helper")
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-orion5x/Kconfig        |    3 -
 arch/arm/mach-orion5x/dns323-setup.c |   53 +++++++++++++++++++++++++++++++++--
 arch/arm/mach-orion5x/tsx09-common.c |   49 +++++++++++++++++++++++++++++---
 3 files changed, 95 insertions(+), 10 deletions(-)

--- a/arch/arm/mach-orion5x/Kconfig
+++ b/arch/arm/mach-orion5x/Kconfig
@@ -58,7 +58,6 @@ config MACH_KUROBOX_PRO
 
 config MACH_DNS323
 	bool "D-Link DNS-323"
-	select GENERIC_NET_UTILS
 	select I2C_BOARDINFO if I2C
 	help
 	  Say 'Y' here if you want your kernel to support the
@@ -66,7 +65,6 @@ config MACH_DNS323
 
 config MACH_TS209
 	bool "QNAP TS-109/TS-209"
-	select GENERIC_NET_UTILS
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  QNAP TS-109/TS-209 platform.
@@ -101,7 +99,6 @@ config MACH_LINKSTATION_LS_HGL
 
 config MACH_TS409
 	bool "QNAP TS-409"
-	select GENERIC_NET_UTILS
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  QNAP TS-409 platform.
--- a/arch/arm/mach-orion5x/dns323-setup.c
+++ b/arch/arm/mach-orion5x/dns323-setup.c
@@ -173,10 +173,42 @@ static struct mv643xx_eth_platform_data
 	.phy_addr = MV643XX_ETH_PHY_ADDR(8),
 };
 
+/* dns323_parse_hex_*() taken from tsx09-common.c; should a common copy of these
+ * functions be kept somewhere?
+ */
+static int __init dns323_parse_hex_nibble(char n)
+{
+	if (n >= '0' && n <= '9')
+		return n - '0';
+
+	if (n >= 'A' && n <= 'F')
+		return n - 'A' + 10;
+
+	if (n >= 'a' && n <= 'f')
+		return n - 'a' + 10;
+
+	return -1;
+}
+
+static int __init dns323_parse_hex_byte(const char *b)
+{
+	int hi;
+	int lo;
+
+	hi = dns323_parse_hex_nibble(b[0]);
+	lo = dns323_parse_hex_nibble(b[1]);
+
+	if (hi < 0 || lo < 0)
+		return -1;
+
+	return (hi << 4) | lo;
+}
+
 static int __init dns323_read_mac_addr(void)
 {
 	u_int8_t addr[6];
-	void __iomem *mac_page;
+	int i;
+	char *mac_page;
 
 	/* MAC address is stored as a regular ol' string in /dev/mtdblock4
 	 * (0x007d0000-0x00800000) starting at offset 196480 (0x2ff80).
@@ -185,8 +217,23 @@ static int __init dns323_read_mac_addr(v
 	if (!mac_page)
 		return -ENOMEM;
 
-	if (!mac_pton((__force const char *) mac_page, addr))
-		goto error_fail;
+	/* Sanity check the string we're looking at */
+	for (i = 0; i < 5; i++) {
+		if (*(mac_page + (i * 3) + 2) != ':') {
+			goto error_fail;
+		}
+	}
+
+	for (i = 0; i < 6; i++)	{
+		int byte;
+
+		byte = dns323_parse_hex_byte(mac_page + (i * 3));
+		if (byte < 0) {
+			goto error_fail;
+		}
+
+		addr[i] = byte;
+	}
 
 	iounmap(mac_page);
 	printk("DNS-323: Found ethernet MAC address: %pM\n", addr);
--- a/arch/arm/mach-orion5x/tsx09-common.c
+++ b/arch/arm/mach-orion5x/tsx09-common.c
@@ -53,12 +53,53 @@ struct mv643xx_eth_platform_data qnap_ts
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
 };
 
+static int __init qnap_tsx09_parse_hex_nibble(char n)
+{
+	if (n >= '0' && n <= '9')
+		return n - '0';
+
+	if (n >= 'A' && n <= 'F')
+		return n - 'A' + 10;
+
+	if (n >= 'a' && n <= 'f')
+		return n - 'a' + 10;
+
+	return -1;
+}
+
+static int __init qnap_tsx09_parse_hex_byte(const char *b)
+{
+	int hi;
+	int lo;
+
+	hi = qnap_tsx09_parse_hex_nibble(b[0]);
+	lo = qnap_tsx09_parse_hex_nibble(b[1]);
+
+	if (hi < 0 || lo < 0)
+		return -1;
+
+	return (hi << 4) | lo;
+}
+
 static int __init qnap_tsx09_check_mac_addr(const char *addr_str)
 {
 	u_int8_t addr[6];
+	int i;
 
-	if (!mac_pton(addr_str, addr))
-		return -1;
+	for (i = 0; i < 6; i++) {
+		int byte;
+
+		/*
+		 * Enforce "xx:xx:xx:xx:xx:xx\n" format.
+		 */
+		if (addr_str[(i * 3) + 2] != ((i < 5) ? ':' : '\n'))
+			return -1;
+
+		byte = qnap_tsx09_parse_hex_byte(addr_str + (i * 3));
+		if (byte < 0)
+			return -1;
+		addr[i] = byte;
+	}
 
 	printk(KERN_INFO "tsx09: found ethernet mac address %pM\n", addr);
 
@@ -77,12 +118,12 @@ void __init qnap_tsx09_find_mac_addr(u32
 	unsigned long addr;
 
 	for (addr = mem_base; addr < (mem_base + size); addr += 1024) {
-		void __iomem *nor_page;
+		char *nor_page;
 		int ret = 0;
 
 		nor_page = ioremap(addr, 1024);
 		if (nor_page != NULL) {
-			ret = qnap_tsx09_check_mac_addr((__force const char *)nor_page);
+			ret = qnap_tsx09_check_mac_addr(nor_page);
 			iounmap(nor_page);
 		}
 
