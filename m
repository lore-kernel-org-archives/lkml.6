Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B080C00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFC02084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550759886;
	bh=IICRDMRi4U2WO9ovdecDoirhdTVFggtfBkInrveLMV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gGq8lAs293FiYLMzK0n2Or0P6wf+sUG+euS/bzHDArFLIqa+HLT7RyWWwFgtBNy3A
	 BYjPA9dsBZZjeeKbDoxk2uzRe72CBp8f3J1wDQzbUqGpqgRe/SGM62b3ygpkpZoQP5
	 mRBMqklo5fInHki7HUn2yAjmSTff+WWh0dr+sGfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfBUOiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:38:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:59588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbfBUOiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:38:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5387320838;
        Thu, 21 Feb 2019 14:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550759882;
        bh=IICRDMRi4U2WO9ovdecDoirhdTVFggtfBkInrveLMV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ScnYu1nILt7yQYRp0tLgjEsYxGrxFTmq22Q/L/8JvPKusGY1+3mH2LAWNttTdXN16
         gRrOHcW47aoajNsJhhjIN63H+WQ37Ai9fZbALAg8jbJSLZjmLbB8nzRrvhr9RPcU6B
         hW+ULE1FLDgMKG/WpBZJ9CgLpc4wrxDkw1t/U644=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hauke Mehrtens <hauke.mehrtens@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 04/20] net: Fix for_each_netdev_feature on Big endian
Date:   Thu, 21 Feb 2019 15:35:34 +0100
Message-Id: <20190221141946.903434630@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221141946.772985220@linuxfoundation.org>
References: <20190221141946.772985220@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hauke Mehrtens <hauke.mehrtens@intel.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/netdev_features.h |   23 +++++++++++++++++++++--
 net/core/dev.c                  |    4 ++--
 2 files changed, 23 insertions(+), 4 deletions(-)

--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -11,6 +11,7 @@
 #define _LINUX_NETDEV_FEATURES_H
 
 #include <linux/types.h>
+#include <asm/byteorder.h>
 
 typedef u64 netdev_features_t;
 
@@ -125,8 +126,26 @@ enum {
 #define NETIF_F_HW_L2FW_DOFFLOAD	__NETIF_F(HW_L2FW_DOFFLOAD)
 #define NETIF_F_BUSY_POLL	__NETIF_F(BUSY_POLL)
 
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
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6421,7 +6421,7 @@ static netdev_features_t netdev_sync_upp
 	netdev_features_t feature;
 	int feature_bit;
 
-	for_each_netdev_feature(&upper_disables, feature_bit) {
+	for_each_netdev_feature(upper_disables, feature_bit) {
 		feature = __NETIF_F_BIT(feature_bit);
 		if (!(upper->wanted_features & feature)
 		    && (features & feature)) {
@@ -6441,7 +6441,7 @@ static void netdev_sync_lower_features(s
 	netdev_features_t feature;
 	int feature_bit;
 
-	for_each_netdev_feature(&upper_disables, feature_bit) {
+	for_each_netdev_feature(upper_disables, feature_bit) {
 		feature = __NETIF_F_BIT(feature_bit);
 		if (!(features & feature) && (lower->features & feature)) {
 			netdev_dbg(upper, "Disabling feature %pNF on lower dev %s.\n",


