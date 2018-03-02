Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvf7nlsHIUo0HwVuEgf3q+KuvMM8B4O6t7LIifCHk3otzgkyThiIsUvb0rd08bAP2ZtJv9I
ARC-Seal: i=1; a=rsa-sha256; t=1519980959; cv=none;
        d=google.com; s=arc-20160816;
        b=HlsBTMuDLiRQL1vFcVNNZ0v/+hxMSWipHd7AXzTeUzJB+qPfmusOSU1XV/x1+zUsh+
         GJXipYaxy1RcDHKkdFv2v37CMet4+wJVtE9T5jYV4Wa2NsjtuM1UvlwcFttzOziYju1t
         u34IWMBXHkRRfT2icc1QQ2jZREtJVItICFGdNSEHGjPyH9g+SdykbYJ9DrUvgCr3CcKK
         GdPbYZnK6IZTvqEAK9wMpHOYXtgm2ZO/M0nBAoTVSIfD3O46hbiNrHnW29155RP5DYLf
         CdvZla6oJCYEtABi55i6BanLoSuCVm6VdNgHE0OHKrbHC7ZMtT2wboO7oWSGhE5A4W+n
         2ieQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fdP8GqDuYWsLgKZL5YrfvA50SHyFbHtHIdVvOzmjdvU=;
        b=Q3funbBAYlnAsjl8xkbAsg3INm4O/yhrcWuj8ILaK9xf9ki6cmWNyc+fFfsGs40ZJj
         I3PLJxgPRmve4zE+dUAMoKd0ieSvXs/gyMG6XGt2EX6+wIXKXEprCNQFDXwTfK0auden
         EhaSVgJSbaTgiHMvfb6hOJn7ouhMIC41N8of9ilXx/H4tcrRzd4FQX8vHEdbvx7OKWUB
         gcrjFvhcIXNzF0511BgTt1yxGHHcXQZM0lGCGzOVSDFycAZBTQaMFqmsC4zlYZaDQtAh
         im0AxxfAInL3GaCZ6MAwdY8XsgPcewaZaTMirjAKqODhxXYxlhDR8O16ljHSGn77x5w6
         nyhw==
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
Subject: [PATCH 4.4 29/34] SolutionEngine771x: fix Ether platform data
Date: Fri,  2 Mar 2018 09:51:25 +0100
Message-Id: <20180302084437.868320664@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815317239776648?=
X-GMAIL-MSGID: =?utf-8?q?1593815554887679024?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
