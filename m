Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE77CECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9032147D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9032147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389918AbeIUQ2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:28:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44871 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727681AbeIUQ2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:28:37 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1EE93ECBA553E;
        Fri, 21 Sep 2018 18:40:18 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.399.0; Fri, 21 Sep 2018
 18:40:10 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <benh@kernel.crashing.org>, <paulus@samba.org>,
        <mpe@ellerman.id.au>, <nfont@linux.vnet.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] powerpc/pseries/memory-hotplug: Fix return value type of find_aa_index
Date:   Fri, 21 Sep 2018 18:37:59 +0800
Message-ID: <20180921103759.24976-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_aa_index will return -1 when dlpar_clone_property fails,
its return value type should be int. Also the caller
update_lmb_associativity_index should use a int variable to
get it,then compared with 0.

Fixes: c05a5a40969e ("powerpc/pseries: Dynamic add entires to associativity lookup array")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 9a15d39..6aad17c 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -101,13 +101,12 @@ static struct property *dlpar_clone_property(struct property *prop,
 	return new_prop;
 }
 
-static u32 find_aa_index(struct device_node *dr_node,
+static int find_aa_index(struct device_node *dr_node,
 			 struct property *ala_prop, const u32 *lmb_assoc)
 {
 	u32 *assoc_arrays;
-	u32 aa_index;
 	int aa_arrays, aa_array_entries, aa_array_sz;
-	int i, index;
+	int i, index, aa_index;
 
 	/*
 	 * The ibm,associativity-lookup-arrays property is defined to be
@@ -168,7 +167,7 @@ static int update_lmb_associativity_index(struct drmem_lmb *lmb)
 	struct device_node *parent, *lmb_node, *dr_node;
 	struct property *ala_prop;
 	const u32 *lmb_assoc;
-	u32 aa_index;
+	int aa_index;
 
 	parent = of_find_node_by_path("/");
 	if (!parent)
-- 
2.7.0


