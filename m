Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752417AbeDQKGF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 06:06:05 -0400
Received: from orthanc.universe-factory.net ([104.238.176.138]:60284 "EHLO
        orthanc.universe-factory.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751810AbeDQKGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 06:06:04 -0400
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND net-next] ipv6: provide Kconfig switch to disable accept_ra by default
Date: Tue, 17 Apr 2018 12:04:50 +0200
Message-Id: <b39b1b4304524c43dfd83280aea4cfb4e8ac97f5.1523959377.git.mschiffer@universe-factory.net>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many distributions and users prefer to handle router advertisements in
userspace; one example is OpenWrt, which includes a combined RA and DHCPv6
client. For such configurations, accept_ra should not be enabled by
default.

As setting net.ipv6.conf.default.accept_ra via sysctl.conf or similar
facilities may be too late to catch all interfaces and common sysctl.conf
tools do not allow setting an option for all existing interfaces, this
patch provides a Kconfig option to control the default value of
default.accept_ra.

Using default.accept_ra is preferable to all.accept_ra for our usecase,
as disabling all.accept_ra would preclude users from explicitly enabling
accept_ra on individual interfaces.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 net/ipv6/Kconfig    | 12 ++++++++++++
 net/ipv6/addrconf.c |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/Kconfig b/net/ipv6/Kconfig
index 6794ddf0547c..0f453110f288 100644
--- a/net/ipv6/Kconfig
+++ b/net/ipv6/Kconfig
@@ -20,6 +20,18 @@ menuconfig IPV6
 
 if IPV6
 
+config IPV6_ACCEPT_RA_DEFAULT
+	bool "IPv6: Accept router advertisements by default"
+	default y
+	help
+	  The kernel can internally handle IPv6 router advertisements for
+	  stateless address autoconfiguration (SLAAC) and route configuration,
+	  which can be configured in detail and per-interface using a number of
+	  sysctl options. This option controls the default value of
+	  net.ipv6.conf.default.accept_ra.
+
+	  If unsure, say Y.
+
 config IPV6_ROUTER_PREF
 	bool "IPv6: Router Preference (RFC 4191) support"
 	---help---
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 62b97722722c..5fd6d2120a35 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -245,7 +245,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read_mostly = {
 	.forwarding		= 0,
 	.hop_limit		= IPV6_DEFAULT_HOPLIMIT,
 	.mtu6			= IPV6_MIN_MTU,
-	.accept_ra		= 1,
+	.accept_ra		= IS_ENABLED(CONFIG_IPV6_ACCEPT_RA_DEFAULT),
 	.accept_redirects	= 1,
 	.autoconf		= 1,
 	.force_mld_version	= 0,
-- 
2.17.0
