Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163593AbeE1Ktz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:49:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932332AbeE1Kts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:49:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 175/496] mlxsw: core: Fix flex keys scratchpad offset conflict
Date: Mon, 28 May 2018 11:59:20 +0200
Message-Id: <20180528100327.252486953@linuxfoundation.org>
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

From: Jiri Pirko <jiri@mellanox.com>

[ Upstream commit 2ddc94c76cc4ccaf51b478315912b38dfdde1afc ]

IP_TTL, IP_ECN and IP_DSCP are using the same offset within the
scratchpad as L4 ports. Fix this by shifting all up.

Fixes: 5f57e0909136 ("mlxsw: acl: Add ip ttl acl element")
Fixes: i80d0fe4710c ("mlxsw: acl: Add ip tos acl element")
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h |   20 +++++++--------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h
@@ -107,20 +107,20 @@ static const struct mlxsw_afk_element_in
 	MLXSW_AFK_ELEMENT_INFO_U32(VID, 0x10, 8, 12),
 	MLXSW_AFK_ELEMENT_INFO_U32(PCP, 0x10, 20, 3),
 	MLXSW_AFK_ELEMENT_INFO_U32(TCP_FLAGS, 0x10, 23, 9),
-	MLXSW_AFK_ELEMENT_INFO_U32(IP_TTL_, 0x14, 0, 8),
-	MLXSW_AFK_ELEMENT_INFO_U32(IP_ECN, 0x14, 9, 2),
-	MLXSW_AFK_ELEMENT_INFO_U32(IP_DSCP, 0x14, 11, 6),
-	MLXSW_AFK_ELEMENT_INFO_U32(SRC_IP4, 0x18, 0, 32),
-	MLXSW_AFK_ELEMENT_INFO_U32(DST_IP4, 0x1C, 0, 32),
-	MLXSW_AFK_ELEMENT_INFO_BUF(SRC_IP6_HI, 0x18, 8),
-	MLXSW_AFK_ELEMENT_INFO_BUF(SRC_IP6_LO, 0x20, 8),
-	MLXSW_AFK_ELEMENT_INFO_BUF(DST_IP6_HI, 0x28, 8),
-	MLXSW_AFK_ELEMENT_INFO_BUF(DST_IP6_LO, 0x30, 8),
 	MLXSW_AFK_ELEMENT_INFO_U32(DST_L4_PORT, 0x14, 0, 16),
 	MLXSW_AFK_ELEMENT_INFO_U32(SRC_L4_PORT, 0x14, 16, 16),
+	MLXSW_AFK_ELEMENT_INFO_U32(IP_TTL_, 0x18, 0, 8),
+	MLXSW_AFK_ELEMENT_INFO_U32(IP_ECN, 0x18, 9, 2),
+	MLXSW_AFK_ELEMENT_INFO_U32(IP_DSCP, 0x18, 11, 6),
+	MLXSW_AFK_ELEMENT_INFO_U32(SRC_IP4, 0x20, 0, 32),
+	MLXSW_AFK_ELEMENT_INFO_U32(DST_IP4, 0x24, 0, 32),
+	MLXSW_AFK_ELEMENT_INFO_BUF(SRC_IP6_HI, 0x20, 8),
+	MLXSW_AFK_ELEMENT_INFO_BUF(SRC_IP6_LO, 0x28, 8),
+	MLXSW_AFK_ELEMENT_INFO_BUF(DST_IP6_HI, 0x30, 8),
+	MLXSW_AFK_ELEMENT_INFO_BUF(DST_IP6_LO, 0x38, 8),
 };
 
-#define MLXSW_AFK_ELEMENT_STORAGE_SIZE 0x38
+#define MLXSW_AFK_ELEMENT_STORAGE_SIZE 0x40
 
 struct mlxsw_afk_element_inst { /* element instance in actual block */
 	const struct mlxsw_afk_element_info *info;
