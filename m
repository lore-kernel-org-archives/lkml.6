Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CBAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87642146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87642146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbeKUSo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:44:59 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:8165 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728231AbeKUSo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 13:44:59 -0500
X-UUID: b9184564d42f476192ec877e5f520667-20181121
X-UUID: b9184564d42f476192ec877e5f520667-20181121
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 300876385; Wed, 21 Nov 2018 16:11:17 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 21 Nov 2018 16:11:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 21 Nov 2018 16:11:16 +0800
From:   <miles.chen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [RFC PATCH] of: make MAX_RESERVED_REGIONS configurable
Date:   Wed, 21 Nov 2018 16:11:13 +0800
Message-ID: <1542787873-8429-1-git-send-email-miles.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miles Chen <miles.chen@mediatek.com>

When we use more than 32 entries in /resered-memory,
there will be an error message: "not enough space all defined regions.".
We can increase MAX_RESERVED_REGIONS to fix this.

commit 22f8cc6e3373 ("drivers: of: increase MAX_RESERVED_REGIONS to 32")
increased MAX_RESERVED_REGIONS to 32 but I'm not sure if increasing
MAX_RESERVED_REGIONS to 64 is suitable for everyone.

In this RFC patch, CONFIG_MAX_OF_RESERVED_REGIONS is added and used as
MAX_RESERVED_REGIONS. Add a sanity test to make sure that
MAX_RESERVED_REGIONS is less than INIT_MEMBLOCK_REGIONS.
Users can configure CONFIG_MAX_OF_RESERVED_REGIONS according to their
need.

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/of/Kconfig           | 9 +++++++++
 drivers/of/of_reserved_mem.c | 5 ++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index ad3fcad..63fff2e 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -86,6 +86,15 @@ config OF_RESERVED_MEM
 	help
 	  Helpers to allow for reservation of memory regions
 
+config MAX_OF_RESERVED_REGIONS
+	int "the max number of devicetree reserved memory regions"
+	depends on OF_RESERVED_MEM
+	default 32
+	help
+	  Setup the max number of devicetree reserved memory regions
+	  If unsure, leave the default value "32".
+
+
 config OF_RESOLVE
 	bool
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 1977ee0..18a7729 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -22,7 +22,7 @@
 #include <linux/slab.h>
 #include <linux/memblock.h>
 
-#define MAX_RESERVED_REGIONS	32
+#define MAX_RESERVED_REGIONS	CONFIG_MAX_OF_RESERVED_REGIONS
 static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
 static int reserved_mem_count;
 
@@ -246,6 +246,9 @@ void __init fdt_init_reserved_mem(void)
 {
 	int i;
 
+	/* MAX_RESERVED_REGIONS should be bounded by INIT_MEMBLOCK_REGIONS */
+	BUILD_BUG_ON(MAX_RESERVED_REGIONS > INIT_MEMBLOCK_REGIONS);
+
 	/* check for overlapping reserved regions */
 	__rmem_check_for_overlap();
 
-- 
1.9.1

