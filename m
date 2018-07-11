Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F35C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F7A2089B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F7A2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbeGKIYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:24:37 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17735 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbeGKIYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:24:36 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b45be040000>; Wed, 11 Jul 2018 01:21:24 -0700
Received: from HQMAIL103.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 11 Jul 2018 01:21:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 11 Jul 2018 01:21:26 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 11 Jul
 2018 08:21:28 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Wed, 11 Jul 2018 08:21:28 +0000
Received: from mperttunen-lnx.Nvidia.com (Not Verified[10.21.26.144]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b45be070000>; Wed, 11 Jul 2018 01:21:28 -0700
From:   Mikko Perttunen <mperttunen@nvidia.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <leonard.crestez@nxp.com>, <cyndis@kapsi.fi>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH] clk: core: Potentially free connection id
Date:   Wed, 11 Jul 2018 11:21:04 +0300
Message-ID: <20180711082104.27955-1-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.16.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch "clk: core: Copy connection id" made it so that the connector
id (con_id) is kstrdup_const'ed to cater to drivers that pass non-
constant connection ids. The patch added the corresponding kfree_const
to __clk_free_clk, but struct clk's can be freed also via __clk_put.
Add the kfree_const call to __clk_put and add comments to both
functions to remind that the logic in them should be kept in sync.

Fixes: 253160a8ad06 ("clk: core: Copy connection id")
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/clk/clk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ac96caab0523..d31055ae6ec6 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3132,6 +3132,7 @@ struct clk *__clk_create_clk(struct clk_hw *hw, const char *dev_id,
 	return clk;
 }
 
+/* keep in sync with __clk_put */
 void __clk_free_clk(struct clk *clk)
 {
 	clk_prepare_lock();
@@ -3511,6 +3512,7 @@ int __clk_get(struct clk *clk)
 	return 1;
 }
 
+/* keep in sync with __clk_free_clk */
 void __clk_put(struct clk *clk)
 {
 	struct module *owner;
@@ -3544,6 +3546,7 @@ void __clk_put(struct clk *clk)
 
 	module_put(owner);
 
+	kfree_const(clk->con_id);
 	kfree(clk);
 }
 
-- 
2.16.1

