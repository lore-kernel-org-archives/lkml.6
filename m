Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4ECECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C36208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C36208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbeGMHZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:25:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38949 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729645AbeGMHZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:25:17 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A5E4DD35EDDBD;
        Fri, 13 Jul 2018 15:11:55 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.382.0; Fri, 13 Jul 2018
 15:11:48 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <zbr@ioremap.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] connector: hide unused procfs helpers
Date:   Fri, 13 Jul 2018 15:11:41 +0800
Message-ID: <20180713071141.15996-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PROC_FS isn't set, gcc warning this:

drivers/connector/connector.c:242:12: warning: ‘cn_proc_show’ defined but not used [-Wunused-function]
 static int cn_proc_show(struct seq_file *m, void *v)
            ^
fix this by adding #ifdef around it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/connector/connector.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
index e718b8c..e2636d4 100644
--- a/drivers/connector/connector.c
+++ b/drivers/connector/connector.c
@@ -239,6 +239,7 @@ void cn_del_callback(struct cb_id *id)
 }
 EXPORT_SYMBOL_GPL(cn_del_callback);
 
+#ifdef CONFIG_PROC_FS
 static int cn_proc_show(struct seq_file *m, void *v)
 {
 	struct cn_queue_dev *dev = cdev.cbdev;
@@ -259,6 +260,7 @@ static int cn_proc_show(struct seq_file *m, void *v)
 
 	return 0;
 }
+#endif
 
 static struct cn_dev cdev = {
 	.input   = cn_rx_skb,
-- 
2.7.0


