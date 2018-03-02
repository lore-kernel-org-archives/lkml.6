Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtL3413kznZ4SrOfm7tIi5smYN7lUPrX+szqpSOSRynyVrN7svuC+81Anmt96MGJMYaBL8w
ARC-Seal: i=1; a=rsa-sha256; t=1519981128; cv=none;
        d=google.com; s=arc-20160816;
        b=VzMfhJhXZxf6FnXxras792QTye+yKJqYbb47iskb92KFTvO23IYhPBDb4z2OHzbYBE
         kisQwecQYOm/6KV0CEFj41N22Qi5mp1iAdQI/bLnEa+6oHglmqOz3OBs3IAqtflIAQjs
         BDveeo+oyCL4JfNVQXFvKCWMY0sYZ7Tp3R7MXlSf3j8jhpkL7dl+wfEQyEfxz1APbFg+
         E4L4bmco59JR75Ui7E4JTuDwIXEmiF7oK5I0qiIlD3sNoBvveWQvjC/PYsy7agU2tZGM
         r54g/0w4aErbXFvKbqVjZL/WsC/do+MN0ulBi62lDUrkbqJ9RUfGxmllMJ4aPF+VRJ+R
         1ihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OTfTeBV0E1kd+u7PxArE9GDi1mLSnPIX0WXl8XTtdfg=;
        b=RSqu4so9FkDxDTg9COd10C6KE8LTzduD7zc5ssF6rqOpEK8ESH+ZwUTRDxRo68NuTB
         JG+Q78X3fWLIRZZJ7aha9UnK6yNIO3BHMbzCuyohDXraf9ZYSowtSD4C8jiHC3H3qhgh
         ql4lgXkla8cbBcX+BCqr7T1A6/yQ6Gqr5RhHvr2dm7FPwBGZo4Ku6AYgHdUR6tijUHsO
         VmODBCwpEPq6ctXBvbwh/rvYIJiQvXkALxS8uC8lTqBpbXh9UI6QfxwgJaMguIjJoZRS
         7S7sEgggLUT910pyBnoGtHAF678cnC6zyCaUFCMpLWjG95MLvjPDuar+Xod2e5j9qnsD
         uyzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 50/56] SolutionEngine771x: fix Ether platform data
Date: Fri,  2 Mar 2018 09:51:36 +0100
Message-Id: <20180302084452.068140598@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815317239776648?=
X-GMAIL-MSGID: =?utf-8?q?1593815730953227363?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>


[ Upstream commit 195e2addbce09e5afbc766efc1e6567c9ce840d3 ]

The 'sh_eth' driver's probe() method would fail  on the SolutionEngine7710
board and crash on SolutionEngine7712 board  as the platform code is
hopelessly behind the driver's platform data --  it passes the PHY address
instead of 'struct sh_eth_plat_data *'; pass the latter to the driver in
order to fix the bug...

Fixes: 71557a37adb5 ("[netdrvr] sh_eth: Add SH7619 support")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sh/boards/mach-se/770x/setup.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/arch/sh/boards/mach-se/770x/setup.c
+++ b/arch/sh/boards/mach-se/770x/setup.c
@@ -8,6 +8,7 @@
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/sh_eth.h>
 #include <mach-se/mach/se.h>
 #include <mach-se/mach/mrshpc.h>
 #include <asm/machvec.h>
@@ -114,6 +115,11 @@ static struct platform_device heartbeat_
 #if defined(CONFIG_CPU_SUBTYPE_SH7710) ||\
 	defined(CONFIG_CPU_SUBTYPE_SH7712)
 /* SH771X Ethernet driver */
+static struct sh_eth_plat_data sh_eth_plat = {
+	.phy = PHY_ID,
+	.phy_interface = PHY_INTERFACE_MODE_MII,
+};
+
 static struct resource sh_eth0_resources[] = {
 	[0] = {
 		.start = SH_ETH0_BASE,
@@ -131,7 +137,7 @@ static struct platform_device sh_eth0_de
 	.name = "sh771x-ether",
 	.id = 0,
 	.dev = {
-		.platform_data = PHY_ID,
+		.platform_data = &sh_eth_plat,
 	},
 	.num_resources = ARRAY_SIZE(sh_eth0_resources),
 	.resource = sh_eth0_resources,
@@ -154,7 +160,7 @@ static struct platform_device sh_eth1_de
 	.name = "sh771x-ether",
 	.id = 1,
 	.dev = {
-		.platform_data = PHY_ID,
+		.platform_data = &sh_eth_plat,
 	},
 	.num_resources = ARRAY_SIZE(sh_eth1_resources),
 	.resource = sh_eth1_resources,
