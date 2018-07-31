Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE66C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148F620844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148F620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbeGaStN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:49:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10160 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727269AbeGaStN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:49:13 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 232E01808BF14;
        Wed,  1 Aug 2018 01:07:54 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.399.0; Wed, 1 Aug 2018 01:07:52 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <jeyu@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] kernel/module: Use kmemdup to replace kmalloc+memcpy
Date:   Wed, 1 Aug 2018 00:56:17 +0800
Message-ID: <1533056177-37255-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

we prefer to the kmemdup rather than kmalloc+memcpy. so just
replace them.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 kernel/module.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 20344e4..6746c85 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2057,21 +2057,19 @@ static int copy_module_elf(struct module *mod, struct load_info *info)
 
 	/* Elf section header table */
 	size = sizeof(*info->sechdrs) * info->hdr->e_shnum;
-	mod->klp_info->sechdrs = kmalloc(size, GFP_KERNEL);
+	mod->klp_info->sechdrs = kmemdup(info->sechdrs, size, GFP_KERNEL);
 	if (mod->klp_info->sechdrs == NULL) {
 		ret = -ENOMEM;
 		goto free_info;
 	}
-	memcpy(mod->klp_info->sechdrs, info->sechdrs, size);
 
 	/* Elf section name string table */
 	size = info->sechdrs[info->hdr->e_shstrndx].sh_size;
-	mod->klp_info->secstrings = kmalloc(size, GFP_KERNEL);
+	mod->klp_info->secstrings = kmemdup(info->secstrings, size, GFP_KERNEL);
 	if (mod->klp_info->secstrings == NULL) {
 		ret = -ENOMEM;
 		goto free_sechdrs;
 	}
-	memcpy(mod->klp_info->secstrings, info->secstrings, size);
 
 	/* Elf symbol section index */
 	symndx = info->index.sym;
-- 
1.7.12.4

