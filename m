Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79C2C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53D0216E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53D0216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbeHNNdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 09:33:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59803 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728873AbeHNNdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 09:33:50 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C60256696951B;
        Tue, 14 Aug 2018 18:47:09 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.399.0; Tue, 14 Aug 2018 18:47:09 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <tony.luck@intel.com>, <fenghua.yu@intel.com>
CC:     <dhowells@redhat.com>, <rppt@linux.vnet.ibm.com>,
        <golf@perches.com>, <linux-ia64@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] ia64: Use ARRAY_SIZE to replace its implementation
Date:   Tue, 14 Aug 2018 18:35:22 +0800
Message-ID: <1534242922-29258-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We prefer to ARRAY_SIZE rather than duplicating its implementation.
And just one place use the #define variable, therefore, remove
PFM_CMD_COUNT definition altogether.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
v1->v2:
  -  According to Joe's suggestion. remove the #define variable,
     and use ARRAY_SIZE to replace directly.

 arch/ia64/kernel/perfmon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/ia64/kernel/perfmon.c b/arch/ia64/kernel/perfmon.c
index a9d4dc6..bfe0094c 100644
--- a/arch/ia64/kernel/perfmon.c
+++ b/arch/ia64/kernel/perfmon.c
@@ -4645,7 +4645,6 @@ static char *pfmfs_dname(struct dentry *dentry, char *buffer, int buflen)
 /* 32 */PFM_CMD(pfm_write_ibrs, PFM_CMD_PCLRWS, PFM_CMD_ARG_MANY, pfarg_dbreg_t, NULL),
 /* 33 */PFM_CMD(pfm_write_dbrs, PFM_CMD_PCLRWS, PFM_CMD_ARG_MANY, pfarg_dbreg_t, NULL)
 };
-#define PFM_CMD_COUNT	(sizeof(pfm_cmd_tab)/sizeof(pfm_cmd_desc_t))
 
 static int
 pfm_check_task_state(pfm_context_t *ctx, int cmd, unsigned long flags)
@@ -4770,7 +4769,7 @@ static char *pfmfs_dname(struct dentry *dentry, char *buffer, int buflen)
 	 */
 	if (unlikely(pmu_conf == NULL)) return -ENOSYS;
 
-	if (unlikely(cmd < 0 || cmd >= PFM_CMD_COUNT)) {
+	if (unlikely(cmd < 0 || cmd >= ARRAY_SIZE(pfm_cmd_tab))) {
 		DPRINT(("invalid cmd=%d\n", cmd));
 		return -EINVAL;
 	}
-- 
1.7.12.4

