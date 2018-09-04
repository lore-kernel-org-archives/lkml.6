Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9714FC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514692086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514692086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbeIDHEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:04:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11658 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbeIDHEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:04:32 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8E9C61F1767BE;
        Tue,  4 Sep 2018 10:41:33 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.399.0; Tue, 4 Sep 2018
 10:41:28 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <jeffrey.t.kirsher@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 net-next] i40e: remove inline directive
Date:   Tue, 4 Sep 2018 10:41:09 +0800
Message-ID: <20180904024109.21492-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes follow gcc warning:

drivers/net/ethernet/intel/i40e/i40e_ethtool.c: In function '__i40e_add_stat_strings':
drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h:193:20: error: function '__i40e_add_stat_strings' can never be inlined because it uses variable argument lists

Fixes: 8fd75c58a09a ("i40e: move ethtool stats boiler plate code to i40e_ethtool_stats.h")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: move __i40e_add_stat_strings back to i40e_ethtool.c as Sergei Shtylyov suggested.
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c       | 15 +++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h | 16 ++--------------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index d7d3974..363c85b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -232,6 +232,21 @@ static const struct i40e_priv_flags i40e_gl_gstrings_priv_flags[] = {
 
 #define I40E_GL_PRIV_FLAGS_STR_LEN ARRAY_SIZE(i40e_gl_gstrings_priv_flags)
 
+static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
+                                    const unsigned int size, ...)
+{
+        unsigned int i;
+
+        for (i = 0; i < size; i++) {
+                va_list args;
+
+                va_start(args, size);
+                vsnprintf(*p, ETH_GSTRING_LEN, stats[i].stat_string, args);
+                *p += ETH_GSTRING_LEN;
+                va_end(args);
+        }
+}
+
 /**
  * i40e_partition_setting_complaint - generic complaint for MFP restriction
  * @pf: the PF struct
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
index bba1cb0..4265db6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
@@ -190,20 +190,8 @@ i40e_add_queue_stats(u64 **data, struct i40e_ring *ring)
  * Format and copy the strings described by stats into the buffer pointed at
  * by p.
  **/
-static inline void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
-				    const unsigned int size, ...)
-{
-	unsigned int i;
-
-	for (i = 0; i < size; i++) {
-		va_list args;
-
-		va_start(args, size);
-		vsnprintf(*p, ETH_GSTRING_LEN, stats[i].stat_string, args);
-		*p += ETH_GSTRING_LEN;
-		va_end(args);
-	}
-}
+static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
+				    const unsigned int size, ...);
 
 /**
  * 40e_add_stat_strings - copy stat strings into ethtool buffer
-- 
2.7.0


