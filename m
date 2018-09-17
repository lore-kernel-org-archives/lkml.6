Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0FDECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D702214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D702214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeIQP2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 11:28:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12590 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726169AbeIQP2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 11:28:15 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C4418AC64D4D4;
        Mon, 17 Sep 2018 18:01:31 +0800 (CST)
Received: from linux-work.huawei.com (10.67.189.174) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.399.0; Mon, 17 Sep 2018 18:01:26 +0800
From:   nixiaoming <nixiaoming@huawei.com>
To:     <jack@suse.cz>, <amir73il@gmail.com>
CC:     <nixiaoming@huawei.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix memory leak in ramoops_init
Date:   Mon, 17 Sep 2018 17:15:31 +0800
Message-ID: <20180917091531.21356-1-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.10.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1, memory leak in ramoops_register_dummy.
   dummy_data = kzalloc(sizeof(*dummy_data), GFP_KERNEL);
   but no free when platform_device_register_data return fail

2, if kzalloc(sizeof(*dummy_data), GFP_KERNEL) return NULL,
    but platform_driver_register(&ramoops_driver) return 0
   kfree(NULL) in ramoops_exit
so, add return val for ramoops_register_dummy, and check it in ramoops_init

3, memory leak in ramoops_init.
   miss platform_device_unregister(dummy) and kfree(dummy_data)
   when platform_driver_register(&ramoops_driver) return fail

Signed-off-by: nixiaoming <nixiaoming@huawei.com>
---
 fs/pstore/ram.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index bd9812e..331b600 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -604,17 +604,17 @@ static struct platform_driver ramoops_driver = {
 	},
 };
 
-static void ramoops_register_dummy(void)
+static int ramoops_register_dummy(void)
 {
 	if (!mem_size)
-		return;
+		return -EINVAL;
 
 	pr_info("using module parameters\n");
 
 	dummy_data = kzalloc(sizeof(*dummy_data), GFP_KERNEL);
 	if (!dummy_data) {
 		pr_info("could not allocate pdata\n");
-		return;
+		return -ENOMEM;
 	}
 
 	dummy_data->mem_size = mem_size;
@@ -636,13 +636,25 @@ static void ramoops_register_dummy(void)
 	if (IS_ERR(dummy)) {
 		pr_info("could not create platform device: %ld\n",
 			PTR_ERR(dummy));
+		kfree(dummy_data);
+		return PTR_ERR(dummy);
 	}
+	return 0;
 }
 
 static int __init ramoops_init(void)
 {
-	ramoops_register_dummy();
-	return platform_driver_register(&ramoops_driver);
+	int ret = ramoops_register_dummy();
+
+	if (ret != 0)
+		return ret;
+
+	ret = platform_driver_register(&ramoops_driver);
+	if (ret != 0) {
+		platform_device_unregister(dummy);
+		kfree(dummy_data);
+	}
+	return ret;
 }
 postcore_initcall(ramoops_init);
 
-- 
1.9.0

