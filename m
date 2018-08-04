Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B236C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFCF2183A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFCF2183A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbeHDQhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 12:37:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50595 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727600AbeHDQhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 12:37:36 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3674FFB9985D;
        Sat,  4 Aug 2018 22:36:39 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.399.0; Sat, 4 Aug 2018 22:36:38 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <benh@kernel.crashing.org>
CC:     <paulus@samba.org>, <mpe@ellerman.id.au>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] powpc:feature: of_node_put is not needed after iterator.
Date:   Sat, 4 Aug 2018 22:25:00 +0800
Message-ID: <1533392700-24621-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

for_each_node_by_name iterators only  exit normally when the loop
cursor is NULL, So there is no point to call of_node_put.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 arch/powerpc/platforms/powermac/feature.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index 3f82cb2..4eb8cb3 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -2889,10 +2889,8 @@ static void __init probe_one_macio(const char *name, const char *compat, int typ
 	/* On all machines, switch modem & serial ports off */
 	for_each_node_by_name(np, "ch-a")
 		initial_serial_shutdown(np);
-	of_node_put(np);
 	for_each_node_by_name(np, "ch-b")
 		initial_serial_shutdown(np);
-	of_node_put(np);
 }
 
 void __init
-- 
1.7.12.4

