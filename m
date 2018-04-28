Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933271AbeD1Acy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 20:32:54 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33348 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933115AbeD1Acu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 20:32:50 -0400
X-Google-Smtp-Source: AB8JxZr2hiYGp627PMPlHEHz+BSTuvfNaPMZlESOsY2uIoX4Ao663glIZNW0omDTZR+bn7SX07kDIQ==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Russell King <rmk@armlinux.org.uk>,
        linux-kernel@vger.kernel.org (open list), davem@davemloft.net,
        cphealy@gmail.com, nikita.yoush@cogentembedded.com,
        vivien.didelot@savoirfairelinux.com, Nisar.Sayed@microchip.com,
        UNGLinuxDriver@microchip.com
Subject: [RFC net-next 2/5] net: ethtool: Add UAPI for PHY test modes
Date: Fri, 27 Apr 2018 17:32:32 -0700
Message-Id: <20180428003237.1536-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180428003237.1536-1-f.fainelli@gmail.com>
References: <20180428003237.1536-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the necessary UAPI changes to support querying the PHY tests modes
implemented and optionally associated test specific data. This will be
used as the foundation for supporting:

- IEEE standard electrical test modes
- cable diagnostics
- packet tester

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/uapi/linux/ethtool.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 4ca65b56084f..a8befecfe853 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -567,6 +567,7 @@ struct ethtool_pauseparam {
  * @ETH_SS_RSS_HASH_FUNCS: RSS hush function names
  * @ETH_SS_PHY_STATS: Statistic names, for use with %ETHTOOL_GPHYSTATS
  * @ETH_SS_PHY_TUNABLES: PHY tunable names
+ * @ETH_SS_PHY_TESTS: PHY tests, for use with %ETHTOOL_GPHYTEST
  */
 enum ethtool_stringset {
 	ETH_SS_TEST		= 0,
@@ -578,6 +579,7 @@ enum ethtool_stringset {
 	ETH_SS_TUNABLES,
 	ETH_SS_PHY_STATS,
 	ETH_SS_PHY_TUNABLES,
+	ETH_SS_PHY_TESTS,
 };
 
 /**
@@ -1296,6 +1298,25 @@ enum ethtool_fec_config_bits {
 	ETHTOOL_FEC_BASER_BIT,
 };
 
+/**
+ * struct ethtool_phy_test - Ethernet PHY test mode
+ * @cmd: Command number = %ETHTOOL_GPHYTEST or %ETHTOOL_SPHYTEST
+ * @flags: A bitmask of flags from &enum ethtool_test_flags.  Some
+ *	flags may be set by the user on entry; others may be set by
+ *	the driver on return.
+ * @mode: PHY test mode to enter. The index should be a valid test mode
+ * obtained through ethtool_get_strings with %ETH_SS_PHY_TESTS
+ * @len: The length of the test specific array @data
+ * @data: Array of test specific results to be interpreted with @mode
+ */
+struct ethtool_phy_test {
+	__u32	cmd;
+	__u32	flags;
+	__u32	mode;
+	__u32	len;
+	__u8 	data[0];
+};
+
 #define ETHTOOL_FEC_NONE		(1 << ETHTOOL_FEC_NONE_BIT)
 #define ETHTOOL_FEC_AUTO		(1 << ETHTOOL_FEC_AUTO_BIT)
 #define ETHTOOL_FEC_OFF			(1 << ETHTOOL_FEC_OFF_BIT)
@@ -1396,6 +1417,8 @@ enum ethtool_fec_config_bits {
 #define ETHTOOL_PHY_STUNABLE	0x0000004f /* Set PHY tunable configuration */
 #define ETHTOOL_GFECPARAM	0x00000050 /* Get FEC settings */
 #define ETHTOOL_SFECPARAM	0x00000051 /* Set FEC settings */
+#define ETHTOOL_GPHYTEST	0x00000052 /* Get PHY test mode(s) */
+#define ETHTOOL_SPHYTEST	0x00000053 /* Set PHY test mode */
 
 /* compatibility with older code */
 #define SPARC_ETH_GSET		ETHTOOL_GSET
-- 
2.14.1
