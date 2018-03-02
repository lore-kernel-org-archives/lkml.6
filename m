Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv36mBrnAcT3UxQOlX/Q/5QAK8OuS528RaX8vlYui/sUPn2Eo5GabEATX+gVcon+nGuRa8p
ARC-Seal: i=1; a=rsa-sha256; t=1519981516; cv=none;
        d=google.com; s=arc-20160816;
        b=WjLIybtUOIJ8acpWvrRow2Bnvwuu2MJeEdulpEpziitSLRLzd2zZgNY+Uino7yvnz1
         XY24j50a1Qk2UTsXxGI/wx8/Xm4vK+VVoYzGZ6zTPogj15rVddphJpDyx51hKv1ieKfI
         DmiGoGgxCtZDN2cxVy1NiQOWXQAWUBsj4paNBlIVc984o6Vmjb4eYgCxeIBSQmkbYnMK
         G3mbVw8YDHX3ElgnKZqh4BDqOvUsCAy45D2uaYfJcUygeTrflyZx3RrV/9JQGiM1wsTY
         XPnisMsLsmMzCYrBbcNcxezwqT7DD08E+305tDzuHr/YKHL13bXDhH1eCxT081YbOkqo
         b2jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ruZa3HtSSsVuoiKCF8HHUDydYSRN31D+YC7DfDVUDIg=;
        b=qMDpD/b2kBzbMQsXPS1xbrYwOcO7lwCsszAgnclxHxd+IkBC16QD2n4iCo+kfaoc3+
         a3lp6VXzpF3O9/IJr117WWstzWeyW0qm/kyPV3SBqW/iSGWctLS5p9Xwx/NGlqZbxhm7
         Evi+L+SMt8IOX1s2bJ4EphMNY57ldjy8K1qwGnGXyI1T71K9E8v4fIkzhatlPe7lDq7x
         AsgxC4FXFOOgTD9z6GZRAHIcB3q4bat9okPvrYvYGcuJ1hflv1iEXlIfDCafYHxgIw+4
         NQZShakFWKI+sx9lUt9nHJ6RFxoPwi5//+sDgxxHhbM4Umc16+6dNyoHRGMrC3Yqpycx
         aygw==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 099/115] SolutionEngine771x: fix Ether platform data
Date: Fri,  2 Mar 2018 09:51:42 +0100
Message-Id: <20180302084507.849994760@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815317239776648?=
X-GMAIL-MSGID: =?utf-8?q?1593816138601790018?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sh/boards/mach-se/770x/setup.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/arch/sh/boards/mach-se/770x/setup.c
+++ b/arch/sh/boards/mach-se/770x/setup.c
@@ -9,6 +9,7 @@
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/sh_eth.h>
 #include <mach-se/mach/se.h>
 #include <mach-se/mach/mrshpc.h>
 #include <asm/machvec.h>
@@ -115,6 +116,11 @@ static struct platform_device heartbeat_
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
@@ -132,7 +138,7 @@ static struct platform_device sh_eth0_de
 	.name = "sh771x-ether",
 	.id = 0,
 	.dev = {
-		.platform_data = PHY_ID,
+		.platform_data = &sh_eth_plat,
 	},
 	.num_resources = ARRAY_SIZE(sh_eth0_resources),
 	.resource = sh_eth0_resources,
@@ -155,7 +161,7 @@ static struct platform_device sh_eth1_de
 	.name = "sh771x-ether",
 	.id = 1,
 	.dev = {
-		.platform_data = PHY_ID,
+		.platform_data = &sh_eth_plat,
 	},
 	.num_resources = ARRAY_SIZE(sh_eth1_resources),
 	.resource = sh_eth1_resources,
