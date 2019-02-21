Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EC5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6630F2080D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760201;
	bh=mhrDYB3dT71/YFpl+k8L/fYuaIfk0eN6i/zqo7Lwxh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bQ6PH8arZDYgteflFdm5BHTKXeZvGJgEN/fU0o/zIThWsS1yIFcp8kTToQMeSggpB
	 hNWGOOcJJsvMW+TnjsExeaJIfu1S0UGq4sIioiw3nzJoG9jiQEhDn1rYWdSs88vZrs
	 6ybEt4xvgDwlzF+q3Mp0DW0VLbgLiByjf4gqtro0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfBUOnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:43:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:39112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729678AbfBUOnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:43:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB0A32075A;
        Thu, 21 Feb 2019 14:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760196;
        bh=mhrDYB3dT71/YFpl+k8L/fYuaIfk0eN6i/zqo7Lwxh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qFOHCXF3lSvo05lVwpqFaFfmWLWvhycesGcSP0Wp2YrF5mLqy7f3XUZy1xOBwfTuv
         cUWnBBOtdotmN4sTQjX7bFjqmnfysq90kBUOhNSWRMbcplKzWu0kqcUKyG7DcCia9I
         9hSLuDphIgI4rXsTuIKg/ZAty9uJBy0WsvqJP14o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hauke Mehrtens <hauke.mehrtens@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 08/32] net: Fix for_each_netdev_feature on Big endian
Date:   Thu, 21 Feb 2019 15:35:56 +0100
Message-Id: <20190221125251.324543420@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125250.855065214@linuxfoundation.org>
References: <20190221125250.855065214@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 3b89ea9c5902acccdbbdec307c85edd1bf52515e ]

The features attribute is of type u64 and stored in the native endianes on
the system. The for_each_set_bit() macro takes a pointer to a 32 bit array
and goes over the bits in this area. On little Endian systems this also
works with an u64 as the most significant bit is on the highest address,
but on big endian the words are swapped. When we expect bit 15 here we get
bit 47 (15 + 32).

This patch converts it more or less to its own for_each_set_bit()
implementation which works on 64 bit integers directly. This is then
completely in host endianness and should work like expected.

Fixes: fd867d51f ("net/core: generic support for disabling netdev features down stack")
Signed-off-by: Hauke Mehrtens <hauke.mehrtens@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netdev_features.h | 23 +++++++++++++++++++++--
 net/core/dev.c                  |  4 ++--
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 2b2a6dce16301..fce28562bed29 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -11,6 +11,7 @@
 #define _LINUX_NETDEV_FEATURES_H
 
 #include <linux/types.h>
+#include <asm/byteorder.h>
 
 typedef u64 netdev_features_t;
 
@@ -154,8 +155,26 @@ enum {
 #define NETIF_F_HW_TLS_TX	__NETIF_F(HW_TLS_TX)
 #define NETIF_F_HW_TLS_RX	__NETIF_F(HW_TLS_RX)
 
-#define for_each_netdev_feature(mask_addr, bit)	\
-	for_each_set_bit(bit, (unsigned long *)mask_addr, NETDEV_FEATURE_COUNT)
+/* Finds the next feature with the highest number of the range of start till 0.
+ */
+static inline int find_next_netdev_feature(u64 feature, unsigned long start)
+{
+	/* like BITMAP_LAST_WORD_MASK() for u64
+	 * this sets the most significant 64 - start to 0.
+	 */
+	feature &= ~0ULL >> (-start & ((sizeof(feature) * 8) - 1));
+
+	return fls64(feature) - 1;
+}
+
+/* This goes for the MSB to the LSB through the set feature bits,
+ * mask_addr should be a u64 and bit an int
+ */
+#define for_each_netdev_feature(mask_addr, bit)				\
+	for ((bit) = find_next_netdev_feature((mask_addr),		\
+					      NETDEV_FEATURE_COUNT);	\
+	     (bit) >= 0;						\
+	     (bit) = find_next_netdev_feature((mask_addr), (bit) - 1))
 
 /* Features valid for ethtool to change */
 /* = all defined minus driver/device-class-related */
diff --git a/net/core/dev.c b/net/core/dev.c
index 43f8a4fd49682..de0690e5b3dfa 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8064,7 +8064,7 @@ static netdev_features_t netdev_sync_upper_features(struct net_device *lower,
 	netdev_features_t feature;
 	int feature_bit;
 
-	for_each_netdev_feature(&upper_disables, feature_bit) {
+	for_each_netdev_feature(upper_disables, feature_bit) {
 		feature = __NETIF_F_BIT(feature_bit);
 		if (!(upper->wanted_features & feature)
 		    && (features & feature)) {
@@ -8084,7 +8084,7 @@ static void netdev_sync_lower_features(struct net_device *upper,
 	netdev_features_t feature;
 	int feature_bit;
 
-	for_each_netdev_feature(&upper_disables, feature_bit) {
+	for_each_netdev_feature(upper_disables, feature_bit) {
 		feature = __NETIF_F_BIT(feature_bit);
 		if (!(features & feature) && (lower->features & feature)) {
 			netdev_dbg(upper, "Disabling feature %pNF on lower dev %s.\n",
-- 
2.19.1



