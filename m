Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30BCC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 03:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971EE20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 03:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971EE20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbeIFHr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 03:47:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725981AbeIFHrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 03:47:55 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5F1FCFE40ACF0;
        Thu,  6 Sep 2018 11:14:41 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.399.0; Thu, 6 Sep 2018
 11:14:33 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <johannes.berg@intel.com>,
        <emmanuel.grumbach@intel.com>, <luciano.coelho@intel.com>,
        <linuxwifi@intel.com>, <kvalo@codeaurora.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] iwlwifi: Use kmemdup instead of duplicating it in iwl_parse_nvm_mcc_info
Date:   Thu, 6 Sep 2018 11:13:22 +0800
Message-ID: <20180906031322.17748-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace calls to kmalloc followed by a memcpy with a direct call to
kmemdup.

Patch found using coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 27db4a3..bd91657 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1113,14 +1113,12 @@ iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
 	regd_to_copy = sizeof(struct ieee80211_regdomain) +
 		valid_rules * sizeof(struct ieee80211_reg_rule);
 
-	copy_rd = kzalloc(regd_to_copy, GFP_KERNEL);
+	copy_rd = kmemdup(reg, regd_to_copy, GFP_KERNEL);
 	if (!copy_rd) {
 		copy_rd = ERR_PTR(-ENOMEM);
 		goto out;
 	}
 
-	memcpy(copy_rd, regd, regd_to_copy);
-
 out:
 	kfree(regdb_ptrs);
 	kfree(regd);
-- 
2.7.0


